# TidyText Tutorial
# https://juliasilge.shinyapps.io/learntidytext/#section-thank-you-for-coming-to-my-ted-talk

# TED Talk data comes from:
# https://culturalanalytics.org/article/11044
# https://github.com/kinnaird-laudun/data/blob/main/Release_v0/TEDonly_speakers_final.csv

# Load TED Talk data
ted_talks <- read.csv("https://raw.githubusercontent.com/kinnaird-laudun/data/main/Release_v0/TEDonly_speakers_final.csv", stringsAsFactors = FALSE)

#install.packages("tidytext")
library(tidytext)
library(tidyverse)
library(dplyr)
library(stringr)


# Exercise 1: Split the text column into one word per row 
tidy_talks <- ted_talks %>% unnest_tokens(word, text)


# Exercise 2:Count how often each word appears
word_count <- tidy_talks %>% count(word, sort = TRUE)

## STOPWORDS
install.packages("stopwords")
library("stopwords")

en_stopwords <- data.frame(word = stopwords(language = "en", source = "snowball"))
zh_stopwords <- data.frame(word = stopwords(language = "zh", source = "misc"))
es_stopwords <- data.frame(word = stopwords(language = "es"))

en_stopwords
zh_stopwords
es_stopwords

# Exercise 3: Remove stopwords from word_count
word_count_no_stops <- tidy_talks %>% anti_join(get_stopwords()) %>%
                       count(word, sort = TRUE)

# Exercise 4: Filter for the top X number of words
top_words <- word_count_no_stops %>% filter(n > 4707) 
top_words
#To get the top 10 words


# Exercise 5: Plot the top words as a bar plot with words on the y-axis and frequency on the x-axis
# Re-order the bars from most to least frequent
# Change the fill color of the bars
# Add an overall title and meaningful x, y axis titles
ggplot(data = top_words) +
  geom_col(aes(x = n, y = word, fill = word)) +
  labs(x = "Frequency", y = "Word", title = "Top 10 Words in TED Talks")

# Bonus: Plot two speakers against each other with the code below!

# First, create a dataframe for plotting word frequency between two speakers
plot_texts <- tidy_talks %>%
  filter(speaker_1 %in% c("Al Gore", "Serena Williams")) %>%
  anti_join(en_stopwords) %>%
  count(speaker_1, word) %>%
  group_by(word) %>%
  filter(sum(n) > 5) %>%
  ungroup() %>%
  pivot_wider(names_from = "speaker_1", values_from = "n", values_fill = 0)
