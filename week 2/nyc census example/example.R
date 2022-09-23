# library
library(tidyr) # for cleaning data
library(dplyr) # for transforming data
library(ggplot2) # for plotting data 
library(ggmap) # for creating maps w/Google Maps
library(ggsci)

# create a dataset
nyc <- read.csv ("canopystreettree_supp_boro.csv", header=TRUE)
new_df <- select(nyc,boroname,canopy2010percent,canopy2017percent)

long <- new_df %>% gather(year, value, -c(boroname))

# Grouped
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="dodge", stat="identity")
