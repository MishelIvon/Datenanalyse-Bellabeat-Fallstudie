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


