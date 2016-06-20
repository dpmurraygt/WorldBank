#Plot GDP for all countries
#color by Income Group (income.group)

#select a subset of the GDP records, and alter the names

EducationGDPClean<-data.frame(EducationGDP$CountryCode,EducationGDP$GDPDollarsMM2012,EducationGDP$IncomeGroup)
names(EducationGDPClean)<-c("CountryCode","GDPDollarsMM2012","IncomeGroup")

#Remove the NA values

EducationGDPClean<-EducationGDPClean[!is.na(EducationGDPClean$GDPDollarsMM2012),]

#Create a ggplot expression for what we want to plot
#I included a reorder statement so that I can show the values from least to greatest

p <- ggplot(data = EducationGDPClean,aes(reorder(CountryCode,GDPDollarsMM2012), y=GDPDollarsMM2012))

#Finally show the visualization, adding labels to the axis

p+geom_point(aes(colour=IncomeGroup))+labs(title="GDP by Country", y = "2012 GDP, $MM", x="Country Code")

