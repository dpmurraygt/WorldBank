#Cut the GDP rankings into 5 quantiles
#Table of Quantile versus Income Group
#How many countries are lower middle income but amog the 38 nations with highest GDP?

#call the ntile function from dplyr to split the GDP into n=5 groups

GDPSub<-data.frame(EducationGDP$GDPDollarsMM2012,EducationGDP$CountryCode,EducationGDP$Income.Group)

GDPSub<-GDPSub[complete.cases(GDPSub),]

GDPQuantile<-data.frame(ntile(EducationGDP$GDPDollarsMM2012,5),EducationGDP$CountryCode,EducationGDP$Income.Group)
