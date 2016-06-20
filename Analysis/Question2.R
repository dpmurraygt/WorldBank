#apply a sort to the dataframe based on GDP ascending
EducationGDP<-EducationGDP[order(EducationGDP$GDPDollarsMM2012),]

#print head records, 10, to show it's been done
head(EducationGDP,10)

#Find the 13th line of data, this will be the 13th record and
#return the name of the country.  
EducationGDP$CountryName[13]
