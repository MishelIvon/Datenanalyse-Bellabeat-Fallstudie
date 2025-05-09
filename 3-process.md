## Phase 3: Process – Daten bereinigen  
🧹 **Bereinigungsschritte**  

1. **Ausreißer entfernen:**  
   - Tägliche Schritte > 25.000 (z. B. ein Nutzer mit 35.000 Schritten).  
   - Sitzende Zeit ≥ 24h (technisch unmöglich).  

2. **Fehlende Werte behandeln:**  
   - **Median-Imputation** bei fehlenden Schlafdaten (`total_minutes_asleep`).  

3. **Datumsformatierung:**  
   - Konvertierung von `ActivityDate` in ein standardisiertes Datumsformat.  

4. **Spaltenauswahl:**  
   - Entfernung irrelevanter Spalten (z. B. `LoggedActivitiesDistance`).  

💻 **Code-Snippet (R)**  
```r
# Daten bereinigen
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
```


 [Hier geht's zum vollständigen R-Skript zur Datenbereinigung](scripts/data_cleaning.R)
