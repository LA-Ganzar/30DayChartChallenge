# 30 Day Chart Challenge - Day 2
# Pictogram
# 2022-04-02

# Data Source: USA Cycling

library(tidyverse)
library(showtext)
library(usefunc)
library(emojifont)
library(waffle)
library(extrafont)

# write data
df <- data.frame(group = c("Not specified", "Female", "Male"),
                 value = c(5, 20, 75))

# Waffle plot
ggplot(df, aes(fill = group, values = value)) +
  


ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 2/plot.jpg", width = 10, height = 6)

x <- c("Not Specified" = 5,  "Female" = 20, "Male" = 75)

# Waffle chart
waffle(x, rows = 10,
       legend_pos = "bottom")
