# 30 Day Chart Challenge - Day 7
# Physical
# 2022-04-07

# Data Source: https://www.cdc.gov/traumaticbraininjury/pdf/TBI-Surveillance-Report-FINAL_508.pdf CDC TBI Surveillance Report

library(tidyverse)
library(showtext)
library(tidytext)
library(MetBrewer)

# Read TBI data
tbi_age <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-24/tbi_age.csv')

# Set up colors and fonts
font_add_google("Merriweather")
showtext_opts(dpi = 300)
showtext_auto(enable = TRUE)

tbi_age <- tbi_age %>%
  mutate(age_group = factor(age_group, 
                            levels = c("0-4", "5-14", "0-17", "15-24", "25-34", "35-44", "45-54", "55-64", "64-75", "75+", "Total"))) %>%
  filter(age_group != "0-17" | type == "Emergency Department Vist") %>%
  na.omit()

# Plot TBI rate by age group and injury mechanism
ggplot(tbi_age, aes(x = age_group, y = rate_est, fill = fct_reorder(injury_mechanism, rate_est, .desc = TRUE))) +
  geom_col(position = "dodge") +
  coord_flip() + 
  theme_minimal() +
  scale_fill_manual(values = met.brewer("Hokusai1", 7)) +
  labs(title = "Unintentional Falls Cause High Rates of Traumatic Brain Injuries among the Very Young and the Very Old", 
       caption = "Data Source: CDC TBI Surveillance Report of Emergency Department Visits (2014) | Plot: Leigh Ann Ganzar",
       x = "Age Group",
       fill = "Injury Mechanism",
       y = "Traumatic Brain Incident Rate (per 100k)")

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 7/plot.jpg", width = 10, height = 6)
