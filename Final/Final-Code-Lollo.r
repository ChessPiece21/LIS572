## LIS 572 Final Data Analysis: Overwatch 2 Hero Play Rates
# by Joe Lollo
# Version 8: updated December 5, 2022

# Load all relevant libraries
#install.packages(tidyverse) # Once per machine.
#install.packages(plotly) # Once per machine.
library("tidyverse")
library("plotly")

# Load the CSV into a data frame
ow2_df <- read.csv("https://raw.githubusercontent.com/ChessPiece21/LIS-572/main/Final/ow2-2022.csv", stringsAsFactors = FALSE)
# This dataset has a lot of interesting things I would want to look at if I had all the time in the world, such as kill per game (KPG),
#healing per game (HPG), and "Play of the Game" rate (POTG rate), but I think for now, the variables I will choose to look at are Hero gender,
#Hero role, and play rate. Categorical variables like gender and Hero role are better than quantitative if I want to look at how Overwatch Heroes 
#are represented both in the game and in the gameplay, so I decided to look at those in conjunction with play rate to build data narratives 
#surrounding what I know about Overwatch's player culture.
# As far as insight of those categories goes, I think it's interesting that there's a nearly equal male-to-female ratio in Hero gender, but that
#the robot heroes are labeled as "Nonbinary." Possibly an oversight from the site that curated this CSV? But I can't think of anything better to
#refer to them by...
# The distribution of Hero role is pretty balanced right now, as the four Heroes introduced in OW2 all cover the four types of Heroes that already
#existed and there's a fairly equal number of each of them, although there is a slightly higher amount of Offense Heroes.
# I think that Defense Heroes will have the lowest play rates on average since they are the least popular in-game. Bastion and Hanzo are definite outliers 
#though, since they are used often by players because they're generally accessible characters and also popular in memes and fan material. Support will be the
#second lowest, followed by Tanks, and lastly Offense, in my opinion.
# I also cleaned the data, as I had to change the names of Soldier.76 and D.va, as they appear in the original dataset and in-game, to "Soldier 76" and "D-va," 
#since the R console was having difficulty recognizing those characters as names.

## Part 1: OW2 Heroes by Play Rate.
# For the rest of the analysis, since I say "PLAY rate" and not "pick rate" in my graphs, I will
#rename the column as appropriate.
ow2_df <- ow2_df %>% rename(Play_Rate = Play_Rate)

# Filter using DPLYR so that the top 10 Heroes appear in the final graph.
top_heroes <- ow2_df %>% filter(Play_Rate > 15) # Estimating the highest play rates using a benchmark.

# Create interactive plot of basic play rates among the top Heroes.
top_heroes_plot <- ggplot(top_heroes) +
  geom_col(aes(x = Play_Rate, 
               y = reorder(Hero, +Play_Rate), 
               fill = Role,
               text = paste0("Hero Name: ", Hero,
                             "\nHero Role: ", Role,
                             "\nPlay Rate: ", Play_Rate,"%"))) +
  labs(x = "Play Rate", y = "Hero Name", title = "Highest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive. 
ggplotly(top_heroes_plot, tooltip = "text")

## Part 2: Average Play Rates by Hero Role.
# Group the original data frame by Hero role, calculate the mean play rate and save it in a new variable.
heroes_by_role <- ow2_df %>% group_by(Role) %>% summarize(Count = n(), Avg_Play_Rate = mean(Play_Rate))

# Create interactive plot of Hero play rate by role.
hero_role_plot <- ggplot(heroes_by_role) +
  geom_col(aes(x = Avg_Play_Rate, 
               y = reorder(Role, +Avg_Play_Rate), 
               fill = Role,
               text = paste0("Hero Role: ", Role,
                             "\nNumber of Heroes: ", Count,
                             "\nAverage Play Rate: ", Avg_Play_Rate,"%"))) + 
  labs(x = "Average Play Rate", y = "Hero Role", title = "Average Play Rate by Hero Role") +
  scale_fill_brewer(palette = "Set1")

# Make the plot interactive.
ggplotly(hero_role_plot, tooltip = "text")

# Already interesting that Offense heroes have the highest, as expected, but DEFENSE, out of the other 3, is nearing -- is this because of two of them (Hanzo and Bastion) being known outliers?

# This begs the question...what would OW2_DF grouped by role look like in a boxplot?
hero_boxplot <- ggplot(ow2_df, aes(x = Role, y = Play_Rate, color = Role)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Role")  +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(hero_boxplot) # Yep, I knew it -- Defense has a wider range than the rest. Based on the dataset, Mercy is an outlier among 
#Support Heroes since she is widely used and considered an asset on teams.

## Part 3: Average Play Rates by Gender.
# Make new data frame grouping Heroes by gender without play rate, just to see the count of each gender.
gender_df <- ow2_df %>% group_by(Gender) %>% summarize(Count = n())

gender_count_plot <- ggplot(gender_df) +
  geom_col(aes(x = Count, 
               y = reorder(Gender, +Count), 
               fill = Gender,
               text = paste0("Hero Gender: ", Gender,
                             "\nNumber of Heroes: ", Count))) +
  labs(x = "Number of Heroes", y = "Hero Gender", title = "Distribution of Overwatch 2 Heroes by Gender") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1")

ggplotly(gender_count_plot, tooltip = "text")

# More female Heroes than male Heroes, despite being nearly equal, but are their play rates this close, too, on average?

# Group the original data frame by Hero gender, calculate the mean play rate and save it in a new variable.
heroes_by_gender <- ow2_df %>% group_by(Gender) %>% summarize(Avg_Play_Rate = mean(Play_Rate))

# Create interactive plot of play rate by gender.
gender_plot <- ggplot(heroes_by_gender) +
  geom_col(aes(x = Avg_Play_Rate, 
               y = reorder(Gender, +Avg_Play_Rate), 
               fill = Gender,
               text = paste0("Hero Gender: ", Gender,
                             "\nAverage Play Rate: ", Avg_Play_Rate,"%"))) +
  labs(x = "Average Play Rate", y = "Hero Gender", title = "Average Play Rate by Hero Gender")  +
  coord_flip() +
  scale_fill_brewer(palette = "Set1")

ggplotly(gender_plot, tooltip = "text")

# Let's see what happens if we view this as a boxplot!
gender_boxplot <- ggplot(ow2_df, aes(x = Gender, y = Play_Rate, color = Gender)) + geom_boxplot() +
  labs(x = "Role", y = "Play Rate", title = "Distribution of Play Rates by Hero Gender") +
  coord_flip() +
  scale_color_brewer(palette = "Set1")

ggplotly(gender_boxplot) # Females have the widest range, but males have the highest average.

# Now let's look at the bottom play rates. I kinda want to see this distribution...

## Part 4: Bottom 10 Play Rates.
bottom_heroes <- ow2_df %>% filter(Play_Rate < 7.15) # Estimating the lowest play rates using a benchmark.

# Create interactive plot of basic play rates among the bottom in-game Heroes.
bottom_heroes_plot <- ggplot(bottom_heroes) +
  geom_col(aes(x = Play_Rate, 
               y = reorder(Hero, -Play_Rate), 
               fill = Role,
               text = paste0("Hero Name: ", Hero,
                             "\nHero Role: ", Role,
                             "\nPlay Rate: ", Play_Rate,"%"))) +
  labs(x = "Play Rate", y = "Hero Name", title = "Lowest Play Rates of Overwatch 2 Heroes") +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(limits = c(0, 10))

# Make the plot interactive. 
ggplotly(bottom_heroes_plot, tooltip = "text")

# Now THAT is interesting! Even if Offense heroes in OW2 have the highest average play rate, an Offense hero has the lowest play rate of all!
# Sombra is considered by fans to be one of the "most annoying" characters to fight against in-game because of her abilities, but the data doesn't show that at all, just that she's among the lowest picked.

## Final Extra Part: Uploading interactive plots for my blog.
# Create system/API key for Plotly website:
Sys.setenv("plotly_username" = "JoeLollo21")
Sys.setenv("plotly_api_key" = "StG9GebmLPqXjbdj7kyB")

# Upload ggplotly plots to the Plotly API, with titles:
api_create(top_heroes_plot, filename = "Top OW2 Heroes")
api_create(bottom_heroes_plot, filename = "Bottom OW2 Heroes")
api_create(gender_count_plot, fielname = "OW2 Heroes By Gender")
api_create(gender_plot, filename = "OW2 Play Rate By Gender")
api_create(hero_role_plot, filename = "OW2 Play Rate By Roles")
api_create(hero_boxplot, filename = "Hero Role Boxplot")
api_create(gender_boxplot, filename = "Hero Gender Boxplot")
