# Phase 4: Analyze – Trends identifizieren  

## 📈 Statistische Kennzahlen  
- **Durchschnittliche Schritte:**  
  - Werktage: 8.200  
  - Wochenende: 4.500  
- **Stress-Tracking:**  
  - Nutzer mit <7h Schlaf trackten Stress **3x häufiger**.  

## 💻 SQL-Abfrage  
```sql
SELECT 
  AVG(Steps) AS AvgSteps,
  AVG(SleepMinutes) AS AvgSleep
FROM fitbit_data
WHERE WEEKDAY(ActivityDate) IN (0, 1, 2, 3, 4); -- Montag bis Freitag
```
[Hier geht's zum vollständigen SQL-Code](analysis/sql/fitbit_analysis.sql)
