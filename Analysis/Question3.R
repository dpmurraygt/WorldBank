#Answer for question 3

#Invoke tapply to find the mean of each group
#of the rank of GDP for the High Income OECD and High Income Non-OECD Groups
#use the na.rm=TRUE to remove the NA records

tapply(EducationGDP$GDPRank,EducationGDP$Income.Group,mean,na.rm=TRUE)

tapply(EducationGDP$GDPRank,EducationGDP$Income.Group,sd,na.rm=TRUE)

