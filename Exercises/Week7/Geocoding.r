# Geocoding Places and Addresses

# Install geocoder
install.packages("tidygeocoder")

# Load libraries
library("tidygeocoder")
library("dplyr")
library("ggplot2")

# Load "Seattle Places" data
seattle_places <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/Seattle-Places.csv", stringsAsFactors = FALSE)

# Geocode Seattle Places
seattle_places_geo <- seattle_places %>%
  geocode(Places, method = "osm",
          lat = latitude , long = longitude)

### How well did our simple geocoder do????
### Let's test it out by making an interactive map

# Install Leaflet
install.packages("leaflet")
# Load Leaflet
library("leaflet")

# Base layer
leaflet() %>%
  # Base map
  addTiles() %>% 
  # Centering view on Seattle coordinates
  setView(lng = -122.33410, lat = 47.606, zoom = 11) %>%   
  # Add markers
  addMarkers(lat = seattle_places_geo$latitude,
             lng = seattle_places_geo$longitude, 
             label = seattle_places_geo$Places)

# Exercise 1: How well do you think the geocoder did? What mistakes did it make? How do you think it could be improved?
# Write your thoughts in a comment here
# Somep points are accurate -- especially the national parks
#and some of the ones specific to more Seattle-area locations
#(like Fremont), but others....others just make no sense, 
#as it was just going based on name data without any
#addresses.

#### Mapping Seattle Public Library Locations

# Load SPL library locations
spl_locations <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/Seattle_Public_Libraries.csv", stringsAsFactors = FALSE)

# Exercise 2: Geocode the library locations
# Fill in the correct column name below
spl_locations <- spl_locations %>%
  geocode(ADDRESS, method = "osm",
          lat = latitude, long = longitude)

# Exercise 3: Map the library locations onto a map
# Fill in the correct column names below
leaflet() %>%
  addTiles() %>% 
  # Centering view on Seattle coordinates
  setView(lng = -122.33410, lat = 47.606, zoom = 12) %>%  
  # Add markers
  addMarkers(lat = spl_locations$latitude,
             lng = spl_locations$longitude,
             popup = spl_locations$ADDRESS,
             label = spl_locations$LABEL)
