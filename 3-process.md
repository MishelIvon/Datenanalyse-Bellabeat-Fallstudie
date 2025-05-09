# Phase 3: Process – Daten bereinigen  

## 🧹 Bereinigungsschritte  
1. **Ausreißer entfernen:**  
   - Ein Nutzer mit 35.000 Schritten/Tag (unrealistisch).  
2. **Fehlende Werte behandeln:**  
   - Median-Imputation bei Schlafdaten.  

## 💻 Code-Snippet (R)  
```r
cleaned_daily <- combined_daily %>%
  distinct() %>%
  filter(
    total_steps > 0,          # Entferne Tage ohne Schritte
    total_steps <= 25000,     # Entferne extreme Ausreißer
    calories > 0,             # Entferne Tage ohne Kalorien
    sedentary_minutes < 1440 # Maximal 24h sitzende Zeit
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
```
 [Hier geht's zum vollständigen R-Skript zur Datenbereinigung](scripts/data_cleaning.R)
