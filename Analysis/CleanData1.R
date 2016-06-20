#This file will start to clean the GDP file and prepare it for use and eventually
#merging with the education file.

#give the columns names so that we can work more easily with them.
setwd("~/R/6306CaseStudyWeek6")
names(GDP)<-c("CountryCode","GDPRank","Blank","CountryName","GDPDollarsMM2012")

#remove the commas from the GDP field

GDP$GDPDollarsMM2012<-gsub(",","",GDP$GDPDollarsMM2012)


#coerce the GDP field to be numeric so that we can rank and perform calculations against it

GDP$GDPDollarsMM2012<-as.numeric(GDP$GDPDollarsMM2012)

#through investigation using tail() I found blank lines and summary data at the 
#end of the file.
#drop lines 232-326...these are blank
#lines 216-232 are summary data, we can exclude those as well
GDPcut<-GDP[1:216,]

#drop v3, v6-v10 as these are empty vectors

#Change the GDPRank to a numeric field
#two step process as going straight to Numeric changed values for some of the 
#rows of data.  First move it to a character
GDPcut$GDPRank<-as.character(GDPcut$GDPRank)


#and then move it to a numeric value
GDPcut$GDPRank<-as.numeric(GDPcut$GDPRank)

#Create a Final version of the data frame

GDPFinal<-data.frame(GDPcut$CountryCode,GDPcut$GDPRank,GDPcut$CountryName,GDPcut$GDPDollarsMM2012)

#fix the field names in GDPFinal
names(GDPFinal)<-c("CountryCode","GDPRank","CountryName","GDPDollarsMM2012")

#Drop Rows that Do not have a Country Code, since this is required to match
#and would show the rows that are actually blanks in original file

GDPFinal<-GDPFinal[GDPFinal$CountryCode!="",]

#Apply a sort by GDPDollarsMM2012, descending

GDPFinal <- GDPFinal[order(-GDPFinal$GDPDollarsMM2012),]
