# 30 Day Chart Challenge - Day 8
# Mountains
# 2022-04-08

# Data Source: cUCI Bike Share Counts

library(tidyverse)
library(ucidata)
library(ggridges)
library(hrbrthemes)
library(MetBrewer)

# Write and wrangle data
data("bike_sharing_daily", package = "ucidata")

ggplot(bike_sharing_daily, aes(x = cnt, y = weathersit, fill = weathersit)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

ggplot(bike_sharing_daily, aes(x = cnt, y = mnth, fill = ..x..)) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_y_discrete(limits=rev) +
  scale_fill_gradientn(colors = met.brewer("Tam")) +
  labs(title = 'Daily count of rental bikes between years 2011 and 2012 in Capital bikeshare system',
       y = "",
       x = "Daily Count",
       caption = "Data: UCI Datasets: Daily Bike Share | Plot: Leigh Ann Ganzar") +
  theme_ipsum() +
  theme(
    legend.position="none",
    panel.spacing = unit(0.1, "lines"),
    strip.text.x = element_text(size = 8)
  )
ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 8/plot.jpg", width = 10, height = 6)

