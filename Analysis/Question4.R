#Plot GDP for all countries
#color by Income Group (income.group)

EducationGDPClean<-data.frame(EducationGDP$CountryCode,EducationGDP$GDPDollarsMM2012,EducationGDP$IncomeGroup)
names(EducationGDPClean)<-c("CountryCode","GDPDollarsMM2012","IncomeGroup")

EducationGDPClean<-EducationGDPClean[!is.na(EducationGDPClean$GDPDollarsMM2012),]

p <- ggplot(data = EducationGDPClean,aes(reorder(CountryCode,GDPDollarsMM2012), y=GDPDollarsMM2012))
p+geom_point(aes(colour=IncomeGroup))+labs(title="GDP by Country", y = "2012 GDP, $MM", x="Country Code")

