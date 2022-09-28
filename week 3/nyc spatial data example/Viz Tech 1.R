# Code provided by Kate Kryder
# STEP 1: Find the documentation for the "Leaflet for R" package.
# "Leaflet" (or leaflet.js) is a popular JavaScript library for
# making interactive maps.
# "Leaflet for R" is a package that allows you to use Leaflet in R/RStudio.

# Here is the documentation:
# https://rstudio.github.io/leaflet/


# STEP 2: Install and load "Leaflet for R".
install.packages("leaflet")
library(leaflet)

# Step 3: Make sure Leaflet for R is working.
# (follow the example from the documentation)
m <- leaflet()
m <- addTiles(m)
m <- addMarkers(m, lng=174.768, lat=-36.852, popup="The birthplace of R")
m

# Step 4: Download your data as GeoJSONS.
# Borough Boundaries
# https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm

# Shooting Incident Data
# https://data.cityofnewyork.us/Public-Safety/NYPD-Shooting-Incident-Data-Year-To-Date-/5ucz-vwe8

# Step 5: Open your data using rgdal.
# Here is the manual: https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
install.packages("rgdal")
library(rgdal)
myBoroughs <- readOGR("/Users/katek/Desktop/2022:9:26 (Viz Tech 1, Matt Bejtlich)/Borough Boundaries.geojson")
myMarkers <- readOGR("/Users/katek/Desktop/2022:9:26 (Viz Tech 1, Matt Bejtlich)/NYPD Shooting Incident Data (Year To Date).geojson")

# Step 6: View your data using leaflet.
myMap <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = myBoroughs)
myMap

myMap <- leaflet() %>%
  addTiles() %>%
  addMarkers(data = myMarkers)
myMap

# Step 7: Join your data using sf.
# Here is the documentation: https://r-spatial.github.io/sf/articles/sf1.html
install.packages("sf")
library(sf)

myMarkersSF <- st_as_sf(myMarkers)
myBoroughsSF <- st_as_sf(myBoroughs)
myJoined <- st_join(myMarkersSF, myBoroughsSF, join = st_within)

# Step 8: Calculate the density using sf and dplyr.
# Here is the documentation: https://dplyr.tidyverse.org/
library(dplyr)
myCount <- count(myJoined, boro)
myBoroughsSFCount <- st_join(myBoroughsSF, myCount)
myBoroughsSFCountDen <- mutate(myBoroughsSFCount, density= n / as.numeric(shape_area))

# Step 9: View the result.
myPalette <- colorNumeric( palette="viridis", domain=myBoroughsSFCountDen$density)
myMap <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = myBoroughsSFCountDen,
              fillColor = ~myPalette(density),
              fillOpacity = 1)
myMap

# Some links that might help if you get stuck:
# https://rstudio.github.io/leaflet/choropleths.html
# https://mattherman.info/blog/point-in-poly/
# https://www.helenmakesmaps.com/post/how-to-make-your-first-interactive-map-in-r-gis
# https://gis.stackexchange.com/questions/420955/counting-points-in-polygon-by-time-attribute-condition