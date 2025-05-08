# Phase 3: Process – Daten bereinigen  

## 🧹 Bereinigungsschritte  
1. **Ausreißer entfernen:**  
   - Ein Nutzer mit 35.000 Schritten/Tag (unrealistisch).  
2. **Fehlende Werte behandeln:**  
   - Median-Imputation bei Schlafdaten.  

## 💻 Code-Snippet (R)  
```r
library(dplyr)
cleaned_data <- raw_data %>%
  filter(Steps < 25000) %>%
  mutate(SleepMinutes = ifelse(is.na(SleepMinutes), median(SleepMinutes, na.rm = TRUE), SleepMinutes))
```
 [Hier geht's zum vollständigen R-Skript zur Datenbereinigung](scripts/data_cleaning.R)
