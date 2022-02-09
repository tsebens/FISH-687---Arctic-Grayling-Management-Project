library(readxl)
library(tidyverse)
################################
###### READ IN THE DATA#########
################################

# Filepath to the data document
fp = file.path(here::here(), "Data", "DCR classs project.xls")

# 1998 sheet
sh_1998 =
  read_excel(
    fp, 
    sheet="1998", 
    skip=1
  ) %>%
  magrittr::set_colnames(
    c(
      "litho",
      "line",
      "page",
      "date",
      "river",
      "sublocation",
      "river_mile",
      "crew",
      "event",
      "fly_jig",
      "length",
      "tag_number",
      "tag_color",
      "age"
    )
  ) %>% 
  dplyr::select(date, sublocation, river_mile, length, age) %>% 
  mutate(date = as.Date(as.numeric(date), origin = as.Date("1899-12-30"))) %>% 
  cbind(year = 1998)


# 1999 sheet
sh_1999 = read_excel(
  fp, 
  sheet="1999", 
  skip=1
) %>%
  magrittr::set_colnames(
    c(
      "litho",
      "line",
      "page",
      "date",
      "river",
      "sublocation",
      "river_mile",
      "crew",
      "event",
      "fly_jig",
      "length",
      "tag_number",
      "tag_color",
      "age"
    )
  ) %>% 
  dplyr::select(date, sublocation, river_mile, length, age) %>% 
  mutate(date = as.Date(date)) %>% 
  cbind(year = 1999)


# 2000 sheet
sh_2000 = read_excel(
  fp, 
  sheet="2000", 
  skip=1
) %>%
  magrittr::set_colnames(
    c(
      "litho",
      "line",
      "page",
      "date",
      "river",
      "sublocation",
      "river_mile",
      "crew",
      "event",
      "fly_jig",
      "length",
      "tag_number",
      "tag_color",
      "age"
    )
  ) %>% 
  dplyr::select(date, sublocation, river_mile, length, age) %>% 
  mutate(date = as.Date(as.numeric(date), origin = as.Date("1899-12-30"))) %>% 
  cbind(year = 2000)


# 2006 sheet
sh_2006 = read_excel(
  fp, 
  sheet="2006", 
  skip=1
) %>%
  magrittr::set_colnames(
    c("date", "river", "fish_num", "sublocation", "river_mile", "event", "gear_type", "length", "tag_number", "tag_color", "age")
  ) %>% 
  dplyr::select(date, river_mile, length, age) %>% 
  mutate(date = as.Date(date)) %>% 
  cbind(year = 2006)


# Bind the individual years into a single dataframe
dat = plyr::rbind.fill(
  sh_1998,
  sh_1999,
  sh_2000,
  sh_2006
) %>% 
  drop_na(date, length) %>% # Drop any of the rows missing critical values (also dummy rows)
  select(year, date, sublocation, river_mile, length, age)
