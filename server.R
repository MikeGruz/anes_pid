# server side probability computator for partisanship

library(shiny)
library(nnet)
library(ggplot2)

shinyServer(function(input, output) {

	# load three fitted models
	# pidFit file fits fitPID for Party ID prediction
	# choiceFit file fits fitChoice for vote choice prediction
	# choiceFitNoPID file fits fitChoiceNoID for vote choice wo partisanship
	load("pidFit.rda")
	load("choiceFit.rda")
	load("choiceFitNoPID.rda")

	varChoices <- reactive({

		# pull inputs into variables of use
		if (input$sex == "Male") sex <- factor(0)
		if (input$sex == "Female") sex <- factor(1)

		if (input$race == "White") {
			black <- factor(0)
			hisp <- factor(0)
		} else if (input$race == "African American") {
			black <- factor(1)
			hisp <- factor(0)
		} else {
			black <- factor(0)
			hisp <- factor(1)
		}

		age <- input$age
		income <- input$income

		if (input$educ == "No High School") educ <- factor(0)
		if (input$educ == "High School") educ <- factor(1)
		if (input$educ == "Some College") educ <- factor(2)
		if (input$educ == "College Grad") educ <- factor(3)
		if (input$educ == "Post-Grad") educ <- factor(4)

		if (input$pid == "Independent") pid <- factor(0)
		if (input$pid == "Democrat") pid <- factor(1)
		if (input$pid == "Republican") pid <- factor(2)

		data.frame(pid=pid,
				   sex=sex,
				   black=black,
				   hisp=hisp,
				   age=age,
				   educ=educ,
				   income=income)

	})

	################################
	# Predicting Partisan ID (Tab 1)
	probPID <- reactive({
		predict(fitPID, type="probs", newdata=varChoices())
	})

	# create bar graph of probabilities
	output$pidPlot <- renderPlot({

		probs.df <- data.frame(probs=probPID(),
							   party=ordered(c("Independent",
											   "Democrat",
											   "Republican"))
							   )

		probs.df$party <- factor(probs.df$party, 
								 levels=unique(probs.df$party))

		locs <- data.frame(x=1:3, 
						   y=probs.df$probs+.04,
						   label=round(probs.df$probs, digits=2))

		print(ggplot(probs.df, aes(x=party, y=probs, fill=party)) + 
				geom_bar(stat='identity', width=.5, alpha=.6) + 
				scale_fill_manual(values=c('#00CC99','#3366CC','#CC0000')) + 
				coord_flip() + ylim(c(0,1.05)) + ylab('') + xlab('') + 
				theme(legend.position='none', text=element_text(size=20),
					  panel.border=element_rect('#666666', fill=NA)) +
				annotate("text", x=locs$x, y=locs$y, label=locs$label) +
				theme_minimal())

	})

	################################
	# Predicting vote choice (Tab 2)
	probChoice <- reactive({

		if (input$pidSelect == TRUE) {	
			predict(fitChoice, type="response", newdata=varChoices())
		} else if (input$pidSelect == FALSE) {
			predict(fitChoiceNoPID, type="response", newdata=varChoices())
		}

	})

	# create bar graph of probs for Romney/Obama choice
	output$choicePlot <- renderPlot({

		probs.df <- data.frame(probs=c(probChoice(),1-probChoice()),
							   choice=ordered(c("Obama","Romney")))
		
		probs.df$choice <- factor(probs.df$choice,
								  levels=unique(probs.df$choice))

		locs <- data.frame(x=1:2,
						   y=probs.df$probs+.04,
						   label=round(probs.df$probs, digits=2))

		print(ggplot(probs.df, aes(x=choice, y=probs, fill=choice)) + 
				geom_bar(stat='identity', width=.5, alpha=.6) + 
				scale_fill_manual(values=c('#3366CC','#CC0000')) + 
				coord_flip() + ylim(c(0,1.05)) + ylab('') + xlab('') + 
				theme(legend.position='none', text=element_text(size=20),
					  panel.border=element_rect('#666666', fill=NA)) +
				annotate("text", x=locs$x, y=locs$y, label=locs$label) +
				theme_minimal())

	})




})
								   

	
