library(tidyverse)
library(ggthemes)

soc_sci_cong <- read_csv("social_science_congressional_testimony.csv") %>% 
  group_by(year) %>% 
  mutate(year_count = n()) %>% 
  group_by(year, discipline1) %>% 
  mutate(displine_per_year_count = n()) %>% 
  summarise(perc_discipline_year = 100*displine_per_year_count/year_count,
            displine_per_year_count) %>% 
  distinct() %>% 
  mutate(Discipline = factor(discipline1, 
                              levels = rev(c("Anthropologist", "Sociologist", "Psychologist", "Political Scientist", "Economist"))))

ggplot(soc_sci_cong, aes(x = year + 0.5, y = perc_discipline_year, fill = Discipline)) +
  geom_col(width = 1, position = "stack", alpha = 0.5) +
  theme_fivethirtyeight() +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(breaks = seq(0, 100, 10), minor_breaks = seq(0, 100, 2)) +
  scale_x_continuous(breaks = seq(1946, 2016, 5), minor_breaks = seq(1946, 2017, 1)) +
  labs(
    title = "Social scientists' expert testimonies in Congress",
    subtitle = "As a percentage of total expert testimonies in Congress each year",
    x = "Year",
    y = "Percentage of expert testimonies in Congress",
    caption = "Visualisation: David Aikman @ResearchingDave, Data Source: Charles Seguin, Thomas V. Maher, Yongjun Zhang (https://osf.io/e3h98/)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 24, margin = margin(t = 20, unit = "pt")),
    plot.subtitle = element_text(size = 16, margin = margin(b = 20, unit = "pt")),
    plot.caption = element_text(margin = margin(t = 20, unit = "pt")),
    legend.title = element_text(face = "bold", size = 16),
    legend.text = element_text(size = 14),
    axis.text = element_text(size = 16),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title = element_text(face = "bold", size = 16),
    panel.grid.major = element_line(color = "darkgrey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")
  )

ggsave(filename = "percentage_plot.png", width = 11, height = 8)

ggplot(soc_sci_cong, aes(x = year + 0.5, y = displine_per_year_count, fill = Discipline)) +
  geom_col(width = 1, position = "stack", alpha = 0.5) +
  theme_fivethirtyeight() +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(breaks = seq(0, 500, 50), minor_breaks = seq(0, 500, 10)) +
  scale_x_continuous(breaks = seq(1946, 2016, 5), minor_breaks = seq(1946, 2017, 1)) +
  labs(
    title = "Social scientists' expert testimonies in Congress",
    x = "Year",
    y = "Number of expert testimonies in Congress",
    caption = "Visualisation: David Aikman @ResearchingDave, Data Source: Charles Seguin, Thomas V. Maher, Yongjun Zhang (https://osf.io/e3h98/)"
  ) +
  theme(
    plot.title = element_text(face = "bold", size = 24, margin = margin(t = 20, b = 10, unit = "pt")),
    plot.caption = element_text(margin = margin(t = 20, unit = "pt")),
    legend.title = element_text(face = "bold", size = 16),
    legend.text = element_text(size = 14),
    axis.text = element_text(size = 16),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title = element_text(face = "bold", size = 16),
    panel.grid.major = element_line(color = "darkgrey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    plot.margin = margin(t = 5, r = 5, b = 5, l = 5, unit = "pt")
  )

ggsave(filename = "count_plot.png", width = 11, height = 8)
