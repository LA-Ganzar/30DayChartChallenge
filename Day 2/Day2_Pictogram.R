# 30 Day Chart Challenge - Day 2
# Pictogram
# 2022-04-02

# Data Source: USA Cycling

library(tidyverse)
library(waffle)

# write data
x <- c("Not Specified" = 5,  "Female" = 20, "Male" = 75)

# Waffle chart
waffle(x, rows = 10, xlab="1 square = 1 percent",
       legend_pos = "bottom",
       colors = c("#d4a012", "#d60b2f", "#031e41")) + 
  labs(
    title="Gender Distribution of 2022 USA Cycling Race Membership", 
    caption="Source: USA Cycling | Graphic by Leigh Ann Ganzar") + 
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 10),
    axis.title.y = element_blank())

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 2/plot.jpg", width = 10, height = 6)

