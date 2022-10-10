# Make Your Own Version of the Cowsay Function called "shout"
# Use str_glue to print the message
# Part of the function is written for you

# Install and load stringr, styler
install.packages("stringr")
install.packages("styler")
library(stringr)

shout <- function(message = "HELLO WORLD.") { #Assigned a default message.
  output <- str_glue("'{message}' \n - 🤡")
  return(output)
}

shout("You think darkness is your ally? You merely adopted the dark.
I was born in it, molded by it.")
