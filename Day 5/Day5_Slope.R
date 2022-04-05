# 30 Day Chart Challenge - Day 5
# Slope
# 2022-04-05

# Data Source: International Union for Conservation of Nature (IUCN) Red list of Threatened Species, compiled by Florent Lavergne

library(tidyverse)
library(tidytuesdayR)

# Write and wrangle data
tuesdata <- tidytuesdayR::tt_load(2022, week = 14)
news_orgs <- tuesdata$news_orgs

plants_rank <- plants %>%
  summarize(AA = sum(threat_AA),
            BRU = sum(threat_BRU),
            RCD	= sum(threat_RCD),
            ISGD = sum(threat_ISGD),
            EPM	= sum(threat_EPM),
            CC = sum(threat_CC),
            HID	= sum(threat_HID),
            P	= sum(threat_P),
            TS = sum(threat_TS),
            NSM	= sum(threat_NSM),
            GE = sum (threat_GE))

flowers <- plants %>%
  filter(group == "Flowering Plant" & threat_NA == 0) %>%
  group_by(continent) %>%
  summarize(AA = sum(threat_AA),
            BRU = sum(threat_BRU),
            RCD	= sum(threat_RCD),
            ISGD = sum(threat_ISGD),
            EPM	= sum(threat_EPM),
            CC = sum(threat_CC),
            HID	= sum(threat_HID),
            TS = sum(threat_TS),
            NSM = sum(threat_NSM)) %>%
  pivot_longer(!continent, names_to = "Threat", values_to = "Count")

# Stacked bar chart comparing threats to extinction across continents
ggplot(flowers, aes(fill = Threat, y = Count, x = reorder(continent, Count))) + 
  geom_bar(position="stack", stat="identity") +
  coord_flip() +
  theme_minimal() +
  scale_fill_manual(name = "Main Driver of Decline", 
                      labels = c("Agriculture & Aquaculture",
                                 "Biological Resource Use",
                                 "Commercial Development",
                                 "Invasive Species",
                                 "Energy Production & Mining",
                                 "Climate Change",
                                 "Human Intrusions",
                                 "Transportation Corridor",
                                 "Natural System Modifications"),
                    values = met.brewer("Cassatt2", 9)) +
  theme(plot.margin = margin(rep(15, 4)),
        panel.grid = element_blank(),
        plot.caption = element_text(size = 8, margin = margin(t = 10), hjust = 0),
        axis.text = element_text(size = 11),
        plot.title = element_text(size = 18),
        plot.subtitle = element_text(size = 10),
        axis.title.y = element_text(margin = margin(r = 10), size = 12)) +
  labs(x = element_blank(),
       y = "Count of Extinct Flowering Plants",
       title = "Extinct Flowering Plants by Main Driver of Species Decline",
       subtitle = "Globally, agriculture and aquaculture are the largest contributors to flowering plant extinction, followed by biological resource use and natural system modifications. \nIn North America, climate change is the largest driver of extinction among this group of species.",
       caption = "Data Source: International Union for Conservation of Nature (IUCN) Red list of Threatened Species, compiled by Florent Lavergne | Plot: Leigh Ann Ganzar")

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 4/plot.jpg", width = 12, height = 6)

