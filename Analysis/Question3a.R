#Find the NA values that remain from our analysis of the 
#Income Groups

sum(!complete.cases(data.frame(EducationGDP$IncomeGroup,EducationGDP$GDPRank)))

