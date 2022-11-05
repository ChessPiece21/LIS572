##############################################################################
## Assignment 3: Books in Translation

## This assignment draws from the Publisher's Weekly Translation Database, which includes "all works of fiction, poetry, children’s books, and nonfiction translated into English and published in the U.S. after January 2008." The data includes information about the book's original language, country, publisher, author, translator, author gender, translator gender, price, and more.

## https://www.publishersweekly.com/pw/translation/home/index.html

## FAQs https://www.publishersweekly.com/pw/corp/translation-database-FAQ.html

## Note: You will make 1 line plot and 2 bar plots in this assignment, which you will need to export as PNG image files and submit with your assignment to Gradescope

##############################################################################

# Name: Joe Lollo

## 1. Load the Publisher's Weekly Translation dataset from the URL below and save it to a variable called `pw_df` (2 points)
# https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/PW-Translation-2022-11-01.csv
# Make sure you use the special argument that ensures text columns will be interpreted correctly
# Hint: This CSV file is separated by commas, unlike the version we used in class 
pw_df <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/PW-Translation-2022-11-01.csv", stringsAsFactors = FALSE)

## 2. Load DPLYR and ggplot2 (1 point)
#install.packages("tidyverse") #once per machine
library("dplyr")
library("ggplot2")

## 3. How many rows are in this dataset?
# Use a built-in R function to find the number of rows, save it to the variable `num_rows`, then print `num_rows` (1 point)
num_rows <- nrow(pw_df)
print(num_rows) #returns 9830, the number of rows.

## 4. How many columns are in this dataset?
# Use a built-in R function to find the number of columns, save it to the variable `num_cols`, then print `num_cols` (1 point)
num_cols <- ncol(pw_df)
print(num_cols) #returns 18, the number of columns.

## 5. How many books from each language have been translated into English and published since 2008? 
# Calculate how many books from each language have been published (3 points)
## Save as total_languages
total_languages <- pw_df %>% filter(pubdate.yr > 2009) %>% group_by(language) %>% summarize(total.books = n())

## 6. Use a function to slice the top 7 languages with the most number of books translated into English
## Save as top_languages
top_languages <- total_languages %>% slice_max(n = 7, order_by = total.books)

# Now we want to make a line plot that charts the number of book translated into English for these top 7 languages between 2008 and 2022.
# First, we will need to calculate the number of books translated into English per language per year.
# Then, we will need to filter for just the top 7 languages.

## 7. How many books from each language were published per year? (3 points)
## Save as total_languages_per_year
total_languages_per_year <- pw_df %>% group_by(language, pubdate.yr) %>% summarize(total.books = n())

## 8. Now, we need to filter this dataframe for only the top 7 languages (2 points)
# We can't use our slicing tool for this task because it would only give us the top languages published in a given year, not overall
# So we'll need to use the work we did in Question 6 when we found the top 7 languages overall with our slicing tool

# Pro tip: You can extract any column from a dataframe and turn it into a vector by using dollar sign $ notation like so
top_languages_vector <- top_languages$language

# Now we have a vector that we can use to filter the dataframe total_languages_per_year for only the top 7 languages
# Hint:You may need to use %in% notation
## Save as top_languages_per_year 
top_languages_per_year <- total_languages_per_year %>% filter(language %in% top_languages_vector)

## 9. Finally, make a line plot of the top 7 languages and how many books have been translated into English from those languages from 2008-2022
# Also choose your own color palette
# And add a meaningful title, x/y axis labels, and a legend title (10 points)
ggplot(data = top_languages_per_year) + geom_line(mapping = aes(x = pubdate.yr, y = total.books, color = language)) + labs(x = "Year", y = "Total Books", title = "Publishers Weekly Translations by Language, 2008-2022") + scale_color_brewer (palette = "Set2")

# Export the line plot as a PNG file, and be sure to submit it with your R script

## 10. What do you make of the pattern represented in the line plot above? Does the fluctuation of languages over time surprise you? Why or why not? Answer in at least 2-3 sentences (2 points)
# My Answer:
# I am very surprised that the amount of translations went down significantly during the pandemic, 

## 11. Calculate the number of authors per gender across the entire dataset
## Save as author_gender (3 points)
author_gender <- pw_df %>% group_by(auth.gender) %>% summarize(count = n())
# Filtered out the blanks, as there were too many of them.

## 12. Make a bar plot of author_gender, and add a meaningful title  (3 points)
ggplot(data = author_gender) + geom_bar(mapping = aes(x = auth.gender, y = count, color = auth.gender)) + labs(x = "Author Gender", y = "Number of Books", title = "Gender Distribution of Authors Translated by PW") + scale_color_brewer (palette = "Set1")

# Export the bar plot as a PNG file, and be sure to submit it with your R script

## 13. Calculate the number of translators per gender across the entire dataset (3 points)
## Save as translator_gender 
translator_gender <- pw_df %>% group_by(trnsl.gend) %>% summarize(count = n())

## 14. Make a bar plot of translator_gender, and add a meaningful title (3 points)
Your code here

# Export the bar plot as a PNG file, and be sure to submit it with your R script

## 15. What do you make of the differences between author gender and translator gender? What do you think explains the similarity or difference? Answer in at least 2-3 sentences (2 points)

## 16. Now it's your turn! Ask your own question about the PW Translation data, and then answer it with code (4 points)
## First, write down your question in English language words here:
# Your question here
# Then answer it with code below
Your code here

## 17. Were you able to answer your question? What do the patterns or results mean? Why does this question matter? Answer in at least 2-3 sentences (2 points)

## 18. What's one more question that you would like to explore with this data if you had time? (2 points)
