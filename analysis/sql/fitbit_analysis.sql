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

-- Klassifiziere Aktivitätslevel
SELECT
  CASE
    WHEN total_steps < 5000 THEN 'Sedentary'
    WHEN total_steps BETWEEN 5000 AND 7499 THEN 'Low Active'
    WHEN total_steps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
    ELSE 'Highly Active'
  END AS activity_level,
  COUNT(*) AS days_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`), 2) AS percentage
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`
GROUP BY activity_level
ORDER BY 
  CASE activity_level
    WHEN 'Sedentary' THEN 1
    WHEN 'Low Active' THEN 2
    WHEN 'Moderately Active' THEN 3
    ELSE 4
  END;

3. Schlafanalyse für Bellabeat Time (Schlaf-Tracking)

-- Durchschnittliche Schlafdauer pro Nutzer
SELECT
  Id,
  AVG(total_minutes_asleep) / 60 AS avg_hours_asleep,
  AVG(TotalTimeInBed) / 60 AS avg_hours_in_bed,
  AVG(TotalTimeInBed - total_minutes_asleep) AS avg_minutes_awake
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data_v2`
WHERE total_minutes_asleep IS NOT NULL
GROUP BY Id
ORDER BY avg_hours_asleep DESC;
