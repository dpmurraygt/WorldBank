#Question 1...How many of the ID's Match?

#subset the dataframe based on having CountryName and Long.Name both populated

CompleteRecords<-EducationGDP$CountryCode[!is.na(EducationGDP$CountryName)&!is.na(EducationGDP$LongName)]

#Find the Total Number of records that have both country name and Long name

print(length(CompleteRecords))

