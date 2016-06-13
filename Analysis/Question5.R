#Cut the GDP rankings into 5 quantiles
#Table of Quantile versus Income Group
#How many countries are lower middle income but amog the 38 nations with highest GDP?

#call the ntile function from dplyr to split the GDP into n=5 groups

GDPSub<-data.frame(EducationGDP$GDPDollarsMM2012,EducationGDP$CountryCode,EducationGDP$IncomeGroup)

GDPSub<-GDPSub[complete.cases(GDPSub),]

GDPQuantile<-data.frame(ntile(GDPSub$EducationGDP.GDPDollarsMM2012,n=5),GDPSub$EducationGDP.GDPDollarsMM2012,GDPSub$EducationGDP.CountryCode,GDPSub$EducationGDP.IncomeGroup)

names(GDPQuantile)<-c("Quantile","GDP","CountryCode","IncomeGroup")

CrossGDP<-xtabs(~GDPQuantile$Quantile+GDPQuantile$IncomeGroup)

CrossGDP
