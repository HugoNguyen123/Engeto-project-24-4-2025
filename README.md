# Engeto-project-24-4-2025
Discord účet - xrakosnicek123x#9043
# Analýza dostupnosti potravin a mezd v ČR

**Vypracoval:** Huu Viet Nguyen  
**Datum:** 9.11.2025

---

## Úvod
Tento projekt analyzuje vztah mezi mzdami, cenami potravin a HDP v České republice. Cílem je poskytnout tiskovému oddělení robustní datové podklady pro prezentaci na konferenci zaměřené na životní úroveň občanů. Analýza se zaměřuje na meziroční změny mezd a cen potravin a zkoumá, zda existuje souvislost s HDP.

---

## Výzkumné otázky
1. Rostou mzdy ve všech odvětvích, nebo v některých klesají?  
2. Kolik litrů mléka a kilogramů chleba lze koupit za první a poslední srovnatelné období?  
3. Která kategorie potravin zdražuje nejpomaleji?  
4. Existuje rok, kdy nárůst cen potravin překročil růst mezd o více než 10 %?  
5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

---

## Shrnutí výsledků

### 1. Růst mezd v odvětvích
- Většina odvětví vykazuje postupný růst mezd.  
- V některých odvětvích byly zaznamenány meziroční poklesy.  
- Sloupec **growing** označuje:
  - `'salary is lower than previous year'` → mzda meziročně klesla  
  - `'0'` → mzda rostla nebo zůstala stejná  
- Některé řádky obsahují prázdné hodnoty v `ib_code` a `ib_name`, což představuje agregace mimo konkrétní odvětví.

### 2. Dostupnost mléka a chleba
- **Rok 2006 (první období):** 1192 kg chleba nebo 1331 litrů mléka  
- **Rok 2018 (poslední období):** 1300 kg chleba nebo 1590 litrů mléka  
- Závěr: dostupnost potravin se mírně zlepšila v průběhu let.

### 3. Kategorie potravin s nejnižším růstem
- Nejpomalejší růst: **banány žluté** – průměrný meziroční nárůst 0,81 %  
- Ceny některých potravin meziročně klesaly:
  - Rajská jablka červená kulatá  
  - Cukr krystal

### 4. Porovnání růstu cen potravin a mezd
- Žádný rok nevykázal meziroční nárůst cen potravin vyšší než růst mezd o více než 10 %.
- Rok 2012 vykazoval mírně zvýšený nárůst 6-8 %.

### 5. Vliv HDP na mzdy a ceny potravin

| Rok       | Růst mezd (%) | Růst cen potravin (%) | Růst HDP (%) |
|-----------|---------------|---------------------|--------------|
| 2006→2007 | 14,96         | 9,26                | 5,57         |
| 2007→2008 | 15,65         | 8,91                | 2,69         |
| 2008→2009 | 10,57         | -6,58               | -4,66        |
| 2009→2010 | 9,8           | 1,52                | 2,43         |
| 2010→2011 | 9,25          | 4,85                | 1,76         |
| 2011→2012 | 9,92          | 7,47                | -0,79        |
| 2012→2013 | 5,57          | 6,1                 | -0,05        |
| 2013→2014 | 8,43          | -0,62               | 2,26         |
| 2014→2015 | 8,9           | -0,69               | 5,39         |
| 2015→2016 | 8,62          | -1,41               | 2,54         |
| 2016→2017 | 10,57         | 7,6                 | 5,17         |
| 2017→2018 | 11,41         | 2,41                | 3,2          |

**Závěr:**  
- HDP má určitý vliv na růst mezd, ale neexistuje přímá úměra.  
- HDP téměř neovlivňuje ceny potravin.  
- Ceny potravin a mzdy mezi sebou prakticky nesouvisí.  
- Ceny potravin se řídí jinými faktory než HDP nebo průměrná mzda.

---

## Informace o datech
- Některé sloupce (`salary`, `value`, `GDP_mil_dollars`, `ib_code`, `ib_name`) obsahují chybějící hodnoty (NULL).  
- Poslední rok každého odvětví nemá hodnoty `salary_nextyear` a `diff`.  
- Výpočty meziročního růstu respektují pouze roky s dostupnými daty a chrání před dělením nulou.

---

## Použité datové zdroje
- **Primární:** mzdy a ceny potravin – `t_huu_viet_nguyen_project_SQL_primary_final`  
- **Sekundární:** HDP, GINI, populace – `t_huu_viet_nguyen_project_SQL_secondary_final`  
- **View:** `industry_salary_with_growth` – přehled meziročního růstu mezd podle odvětví





