#Clean up the Education file to prepare to merge with the GDP file.

#select the columns that we will actually use in the analysis
EDUFinal<-data.frame(EDU$CountryCode,EDU$Long.Name,EDU$Income.Group,EDU$Region)

#Clean up the Names to make them easier to work with
names(EDUFinal)<-c("CountryCode","LongName","IncomeGroup","Region")

#names(EDUFinal)<-c("CountryCode","LongName","IncomeGroup","Region","LendingCategory","OtherGroups","CurrencyUnit","LatestPopulationCensus","LatestHouseholdSurvey","SpecialNotes","NationalAccountsBaseYear","NationalAccountsReferenceYear","SystemOfNationalAccounts","SNAPriceValuation","AlternativeConversionFactor","PPPSurveyYear","BalanceOfPaymentsManualInUse","ExternalDebtReportingStatus","SystemOfTrade","GovernmentAccountingConcept","IMFDataDisseminationStandard","SourceOfMostRecentIncomeandExpenditureData","VitalRegistrationComplete","LatestAgriculturalCensus","LatestIndustrialData","LatestTradeData","LatestWaterWithdrawalData","X2AlphaCode","WB2Code","TableName","ShortName")


#Shuffle the columns so it makes more sense when we view it
