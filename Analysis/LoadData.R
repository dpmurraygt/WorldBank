#This file will load the the two files from the remote site into data frames so that we can begin
#to work on cleaning and merging the files.


#encode the addresses for the data files to two variables

GDPurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
EDUurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

#set the working directory to download the data to
setwd("~/R/6306CaseStudyWeek6/Data")

#download the data to temporary files in the working directory

#download.file(GDPurl,"GDP.csv")
#download.file(EDUurl,"education.csv")

#Read the GDP file from the csv file into a data frame.  We will skip the first five lines of the file as
#they do not contain usable data, and there are not usable headers that we can import so set that argument
#to false

GDP<-read.csv("GDP.csv",skip=5,header=FALSE)

#Read the education file from the csv into a dataframe.  Here, there are no blank lines to skip and there
#is a usable header.

EDU<-read.csv("education.csv",header=TRUE)
