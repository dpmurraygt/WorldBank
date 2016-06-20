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
## 
## > GDPcut <- GDP[1:216, ]
## 
## > GDPcut$GDPRank <- as.character(GDPcut$GDPRank)
## 
## > GDPcut$GDPRank <- as.numeric(GDPcut$GDPRank)
## 
## > GDPFinal <- data.frame(GDPcut$CountryCode, GDPcut$GDPRank, 
## +     GDPcut$CountryName, GDPcut$GDPDollarsMM2012)
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
## > EDUFinal <- data.frame(EDU$CountryCode, EDU$Long.Name, 
## +     EDU$Income.Group, EDU$Region)
## 
## > names(EDUFinal) <- c("CountryCode", "LongName", "IncomeGroup", 
## +     "Region")
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
## > head(EducationGDP, 10)
##     CountryCode                                     LongName
## 214         TUV                                       Tuvalu
## 108         KIR                         Republic of Kiribati
## 138         MHL             Republic of the Marshall Islands
## 170         PLW                            Republic of Palau
## 195         STP Democratic Republic of São Tomé and Principe
## 70          FSM               Federated States of Micronesia
## 210         TON                             Kingdom of Tonga
## 51          DMA                     Commonwealth of Dominica
## 42          COM                         Union of the Comoros
## 229         WSM                                        Samoa
##             IncomeGroup                    Region GDPRank
## 214 Lower middle income       East Asia & Pacific     190
## 108 Lower middle income       East Asia & Pacific     189
## 138 Lower middle income       East Asia & Pacific     188
## 170 Upper middle income       East Asia & Pacific     187
## 195 Lower middle income        Sub-Saharan Africa     186
## 70  Lower middle income       East Asia & Pacific     185
## 210 Lower middle income       East Asia & Pacific     184
## 51  Upper middle income Latin America & Caribbean     183
## 42           Low income        Sub-Saharan Africa     182
## 229 Lower middle income       East Asia & Pacific     181
##               CountryName GDPDollarsMM2012
## 214                Tuvalu               40
## 108              Kiribati              175
## 138      Marshall Islands              182
## 170                 Palau              228
## 195 São Tomé and Principe              263
## 70  Micronesia, Fed. Sts.              326
## 210                 Tonga              472
## 51               Dominica              480
## 42                Comoros              596
## 229                 Samoa              684
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
##                  NaN             91.91304             32.96667 
##           Low income  Lower middle income  Upper middle income 
##            133.72973            107.70370             92.13333 
## 
## > tapply(EducationGDP$GDPRank, EducationGDP$IncomeGroup, 
## +     sd, na.rm = TRUE)
##                      High income: nonOECD    High income: OECD 
##                   NA             42.68799             27.54868 
##           Low income  Lower middle income  Upper middle income 
##             29.65135             54.19136             56.51010
```

The High Income: nonOECD Group has a mean rank of 32.97, and the High Income: OECD group has a mean rank of 91.9.  
The standard deviation of the nonOECD group is also higher than the OECD group, so there may be some skew to the data of the nonOECD countries.


```r
source("Analysis/Question3a.R", echo=TRUE)
```

```
## 
## > sum(!complete.cases(data.frame(EducationGDP$IncomeGroup, 
## +     EducationGDP$GDPRank)))
## [1] 49
```

There are 49 instances of missing either the GDP rank, or the Income Group.

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

![](papers/Figs/unnamed-chunk-4-1.png)<!-- -->

The scale of the visualization shows significant compression of the data on the axis of GDP, due to the significant disparity in value between the lowest (Tuvalu, with a GDP of 40 million) and the United States, with a value of $16,244,600,000.  Fifteen countries have a value over one trillion dollars, out of scale with the remaining 170+ countries.  Sixty countries have less than one billion dollars in gross domestic product as of 2012.

Most of the top ranked countries are in the highest income groups, with the notable of exception of the second ranked country, China.

If we remove the top 15 countries from the visualization, and replot again,  a greater amount of the variability Gross Domestic Product of the countries ranked 16-190 in the world.  It also appears that most of the lower GDP countries fall into the "Lower Middle Income" or "Low Income" groups, but there are a few higher income countries in the lower tiers.

```r
source("Analysis/Question4b.R", echo=TRUE)
```

```
## 
## > library(ggplot2)
## 
## > EducationGDPCleanLow <- data.frame(EducationGDP$CountryCode, 
## +     EducationGDP$GDPDollarsMM2012, EducationGDP$IncomeGroup, 
## +     EducationGDP$GDP .... [TRUNCATED] 
## 
## > names(EducationGDPCleanLow) <- c("CountryCode", "GDPDollarsMM2012", 
## +     "IncomeGroup", "GDPRank")
## 
## > EducationGDPCleanLow <- EducationGDPCleanLow[!is.na(EducationGDPCleanLow$GDPDollarsMM2012), 
## +     ]
## 
## > EducationGDPCleanLow <- EducationGDPCleanLow[EducationGDPCleanLow$GDPRank > 
## +     15, ]
## 
## > pl <- ggplot(data = EducationGDPCleanLow, aes(reorder(CountryCode, 
## +     GDPDollarsMM2012), y = GDPDollarsMM2012))
## 
## > pl + geom_point(aes(colour = IncomeGroup)) + labs(title = "GDP by Country", 
## +     y = "2012 GDP, $MM", x = "Country Code")
```

![](papers/Figs/unnamed-chunk-5-1.png)<!-- -->



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

There are 16 countries in the group of "Lower Middle Income", but in quantile 1 of GDP. This would raise the question of where the income created from the gross domestic product is going.  Additionally, there are 11 countries in the top quantile of GDP, but classified as Low Income. 


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

###Conclusions
The World Bank data provides insights into the Gross Domestic Product, as well as qualitative data about the countries of the world.

From examining the data, we have found a sizable disaparity in the GDP of the top 15 countries, and the remaining 170 countries of the World.  The Top 15 have gross domestic poroduct in excess of one trillion US Dollars, while sixty countries have less than one billion dollars in gross domestic product.  

Income classification does not necessarily follow the Gross Domestic Product output, either.  Among the top 38 countries in the world, 16 are classified by the World Bank as "Lower Middle Income" or "Low Income." This may show a disparity in the income of the citizens, versus the product created, with either government or a handful of individuals absorbing the value created by the country's economy.

Further investigation into the subject could take the path of examining the income classifications in further depth, or developing a more quantitative measure for income.
