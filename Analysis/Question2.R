#apply a sort, based on GDP descending
attach((EducationGDP))
EducationGDP<-EducationGDP[order(-GDPDollarsMM2012),]
detach(EducationGDP)
