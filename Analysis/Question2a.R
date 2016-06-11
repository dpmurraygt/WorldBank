#Find the number of NA values
#If we use a sum function combined with is.na, it will
#count the instances where the NA condition exists in the variable

sum(is.na(EducationGDP$GDPDollarsMM2012))
