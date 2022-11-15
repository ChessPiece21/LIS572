# Replication Experiment for Fleshing Out Models of Gender

# Load replication data from Fleshing Out Models of Gender
# https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/QUGW8V/S6YFQ9&version=1.0
gender_data <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/Figure1Data.csv", stringsAsFactors = FALSE)


# Exercise 1: See if you can recreate this plot with ggplot
# You are plotting the percentange of characterization that is bodily description over time
# This percentage should be in the "percentage" column
# Note: You might have to google new things or look at the ggplot documentation to add shapes and smoothing lines
library("ggplot2")

ggplot(data = gender_data) +
  geom_point(aes(x = pub_date, y = percentage, shape = gender, color = gender)) + 
  geom_smooth(aes(x = pub_date, y = percentage, color = gender)) +
  scale_color_brewer(palette = "Set1")
