#Cut the GDP rankings into 5 quantiles
#Table of Quantile versus Income Group
#How many countries are lower middle income but amog the 38 nations with highest GDP?

#Get a subset of the data frame

GDPSub<-data.frame(EducationGDP$GDPDollarsMM2012,EducationGDP$CountryCode,EducationGDP$IncomeGroup)

#Remove the lines that don't have all of GDP Dollars, Country Code, Income Group

GDPSub<-GDPSub[complete.cases(GDPSub),]

#call the ntile function from dplyr to split the GDP into n=5 groups, put it in a new data frame

GDPQuantile<-data.frame(ntile(GDPSub$EducationGDP.GDPDollarsMM2012,n=5),GDPSub$EducationGDP.GDPDollarsMM2012,GDPSub$EducationGDP.CountryCode,GDPSub$EducationGDP.IncomeGroup)

#give the vectors more descriptive names

names(GDPQuantile)<-c("Quantile","GDP","CountryCode","IncomeGroup")

#display a cross tab of the quantile with the Income Group

CrossGDP<-xtabs(~GDPQuantile$Quantile+GDPQuantile$IncomeGroup)

#print the cross tab

CrossGDP
