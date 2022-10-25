##############################################################################
## Assignment 2: SPL Data & DPLYR
## Please write your code/responses in the places marked "Your code/response here."

## This assignment draws on Seattle Public Library circulation data from 2018-2022. The data only includes items that were checked out at least 15 times in a month.

## To explore the circulation data for yourself, see: 
## https://data.seattle.gov/Community/Checkouts-by-Title/tmmm-ytt6/data
##############################################################################

## Name: Joe Lollo

## 1. Load the Seattle Public Library circulation dataset from the URL below and save it to a variable called `spl_df` (2 points)
# https://github.com/melaniewalsh/Neat-Datasets/raw/main/Checkouts_by_Title_2018-2022_15-checkouts.csv
# Make sure you use the special argument that ensures text columns will be interpreted correctly!
spl_df <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/Checkouts_by_Title_2018-2022_15-checkouts.csv", stringsAsFactors = FALSE)

## 2. Load the DPLYR library (1 point)
library("dplyr") #On my console, this doesn't work unless I have the quotes...

## 3. How many rows are in this dataset?
# Use a built-in R function to find the number of rows and save to the variable `num_rows` (1 point)
num_rows <- nrow(spl_df)
print(num_rows) # returns 278,974 (HUGE), done just to make sure.

## 4. How many columns are in this dataset?
# Use a built-in R function to find the number of columns and save to the variable `num_cols` (1 point)
num_cols <- ncol(spl_df)
print(num_cols) # returns 11, done just to make sure.

## 5. There are more than just books in this dataset. Use a DPLYR function to identify all of the different, or "distinct," material types
# Save these values to the variable `material_types` (2 points)
material_types <- spl_df %>% distinct(MaterialType)

## How do the total number of checkouts for each material type compare — i.e., number of books checked out vs e-books vs audiobooks, etc.

# We can answer this question in a few different ways. Let's first try to filter the dataframe.
# 6. Filter the dataframe for only print books and save the books dataframe to the variable `books_df` (2 points)
books_df <- spl_df %>% filter(MaterialType == "BOOK")

# 7. Now use a DPLYR function to calculate the sum total number of checkouts for books from 2018-2022.
# Save this number to the variable `num_books` (2 points)
# (Your result may be a dataframe, and that's fine)
num_books <- books_df %>% summarize(TotalCheckouts = sum(Checkouts))
#I decided to add a variable name because sum(Checkouts) is not a very descriptive or useful column title.

print(num_books) #Printing the one-value data frame, should return 3018122.

# A more efficient way to calculate the number of checkouts for each material type might be to group the material types together and then do a calculation on each group.

# 8. Use a DPLYR function to group by material type, and then calculate the sum total checkouts for each material type.
# Save to a variable `checkouts_per_material_type` (6 points)
checkouts_per_material_type <- spl_df %>% group_by(MaterialType) %>%
                               summarize(Total_Checkouts = sum(Checkouts))

# View the `checkouts_per_material_type` dataframe and inspect the results
# 9. Make a built-in comment below, and answer the following questions in a few sentences:
# Which material type has the most number of checkouts, and does it surprise you or not?
# What other patterns or observations stand out to you or are interesting to you from the `checkouts_per_material_type` dataframe? (4 points)

# Answer:
# The material that has the highest number of checkouts is a physical book, 
#but this honestly both DOES and DOESN'T surprise me at the same time, if 
#that's even possible -- while I knew that books would definitely be among
#the top, I'm surprised that the higher demand for ebooks and audiobooks didn't
#diminish one of the most fundamental parts of a library by too much, especially
#with the rise of audiobooks in the pandemic and the fact that everyone 
#(myself included) bought a Kindle at that time too.

# Something I find very interesting is that there are multiple DVDs (or 
#"videodiscs", as SPL data calls them) that have distinct labels and checkouts 
#in the dataset (3259 on "MOVIE" items, 652 on "TELEVISION" itmes, for 
#example) -- if it was not for me looking at the bigger dataset (and the fact that 
#many of them have "- DVD" in their hold title), I honestly would not have guessed that 
#they were DVDs based on their vague labels, like "movie" and "television," #if it was not for looking at the dataset.


# 10. How do the total number of checkouts from the SPL fluctuate over time? 
# Use a DPLYR function to group by year, and then calculate the sum total checkouts for each year
# Save to a variable `checkouts_per_year` (6 points)
checkouts_per_year <- spl_df %>% group_by(CheckoutYear) %>% 
                      summarize(Yearly_Checkouts = sum(Checkouts))

# For fun, you can plot these results:
plot(checkouts_per_year, type = "b")

# How do the total number of checkouts from the SPL fluctuate over time for a specific title or author?

# 11. First, filter the spl_df for a specific title or author of your choice. To do this filtering, you will probably need to use str_detect() from the stringr library.
# Save the filtered dataframe to the variable `query_df` (4 points)
library("stringr")
query_df <- spl_df %>% filter(str_detect(Creator, "Stephenie.*Meyer|Meyer.*Stephenie"))

# 12. Now use a DPLYR function to group by year for that particular author or title, and then calculate the sum total checkouts for each year for that author or title
# Save to a variable `query_checkouts_per_year` (6 points)
query_checkouts_per_year <- query_df %>% group_by(CheckoutYear) %>%
                            summarize(Yearly_Checkouts = sum(Checkouts))

# For fun, you can plot these results:
plot(query_checkouts_per_year, type = 'b')

# 13. Lastly, come up with your own question that you want to answer about the SPL data, and then answer it by writing the appropriate code. You should use at least one DPLYR function. (3 points)
#--EVERYTHING BELOW THIS LINE IS MY CUSTOM QUESTION AND ANSWER--
# Question: Science fiction is my favorite genre of all time, for any form of media
#or art. In a similar vein to the questions above, I want to use a DPLYR
#function to search for "Science Fiction" in the subject tags and then
#calculate the sum of the total checkouts per year within that tag, to see
#if there was an increase or decrease in interest in science fiction, be it
#literature, movies, or TV, during the COVID-19 pandemic.

# Answer:
scifi_query <- spl_df %>% filter(str_detect(Subjects, "Science Fiction"))

scifi_checkouts <- scifi_query %>% group_by(CheckoutYear) %>%
                   summarize(Yearly_Checkouts = sum(Checkouts))

# As I suspected, if you view the dataset filtered, grouped, and summarized
#the way I did it using DPLYR functions, you can see a confirmation of my hypothesis
#that science fiction-themed materials, at least considered to be SF in the SPL 
#catalogers' eyes, had an increase in interest during the pandemic (2020-2021), as 
#more and more people couldn't believe what was happening to it. I would like
#to take a closer look at the data to see if there are any outliers in the future.

# Plotting the data for an extra visual aid:
plot(scifi_checkouts, type = 'b')
