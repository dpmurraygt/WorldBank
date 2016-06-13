#This file will start to clean the GDP file and prepare it for use and eventually
#merging with the education file.

#give the columns names so that we can work more easily with them.
setwd("~/R/6306CaseStudyWeek6")
names(GDP)<-c("CountryCode","GDPRank","Blank","CountryName","GDPDollarsMM2012")

#remove the commas from the GDP field

GDP$GDPDollarsMM2012<-gsub(",","",GDP$GDPDollarsMM2012)


#coerce the GDP field to be numeric so that we can rank and perform calculations against it

GDP$GDPDollarsMM2012<-as.numeric(GDP$GDPDollarsMM2012)

#tail(GDP,100)

#drop lines 232-326...these are blank
GDP<-GDP[1:232,]

#lines 216-232 are summary data, we can exclude those as well
GDP<-GDP[1:216,]

#drop v3, v6-v10 as these are empty vectors

#Change the GDPRank to a numeric field
GDP$GDPRank<-as.numeric(GDP$GDPRank)

#Create a Final version of the data frame

GDPFinal<-data.frame(GDP$CountryCode,GDP$GDPRank,GDP$CountryName,GDP$GDPDollarsMM2012)

#fix the field names in GDPFinal
names(GDPFinal)<-c("CountryCode","GDPRank","CountryName","GDPDollarsMM2012")

#Drop Rows that Do not have a Country Code, since this is required to match
#and would show the rows that are actually blanks in original file

GDPFinal<-GDPFinal[GDPFinal$CountryCode!="",]

#Apply a sort by GDPDollarsMM2012, descending

GDPFinal <- GDPFinal[order(-GDPFinal$GDPDollarsMM2012),]
