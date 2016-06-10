#Clean up the Education file to prepare to merge with the GDP file.

#Shuffle the columns so it makes more sense when we view it

#EDUFinal<-data.frame(EDU$CountryCode,EDU$EDU$Long.Name,EDU$Short.Name,EDU$Table.Name,EDU$Region,EDU$Income.Group,EDU$Lending.category,EDU$Other.groups,EDU$Other.groups,EDU$Currency.Unit,EDU$Latest.population.census,EDU$Latest.household.survey,EDU$Latest.household.survey,EDU$National.accounts.base.year,EDU$National.accounts.reference.year,EDU$System.of.National.Accounts, EDU$SNA.price.valuation, EDU$Alternative.conversion.factor, EDU$PPP.survey.year, EDU$Balance.of.Payments.Manual.in.use, EDU$External.debt.Reporting.status, EDU$System.of.trade, EDU$Government.Accounting.concept, EDU$IMF.data.dissemination.standard, EDU$Source.of.most.recent.Income.and.expenditure.data, EDU$Vital.registration.complete, EDU$Latest.agricultural.census, EDU$Latest.industrial.data, EDU$Latest.trade.data, EDU$Latest.water.withdrawal.data, EDU$X2.alpha.code, EDU$WB.2.code)

EDUFinal<-EDU
