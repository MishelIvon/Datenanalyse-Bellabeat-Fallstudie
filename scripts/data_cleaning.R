# data_cleaning.R
# Autorin: Mishel-Ivon Jovanovski
# Zweck: Einlesen, Bereinigen & Zusammenführen aller Fitbit-Daten
# Input: data/Fitabase Data …/*.csv
# Output: data/bellabeat_final_data.csv
# Letzte Änderung: 2025-05-16

# Bibliotheken laden
library(tidyverse)    # Für Datenmanipulation und visuelle Aufbereitung
library(lubridate)    # Für Datum- und Zeitfunktionen
library(janitor)      # Für einfache Datenbereinigung (clean_names etc.)
library(skimr)        # Für schnelle Zusammenfassung der Datensätze
library(here)         # Für pfadunabhängiges Arbeiten im Projektverzeichnis

# 1) Daily Activity-Daten einlesen
daily_activity_1 <- read_csv(
  here("data", "Fitabase Data 3.12.16-4.11.16", "dailyActivity_merged.csv")
)
daily_activity_2 <- read_csv(
  here("data", "Fitabase Data 4.12.16-5.12.16", "dailyActivity_merged.csv")
)

# 2) Sleep-Daten einlesen
sleep_data <- read_csv(
  here("data", "Fitabase Data 4.12.16-5.12.16", "sleepDay_merged.csv")
)

# 3) Heartrate-Daten einlesen
heartrate_1 <- read_csv(
  here("data", "Fitabase Data 3.12.16-4.11.16", "heartrate_seconds_merged.csv")
)
heartrate_2 <- read_csv(
  here("data", "Fitabase Data 4.12.16-5.12.16", "heartrate_seconds_merged.csv")
)

# 4) Daten kombinieren und Spalten bereinigen
combined_daily <- bind_rows(daily_activity_1, daily_activity_2) %>%
  clean_names()  # Spaltennamen in snake_case umwandeln

combined_heartrate <- bind_rows(heartrate_1, heartrate_2) %>%
  clean_names()

# 5) Datenreinigung für tägliche Aktivitäten
cleaned_daily <- combined_daily %>%
  distinct() %>%                            # Duplikate entfernen
  filter(
    total_steps > 0,                        # Nur Tage mit mehr als 0 Schritten
    total_steps <= 25000,                   # Realistischer Maximalwert
    calories > 0,                           # Kalorienverbrauch muss positiv sein
    sedentary_minutes < 1440                # Weniger als 24 Stunden sitzend
  ) %>%
  mutate(
    activity_date = mdy(activity_date),    # Datum im Monat-Tag-Jahr-Format umwandeln
    weekday = weekdays(activity_date)       # Wochentag extrahieren
  ) %>%
  select(
    id, activity_date, total_steps, total_distance,
    calories, sedentary_minutes, lightly_active_minutes,
    fairly_active_minutes, very_active_minutes, weekday
  )

# 6) Datenreinigung für Schlafdaten
cleaned_sleep <- sleep_data %>%
  clean_names() %>%                          # Spaltennamen bereinigen
  distinct() %>%                              # Duplikate entfernen
  filter(
    total_minutes_asleep > 0,                # Mindestens 1 Minute Schlaf
    total_time_in_bed <= 1440                 # Nicht mehr als 24 Stunden im Bett
  ) %>%
  mutate(
    sleep_day = mdy_hms(sleep_day),          # Datumzeit umwandeln
    sleep_date = as_date(sleep_day)          # Nur das Datum extrahieren
  ) %>%
  select(id, sleep_date, total_minutes_asleep)

# 7) Datenreinigung für Herzfrequenzdaten
cleaned_heartrate <- combined_heartrate %>%
  mutate(
    time = mdy_hms(time),                    # Zeitstempel umwandeln
    hour = hour(time),                       # Stunde extrahieren
    date = as_date(time)                     # Datum extrahieren
  ) %>%
  group_by(id, date, hour) %>%               # Gruppierung nach Nutzer, Datum und Stunde
  summarise(avg_heartrate = mean(value), .groups = "drop")  # Durchschnitt berechnen

# 8) Zusammenführen aller Tabellen
final_data <- cleaned_daily %>%
  left_join(cleaned_sleep, by = c("id", "activity_date" = "sleep_date")) %>%
  left_join(cleaned_heartrate, by = c("id", "activity_date" = "date"))

# 9) Anzahl eindeutiger Nutzer prüfen
final_data %>% summarise(unique_users = n_distinct(id))

# 10) Offizielle Nutzer:innen auswählen (official_ids muss definiert sein)
official_ids <- read_csv(here("data", "official_user_ids.csv"))$id  # Beispielhafte Definition
final_data_clean <- final_data %>%
  filter(id %in% official_ids)

# 11) Datenqualität prüfen
final_data_clean %>% skim()  # Zusammenfassung der finalen Daten

# 12) Export der bereinigten Daten
write_csv(
  final_data_clean,
  here("data", "bellabeat_final_data.csv")
)
