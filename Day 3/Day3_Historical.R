# 30 Day Chart Challenge - Day 3
# Historical
# 2022-04-03

# Data Source: camminady/LeTourDataSet

library(tidyverse)
library(hrbrthemes)

# Write and wrangle data
tdf <- read.csv("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 3/tdf.csv")

tdf_distance <- tdf %>%
  group_by(Year) %>%
  summarise(distance = mean(Distance..km.))

# Plot distance over time
ggplot(tdf_distance, aes(x = Year, y = distance)) +
  geom_line(color = "#ffff01", size = 2, alpha = 0.9) +
  scale_y_continuous(breaks = seq(2000, 6000, 1000)) +
  scale_x_continuous(breaks = seq(1901, 2021, 10)) +
  theme_minimal() +
  theme(plot.margin = margin(rep(15, 4)),
        plot.background = element_rect(fill = "#22333b"),
        panel.grid = element_blank(),
        plot.caption = element_text(size = 8, color = "white", margin = margin(t = 10)),
        axis.text = element_text(color = "white", size = 11),
        plot.title = element_text(color = "white", size = 18),
        plot.subtitle = element_text(color = "white", size = 9),
        axis.title.y = element_text(color = "white", margin = margin(r = 10), size = 12)) +
  labs(x = element_blank(),
       y = "Total race distance in kilometers",
       title = "Evolution of Tour de France Total Race Distance",
       subtitle = "Over time, the total distance of the Tour de France has decreased, but in 2021, riders still completed 3383 kilometers (2102 miles) in 21 days.",
       caption = "Data: camminady/LeTourDataSet | Plot: Leigh Ann Ganzar")

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 3/plot.jpg", width = 10, height = 6)

