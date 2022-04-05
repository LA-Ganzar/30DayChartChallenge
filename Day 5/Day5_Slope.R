# 30 Day Chart Challenge - Day 5
# Slope
# 2022-04-05

# Data Source: survivorR R package from Daniel Oehm

library(tidyverse)
library(tidytuesdayR)
library(MetBrewer)
library(ggtext)

theme_set(theme_minimal(base_family = "Assistant"))

# Read and wrangle data
tuesdata <- tidytuesdayR::tt_load(2021, week = 23)
summary <- tuesdata$summary

summary <- summary %>%
  mutate(change = viewers_finale - viewers_premier) %>%
  arrange(desc(change))

survivor <- summary %>%
  select(season, viewers_premier, viewers_finale) %>%
  pivot_longer(!season, names_to = "Episode", values_to = "Viewers_Count") %>%
  mutate(Episode = factor(Episode),
         season = factor(season)) %>% 
  mutate(Episode = fct_relevel(Episode,c("viewers_premier","viewers_finale"))) %>%
  mutate(color = case_when(season == "1" ~ "#3391a3", 
                           season == "2" | season == "8" ~ "#f37e41",
                           TRUE ~ "#2f2f2f"),
         alpha = ifelse(season %in% c("1", "2", "8"), 1, 0.75))
 
survivor %>%
  ggplot( aes(x = Episode, y = Viewers_Count, group = season, color = color, alpha = alpha)) +
  geom_line(size = 1) +
  scale_color_identity() +
  scale_x_discrete(expand = c(0.05,0),
                   labels=c("viewers_premier" = "Season \nPremiere", "viewers_finale" = "Season \nFinale")) +
  labs(y = "Viewers in millions",
       fill = "",
       title = "The Evolution of Survivor Viewer Count from Premiere to Finale by Season",
       subtitle = "For most Survivor seasons, the viewership remained stable from the premiere to the finale, with the exception of the 3 highlighted seasons.",
       caption = "survivorR R package from Daniel Oehm | Plot: Leigh Ann Ganzar") +
  theme_minimal() +
  annotate("text",
           x = c(1.25, 1.75),
           y = c(48, 50),
           label = c("Seasons 2 and 9 \nviewership decreased by \nabout 9 million", "Season 1 viewership \n increased by 36 million"),
           family = "", fontface = 3, size=4, color = c("#f37e41", "#3391a3")) +
  theme(
    plot.title = (element_text(face = "bold")),
    panel.grid.major.y = element_blank(), 
    panel.grid.minor.y = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_text(face = "bold"),
    plot.caption = element_text(size = 8, margin = margin(t = 10), hjust = 0),
    legend.position = "none")

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 5/plot.jpg", width = 10.5, height = 6)
