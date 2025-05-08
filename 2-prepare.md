# Phase 2: Prepare – Daten vorbereiten

## 📊 Datenquelle  
Die Analyse basiert auf öffentlich zugänglichen Daten von Kaggle:  
📎 [FitBit Fitness Tracker Data (CC0: Public Domain)](https://www.kaggle.com/datasets/arashnic/fitbit)  

**Überblick:**  
- Beobachtungen: Daten von **30 freiwilligen Fitbit-Nutzer:innen**  
 - Dateiformat: Mehrere **CSV-Dateien**, z. B. tägliche Aktivität, Schlaf, Herzfrequenz  
- **Wichtige Metriken:**  
  - Schritte (TotalSteps)  
  - Schlafdauer (TotalMinutesAsleep)  
  - Kalorienverbrauch (Calories)  
  - Intensitätslevel (VeryActiveMinutes etc.)  
  - ggf. Stress / Ruhezeiten (ableitbar über Herzfrequenzdaten)

## 📂 Datenstruktur  
Die Daten liegen in **Wide-Format-Tabellen** vor, jede Datei enthält eine andere Messdimension (z. B. Aktivität, Schlaf, Gewicht).  
Zur späteren Analyse müssen sie **vereinheitlicht und zusammengeführt** werden (z. B. über `Id` und Datum).

## ⚠️ Limitierungen  
- ❌ **Keine demografischen Daten** wie Alter, Geschlecht oder BMI → keine zielgruppenspezifische Segmentierung möglich  
- ❌ **Kleine Stichprobe (n=30)** → Ergebnisse sind nicht generalisierbar auf die Gesamtbevölkerung  
- ❌ **Selbstberichtete Daten können ungenau sein**  
- ⚠️ Keine Daten zu **Gerätemodell oder konkreter Tracker-Nutzung** (z. B. Leaf vs. andere Tracker)

---

## 🧠 Bewertung der Datenqualität (ROCCC-Prinzip)

- **Reliable:** Daten stammen von echten Geräten (Fitbit)  
- **Original:** Keine Sekundärdaten – direkt erfasst  
- **Comprehensive:** Mehrere Gesundheitsmetriken abgedeckt  
- **Current:** Daten sind etwas älter, aber für Nutzungsmuster noch aussagekräftig  
- **Cited:** Frei verfügbar unter Public Domain Lizenz (CC0)
