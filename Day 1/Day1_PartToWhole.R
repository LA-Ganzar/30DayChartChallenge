# 30 Day Chart Challenge - Day 1
# Part to Whole
# 2022-04-01

# Data Source: Personal Strava Data

library(tidyverse)
library(lubridate)
library(showtext)

# Read activities data
strava <- read.csv("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 1/activities.csv")

# Set up colors and fonts
col1 <- "#fc5200"
col2 <- "#ade6d6"
col3 <- "#6d6d78"

font_add_google("Montserrat")
showtext_opts(dpi = 300)
showtext_auto(enable = TRUE)

# Convert date and create year variable
strava <- strava %>%
  mutate(date = mdy_hms(Activity.Date))
strava$year <- as.factor(format(strava$date,'%Y'))

# Plot distance by year
ggplot(strava, aes(x = year, fill = Activity.Type)) + 
  geom_bar() +
  theme_minimal() + 
  scale_fill_manual(values = c(col1, col2, col3)) +
  labs(fill = "Activity Type",
       title = "Number of Strava Activities by Year",
       subtitle = "Across time, I have relatively run less and rode more, and was unfortunately forced to ride virtually in 2019 and 2020.",
       caption = "Source: @LAGanzar Strava Export",
       x = "Year",
       y = "Number of Uploaded Activities") +
  theme(text=element_text(family="Montserrat"),
        axis.text = element_text(size = 12),
        plot.caption.position="plot",
        plot.caption=element_text(hjust=0, size=8.3, color="grey20"),
        plot.title.position="plot",
        plot.subtitle = element_text(size=12))
ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 1/plot.jpg", width = 10, height = 6)
