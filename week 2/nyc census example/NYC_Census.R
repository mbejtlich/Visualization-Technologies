# NYC 2015 CENSUS EXAMPLE
# EXPLORATORY DATA ANALYSIS 
# ATTACH PACKAGES
library(tidyr) # for cleaning data
library(dplyr) # for transforming data
library(ggplot2) # for plotting data 
library(ggmap) # for creating maps w/Google Maps

# LOAD DATA
nyc <- read.csv ("nyc_census.csv", header=TRUE)
loc <- read.csv ("census_tract_loc.csv", header=TRUE)
summary(nyc) # compute simple statistics 

# REMOVE SCIENTIFIC NOTATION
options(scipen = 999) 

# CLEAN DATA / DROP NA
dim(nyc)  # 2095 35
nyc <- na.omit(nyc) # at this point you can also drop columns that you don't need

# SUMMARY STATISTICS
dim(nyc)  # 2095 35
summary(nyc)

# CATEGORICAL DISTRIBUTIONS

par(mfrow = c(1,1))
boxplot(Income~County,data = nyc_census,
        main="Boxplot of Income in Different Counties",
        xlab="County",ylab="Income")

par(mfrow = c(2,1))
boxplot(nyc_census$Men~nyc_census$County)
boxplot(nyc_census$Women~nyc_census$County)

par(mfrow = c(2,1))
boxplot(nyc_census$Hispanic~nyc_census$County,ylab="Hispanic")
boxplot(nyc_census$White~nyc_census$County,ylab="White")
boxplot(nyc_census$Black~nyc_census$County,ylab="Black")
boxplot(nyc_census$Asian~nyc_census$County,ylab="Asian")
boxplot(nyc_census$Native~nyc_census$County,ylab="Native")

par(mfrow = c(2,1))
boxplot(nyc_census$Income~nyc_census$County,ylab="Income")
boxplot(nyc_census$Poverty~nyc_census$County,ylab="Poverty")

par(mfrow = c(1,1))
boxplot(nyc_census$Professional~nyc_census$County,ylab="Professional")
boxplot(nyc_census$Service~nyc_census$County,ylab="Service")
boxplot(nyc_census$Office~nyc_census$County,ylab="Office")
boxplot(nyc_census$Construction~nyc_census$County,ylab="Construction")
boxplot(nyc_census$Production~nyc_census$County,ylab="Production")

par(mfrow = c(2,1))
boxplot(nyc_census$Drive~nyc_census$County,ylab="Drive")
boxplot(nyc_census$Transit~nyc_census$County,ylab="Transit")
boxplot(nyc_census$Carpool~nyc_census$County,ylab="Carpool")
boxplot(nyc_census$Walk~nyc_census$County,ylab="Walk")

# conditional barchart
ggplot(nyc,aes(x = Borough, y = Women)) + geom_bar(stat = "Identity") 


test = filter(nyc, Borough == "Manhattan")
sum(test$Women)


# NUMERICAL DISTRIBUTIONS

# scatterplot
p <- ggplot(nyc,aes(x=Poverty, y=Income)) + geom_point(size=1.0)
p

# scatterplot
nyc %>%
  gather(Asian,Black, Carpool, ChildPoverty, Citizen,
         key = "var", value = "value") %>%
  ggplot(aes(x = value, y = IncomePerCap)) +
  geom_point(colour = "blue", alpha = 0.8, size=0.2) +
  facet_wrap(~ var, scales = "free") +
  theme_bw()

# histogram for each variable 
nyc_census %>%
  gather(County, Men, Hispanic, Black, Native, Asian, Citizen, Income, IncomeErr,
         IncomePerCapErr, ChildPoverty, Service, Office, Construction,
         Production, Drive, Carpool, OtherTransp, MeanCommute, Employed, 
         PublicWork, SelfEmployed, FamilyWork,Unemployment,  
         -IncomePerCap, key = "var", value = "value") %>%
  ggplot(aes(value)) +
  geom_histogram(fill='blue') +
  facet_wrap(~ var, scales = "free") +
  theme_bw()




