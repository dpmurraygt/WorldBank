#apply a sort, based on GDP descending
attach((EducationGDP))
EducationGDP<-EducationGDP[order(EducationGDP$GDPDollarsMM2012),]
EducationGDP$CountryName[13]
detach(EducationGDP)
