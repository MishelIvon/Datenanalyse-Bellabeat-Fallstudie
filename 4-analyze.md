# Phase 4: Trends erkennen & Hypothesen testen

## 📈 Statistische Kennzahlen

- **Durchschnittliche Schrittanzahl:**  
  - **Werktage (Montag–Freitag):** ca. 9.500 Schritte pro Tag  
  - **Wochenende (Samstag & Sonntag):** ca. 8.900 Schritte pro Tag  
  → Die Aktivität sinkt am Wochenende moderat, bleibt aber auf hohem Niveau.

- **Stress-Tracking:**  
  Nutzer mit durchschnittlich weniger als 7 Stunden Schlaf weisen eine etwa **dreimal höhere Häufigkeit von Stress-Tagen** (erhöhte Herzfrequenz) auf als Nutzer mit 7 oder mehr Stunden Schlaf.

## 💻 SQL-Abfrage  
```sql
SELECT 
  AVG(Steps) AS AvgSteps,
  AVG(SleepMinutes) AS AvgSleep
FROM fitbit_data
WHERE WEEKDAY(ActivityDate) IN (0, 1, 2, 3, 4); -- Montag bis Freitag
```
[Hier geht's zum vollständigen SQL-Code](analysis/sql/fitbit_analysis.sql)
