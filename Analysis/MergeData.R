#This script will merge the data from the EDU dataframe with the GDP dataframe

#Set the merge field and merge into a new dataframe
#full_join from dplyr will retain all records from both tables

EducationGDP<-full_join(EDUFinal,GDPFinal,by="CountryCode")
