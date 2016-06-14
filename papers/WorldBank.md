# Understanding GDP and Educational Factors from World Bank Data
Dennis Murray  
June 10, 2016  
###Introduction
The World Bank is an international financial organization with the stated objective of ending world poverty, and promoting shared poverty. (Source: Worldbank.org)  

Accompanying this mission, the Bank also collects data about the national economies and incomes of countries in all parts of the world.  This provides a clearinghouse of objectively collected data about each country, and the economic status of their citizens.

Our data set for this review is comprised of two pieces.  

The first provides the Gross Domestic Product (GDP) of 190 countries.  Gross Domestic Product is defined by the World Bank as "sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products."

The second data source from the World Bank provides a host of demographic data regarding the income of the citizens of each country.  

This report will seek to find and explain the relationships between several of these variables, and the differences among GDP between countries.

###Data Import, Cleaning and Merging

We will require several packages within R to load, process, and visualize the data from the World Bank.  These include dplyr, repmis and ggplot2.


```r
source("Analysis/Environment.R", echo=TRUE)
```

```
## 
## > library(repmis)
## 
## > library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## 
## > library(ggplot2)
```

We will begin by downloading, and then loading to the R environment, each of the data files from the World Bank.


```r
source("Analysis/LoadData.R", echo=TRUE)
```

```
## 
## > GDPurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
## 
## > EDUurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
## 
## > setwd("~/R/6306CaseStudyWeek6/Data")
## 
## > download.file(GDPurl, "GDP.csv")
## 
## > download.file(EDUurl, "education.csv")
## 
## > GDP <- read.csv("GDP.csv", skip = 5, header = FALSE)
## 
## > EDU <- read.csv("education.csv", header = TRUE)
```

First we will clean up the table with the GDP data and provide column names that are tidy and more descriptive.
  

```r
source("Analysis/CleanData1.R", echo=TRUE)
```

```
## 
## > setwd("~/R/6306CaseStudyWeek6")
## 
## > names(GDP) <- c("CountryCode", "GDPRank", "Blank", 
## +     "CountryName", "GDPDollarsMM2012")
## 
## > GDP$GDPDollarsMM2012 <- gsub(",", "", GDP$GDPDollarsMM2012)
## 
## > GDP$GDPDollarsMM2012 <- as.numeric(GDP$GDPDollarsMM2012)
```

```
## Warning: NAs introduced by coercion
```

```
## 
## > GDP <- GDP[1:232, ]
## 
## > GDP <- GDP[1:216, ]
## 
## > GDP$GDPRank <- as.numeric(GDP$GDPRank)
## 
## > GDPFinal <- data.frame(GDP$CountryCode, GDP$GDPRank, 
## +     GDP$CountryName, GDP$GDPDollarsMM2012)
## 
## > names(GDPFinal) <- c("CountryCode", "GDPRank", "CountryName", 
## +     "GDPDollarsMM2012")
## 
## > GDPFinal <- GDPFinal[GDPFinal$CountryCode != "", ]
## 
## > GDPFinal <- GDPFinal[order(-GDPFinal$GDPDollarsMM2012), 
## +     ]
```

Next we will clean up the table with the Education and Income data, and provide cleaner and more descriptive field names.


```r
source("Analysis/CleanData2.R", echo=TRUE)
```

```
## 
## > EDUFinal <- EDU
## 
## > names(EDUFinal) <- c("CountryCode", "LongName", "IncomeGroup", 
## +     "Region", "LendingCategory", "OtherGroups", "CurrencyUnit", 
## +     "LatestPopu ..." ... [TRUNCATED]
```

###Question 1: Match the data based on the country shortcode.  How many of the IDs match?

First, we will merge the two files together using the Country code as a key field in each table.


```r
source("Analysis/MergeData.R", echo=TRUE)
```

```
## 
## > library(dplyr)
## 
## > EducationGDP <- full_join(EDUFinal, GDPFinal, by = "CountryCode")
```

```
## Warning in outer_join_impl(x, y, by$x, by$y): joining factors with
## different levels, coercing to character vector
```



```r
source("Analysis/Question1.R", echo=TRUE)
```

```
## 
## > CompleteRecords <- EducationGDP$CountryCode[!is.na(EducationGDP$CountryName) & 
## +     !is.na(EducationGDP$LongName)]
## 
## > print(length(CompleteRecords))
## [1] 210
## 
## > sum(is.na(EducationGDP$GDPDollarsMM2012))
## [1] 48
```

The join gave us 210 complete records - with definition of complete here meaning instances where both the Long Name (from the Education data) and the Country Name (from the GDP data) are populated for the record, indicating a successful join.

###Question 2: Sort the data frame in ascending order by GDP rank (so United States is last.)  What is the 13th country in the resulting data frame?

First, we will sort the combined data frame on ascending order and then retrieve the 13th ranked country.


```r
source("Analysis/Question2.R", echo=TRUE)
```

```
## 
## > EducationGDP <- EducationGDP[order(EducationGDP$GDPDollarsMM2012), 
## +     ]
## 
## > EducationGDP$CountryName[13]
## [1] St. Kitts and Nevis
## 229 Levels:    East Asia & Pacific   Euro area ... Zimbabwe
```

St. Kitts and Nevis is the 13th ranked country, with 767 million dollars in GDP in 2012.

Second, we will find the number of values where there is no value for the Gross Domestic Product.


```r
source("Analysis/Question2a.R", echo=TRUE)
```

```
## 
## > sum(is.na(EducationGDP$GDPDollarsMM2012))
## [1] 48
```

There are 48 instances of missing value in the GDP field.

###Question 3: What are the average GDP rankings for the "High income: OECD" and "High income: nonOECD" groups?


```r
source("Analysis/Question3.R", echo=TRUE)
```

```
## 
## > tapply(EducationGDP$GDPRank, EducationGDP$IncomeGroup, 
## +     mean, na.rm = TRUE)
##                      High income: nonOECD    High income: OECD 
##                  NaN             58.64865            110.06667 
##           Low income  Lower middle income  Upper middle income 
##             62.02500            101.32143            101.65957 
## 
## > tapply(EducationGDP$GDPRank, EducationGDP$IncomeGroup, 
## +     sd, na.rm = TRUE)
##                      High income: nonOECD    High income: OECD 
##                   NA             66.56251             46.86660 
##           Low income  Lower middle income  Upper middle income 
##             49.83794             57.79497             54.86952
```

The High Income: nonOECD Group has a mean rank of 58.65, and the High Income: OECD group has a mean rank of 110.07.  
The standard deviation of the nonOECD group is also higher than the OECD group, so there may be a more extreme member of the nonOECD group pulling the average lower.


```r
source("Analysis/Question3a.R", echo=TRUE)
```

```
## 
## > sum(!complete.cases(data.frame(EducationGDP$IncomeGroup, 
## +     EducationGDP$GDPRank)))
## [1] 28
```

There are 28 instances of missing either the GDP rank, or the Income Group.

###Question 4: Plot the GDP for all of the countries.  Use ggplot2 to color your plot by Income Group.


```r
source("Analysis/Question4.R", echo=TRUE)
```

```
## 
## > EducationGDPClean <- data.frame(EducationGDP$CountryCode, 
## +     EducationGDP$GDPDollarsMM2012, EducationGDP$IncomeGroup)
## 
## > names(EducationGDPClean) <- c("CountryCode", "GDPDollarsMM2012", 
## +     "IncomeGroup")
## 
## > EducationGDPClean <- EducationGDPClean[!is.na(EducationGDPClean$GDPDollarsMM2012), 
## +     ]
## 
## > p <- ggplot(data = EducationGDPClean, aes(reorder(CountryCode, 
## +     GDPDollarsMM2012), y = GDPDollarsMM2012))
## 
## > p + geom_point(aes(colour = IncomeGroup)) + labs(title = "GDP by Country", 
## +     y = "2012 GDP, $MM", x = "Country Code")
```

<img src="papers\WorldBank_files/figure-html/unnamed-chunk-4-1.png" width="1000px" />

The scale of the visualization shows significant compression of the data on the axis of GDP, due to the significant disparity in value between the lowest (Tuvalu, with a GDP of 40 million) and the United States, with a value of $16,244,600,000.  Fifteen countries have a value over one trillion dollars, out of scale with the remaining 170+ countries.


```r
source("Analysis/Question4a.R")
```

The visualization of the GDP by Country excludes 48 countries that have no value available for GDP.

###Question 5: Cut the GDP ranking into 5 separate quantile groups.  Make a table versus Income.Group.  How many countries are Lower Middle income but among the 38 nations with highest GDP?


```r
source("Analysis/Question5.R", echo=TRUE)
```

```
## 
## > GDPSub <- data.frame(EducationGDP$GDPDollarsMM2012, 
## +     EducationGDP$CountryCode, EducationGDP$IncomeGroup)
## 
## > GDPSub <- GDPSub[complete.cases(GDPSub), ]
## 
## > GDPQuantile <- data.frame(ntile(GDPSub$EducationGDP.GDPDollarsMM2012, 
## +     n = 5), GDPSub$EducationGDP.GDPDollarsMM2012, GDPSub$EducationGDP.Count .... [TRUNCATED] 
## 
## > names(GDPQuantile) <- c("Quantile", "GDP", "CountryCode", 
## +     "IncomeGroup")
## 
## > CrossGDP <- xtabs(~GDPQuantile$Quantile + GDPQuantile$IncomeGroup)
## 
## > CrossGDP
##                     GDPQuantile$IncomeGroup
## GDPQuantile$Quantile    High income: nonOECD High income: OECD Low income
##                    1  0                    2                 0         11
##                    2  0                    4                 1         16
##                    3  0                    8                 1          9
##                    4  0                    5                10          1
##                    5  0                    4                18          0
##                     GDPQuantile$IncomeGroup
## GDPQuantile$Quantile Lower middle income Upper middle income
##                    1                  16                   9
##                    2                   9                   8
##                    3                  11                   9
##                    4                  14                   8
##                    5                   4                  11
```

There are 16 countries in the group of "Lower Middle Income", but in quantile 1 of GDP.  


```r
source("Analysis/Question5a.R", echo=TRUE)
```

```
## 
## > sum(!complete.cases(EducationGDP$GDPDollarsMM2012, 
## +     EducationGDP$CountryCode, EducationGDP$IncomeGroup))
## [1] 49
```

There are 49 countries with an empty value in either GDP or Income Group.
