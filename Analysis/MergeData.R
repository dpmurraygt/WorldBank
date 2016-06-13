#This script will merge the data from the EDU dataframe with the GDP dataframe

#load dplyr

library(dplyr)

#Set the merge field and merge into a new dataframe

EducationGDP<-full_join(EDUFinal,GDPFinal,by="CountryCode")
