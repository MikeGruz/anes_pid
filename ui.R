# interactive computator for probability of party membership

library(shiny)

shinyUI(

  pageWithSidebar(
    
	headerPanel("Predictors of Political Behavior
				in the 2012 U.S. Election"),

	sidebarPanel(
	  
	  # include script to label age input
	  tags$head(includeScript('ageSlider.js')),
	  
	  # include script to label income input
	  tags$head(includeScript('incomeSlider.js')),

		conditionalPanel(
			condition = "input.tabs1=='Partisanship'",
				h5("Demographic Characteristics")),

		conditionalPanel(
			condition = "input.tabs1=='Vote Choice'",
				h5("Partisanship and Demographics"),

				# put party id in the model
				checkboxInput("pidSelect", "Include Party ID in Model",
							  FALSE),

				# party id radios
  			radioButtons("pid", label="Party ID",
						 choices = c("Republican",
									 "Democrat",
									 "Independent"),
						 selected = "Independent")),

		# sex radio buttons
		radioButtons("sex", "Sex:",
					 choices = c("Male", "Female"),
					 selected = "Male"),

		# race/ethnicity radios
		radioButtons("race", "Race/Ethnicity:",
					choices = c("White","African American","Hispanic"),
					selected = "White"),


		# age slider
		sliderInput("age", "Age:",
					min=1, max=13, step=1, value=1),

		# education radios
		radioButtons("educ", "Education:",
					choices = c("No High School",
								"High School",
								"Some College",
								"College Grad",
								"Post-Grad"),
					 selected="No High School"),

		# income slider
		sliderInput("income", "Income:",
					min=1, max=28, step=1, value=1)
		),
	
	mainPanel(

		# tabset 1 - predicting partisanship
		tabsetPanel(id="tabs1",
			tabPanel("Partisanship",
				plotOutput("pidPlot", width='700px', height='550px'),

				# model info at bottom
				HTML("<br>
			  	<i>Data from the 2012 American National Election Study.
				<br>X-axis denotes predicted probability of party
				membership using a multinomial logistic regression
				model.<br>Republican/Democratic identifiers include
				Independent leaners.</i>")),

		# tabset 2 - predicting vote choice
		tabPanel("Vote Choice",
				plotOutput("choicePlot", width='700px', height='550px'),

				HTML("<br>
			  	<i>Data from the 2012 American National Election Study.
				<br>X-axis denotes predicted probability of vote
				choice using a logistic regression
				model.<br>Republican/Democratic identifiers include
				Independent leaners.</i>"))

		)

	)
)





	)
