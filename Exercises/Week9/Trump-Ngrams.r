# Analyzing Donald Trump's Tweets via Ngrams
library(tidyverse)
library(tidytext)
library(ggplot2)
library(dplyr)

# Drawn form Trump Twitter Archive v2
# https://www.thetrumparchive.com/
trump_data <- read.csv("https://github.com/melaniewalsh/Intro-Cultural-Analytics/blob/master/book/texts/social-media/Trump-Tweets_2009-2021.csv?raw=true", stringsAsFactors = FALSE)

# Exercise 1: Split the text column into *three* words per row 
# Save as trump_ngrams
trump_ngrams <- trump_data %>% unnest_tokens(trigram, text, token = "ngrams", n = 3)

# Exercise 2:Count how often each ngram appears
# Save as ngram_count
ngram_count <- trump_ngrams %>% count(trigram, sort = TRUE)

# Exercise 3: Re-do Exercise 1 and 2 but this time with *two* words per row
trump_bigrams <- trump_data %>% unnest_tokens(bigram, text, token = "ngrams", n = 2)

bigram_count <- trump_bigrams %>% count(bigram, sort = TRUE)

# Exercise 4: Using bigrams, find out which words most often appear 
# with a specific word of your choice, e.g. "hillary"

# First, separate the bigrams into two columns (word1, word2)
# Then filter word2 for the word of your choice
# Then filter out stopwords for word1
# Then count the occurrences of word1
# Some of the code is already filled in for you
# Save as filtered_count
filtered_count <- trump_bigrams %>%
  # Separate bigrams into word1 and word2
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  # Make a filter for word2 for the word of your choice
  filter(word2 == "obama") %>%
  filter(!word1 %in% stop_words$word) %>% 
  count(word1, sort = TRUE) %>% 
  rename(total = n)

# Exercise 5: Filter for only the top words in  filtered_count
# You get to pick the threshold
top_filtered_ngrams <- filtered_count %>% 
  slice_max(order_by = total, n = 10)

# Exercise 6: Make a horizontal bar plot of Trump bigrams with your word of choice
# Re-order the bars from most to least frequent
# Change the fill color of the bars
# Add an overall title and meaningful x, y axis titles
ggplot(top_filtered_ngrams) +
  geom_col(aes(y = reorder(word1, total), x = total), fill = "red") +
  labs(x = "Word Frequency", y = "Word", title = "New From WatchMojo.com: Top 10 Words Preceding 'Obama'")

# When you're done, drop your plot into the Discord server!


