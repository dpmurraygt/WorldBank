#Question 1...How many of the ID's Match?

#subset the dataframe based on having CountryName and Long.Name both populated

CompleteRecords<-EducationGDP$CountryCode[!is.na(EducationGDP$CountryName)&!is.na(EducationGDP$Long.Name)]
print(length(CompleteRecords))
#Find cases where Country Code and Long name is complete, but CountryName is missing
sum(is.na(EducationGDP$GDPDollarsMM2012))
#Find cases where Country Code and Country name is complete, but Long Name is missing
