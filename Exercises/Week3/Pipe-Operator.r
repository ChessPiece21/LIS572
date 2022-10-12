# Use pipe operators
# Load data
np_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/1979-2020-National-Park-Visits-By-State.csv", stringsAsFactors = FALSE)

# View this data frame by clicking on the spreadsheet icon in the Global Environment

# Install tidyverse
#install.packages("tidyverse")

# Load dplyr library
library("dplyr")

# Exercise 1
# Select 2 columns from the data using a DPLYR function
# Save this 2-column data frame to the variable smaller_df
# Make sure to use the pipe %>% operator!
smaller_df <- np_data %>%
              select(Year, RecreationVisits)

plot(smaller_df) #I decided to do this so I could have a visual aid for some of the answers.

# Question 1: How have the total number of visits to National Parks changed from 1979 to 2020? Were there more visits in 2020 than 1979? What do you think?
# There seems to be a higher average of visits over time, especially if you plot the data frame out (like I did), but there's a lot of parks that had 0 visits in the 1980s and 1990s. There is a much higher rate of visits in 2020 than there was in 1979, according to the plot and to some of the data points in the np_data and smaller_df frames.

# Exercise 2
# To find out, first filter the data frame for only values from the year 1979, and then calculate the sum total visits for that year
# Save this to a variable called visits_1979
# You will need to use the pipe %>% operator and multiple dplyr functions! 
visits_1979 <- np_data %>%
               filter(Year == 1979) %>%
               summarize(sum(RecreationVisits))

# Exercise 3
# Next, filter the data frame for only values from the year 2020, and then calculate the sum total visits for that year
# Save to a variable called visits_2020
# You will need to use the pipe %>% operator and multiple dplyr functions! 
visits_2020 <- np_data %>%
               filter(Year == 2020) %>%
               summarize(sum(RecreationVisits))

# Exercise 4
# Now subtract visits_1979 from visits_2020
visits_diff <- visits_2020 - visits_1979
#The difference between the two (if I did this right) is: 15326603

# Question 2: How have the total number of National *Parks* changed from 1979 to 2020? Are there more parks or fewer parks in 2020?
# As my code shows below, there was a lower number of parks in 1979 than 2020. There are 8 more parks in 2020 than there were in 1963.

# Exercise 5
# First, filter the data frame for only values from the year 1979, and then calculate the number of distinct parks for that year
# Save to a variable called parks_1979
# You will need to use the pipe %>% operator and multiple dplyr functions! 
parks_1979 <- np_data %>%
              filter(Year == 1979) %>%
              summarize(n_distinct(ParkName)) #55 distinct parks.

# Exercise 6
# First, filter the data frame for only values from the year 2020, and then calculate the number of distinct parks for that year
# Save to a variable called parks_2020
# You will need to use the pipe %>% operator and multiple dplyr functions! 
parks_2020 <- np_data %>%
              filter(Year == 2020) %>%
              summarize(n_distinct(ParkName)) #63 distinct parks.

# Exercise 7
# Now subtract parks_1979 from parks_2020
parks_diff <- parks_2020 - parks_1979 #Difference is 8.

# Exercise 8
# Find the number of regions
regions <- np_data %>%
           summarize(n_distinct(Region))
