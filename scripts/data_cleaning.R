library(tidyverse)   
library(lubridate)   
library(janitor)    
library(skimr)       
library(here) 

daily_activity_1 <- read_csv(here("data", "Fitabase Data 3.12.16-4.11.16", "dailyActivity_merged.csv"))
daily_activity_2 <- read_csv(here("data", "Fitabase Data 4.12.16-5.12.16", "dailyActivity_merged.csv"))

sleep_data <- read_csv(here("data", "Fitabase Data 4.12.16-5.12.16", "sleepDay_merged.csv"))

heartrate_1 <- read_csv(here("data", "Fitabase Data 3.12.16-4.11.16", "heartrate_seconds_merged.csv"))
heartrate_2 <- read_csv(here("data", "Fitabase Data 4.12.16-5.12.16", "heartrate_seconds_merged.csv"))

combined_daily <- bind_rows(daily_activity_1, daily_activity_2) %>%
  clean_names()

combined_heartrate <- bind_rows(heartrate_1, heartrate_2) %>%
  clean_names()

cleaned_daily <- combined_daily %>%
  distinct() %>%
  filter(
    total_steps > 0,          
    total_steps <= 25000,     
    calories > 0,             
    sedentary_minutes < 1440 
  ) %>%
  mutate(
    activity_date = mdy(activity_date),
    weekday = weekdays(activity_date)
  ) %>%
  select(
    id, activity_date, total_steps, total_distance, 
    calories, sedentary_minutes, lightly_active_minutes,
    fairly_active_minutes, very_active_minutes, weekday
  )

cleaned_sleep <- sleep_data %>%
  clean_names() %>%
  distinct() %>%
  filter(
    total_minutes_asleep > 0,   
    total_time_in_bed <= 1440    
  ) %>%
  mutate(
    sleep_day = mdy_hms(sleep_day),
    sleep_date = as_date(sleep_day)
  ) %>%
  select(id, sleep_date, total_minutes_asleep)

cleaned_heartrate <- combined_heartrate %>%
  mutate(
    time = mdy_hms(time),
    hour = hour(time),
    date = as_date(time)
  ) %>%
  group_by(id, date, hour) %>%
  summarise(avg_heartrate = mean(value)) %>%
  ungroup()

final_data <- cleaned_daily %>%
  left_join(cleaned_sleep, by = c("id", "activity_date" = "sleep_date")) %>%
  left_join(cleaned_heartrate, by = c("id", "activity_date" = "date"))

final_data %>% summarise(unique_users = n_distinct(id))  

final_data_clean <- final_data %>%
  filter(id %in% official_ids) 

final_data_clean %>% summarise(unique_users = n_distinct(id))  

skim(final_data_clean) 

write_csv(final_data_clean, here("data", "bellabeat_final_data.csv"))
