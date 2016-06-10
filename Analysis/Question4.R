#Plot GDP for all countries
#color by Income Group (income.group)




p <- ggplot(data = EducationGDP,aes(reorder(CountryCode,GDPDollarsMM2012), y=GDPDollarsMM2012))
p+geom_point(aes(colour=Income.Group))

