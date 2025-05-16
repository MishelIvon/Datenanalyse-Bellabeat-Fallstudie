# 📊 Bellabeat Case Study: Datenanalyse für zielgerichtetes Marketing

**Autorin:** Mishel-Ivon Jovanovski  
**Rolle:** Data Analyst

---

## 🧠 Einführung

Ziel dieser Analyse ist es, auf Basis von Fitbit-Daten Verhaltensmuster in den Bereichen Aktivität, Schlaf und Stress zu identifizieren und daraus datengetriebene Marketing­empfehlungen für den **Leaf-Tracker** von Bellabeat abzuleiten.

---

## 🔍 Projektstruktur & Phasen

- [**Phase 1 – Ask**: Geschäftsauftrag & Fragestellung](./1-ask.md)  
- [**Phase 2 – Prepare**: Datensichtung & -verständnis](./2-prepare.md)  
- [**Phase 3 – Process**: Datenbereinigung in R](./3-process.md)  
- [**Phase 4 – Analyze**: Trends erkennen & Hypothesen testen](./4-analyze.md)  
- [**Phase 5 – Share**: Visualisierungen & Ergebnisse](./5-share.md)  
- [**Phase 6 – Act**: Konkrete Handlungsempfehlungen](./6-act.md)  

---

## 🛠️ Genutzte Skripte & Dateien

- **R-Skript:** `scripts/data_cleaning.R`  
- **SQL-Queries:** `analysis/sql/fitbit_analysis.sql`  
- **Visualisierungen:** Ordner `images/` (PNG-Grafiken aus Tableau)

- **R-Pakete:**  
  ```r
  library(tidyverse)
  library(lubridate)
  library(janitor)
  library(skimr)
  library(here)
  
## 📈 Wichtigste Erkenntnisse

- **Wochenend-Aktivität:** Deutlich höhere Schrittzahlen an Samstag und Sonntag  
- **Schlafmuster:** Längere, erholsamere Schlafphasen am Wochenende  
- **Stress & Herzfrequenz:** Erhöhte Herzfrequenz korreliert mit weniger Schlaf  
- **Nutzersegment:** Ca. 50 % „Highly Active“, 15 % „Sedentary“

---

## 💡 Empfehlungen für Bellabeat

- **Wochenend-Kampagnen** – Nutze die erhöhte Aktivität am Wochenende für gezielte Aktionen.  
- **Reminder-Funktion** – Automatische Push Benachrichtigungen an schwächeren Tagen.  
- **Schlaf-Feature promoten** – Hebe die Schlaf­tracking Vorteile stärker hervor.  
- **Stressmanagement integrieren** – Biete in der App kurze Atem und Achtsamkeitsübungen an.  
- **Gamification & Personalisierung** – Belohnungen für Aktivitäts und Schlafziele; individuelle Challenges.  


