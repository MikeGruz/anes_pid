# set up datasets for predicting probabilities of party membership, by demographic characteristics
require(foreign)
require(plyr)

setwd("~/Documents/Academic/Programming/Shiny/probabilities/anes_timeseries_2012")
anes <- read.csv('anes_timeseries_2012_rawdata.txt', sep='|')

# pull in only relevant variables
anes <- with(anes, data.frame(pid=pid_self,
                              pid_lean=pid_lean,
                              vchoice=presvote2012_x,
                              sex=gender_respondent,
                              white=dem_racecps_white,
                              black=dem_racecps_black,
                              hisp=dem_hisp,
                              age=dem_agegrp_iwdate,
                              educ=dem_edugroup,
                              income=inc_incgroup_pre,
                              union=dem_unionhh,
                              relig=relig_4cat,
                              state=sample_state,
                              weight=weight_full))

# recode vars

# pid - with indies - originally 1 dem 2 rep 3 ind
# after flip, 0 ind 1 dem 2 rep
# also pulls leaning independents from pid_lean
anes$pid[anes$pid==3] <- 0
anes$pid[anes$pid_lean==1] <- 2
anes$pid[anes$pid_lean==3] <- 1
anes <- subset(anes, pid==0 | pid==1 | pid==2)
#anes$pid <- factor(anes$pid)
#anes$pid <- revalue(anes$pid, c("0"="Independent","1"="Democrat","2"="Republican"))

# vote choice - originally 1 Obama 2 Romney, and others
# recoded as 0 Romney 1 Obama
anes$vchoice[anes$vchoice==2] <- 0
anes <- subset(anes, vchoice == 1 | vchoice == 0)

# sex, change coding (originally 1==male, 2==female)
# so 0==Male, 1==Female
anes$sex[anes$sex==1] <- 0
anes$sex[anes$sex==2] <- 1
anes <- subset(anes, sex==0 | sex==1)
anes$sex <- factor(anes$sex)

# white non-hispanic (white==1 & hisp==2)
anes$white[anes$white==1 & anes$hisp==1] <- 0
anes$white <- factor(anes$white)

# black should be ok on its own, but make a factor
anes$black <- factor(anes$black)

# hispanic (1==yes, 2==no, but will recode)
# recoded, 1==hispanic, 0==not
anes$hisp[anes$hisp==2] <- 0
anes <- subset(anes, hisp==0 | hisp==1)
anes$hisp <- factor(anes$hisp)

# recode age, because it's a clusterfuck in ANES data
# coding will go as follows:
# 0 == 17-24
# 1 == 25-34
# 2 == 35-44
# 3 == 45-54
# 4 == 55-64
# 5 == 65-up
#anes$age[anes$age==1 | anes$age==2] <- 0
#anes$age[anes$age==3 | anes$age==4] <- 1
#anes$age[anes$age==5 | anes$age==6] <- 2
#anes$age[anes$age==7 | anes$age==8] <- 3
#anes$age[anes$age==9 | anes$age==10] <- 4
#anes$age[anes$age>=11 & anes$age<=13] <- 5
anes <- subset(anes, age!=-2)
#anes$age <- ordered(anes$age)
#anes$age <- factor(anes$age)

# education, coded 1-5
# (1 no HS, 2 HS, 3 Some college, 4 bach, 5 post-grad)
# recode 0-4
anes$educ <- anes$educ - 1
anes <- subset(anes, educ>=0)
anes$educ <- ordered(anes$educ)

# income, for now just subtract 1 and eliminate DK/NA
anes$income <- anes$income - 1
anes <- subset(anes, income >= 0)
#anes$income <- ordered(anes$income)




















