#Clean up the Education file to prepare to merge with the GDP file.

#select the columns that we will actually use in the analysis
EDUFinal<-data.frame(EDU$CountryCode,EDU$Long.Name,EDU$Income.Group,EDU$Region)

#Clean up the Names to make them easier to work with
names(EDUFinal)<-c("CountryCode","LongName","IncomeGroup","Region")

