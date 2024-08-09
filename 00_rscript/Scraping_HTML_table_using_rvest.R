library(tidyverse)
library(rvest)

content <- read_html("https://en.wikipedia.org/wiki/List_of_highest-grossing_films")

tables <- content %>% html_table(fill = TRUE)

first_table <- data.frame(tables[1])

glimpse(first_table)

library(janitor)

first_table <- first_table %>% clean_names()

first_table %>% 
  mutate(worldwide_gross = parse_number(worldwide_gross)) %>% 
  arrange(desc(worldwide_gross)) %>% 
  head(20) %>% 
  mutate(title=fct_reorder(title, worldwide_gross)) %>% 
  ggplot() + geom_bar(aes(x = title, y = worldwide_gross), stat = "identity",
                      fill = "#ff1122") +
  labs("Top 20 Grossing Movies in Us", caption = "Data Source: Wikipedia")+
  coord_flip() 
  