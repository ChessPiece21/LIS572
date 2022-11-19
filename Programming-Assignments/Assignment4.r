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

## 9. Now it's your turn! Ask your own question about the Goodreads data, and then answer it with code (4 points)
## Your question in English language words here
# My Question: Four books with a very large fandom on the Internet that are represented in this data are the Harry Potter
#series, the Hunger Games series, Percy Jackson & the Olympians, and the Lord of the Rings series. Which of these franchises 
#have a higher average rating, as represented on Goodreads, and are there any specific books in the series that are considered 
#outliers because of extremely high or low average ratings?

# My Answer:
# Create a vector for each book series, based on official_title in the Goodreads data frame.
hp_vector <- c("Harry Potter and the Philosopher's Stone", "Harry Potter and the Chamber of Secrets",
             "Harry Potter and the Prisoner of Azkaban", "Harry Potter and the Goblet of Fire", 
             "Harry Potter and the Order of the Phoenix", "Harry Potter and the Half-Blood Prince",
             "Harry Potter and the Deathly Hallows")

hg_vector <- c("The Hunger Games", "Catching Fire", "Mockingjay")

pjo_vector <- c("The Lightning Thief", "The Sea of Monsters", "The Titan's Curse", "The Battle of the Labyrinth", "The Last Olympian")

lotr_vector <- c("The Fellowship of the Ring", "The Two Towers", "The Return of the King", "The Hobbit or There and Back Again")

# Create small data frames based on the title and add a series indicator for each series plus a custom indicator to join them later.
hp_df <- goodreads_df %>% filter(original_title %in% hp_vector) %>%
         mutate(Series = "Harry Potter")
  
hg_df <- goodreads_df %>% filter(original_title %in% hg_vector) %>%
         mutate(Series = "Hunger Games")

pjo_df <- goodreads_df %>% filter(original_title %in% pjo_vector) %>%
          mutate(Series = "Percy Jackson")

lotr_df <- goodreads_df %>% filter(original_title %in% lotr_vector) %>%
           mutate(Series = "Lord of the Rings")

# Use the full_join function to combine the data frames twice. This isn't the perfect method, but it's the only way I can combine them.
indicators <- c("Series", "original_title", "average_rating", "ratings_count")
combined_1 <- full_join(hp_df, hg_df, by = indicators)
combined_2 <- full_join(pjo_df, lotr_df, by = indicators)

# Create combined_books, which combines all the data frames also using a full_join.
combined_books <- full_join(combined_1, combined_2, by = indicators)

# To comment on this, I used the indicators to join the data frames by multiple parameters, specifically the ones
#I knew I was going to use in my visualizations.

# Plot the data in ggplot and give meaningful names to the title and axes. Save as a variable so it can be used with plotly.
goodreads_plot <- ggplot(data = combined_books) +
                  geom_point(mapping = aes(x = average_rating, y = ratings_count, text = original_title, color = Series)) +
                  labs(x = "Average Rating", y = "Ratings Count", title = "Average Ratings of Popular Fantasy Book Series on Goodreads, By Series")

# Make the plot interactive after saving it, using ggplotly and the tooltip to see the data points.
ggplotly(goodreads_plot, tooltip = "text")

## 10. Were you able to answer your question? What do the patterns or results mean? Why does this question matter? Answer in at least 2-3 sentences (3 points)
# My Answer:
# This question was one that I came up with easily, but was rather difficult to carry out. I was confused as to how to combine the data frames into one before I settled on
#making a vector of parameters that I knew I would visualize. I think it's funny that my prediction was actually incorrect, as Harry Potter has the highest average ranges 
#while The Hunger Games has the lowest (and the largest variance). Percy Jackson and LOTR are squarely in the middle, with LOTR having a generally higher average. This surprises
#me because of J.K. Rowling's controversies led to many people regretting being fans of the books and movies, but at the same time I actually think that 
#this distribution proves that there are people able to separate the art from the artist, or at least make their own meanings out of these iconic books, because people still give them
#higher ratings. 

# Another interesting data point to talk about is that the first books in each series -- The Hobbit, The Lightning Thief, The Hunger Games, and Philosopher's Stone -- have a higher count of 
#ratings than any other books in the series.

# This question matters because it shows the presence of multiple fandoms on Goodreads, which can skew the ratings of books towards a higher or more positive trend than they would be
#in critic circles, for example. The rise of amateur criticism and literary fan culture that was caused by online reader networks such as Goodreads is ultimately a good thing, in my opinion,
#for literature's presence and legacy because it is far more participatory than what rather elitist hubs for the criticism and appreciation of literature we had in the past. I would love to
#continue researching this subject.
