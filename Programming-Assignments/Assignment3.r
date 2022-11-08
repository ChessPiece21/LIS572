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
#install.packages("plotly") #once per machine, as I'm including it later
library("plotly") #I need this for later parts of this assignment.

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
total_languages <- pw_df %>% group_by(language) %>% summarize(total.books = n())

## 6. Use a function to slice the top 7 languages with the most number of books translated into English
## Save as top_languages
top_languages <- total_languages %>% slice_max(n = 7, order_by = total.books)

# Now we want to make a line plot that charts the number of book translated into English for these top 7 languages between 2008 and 2022.
# First, we will need to calculate the number of books translated into English per language per year.
# Then, we will need to filter for just the top 7 languages.

## 7. How many books from each language were published per year? (3 points)
## Save as total_languages_per_year
total_languages_per_year <- pw_df %>% group_by(language, pubdate.yr) %>% 
  summarize(total.books = n())

## 8. Now, we need to filter this dataframe for only the top 7 languages (2 points)
# We can't use our slicing tool for this task because it would only give us the top languages published in a given year, not overall
# So we'll need to use the work we did in Question 6 when we found the top 7 languages overall with our slicing tool

# Pro tip: You can extract any column from a dataframe and turn it into a vector by using dollar sign $ notation like so
top_languages_vector <- top_languages$language

# Now we have a vector that we can use to filter the dataframe total_languages_per_year for only the top 7 languages
# Hint:You may need to use %in% notation
## Save as top_languages_per_year 
top_languages_per_year <- total_languages_per_year %>% 
  filter(language %in% top_languages_vector)

## 9. Finally, make a line plot of the top 7 languages and how many books have been translated into English from those languages from 2008-2022
# Also choose your own color palette
# And add a meaningful title, x/y axis labels, and a legend title (10 points)
ggplot(top_languages_per_year) + geom_line(mapping = aes(x = pubdate.yr, y = total.books, color = language)) +
  labs(x = "Year", y = "Total Books", title = "Book Translations into English, 2008-2022") +
  scale_color_brewer(palette = "Dark2")

# Export the line plot as a PNG file, and be sure to submit it with your R script

## 10. What do you make of the pattern represented in the line plot above? Does the fluctuation of languages over time surprise you? Why or why not? Answer in at least 2-3 sentences (2 points)
# My Answer:
# I am very surprised that the amount of translations went down significantly during the pandemic, as that was a point in time where many people 
#had much more free time to read and I saw a greater public interest in international literature and film. At the same time, however, 
#this distribution absolutely makes sense because of how hard I know the publishing industry was hit by the pandemic -- there was a big
#decline in revenue from publishers and translators in the age of COVID, and many translators and publishers lost their jobs,
#which is reflected here. This was both surprising and unsurprising. As far as languages are concerned, I was surprised to see Swedish 
#in the top 7 languages, as I can't really think of any popular Swedish authors whose works have been translated and circulated 
#immensely in the U.S. aside from one, (Stieg Larsson) who isn't even in the dataset as he died before the dataset was even produced,
#and I also expected Japanese to be higher than it was because of the fascination that Americans have with Japanese culture and its 
#translation, as well as the inclusion of various works of literature and manga I recognize in the dataset. Overall, it's
#a good representation of the highs and lows (especially in the pandemic, a situation aside from their control) in the publishing industry.

## 11. Calculate the number of authors per gender across the entire dataset
## Save as author_gender (3 points)
author_gender <- pw_df %>% group_by(auth.gender) %>% 
  filter(auth.gender %in% c("Male", "Female", "Both", "Undisclosed")) %>% 
  summarize(count = n())

## 12. Make a bar plot of author_gender, and add a meaningful title  (3 points)
author_plot <- ggplot(author_gender) + 
  geom_col(aes(x = auth.gender, y = count, fill = auth.gender)) +
  labs(x = "Author Gender", y = "Number of Books", title = "Gender Distribution of Translated Authors, Top 7 Languages")

ggplotly(author_plot)

# Export the bar plot as a PNG file, and be sure to submit it with your R script

## 13. Calculate the number of translators per gender across the entire dataset (3 points)
## Save as translator_gender 
translator_gender <- pw_df %>% group_by(trnsl.gend) %>% 
  filter(trnsl.gend %in% c("Male", "Female", "Both", "Undisclosed")) %>% 
  summarize(count = n())

## 14. Make a bar plot of translator_gender, and add a meaningful title (3 points)
translator_plot <- ggplot(translator_gender) + 
  geom_col(aes(x = trnsl.gend, y = count, fill = trnsl.gend)) +
  labs(x = "Translator Gender", y = "Number of Books", title = "Gender Distribution of Book Translators, Top 7 Languages")

ggplotly(translator_plot)

# Export the bar plot as a PNG file, and be sure to submit it with your R script

## 15. What do you make of the differences between author gender and translator gender? What do you think explains the similarity or difference? Answer in at least 2-3 sentences (2 points)
# My Answer:
# There are many more male authors than female authors (males: 5491, females: 2706), which says a lot about the book publishing industry as a whole, 
#but the gender imbalance is much lower in the translator data (males: 4067, females: 3698). 

# I think this inequality stems from both the publishing tradition of championing more "serious" male writers, as well as more general societal 
#attitudes regarding women's interests and their role in society – for example, there is a general cultural assumption across the Western world that 
#women write feel-good, domestic "fluff" fiction whereas men write more "intellectual" literary work which publishers will probably pick up more. 
#The ratio between translators' genders was closer, which makes me think that there is less of a cultural stigma regarding womens' roles as translators 
#than as authors in some cultures.

# I am curious about the identities of the "undisclosed" author and translator genders, and I see many questions that arise from just thinking about 
#them -- are they hiding their identities? Were their genders never revealed to the public? Did they choose to not have themselves publicly revealed? 
#These are questions that my exploration and analysis of the data provoked in me, even if I know I will never have the answers, because the fact that 
#there are quite a few (29 translators and 8 authors) is interesting and does beg some curiosity.

#(if you're wondering why I used ggplotly, it's so that I could make the note of the number of each author and translator based on gender)

# Side note: there were quite a few blank data points, and I wasn't sure what to do with them. I thought that they would make the final analysis harder 
#to read, even if there are many arguments I hold against "data cleaning," so I decided to eliminate them from my dataset. This gives a narrower picture 
#of the data, as the dataset has several points that have an author or translator's name indicated but don't indicate their gender, but I think this 
#"cleaning" was beneficial because of how it makes the visualization much easier to read, especially for translators because their work was not always indicated
#and it led to blanks clogging up the visualization.

## 16. Now it's your turn! Ask your own question about the PW Translation data, and then answer it with code (4 points)
## First, write down your question in English language words here:
# My Question:
# What are the top genres that have been translated, seeing how the PW data frame includes genres as a listed column? 
# This I know I will answer using DPLYR function, namely group-by(). I believe fiction will be the highest, with nonfiction as a close second.

# To follow up, is there a relationship between genre and language, especially among the top 10 languages? 
# I will answer this with a stacked bar chart, using the position modifier indicated in the textbook, and the filter() function in DPLYR.

# Then answer it with code below
# My Code:
# Group the original PW data frame by genre and language, count
#each instance.
genre_df <- pw_df %>% group_by(genre, language) %>% 
  summarize(count = n())
# Comment: I think I will keep the blanks here because it is super interesting to see how there is one blank language and two blank genres, as
#you can see in the dataset. This is an example of how NOT cleaning data can possibly make your analysis richer.

# Create the filtered data frame of the top 7 languages. Use the language vector from before!
top_by_genre <- genre_df %>% filter(language %in% top_languages_vector)

# Visualize the data using a stacked bar chart. Make it interactive with ggplotly().
top_7_by_genre <- ggplot(top_by_genre) + 
  geom_col(aes(x = language, y = count, fill = genre), position = "fill") +
  labs(x = "Genre", y = "Number of Books", title = "Genre Distributions in the Top 7 Languages")

ggplotly(top_7_by_genre) #So that we can interact with it too.

## 17. Were you able to answer your question? What do the patterns or results mean? Why does this question matter? Answer in at least 2-3 sentences (2 points)
# My Answer:
# Yes, I was able to answer my question. I predicted at first that the most translated genre was going to be fiction, and by the looks of things, 
#especially after seeing the specific counts using Plotly, that prediction was accurate. I think that the questions I wrote matter because they can 
#potentially reveal additional biases in what gets translated, and for whom, in the American literary market/publishing industry. It makes me think 
#that similar to gender bias in authors, which was encountered in a previous question on this assignment, there is also some sort of bias in the genres 
#published, which is just based on mass-market appeal. Having visualizations of data that's only readable can make these patterns more noticeable to 
#people who are not data-literate, as I predict a lot of the PW audience would be, and I think it can possibly inspire translators to translate more 
#diverse books that can appeal to a wider variety of audiences, especially nonfiction which appeals to older generations, children's literature, and 
#poetry (which is usually a very niche literary genre).

## 18. What's one more question that you would like to explore with this data if you had time? (2 points)
# One additional question I have, that I would love to explore with this data if I had more time, is the correlation between language and country.
# For example, many books in this dataset are originally written in French and Spanish but do not come from France and Spain, and I think that
#exploring this could shed some more light on the diversity of authors' backgrounds, as not everyone who speaks a nation's language is from that nation, 
#and add an additional cultural narrative behind the data as it can give way to revealing some more complex histories as to why that language is spoken in
#other countries, and evoke some feelings. Looking at the relationship between language and nation would be an example decolonizing this sort of data 
#visualization work, as it can reveal what languages have been subjugated onto other countries.
