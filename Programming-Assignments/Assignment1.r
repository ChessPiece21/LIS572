##############################################################################
## Assignment 1: Intro to R

## Please write your code/responses in the places marked "Your code/response here"

## This assignment draws on real Seattle Public Library circulation data for Emily St. John Mandel's novel Station Eleven in the year 2020.
## You are going to manipulate this real checkout data to explore different trends.
## For context, in March 2020, the WHO declared COVID-19 a pandemic, and this novel is a story about a fictional pandemic.

## To explore the circulation data for yourself, see https://data.seattle.gov/Community/Checkouts-by-Title/tmmm-ytt6/data
##############################################################################

## Name: Joe Lollo

## 1. Assign the words "Station Eleven" to a variable called spl_book (1 point)
spl_book <- "Station Eleven"

## 2. Use a built-in R function to print the data type of the variable spl_book to the Console (1 point)
typeof(spl_book)

## 3. Assign the words "Emily St. John Mandel" to a variable called spl_author (1 point)
spl_author <- "Emily St. John Mandel"
#typeof(spl_author)

## Imagine that we want to print out a statement that will describe any SPL book and author that we are analyzing, like so: "The SPL book that we are analyzing is [spl_book] by [spl_author]." Let's write some code that will accomplish this task.

## 4. Use a built-in R function to print out the sentence "The SPL book that we are analyzing is Station Eleven by Emily St. John Mandel." without actually typing "Station Elevan" and "Emily St. John Mandel" and instead using the variables spl_book and spl_author. (2 points)
paste("The SPL book that we are analyzing is", spl_book, "by", spl_author)

## 5. The number of SPL checkouts for physical copies of Station Eleven across the 12 months of the year 2020 was as follows: 31, 20, 12, 0, 0, 0, 0, 2, 3, 11, 14, 18
## Make a vector of these values and assign them to a variable called spl_checkouts (2 points)
spl_checkouts <- c(31, 20, 12, 0, 0, 0, 0, 2, 3, 11, 14, 18)

# Bonus: You can plot the checkouts by month using plot()!
plot(spl_checkouts)

## 6. Use a built-in R function to calculate the length of the vector spl_checkouts (1 point)
spl_length <- length(spl_checkouts) #Should be 12, because it's the length of the months of the year.

## 7. Use a built-in R function to calculate the maximum value of the vector spl_checkouts (1 point)
spl_max <- max(spl_checkouts) #Should be 31

## 8. Use a built-in R function to calculate the minimum value of the vector spl_checkouts (1 point)
spl_min <- min(spl_checkouts) #Should be 0

## 9. Use a built-in R function to calculate the average (mean) value of the vector spl_checkouts (1 point)
spl_mean <- mean(spl_checkouts) #Should be 9.25

## 10. Use a built-in R function to calculate the sum total of the vector spl_checkouts (1 point)
spl_sum <- sum(spl_checkouts) #Should be 111

## 11. Make a comment below (1 point), and write 3 or more sentences about the pattern of the physical checkouts for Station Eleven across the 12 months of 2020: 31, 20, 12, 0, 0, 0, 0, 2, 3, 11, 14, 18
## Answer: 
## Assuming that January is the first month, February the second, and so on, it is interesting to note that the book had a 4-month period of no physical checkouts from April to July (months indexed by 4:7 in the vector), which makes sense because many libraries were closed at that time as a result of the COVID-19 pandemic. Similarly, the fact that the number of checkouts picks back up starting in August, the month indexed at 8, is a representation of how restrictions were loosened slightly during that time and in-person interactions were slowly being integrated again in these spaces. As my family and I are SPL patrons, I think this distribution is an accurate representation of my experience placing holds on and picking up materials, especially with services picking up to almost "normal" levels right at the end of 2020.

## Does this pattern surprise you? Why or not why not? What other information or data would you want to explore after seeing this information? (3 points)
## Answer:
## I was not entirely surprised that the data went down to 0 in April 2020, given what we knew already about the world and how most services changed to being virtual during the COVID-19 pandemic. Despite this, the visual plot associated with the vector I made helped me understand just how significant of a change the closing of libraries and other institutions during COVID-19 was in our daily lives, as the data is just one bit of information showing that there was no physical or in-person engagement with the library.
## Additionally, I think that having some sort of information about the book and its content would be helpful or interesting, like extra information dedicated to the book's genre or year (indicated in the original book's data, I assume?), would help bring more context as to why there was a newfound interest in this book picking up when COVID hit -- it was only after Googling it that I realized it was a novel about another pandemic or disease, from which I was even LESS surprised than I was initially about the amount of checkouts of the book over 2020. I think this speaks to the big problem associated with only having a limited amount of data dedicated to one subject, as you don't know the full story or context behind what was selected to analyze, especially data related to books and other cultural materials, as well as people-centered research like LIS and the social sciences, as just listing their names and authors may reduce their significance.


