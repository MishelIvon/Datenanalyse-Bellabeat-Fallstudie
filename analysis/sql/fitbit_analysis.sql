1. Datenexploration und Qualitätsprüfung

-- Prüfe die Zeitspanne der Daten
SELECT 
  MIN(activity_date) AS start_date,
  MAX(activity_date) AS end_date,
  DATE_DIFF(MAX(activity_date), MIN(activity_date), DAY) AS days_covered
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`;

-- Anzahl der Nutzer und Tage pro Nutzer
SELECT 
  Id,
  COUNT(DISTINCT activity_date) AS days_tracked
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`
GROUP BY Id
ORDER BY days_tracked DESC;

2. Aktivitätsanalyse (Fokus: Bellabeat Leaf)

-- Durchschnittliche tägliche Aktivität
SELECT
  Id,
  AVG(total_steps) AS avg_steps,
  AVG(total_distance) AS avg_distance_km,
  AVG(calories) AS avg_calories,
  AVG(very_active_minutes) AS avg_intense_activity
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`
GROUP BY Id
ORDER BY avg_steps DESC;
