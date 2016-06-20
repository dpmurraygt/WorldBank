#Subset the GDP Data to select ranks >16
library(ggplot2)
EducationGDPCleanLow<-data.frame(EducationGDP$CountryCode,EducationGDP$GDPDollarsMM2012,EducationGDP$IncomeGroup,EducationGDP$GDPRank)
names(EducationGDPCleanLow)<-c("CountryCode","GDPDollarsMM2012","IncomeGroup","GDPRank")

EducationGDPCleanLow<-EducationGDPCleanLow[!is.na(EducationGDPCleanLow$GDPDollarsMM2012),]
EducationGDPCleanLow<-EducationGDPCleanLow[EducationGDPCleanLow$GDPRank>15,]

pl <- ggplot(data = EducationGDPCleanLow,aes(reorder(CountryCode,GDPDollarsMM2012), y=GDPDollarsMM2012))
pl+geom_point(aes(colour=IncomeGroup))+labs(title="GDP by Country", y = "2012 GDP, $MM", x="Country Code")

