## LIS 572 Final Data Analysis: Overwatch 2 Heroes
# by Joe Lollo
# Version 1: November 27, 2022

# Load all relevant libraries
#install.packages(tidyverse) # Once per machine.
#install.packages(plotly) # Once per machine.
library("tidyverse")
library("plotly")

# Load the CSV into a data frame
ow2_df <- read.csv("ow2-2022.csv", stringsAsFactors = FALSE)

## Part 1: OW2 Heroes by Pick Rate.
# Filter using DPLYR so that the top 10 Heroes appear in the final graph.
top_heroes <- ow2_df %>% filter(Pick_Rate > 15) # Estimating the highest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the top Heroes.
top_heroes_plot <- ggplot(top_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, +Pick_Rate), fill = Role)) +
  labs(x = "Pick Rate", y = "Hero Name", title = "Highest Play Rates of Overwatch 2 Heroes")

# Make the plot interactive. 
ggplotly(top_heroes_plot)

## Part 2: Average Pick Rates by Hero Role.
# Group the original data frame by Hero role, calculate the mean pick rate and save it in a new variable.
heroes_by_role <- ow2_df %>% group_by(Role) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of Hero pick rate by role.
hero_role_plot <- ggplot(heroes_by_role) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Role, +Avg_Pick_Rate), fill = Role)) +
  labs(x = "Average Pick Rate", y = "Hero Role", title = "Average Play Rate by Hero Role")

# Make the plot interactive.
ggplotly(hero_role_plot)

# Already interesting that Offense heroes have the highest, as expected, but DEFENSE, out of the other 3, are nearing -- is this because of two of them (Hanzo and Bastion) being outliers?
# This begs the question...what would OW2_DF grouped by role look like in a boxplot?
hero_boxplot <- ggplot(ow2_df, aes(x = Role, y = Pick_Rate)) + geom_boxplot() +
  labs(x = "Role", y = "Pick Rate", title = "Distribution of Pick Rates by Hero Role")

ggplotly(hero_boxplot) # Yep, I knew it -- Defense has a wider range than the rest.

## Part 3: Average Pick Rates by Gender.
# Group the original data frame by Hero gender, calculate the mean pick rate and save it in a new variable.
heroes_by_gender <- ow2_df %>% group_by(Gender) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of pick rate by gender.
gender_plot <- ggplot(heroes_by_gender) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Gender, +Avg_Pick_Rate), fill = Gender)) +
  labs(x = "Average Pick Rate", y = "Hero Gender", title = "Average Play Rate by Hero Gender")

ggplotly(gender_plot)

# Now let's look at the bottom pick rates. I kinda want to see this distribution...
## Part 4: Bottom 10 Pick Rates.
bottom_heroes <- ow2_df %>% filter(Pick_Rate < 7.15) # Estimating the lowest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the bottom in-game Heroes.
bottom_heroes_plot <- ggplot(bottom_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, -Pick_Rate), fill = Role)) +
  labs(x = "Pick Rate", y = "Hero Name", title = "Lowest Play Rates of Overwatch 2 Heroes")

# Make the plot interactive. 
ggplotly(bottom_heroes_plot)

# Now THAT is interesting! Even if Offense heroes in OW2 have the highest average pick rate, an Offense hero has the lowest pick rate of all!
# Sombra is considered by fans to be one of the "most annoying" characters to fight against in-game because of her abilities, but the data doesn't show that at all, just that she's among the lowest picked.
# (Also, Echo is one of the characters I main, I'm offended...)

# My last question has to do with Play of the Game (POTG) award rates as they relate to pick rates, because I wonder if the highest picked Heroes also have the highest picked POTGs.
## Part 5: Top Play of the Game Rates.
# Filter using DPLYR so that the Heroes with the top 10 POTG rates appear in the final graph.
top_potgs <- ow2_df %>% filter(POTG_Rate > 10.54) # Using the actual 10th data point.

# Create interactive plot of POTG rates.
potg_plot <- ggplot(top_potgs) + 
  geom_col(aes(x = POTG_Rate, y = reorder(Hero,+POTG_Rate), fill = Role)) + 
  labs(x = "POTG Rate", y = "Hero Name", title = "Top Play of the Game Rates in Overwatch 2")

ggplotly(potg_plot)
# Interesting, only half of the top picked heroes have the top POTG rates.
# Also Support heroes are really being done dirty in this plot lmao. 
