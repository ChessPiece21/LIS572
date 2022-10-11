# Load data
np_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/1979-2020-National-Park-Visits-By-State.csv")

# View this data frame by clicking on the spreadsheet icon in the Global Environment

# Install tidyverse
install.packages("tidyverse")

# Load dplyr library
library(dplyr)

# Select 2 columns from the data and save to the variable smaller_df
smaller_df <- select(np_data, Region, RecreationVisits)

# View this data frame by clicking on the spreadsheet icon in the Global Environment

# Filter the data frame for only values in the state of Washington and save to the variable
# Hint: Think about the special equals sign that you will need to use!
wa_parks <- filter(np_data, State == "WA")

# View this data frame by clicking on the spreadsheet icon in the Global Environment

# Calculate the sum total of RecreationVisits to Washington by using summarize() on the smaller data frame wa_parks
summarize(wa_parks, sum(RecreationVisits))
