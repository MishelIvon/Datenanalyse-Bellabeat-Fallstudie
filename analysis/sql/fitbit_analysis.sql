1. Tabelle mit korrigierten Datentypen erstellen (direkt aus cleaned_data)

CREATE OR REPLACE TABLE `bellabeat-analysis-459322.fitbit_data.final_analysis` AS
SELECT
  id,
  activity_date,
  total_steps,
  total_distance,
  calories,
  sedentary_minutes,
  lightly_active_minutes,
  fairly_active_minutes,
  very_active_minutes,
  weekday,
  -- Konvertiere total_minutes_asleep zu FLOAT64
  SAFE_CAST(REGEXP_REPLACE(total_minutes_asleep, '[^0-9.]', '') AS FLOAT64) AS total_minutes_asleep,
  -- Konvertiere avg_heartrate zu FLOAT64
  SAFE_CAST(REGEXP_REPLACE(avg_heartrate, '[^0-9.]', '') AS FLOAT64) AS avg_heartrate
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`;

2. Aktivitätslevel-Analyse (Bellabeat Leaf)

SELECT
  CASE
    WHEN total_steps < 5000 THEN 'Sedentary'
    WHEN total_steps BETWEEN 5000 AND 7499 THEN 'Low Active'
    WHEN total_steps BETWEEN 7500 AND 9999 THEN 'Moderately Active'
    ELSE 'Highly Active'
  END AS activity_level,
  COUNT(*) AS days_count,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `bellabeat-analysis-459322.fitbit_data.final_analysis`), 2) AS percentage
FROM `bellabeat-analysis-459322.fitbit_data.final_analysis`
GROUP BY activity_level
ORDER BY 
  CASE activity_level
    WHEN 'Sedentary' THEN 1 WHEN 'Low Active' THEN 2 
    WHEN 'Moderately Active' THEN 3 ELSE 4
  END;

3. Schlafanalyse (Bellabeat Time)

SELECT
  CASE
    WHEN total_minutes_asleep/60 < 6 THEN 'Insufficient Sleep'
    WHEN total_minutes_asleep/60 BETWEEN 6 AND 7 THEN 'Below Average'
    ELSE 'Healthy Sleep'
  END AS sleep_category,
  COUNT(*) AS days_count,
  AVG(calories) AS avg_calories_burned
FROM `bellabeat-analysis-459322.fitbit_data.final_analysis`
WHERE total_minutes_asleep IS NOT NULL
GROUP BY sleep_category;




