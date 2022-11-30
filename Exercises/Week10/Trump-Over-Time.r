# Track Trump's Use of a Word Over Time
# For practice with reading in CSV files from your own comptuer and working with dates
library(tidyverse)
library("lubridate")
library(tidytext)
library(ggplot2)
library(dplyr)

# Data will be drawn from Trump Twitter Archive v2
# Go to this link and dowload the CSV to your computer
# https://www.thetrumparchive.com/faq
# Then read in the CSV from your own computer
trump_data <- read.csv("/Users/joelollo/Documents/trump-tweets.csv", stringsAsFactors = FALSE)

#For GitHub:
#trump_data <- read.csv("trump-tweets.csv", stringsAsFactors = FALSE)

# Exercise 1: Split the text column into one word per row 
# Save as trump_words
trump_words <- trump_data %>% unnest_tokens(word, text, token = "ngrams", n = 1)

# Exercise 2: Transform the "date" column into an actual date
# For example, if you check the data type of the "date" column, it is "character"
typeof(trump_words$date)
# We want it to be "double"

trump_words <- trump_words %>% mutate(date = ymd_hms(date))

# Check to see if you succeeded
typeof(trump_words$date)

# Exercise 3: Extract just the year from the "date" column and make a new column "year"
# Save as trump_words
trump_words <- trump_words %>% mutate(year = year(date))

# Exercise 4: Filter for the word "america," and then count how many times each year Trump mentioned the word
# Hint: you might need to count by two columns!
filter_words <- trump_words %>% filter(word == "america") %>%
                group_by(year) %>% summarize(count = n())

# Exercise 5: Make a line plot of word frequency over time
ggplot(filter_words) +
  geom_line(mapping = aes(x = year, y = count, color = "#FF0000")) +
  geom_point(mapping = aes(x = year, y = count, fill = "#000000")) +
  labs(x = "Year", y = "Count", title = "Did Trump Make \"America\" Great Again?") 

# When you're done, drop your plot into the Discord server!
