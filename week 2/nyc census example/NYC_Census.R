# NYC 2015 CENSUS EXAMPLE
# EXPLORATORY DATA ANALYSIS 
# ATTACH PACKAGES
library(tidyr) # for cleaning data
library(dplyr) # for transforming data
library(ggplot2) # for plotting data 
library(ggmap) # for creating maps w/Google Maps
library(ggsci)

# LOAD DATA
nyc <- read.csv ("nyc_census.csv", header=TRUE)
loc <- read.csv ("census_tract_loc.csv", header=TRUE)
summary(nyc) # compute simple statistics 

# REMOVE SCIENTIFIC NOTATION
options(scipen = 999) 

# CLEAN DATA / DROP NA 
dim(nyc)  # 2095 35
nyc_census <- na.omit(nyc) # at this point you can also drop columns that you don't need

# SUMMARY STATISTICS
dim(nyc_census)  # 2095 35
summary(nyc_census)

# CATEGORICAL DISTRIBUTIONS

par(mfrow = c(1,1)) # Create 
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


library(gridExtra)
library(ggthemes)

# conditional barchart
ggplot(nyc_census,aes(x = Borough, y = Women)) + geom_bar(stat = "Identity", fill="black") 
ggplot(nyc_census,aes(x = Borough, y = Women)) + geom_bar(stat = "Identity", fill="grey")+ theme_tufte() 

# conditional barchart
ggplot(nyc_census,aes(x = County, y = Income)) + geom_boxplot(fill="blue")+ theme_classic() 

test = filter(nyc_census, Borough == "Manhattan")
sum(test$Women)


# NUMERICAL DISTRIBUTIONS

# scatterplot
ggplot(nyc_census,aes(x=Poverty, y=Income)) + geom_point(size=1) + theme_bw()+ theme_tufte()
ggplot(nyc_census,aes(x=Poverty, y=Income)) + geom_point(size=1.2,color="darkblue", alpha = 0.5) + theme_tufte()

nyc_q = subset(nyc_census, select = -c(CensusTract, County, Borough))
dim(nyc_q)

# multiple scatterplots
nyc_q %>%
  gather(-Income, key = "var", value = "value") %>%
  ggplot(aes(x = value, y = Income)) +
  geom_point(colour = "blue", alpha = 0.2, size=0.1) +
  facet_wrap(~ var, scales = "free") +
  theme_bw()

ggplot(nyc_census,aes(x = Poverty, y = Income)) + geom_point(colour = "blue", alpha = 0.2, size=1) + theme_bw()


# histogram of all continuous variables 
nyc_q %>%
  gather(., key = "var", value = "value") %>%
  ggplot(aes(value)) +
  geom_histogram(fill='blue') +
  facet_wrap(~ var, scales = "free") +
  theme_bw()




