### Auditing the Gender Prediction Package

# Install package
install.packages("gender")
install.packages("genderdata")

# Load packages
library("gender")
library("genderdata")
library("dplyr")

# Make a variable with a vector of names
# Start with these names, but feel free to customize later
sample_names <- c("William", "Hillary")

# Exercise 1: Use the gender function to predict the probable gender of each name for the year 1930 with the "ssa" method (Social Security baby names)
gender(sample_names, years = 1930, method = "ssa")

# Exercise 2: Use the gender function to predict the probable gender of each name for the year 2000 with the "ssa" method (Social Security baby names)
gender(sample_names, years = 2000, method = "ssa")

# How do the probabilities change?

## Now, let's test out the gender function on some film characters

# Load film data
film_df <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Intro-Cultural-Analytics/master/book/data/Pudding/Pudding-Film-Dialogue-Clean.csv", stringsAsFactors = FALSE)

# Exercise 3: Filter for a few movies
# Don't forget about the %in% notation!
# For historical and cultural comparison, interesting films include "Citizen Kane," "Selma," "Mulan," and "Snowpiercer"

#Note: I decided to just create a vector and update the original data frame after. The Prequels are masterpieces.
few_films <- c("Star Wars: Episode I - The Phantom Menace", "Star Wars: Episode II - Attack of the Clones", "Star Wars: Episode III - Revenge of the Sith")
# "These are the worst thing that happened since my son" - Mr. Plinkett

film_df <- film_df %>% filter(title %in% few_films)

# Exercise 4: Pull out the character column from the few_movies dataframe and assign to characters below
# Hint: use the $ notation
film_characters <- film_df$character

# Exercise 5: Now run the gender package on these character names, choosing whatever parameters you like, and see what results you get
predicted_gender <- gender(film_characters, years = 2015, method = "ssa")

# How well do you think the gender package is working?
# I don't think it's working well at all. It does not recognize all the characters, especially because of what I picked and how
#it's unrelated to the census data. There's a lot of bias into how this works, that is based in normative definitions of what
#"male" and "female" names purport to be. The fact that people named their children "Padme" and "Anakin" because of the Prequels
#as of 2015 is concerning.
