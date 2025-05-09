-- Durchschnittliche tägliche Aktivität pro Nutzer
SELECT
  Id,
  AVG(total_steps) AS avg_steps,
  AVG(total_distance) AS avg_distance,
  AVG(calories) AS avg_calories,
  AVG(very_active_minutes) AS avg_very_active_min,
  AVG(fairly_active_minutes)AS avg_fairly_active_min,
  AVG(lightly_active_minutes) AS avg_lightly_active_min,
  AVG(sedentary_minutes) AS avg_sedentary_min
FROM `bellabeat-analysis-459322.fitbit_data.cleaned_data`
GROUP BY Id
ORDER BY avg_steps DESC;

