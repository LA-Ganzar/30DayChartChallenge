# 30 Day Chart Challenge - Day 6
# Data day: OWID
# 2022-04-06

# Data Source: 

library(tidyverse)
library(owidR)
library(ggstream)
library(ggtext)

theme_set(theme_minimal())

# Read and wrangle data
owid_search("burden")
burden <- owid("disease-burden-by-risk-factor")

burden <- burden %>%
  rename(physical_activity=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Low physical activity - Sex: Both - Age: All Ages (Number)`,
         breastfeeding=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Non-exclusive breastfeeding - Sex: Both - Age: All Ages (Number)`,
         air_pollution=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Air pollution - Sex: Both - Age: All Ages (Number)`,
         child_wasting=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Child wasting - Sex: Both - Age: All Ages (Number)`,
         bp=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: High systolic blood pressure - Sex: Both - Age: All Ages (Number)`,
         glucose=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: High fasting plasma glucose - Sex: Both - Age: All Ages (Number)`,
         child_stunting=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Child stunting - Sex: Both - Age: All Ages (Number)`,
         bmi=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: High body-mass index - Sex: Both - Age: All Ages (Number)`,
         smoke=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Secondhand smoke - Sex: Both - Age: All Ages (Number)`,
         sanitation=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Unsafe sanitation - Sex: Both - Age: All Ages (Number)`,
         water=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Unsafe water source - Sex: Both - Age: All Ages (Number)`,
         low_veggie=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Diet low in vegetables - Sex: Both - Age: All Ages (Number)`,
         low_fruit=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Diet low in fruits - Sex: Both - Age: All Ages (Number)`,
         sodium=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Diet high in sodium - Sex: Both - Age: All Ages (Number)`,
         drug=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Drug use - Sex: Both - Age: All Ages (Number)`,
         indoor_pollution=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Household air pollution from solid fuels - Sex: Both - Age: All Ages (Number)`,
         ldl=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: High LDL cholesterol - Sex: Both - Age: All Ages (Number)`,
         iron=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Iron deficiency - Sex: Both - Age: All Ages (Number)`,
         zinc=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Zinc deficiency - Sex: Both - Age: All Ages (Number)`,
         smoking=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Smoking - Sex: Both - Age: All Ages (Number)`,
         vitamin_a=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Vitamin A deficiency - Sex: Both - Age: All Ages (Number)`,
         ambient_pollution=`DALYs (Disability-Adjusted Life Years) - Cause: All causes - Risk: Ambient particulate matter pollution - Sex: Both - Age: All Ages (Number)`)

burden_pa <- burden %>%
  filter(grepl('^World Bank', entity)) %>%
  select(entity, year, physical_activity) %>%
  mutate(entity = factor(entity,
                         levels = c(
                         "World Bank High Income",
                         "World Bank Lower Middle Income",
                         "World Bank Upper Middle Income",
                         "World Bank Low Income"),
                         labels = c("High Income",
                         "Upper Middle Income",
                         "Lower Middle Income",
                         "Low Income")),
         physical_activity = physical_activity / 1000000)

# Plot
burden_pa %>%
  ggplot( aes(x = year, y = physical_activity, fill = entity)) +
  geom_area() +
  scale_fill_manual(
    name = "World Bank Designation",
    values = c("#0f4c5f", "#8bb791", "#ec9041", "#c54a41"),
  ) +
  labs(
    title = "The Global Burden of Physical Inactivity is Increasing",  
    subtitle = "Globally, low levels of physical activity are responsible for 15.8 million lost years of healthy
    life annually, a figure that has doubled <br>in the last two decades. 
    <span style='color:#8bb791;'>Upper middle income</span>, and 
    <span style='color:#ec9041;'>lower middle income</span> countries have seen the highest increases in disease <br>burden from low physical activity levels since 1990.",
    x = "Year", 
    y = "Disability-Adjusted Life Years (in millions)",
    caption = "Data: OWID & IHME Global Burden of Disease | Plot: Leigh Ann Ganzar") +
  theme_minimal() +
  theme(plot.title = element_markdown(lineheight=.1, face = "bold", size = 20),
        plot.subtitle = element_markdown(lineheight=.1),
        legend.text = element_markdown(size = 11),
        plot.caption = element_text(size = 8, hjust = 0))

ggsave("/Users/leighannganzar/Desktop/Post-Doc/30DayChartChallenge/30DayChartChallenge/Day 6/plot.jpg", width = 9.5, height = 6)
