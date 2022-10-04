# Let's play a game of Mad Libs!

# Talk to your partners and ask them:
# What is their hometown?
# What is their favorite food?
# What is their age?
# Do they like rain — yes or no? 

# Now assign the appropriate values to each of the following variable names
# Use the data type listed in the comment
# Make sure to run each line to save the variable in your Global Environment
hometown <- "Tacoma, WA" #character
food <- "apples" #character
age <- 26 #numeric
likes_rain  <- TRUE #logical
  
# Calculate someone's likely birth year by 
# only using the age variable and a basic math operation
birth_year  <- 2022 - age #numeric

# Use a built-in R function to mash together
# each statement and variable
# Then print the message to the Console

# Here's an example:
paste("My partner's hometown is", hometown)
      
# Format the rest of these statements in the same way so you can print them to the console
paste("My partner's favorite food is", food)
paste("My partner was probably born in", birth_year)
paste("The statement 'my partner likes rain' is", likes_rain)

# Use a built-in R function to print the data type of each variable to the console
# Here's an example:
typeof(hometown)
# Format the rest of these statements in the same way so you can print the data type to the console
typeof(food)
typeof(age)
typeof(likes_rain)
