##############################################################################
## Assignment 4: Goodreads Reviews

## This assignment draws on Goodreads metadata for 10,000 of the most popular books, including average rating (1-5 stars), number of ratings (1-5 star ratings), number of reviews (textual reviews), book publication date, and more.
## https://github.com/zygmuntz/goodbooks-10k

## Note: You will make a histogram plot and a box plot in this assignment, which you will need to export as PNG image files and submit with your assignment to Gradescope

##############################################################################

# Name: Your name here

## 1. Load the Goodreads review dataset from the URL below and save it to a variable called `goodreads_df` (3 points)
# https://github.com/zygmuntz/goodbooks-10k/blob/master/books.csv?raw=true
# Make sure you use the special argument that ensures text columns will be interpreted correctly
goodreads_df <- read.csv("https://github.com/zygmuntz/goodbooks-10k/blob/master/books.csv?raw=true", stringsAsFactors = FALSE)

# Load ggplot2, dplyr, plotly
#install.packages("tidyverse") # because it's not on my home PC.
#install.packages("plotly") # because it's not on my home PC.
library(ggplot2)
library(dplyr)
library(plotly)

## 2. Calculate the mean rating of all books (2 points)
mean_rating <- goodreads_df %>% summarize(mean_rating = mean(average_rating))
mean_rating # should return 4.002191

## 3. Calculate the median rating of all books (2 points)
median_rating <- goodreads_df %>% summarize(median_rating = median(average_rating))
median_rating # should return 4.02

## 4. Calculate the quartiles for the ratings of all books (2 points)
quartiles <- goodreads_df %>% summarize(quartiles = fivenum(average_rating))
# I got this function, fivenum(), from the Programming Skills textbook.
quartiles # should return a dataframe using all four: lower quartile is 3.85, upper quartile is 4.18.

## 5. Make a histogram plot for the ratings of all books (5 points)
# Change the binwidth to .1
# Give the plot a meaningful title and x, y axis labels
ggplot(goodreads_df, aes(x = average_rating)) + 
  geom_histogram(binwidth = 0.1, color = "black", fill = "purple") +
  labs(title = "Average Rating Distribution of Books on Goodreads", x = "Average Rating", y = "Count")
# Export the histogram plot as a PNG file, and be sure to submit it with your R script

## 6. Make a box plot for the ratings of all books (4 points)
# Give the plot a meaningful title and x axis label
ggplot(goodreads_df, aes(x = average_rating)) + 
  geom_boxplot(color = "black") +
  labs(title = "Average Rating Distribution of Books on Goodreads", x = "Average Rating")
# Export the box plot as a PNG file, and be sure to submit it with your R script

## 7. Is there a relationship between the number of Goodreads reviews (textual reviews) and number of Goodreads ratings (1-5 star ratings) for each book?

## Make a scatter plot of "ratings_count" vs "work_text_reviews_count" for all books (10 points)
# Add a regression line
# Make the plot interactive and add the title of the book in the tooltip
ratings_vs_reviews <- ggplot(goodreads_df) + 
  geom_point(aes(x = ratings_count, y = work_text_reviews_count, text = original_title)) +   
  labs(title = "Ratings and Reviews of Goodreads Books", x = "Number of Ratings", y = "Number of Text Reviews") +
  geom_smooth(method = "lm", aes(x = ratings_count, y = work_text_reviews_count)) +
  scale_x_log10()

ggplotly(ratings_vs_reviews, tooltip = "text")
# Note: I decided to do the *original* title of each text rather than the full title and edition because I thought it would be less messy.
#I was right.


## 8. What do you think? Is there a relationship between number of Goodreads reviews and ratings for books? What is an example of a book that had more ratings than reviews, or more reviews than ratings? Why do you think that is for that particular book? (4 points) Answer in at least 2-3 sentences
# My Answer:
# I think there's an interesting relationship between these two variables -- as a book gains more ratings, there is a much less
#concentrated amount of reviews, as seen on my interactive plot -- most of the data is bundled up around lower numbers, while the higher
#ratings or higher review count are seen as outliers. My prediction was going to be that the number of ratings was going to increase
#as the number of reviews increased, but because there were less data points as the number of ratings went up (which 
#the logarithmic scale I added made even easier to view), I found that it was incorrect -- most of the data points were
#around the middle of the graph/data, and the data was spread out more near the higher numbers. I think the regression
#line in particular is interesting because it shows a weak to medium positive correlation, possibly because of the high amount of
#ratings near the middle.
