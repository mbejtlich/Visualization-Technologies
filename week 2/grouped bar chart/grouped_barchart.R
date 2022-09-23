# library
library(tidyr) # for cleaning data
library(dplyr) # for transforming data
library(ggplot2) # for plotting data 
library(ggmap) # for creating maps w/Google Maps
library(ggsci)
library(gridExtra)
library(ggthemes)

# create a dataset
nyc <- read.csv ("canopystreettree_supp_boro.csv", header=TRUE)
new_df <- select(nyc,boroname,canopy2010percent,canopy2017percent)

long <- new_df %>% gather(year, value, -c(boroname))

# Grouped
ggplot(long, aes(x=boroname, y=value, group=year, fill=year)) + 
  geom_bar(position="dodge", stat="identity")+scale_y_continuous(expand=c(0,0))+theme_classic()