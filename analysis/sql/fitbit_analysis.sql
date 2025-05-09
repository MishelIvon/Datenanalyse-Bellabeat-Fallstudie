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


