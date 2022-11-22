##############################################################################
## Assignment 4: Text Analysis of Your Favorite Book 
# (From Project Gutenberg)

## In this assignment, you will be calculating the most frequent words in a text of your choice from Project Gutenberg, making a bar plot of top words, and making an argument about what these top words represent or reveal about your text.
# https://www.gutenberg.org/ebooks/search/?sort_order=downloads

## Note: You will make 1 bar plot in this assignment, which you will need to export as PNG image file and submit with your assignment to Gradescope

##############################################################################

# Name: Joe Lollo

## Load the necessary libraries
install.packages("tidyverse")
install.packages("gutenbergr")
install.packages("tidytext")
library(gutenbergr)
library(tidytext)
library(dplyr)
library(ggplot2)

# 1. Choose a text from Project Gutenberg, find the text's unique ID, and download the text as a dataframe by putting the ID in the function below (2 points)
# https://www.gutenberg.org/ebooks/search/?sort_order=downloads
# Note: The ID should be the last numbers in the text's URL
# e.g. Kate Chopin's The Awakening URL is https://www.gutenberg.org/ebooks/160 and the ID is 160
#book_data <- gutenberg_download(41445)
book_lines <- readLines("https://www.gutenberg.org/cache/epub/42324/pg42324.txt")
book_data <- data.frame(line=1:length(book_lines), text=book_lines)
  
# 2. Before you begin your analysis, answer these questions in 2-4 sentences. (3 points)
# What book did you choose, and why?
# What do you think will be some of the most frequent words in your text? Why? 
# What do you think would be an interesting word or words to analyze? Why?

## My Answer:
# I chose the original 1818 version of Mary Shelley's Frankenstein (Gutenberg ID 41445), which happens to be 
#one of my favorite books of all time. I chose it because, aside from its legacy and status as one 
#of my favorite books of all time, it is known for having some very unique approaches to written 
#English that I would be interested in exploring here.

# I think that "Father" will be among the top words included in the novel, because of how Frankenstein's Creature refers
#to the scientist as his "father" and "creator," and that "creature" would also be of a similarly high
#frequency because of how much I remember it being said.

# Some words I would be interested in analyzing are "God," as I said above, and "Adam," both of which
#I'd think appear frequently and describe the creator-creation relationship between Victor and the Creature,
#as Victor refers to his creation frequently as "my Adam," yet I am wondering which one will appear more
#often because it was often considered a taboo to write about religion in a fictional work of that time period.

#I would also be interested in seeing how frequent "alive" is written in the text, since "IT'S ALIVE!" is
#a common misattribution to the original text that was only in film adaptations.

# 3. To do a word frequency analysis, we first need to tokenize the text. (4 points)
# Split the text dataframe into one word per row and save as tidy_book
tidy_book <- book_data %>% unnest_tokens(word, text)
  
# 4. Now, count how many times each word appears and sort from most to least frequent (4 points)
# Save as word_count
word_count <- tidy_book %>% count(word, sort = TRUE)
  
## Next, we need to get rid of stopwords.
  
# Install stopwords
install.packages("stopwords")
# Load stopwords 
library("stopwords")
# Make a dataframe with default English stopwords
en_stopwords <- data.frame(word = stopwords(language = "en", source = "snowball"))

# Add custom stopwords
# If you wish, you can also add custom stopwords as shown below
#en_stopwords <- en_stopwords %>% add_row(word = c("said", "went"))
en_stopwords <- en_stopwords %>% add_row(word = c("said", "went", "then", "now", "yet", "may"))
  
# 5. Now, remove stopwords from the word_count dataframe (4 points)
# Save as meaningful_words
meaningful_words <- word_count %>% anti_join(en_stopwords)
  
# 6. Next, filter the dataframe for only words that appear X number of times (4 points)
# You get to pick the X word frequency threshold
# Save as top_words
top_words <- meaningful_words %>% filter(n > 90)
# This will give us the top 15 words.
  
# 7. Now, plot the top_words as a bar plot with words on the y-axis and frequency on the x-axis (10 points)
# .5 bonus points if you can order the bars from most to least frequent
# Also, change the fill color of the bars
# And add an overall title and meaningful x, y axis titles
# Then export and submit to Gradescope when you're finished
ggplot(top_words) +
  geom_col(aes(x = n, y = reorder(word, +n)), fill = "#00693e") +
  labs(x = "Word Frequency", y = "Word", title = "The Most Frequent Word in Mary Shelley's Frankenstein: Is It \"Alive\"?")
#A nice Frankenstein-themed green.
  
# 8. Answer the following questions in 4 or more sentences. (4 points)
# What do you think the top words reveal or represent about your text, if anything?
# Based on your predictions from Q2, do these results surprise you? Why or why not?
# What other kinds of data would you like to do text analysis on?

## My Answer:
# The word that I predicted to be in the top, specifically "father," was among the top of my
#text analysis results. The fact that "one," which almost seems like a stopword but could at least
#be relevant to the text, is the top word is somewhat surprising, as all that word would
#really do in the novel is indicate a specific person or event/instance. This is interesting to note
#because this word's usage depends so much on its context compared to others in the top. 
# This visualization reveals what was common in 19th Century writing, as well as how some
#general tropes in horror and science fiction were developed, such as "night," and "mind."

# As humorous as my title is, "life," which is related to "alive," is the fourth most popular word 
#in the text after stopwords are removed. The misattribution of "IT'S ALIVE!" to the original text in popular culture
#makes a lot more sense now, as "life" is so frequent in the book. I said in the beginning that I was
#interested in looking at how frequent "life" is included in the text, and I was surprised that there
#was more than I expected.

# Some data I would be interested in doing more text analysis on is word choice, and most frequent words, in
#early (19th-early 20th Century) horror/science fiction novels by women and by men, including 
#Shelley's Frankenstein.I'm definitely inspired by the Cheng "Models of Gender" reading when I say that, 
#but I think looking at how men and women described different subjects in their genres would be
#very interesting because it could show how women may have consistently been doing something
#"different" in their male-dominated genres or trying to "blend in" with male contemporaries.
#Visualizing the data in particular would be very useful for this, since it can provide a visual aid for these discrepancies.
