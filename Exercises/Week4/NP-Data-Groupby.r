# NP Data Groupby

# Load the data
np_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/1979-2020-National-Park-Visits-By-State.csv", stringsAsFactors = FALSE)

# Load dplyr library
library(dplyr)

# Exercise 1: What is the average number of visits for each state from 1979 to 2020?
# Save as avg_state_visits and then view the resulting dataframe
avg_state_visits <- np_data %>%
  group_by(State) %>%
  summarize(mean(RecreationVisits))

# What state has the most and least average visits?
# What patterns or surprises do you notice?

# American Samoa has the last average visits, Tennessee the most. 
# I predicted Wyoming would be one of the highest, and that was accurate,
#because Yellowstone is one of the biggest and most visited national parks
#in the U.S.
# I'm surprised that California isn't higher, because it has a lot of national
#parks and people do go to them fairly often.

# Exercise 2:  What is the average number of visits for each National Park?
# Save as avg_park_visits and then view the resulting dataframe
avg_park_visits <- np_data %>%
  group_by(ParkName) %>%
  summarize(mean(RecreationVisits))

# Which National Park has the most and least average visits?
# What patterns or surprises do you notice?
# The national park with the highest average visits is Great Smoky Mountains
#National Park in Tennessee, the lowest Kobuk Valley National Park in Alaska
#(expected, because it's cold there). 
# The correlation with avg_state_visits is somewhat high, as the states
#with high average numbers have high visits in their individual parks.
#I'd like to see them both as boxplots so I can see if there's any outliers.

# Exercise 3: How many National Parks are there in each state?
# Save as distinct_parks
distinct_parks <- np_data %>%
  group_by(State) %>%
  summarize(NumParks = n_distinct(ParkName))

# Which state has the most national parks? California
# What patterns or surprises do you notice?
# More than 50% of the states included in this dataset have only 1 park, which
#is interesting to note as it's what leads to a big skew in the data.
