# SPL Data Part II

# Load the Seattle Public Library Data
# https://github.com/melaniewalsh/Neat-Datasets/raw/main/Checkouts_by_Title_2018-2022_15-checkouts.csv
spl_data <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/Checkouts_by_Title_2018-2022_15-checkouts.csv", stringsAsFactors = FALSE)

# Load the dplyr library
# Load the stringr library
library("dplyr")
library("stringr")

# Count the number of columns and rows
columns <- ncol(spl_data)
rows <- nrow(spl_data)

########### Publishers
# Exercise 1
# What are all the distinct publishers in the SPL data — e.g., Random House, Scholastic, etc.? 
# Save as a variable distinct_publishers
distinct_publishers <- spl_data %>% distinct(Publisher)

#spl_data %>% summarize(n_distinct(Publisher)) #alternate way to do it

############ Creators
# Exercise 2
# Filter the dataframe for a specific author/creator but try to capture different existing representations of their name
# Save as creator_df
creator_df <- spl_data %>% filter(str_detect(Creator, "Stephenie.*Meyer|Meyer.*Stephenie"))

############ Publication Years
# Exercise 3
# What are the most common publication dates for items in the 2018-2022 SPL data?

# To answer this question, you need to make a dataframe that shows how many times each publication date appears.

# Save your new dataframe as a variable called publication_years
publication_years <- spl_data %>% count(PublicationYear)

#publication_years2 <- spl_data %>% group_by(PublicationYear) %>% summarize(n())
#^this also works
#From SPL report: all organized by bibliographic record -- [] printing date, (c) copyright date

# What do you notice about the publication year data? What steps should we take next? Should we clean these values?
# I notice that there is a big difference between the way years were written in 
#the dataset. As we discussed in class, that's mostly because of the different
#types of years mentioned #in the documentation, such as publication and
#copyright years, BUT that is not apparent in the spreadsheet without looking
#at the documentation. While I see many arguments FOR cleaning the data, I also
#think that inconsistencies in data, like the SPL set, can help you answer #questions about time, place, and subject, which can be useful for working 
#with more humanistic questions related to your code. DH is all about 
#preserving data as much as it is working with it from a technical perspective.

############ Most Checked Out Items

# What are the most checked out items in this SPL data?
# How many times has each title been checked out?
# To answer this question, you need to make a dataframe that shows how many times each individual item has been checked out
# Save your new dataframe as a variable called most_checked_out
most_checked_out <- spl_data %>% group_by(Title) %>%
                    summarize(sum(Checkouts))


