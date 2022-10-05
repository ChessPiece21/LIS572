# cowsay

# Install package
install.packages("cowsay")
install.packages("multicolor") #I had to install this to make my text rainbow.

# Load package
library("cowsay")
library("multicolor")

# Use the cowsay function say()
say()

# Read the documentation for the function say()
?say
#help(say) #Alternatively, I can use this.

# Now use the function say() from the package cowsay and:
# 1. Change the message to a short declaration
# about privacy and/or fanfiction and/or web scraping
# 2. Change the animal
# 3. Change the color of the animal
# Then take a screenshot of your artwork and share it in #cowsay-practice
say(what = "Your data is OC, so tell the companies \"DO NOT STEAL!\"", 
    #^ combining fandom (well, fanart specifically) AND data privacy!
    by = "clippy",
    what_color = "rainbow",
    by_color = "rainbow"
)



