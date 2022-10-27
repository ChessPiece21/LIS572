# SPL Data Viz — Part 2

library("dplyr")
library("ggplot2")

# Load the data
spl_df <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/Checkouts_by_Title_2018-2022_15-checkouts.csv", stringsAsFactors = FALSE)

# Exercise 1: Calculate the total number of SPL checkouts per year per "material type"
# Save as checkouts_per_year_type
checkouts_per_year_type <- spl_df %>% group_by(CheckoutYear, MaterialType) %>%
                           summarize(TotalCheckouts = sum(Checkouts))

# Exercise 2: Filter the checkouts_per_year_type dataframe for only audiobooks, books, and ebooks
# Hint: you may want to use the %in% operator!
# Save as checkouts_per_year_top_types
checkouts_per_year_top_types <- checkouts_per_year_type %>%
                                filter(MaterialType %in% c("AUDIOBOOK", "BOOK", "EBOOK"))

# Turn off scientific notation for y axis
options(scipen=999)

# Exercise 3: Plot checkouts_per_year_top_types as a line plot with ggplot and color by material type
ggplot(data = checkouts_per_year_top_types) + 
  geom_line(mapping = aes(x = CheckoutYear, y = TotalCheckouts, color = MaterialType))

# Exercise 4: Change the color scheme of this plot
# Choose one of the color schemes featured in the website below:
# https://r-graph-gallery.com/38-rcolorbrewers-palettes.html
ggplot(data = checkouts_per_year_top_types) + 
  geom_line(mapping = aes(x = CheckoutYear, y = TotalCheckouts, color = MaterialType)) + 
  labs(title = "SPL Checkouts from 2018-2022") + 
  scale_color_brewer (palette = "Set1")

# Exercise 5: Find the total number of SPL checkouts per year for an author or title of your choice
# Visualize it as a line plot over time with custom labeling
# Add a title, subtitle, and custom x,y axis labels to this plot
# Also add a caption that explains the most salient pattern(s) in the plot
# When you're done, drop it in the Discord server! 
author_df <- spl_df %>% filter(str_detect(Creator, "Margaret.*Atwood|Atwood.*Margaret")) %>% 
  filter(MaterialType %in% c("AUDIOBOOK", "BOOK", "EBOOK")) %>%
  group_by(CheckoutYear, MaterialType) %>%
  summarize(TotalCheckouts = sum(Checkouts))

ggplot(data = author_df) + 
  geom_line(mapping = aes(x = CheckoutYear, y = TotalCheckouts, color = MaterialType)) + 
  labs(x = "Checkout Year", y = "Total Checkouts", title = "Margaret Atwood Checkouts at SPL, 2018-2022") + 
  scale_color_brewer (palette = "Set1")
