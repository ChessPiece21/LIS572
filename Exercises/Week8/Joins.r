# Joining and Exploring the "Fleshing Out Gender" Data

# What is the distribution of author gender across all the books in the corpus?
# To complete this work, we first need to merge two datasets
# Load libraries
library("dplyr")

# Load data
texts <- read.csv("https://raw.githubusercontent.com/melaniewalsh/lis572-au22/main/data/fleshingout_titles.csv", stringsAsFactors = FALSE)
authors <- read.csv("https://raw.githubusercontent.com/melaniewalsh/lis572-au22/main/data/fleshingout_authors.csv", stringsAsFactors = FALSE)

# Exercise 1: Join the texts and authors dataframes together
joined <- left_join(texts, authors, by = "author_id")

# Exercise 2: What is the author gender distribution across all of these books? In other words, how often does each category appear?
gender_breakdown <- joined %>% 
  group_by(auth_gender) %>%
  summarize(count = n())

# Exercise 3: Filter the dataframe for one of these categories to learn more about the category
category <- joined %>% filter(auth_gender %in% c("F"))
