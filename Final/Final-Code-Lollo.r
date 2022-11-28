## LIS 572 Final Data Analysis: Overwatch 2 Hero Play Rates
# by Joe Lollo
# Version 3: updated November 27, 2022

# Load all relevant libraries
#install.packages(tidyverse) # Once per machine.
#install.packages(plotly) # Once per machine.
library("tidyverse")
library("plotly")

# Load the CSV into a data frame
ow2_df <- read.csv("https://raw.githubusercontent.com/ChessPiece21/LIS-572/main/Final/ow2-2022.csv", stringsAsFactors = FALSE)

## Part 1: OW2 Heroes by Pick Rate.
# Filter using DPLYR so that the top 10 Heroes appear in the final graph.
top_heroes <- ow2_df %>% filter(Pick_Rate > 15) # Estimating the highest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the top Heroes.
top_heroes_plot <- ggplot(top_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, +Pick_Rate), fill = Role)) +
  labs(x = "Play Rate", y = "Hero Name", title = "Highest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive. 
ggplotly(top_heroes_plot)

## Part 2: Average Pick Rates by Hero Role.
# Group the original data frame by Hero role, calculate the mean pick rate and save it in a new variable.
heroes_by_role <- ow2_df %>% group_by(Role) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of Hero pick rate by role.
hero_role_plot <- ggplot(heroes_by_role) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Role, +Avg_Pick_Rate), fill = Role)) +
  labs(x = "Average Play Rate", y = "Hero Role", title = "Average Play Rate by Hero Role") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive.
ggplotly(hero_role_plot)

# Already interesting that Offense heroes have the highest, as expected, but DEFENSE, out of the other 3, are nearing -- is this because of two of them (Hanzo and Bastion) being outliers?
# This begs the question...what would OW2_DF grouped by role look like in a boxplot?
hero_boxplot <- ggplot(ow2_df, aes(x = Role, y = Pick_Rate, color = Role)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Role")  +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(hero_boxplot) # Yep, I knew it -- Defense has a wider range than the rest. Mercy is an outlier.

## Part 3: Average Pick Rates by Gender.
# Group the original data frame by Hero gender, calculate the mean pick rate and save it in a new variable.
heroes_by_gender <- ow2_df %>% group_by(Gender) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of pick rate by gender.
gender_plot <- ggplot(heroes_by_gender) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Gender, +Avg_Pick_Rate), fill = Gender)) +
  labs(x = "Average Play Rate", y = "Hero Gender", title = "Average Play Rate by Hero Gender")  +
  coord_flip() +
  scale_fill_brewer(palette = "Set1")

ggplotly(gender_plot)

# Let's see what happens if we view this as a boxplot!
gender_boxplot <- ggplot(ow2_df, aes(x = Gender, y = Pick_Rate, color = Gender)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Gender") +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(gender_boxplot) # Females have the widest range, but males have the highest average.

# Now let's look at the bottom pick rates. I kinda want to see this distribution...
## Part 4: Bottom 10 Pick Rates.
bottom_heroes <- ow2_df %>% filter(Pick_Rate < 7.15) # Estimating the lowest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the bottom in-game Heroes.
bottom_heroes_plot <- ggplot(bottom_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, -Pick_Rate), fill = Role)) +
  labs(x = "Play Rate", y = "Hero Name", title = "Lowest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive. 
ggplotly(bottom_heroes_plot)

# Now THAT is interesting! Even if Offense heroes in OW2 have the highest average pick rate, an Offense hero has the lowest pick rate of all!
# Sombra is considered by fans to be one of the "most annoying" characters to fight against in-game because of her abilities, but the data doesn't show that at all, just that she's among the lowest picked.
# (Also, Echo is one of the characters I main, I'm offended...)

## LIS 572 Final Data Analysis: Overwatch 2 Hero Play Rates
# by Joe Lollo
# Version 3: updated November 27, 2022

# Load all relevant libraries
#install.packages(tidyverse) # Once per machine.
#install.packages(plotly) # Once per machine.
library("tidyverse")
library("plotly")

# Load the CSV into a data frame
ow2_df <- read.csv("https://raw.githubusercontent.com/ChessPiece21/LIS-572/main/Final/ow2-2022.csv", stringsAsFactors = FALSE)

## Part 1: OW2 Heroes by Pick Rate.
# Filter using DPLYR so that the top 10 Heroes appear in the final graph.
top_heroes <- ow2_df %>% filter(Pick_Rate > 15) # Estimating the highest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the top Heroes.
top_heroes_plot <- ggplot(top_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, +Pick_Rate), fill = Role)) +
  labs(x = "Play Rate", y = "Hero Name", title = "Highest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive. 
ggplotly(top_heroes_plot)

## Part 2: Average Pick Rates by Hero Role.
# Group the original data frame by Hero role, calculate the mean pick rate and save it in a new variable.
heroes_by_role <- ow2_df %>% group_by(Role) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of Hero pick rate by role.
hero_role_plot <- ggplot(heroes_by_role) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Role, +Avg_Pick_Rate), fill = Role)) +
  labs(x = "Average Play Rate", y = "Hero Role", title = "Average Play Rate by Hero Role") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive.
ggplotly(hero_role_plot)

# Already interesting that Offense heroes have the highest, as expected, but DEFENSE, out of the other 3, are nearing -- is this because of two of them (Hanzo and Bastion) being outliers?
# This begs the question...what would OW2_DF grouped by role look like in a boxplot?
hero_boxplot <- ggplot(ow2_df, aes(x = Role, y = Pick_Rate, color = Role)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Role")  +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(hero_boxplot) # Yep, I knew it -- Defense has a wider range than the rest. Mercy is an outlier.

## Part 3: Average Pick Rates by Gender.
# Group the original data frame by Hero gender, calculate the mean pick rate and save it in a new variable.
heroes_by_gender <- ow2_df %>% group_by(Gender) %>% summarize(Avg_Pick_Rate = mean(Pick_Rate))

# Create interactive plot of pick rate by gender.
gender_plot <- ggplot(heroes_by_gender) +
  geom_col(aes(x = Avg_Pick_Rate, y = reorder(Gender, +Avg_Pick_Rate), fill = Gender)) +
  labs(x = "Average Play Rate", y = "Hero Gender", title = "Average Play Rate by Hero Gender")  +
  coord_flip() +
  scale_fill_brewer(palette = "Set1")

ggplotly(gender_plot)

# Let's see what happens if we view this as a boxplot!
gender_boxplot <- ggplot(ow2_df, aes(x = Gender, y = Pick_Rate, color = Gender)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Gender") +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(gender_boxplot) # Females have the widest range, but males have the highest average.

# Now let's look at the bottom pick rates. I kinda want to see this distribution...
## Part 4: Bottom 10 Pick Rates.
bottom_heroes <- ow2_df %>% filter(Pick_Rate < 7.15) # Estimating the lowest pick rates using a benchmark.

# Create interactive plot of basic pick rates among the bottom in-game Heroes.
bottom_heroes_plot <- ggplot(bottom_heroes) +
  geom_col(aes(x = Pick_Rate, y = reorder(Hero, -Pick_Rate), fill = Role)) +
  labs(x = "Play Rate", y = "Hero Name", title = "Lowest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive. 
ggplotly(bottom_heroes_plot)

# Now THAT is interesting! Even if Offense heroes in OW2 have the highest average pick rate, an Offense hero has the lowest pick rate of all!
# Sombra is considered by fans to be one of the "most annoying" characters to fight against in-game because of her abilities, but the data doesn't show that at all, just that she's among the lowest picked.
# (Also, Echo is one of the characters I main, I'm offended...)

# Upload ggplotly plots to the Plotly API:
Sys.setenv("plotly_username" = "JoeLollo21")
Sys.setenv("plotly_api_key" = "StG9GebmLPqXjbdj7kyB")

api_create(top_heroes_plot, filename = "Top OW2 Heroes")
api_create(bottom_heroes_plot, filename = "Bottom OW2 Heroes")
api_create(gender_plot, filename = "OW2 Play Rate By Gender")
api_create(hero_role_plot, filename = "OW2 Play Rate By Roles")
api_create(hero_boxplot, filename = "Hero Role Boxplot")
api_create(gender_boxplot, filename = "Hero Gender Boxplot")
