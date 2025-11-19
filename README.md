# Engeto-project-24-4-2025
SQL data analysis project

Průvodní zpráva k projektu v SQL 

Zadání projektu: 
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast. 
Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období. 
Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Datové sady, které je možné použít pro získání vhodného datového podkladu Primární tabulky: 
1. czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
2. czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
3. czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd. 
4. czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
5. czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd. 
6. czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR. 
7. czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu. 

Číselníky sdílených informací o ČR:
1. czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2. 
2. czechia_district – Číselník okresů České republiky dle normy LAU. 

Dodatečné tabulky: 
1. countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
2. economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok. 

Výzkumné otázky 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? 
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli,  pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

Výstup projektu 

Úvod: 
Tato průvodní zpráva slouží k prezentaci výsledků a závěrů z analýzy dat týkajících se mezd, cen potravin a jejich vztahu k výšce HDP. Projekt se zaměřil na důkladné zpracování dostupných dat o mzdách a cenách potravin z různých let s cílem odhalit klíčové trendy a vzájemné souvislosti mezi těmito faktory. V následujících sekcích představíme odpovědi na pět výzkumných otázek, které nás vedly k analýze dat. 
Pro každý úkol je vytvořený jednotlivý soubor (Task1 - Task5). Zároveň je samostatný soubor pro vytváření tabulek (tables.sql) 

1. Růst mezd v odvětvích 
- Prozkoumali jsme data a zjistili jsme, že mzdy ve většině odvětví průběžně rostou v průběhu let. Nicméně ve vybraných odvětvích jsme také zaznamenali pokles mezd.
 -Ve většině odvětví bylo nalezeno období, ve kterém mzda meziročně klesala. To si můžeme nádherně zobrazit ve sloupci growing 
- pokud je tento sloupce vyplněn textem znamená to, že mzda meziročně klesala. V ostatních případech mzda meziročně rostla.

2. Kolik litrů mléka a kilogramů chleba lze koupit za první a poslední srovnatelné období? 
- Analyzovali jsme dostupná data o cenách mléka a chleba za první a poslední srovnatelné období. 
- Na základě těchto dat jsme vypočítali, že v prvním období (rok 2006) jsme si mohli koupit 1192 kg chleba nebo 1331 litrů mléka. 
- V posledním období (rok 2018) jsme si mohli koupit 1300 kg chleba nebo 1590 litrů mléka, tedy více než v prvním období

3. Která kategorie potravin zdražuje nejpomaleji
 - Identifikovali jsme různé kategorie potravin a analyzovali jsme jejich ceny v průběhu let. Na základě meziročních změn jsme zjistili, že kategorii, která zdražuje nejpomaleji jsou banány žluté. Meziroční procentuální nárust této kategorie je průměrně 0,81% - Zároveň jsme vypozorovali, že mezi sledovanými daty jsou dokonce dvě kategorie, u kterých cena meziročně klesala. A to jsou: Rajská jablka červená kulatá a Cukr krystalový

4. Porovnání růstu cen potravin a mezd 
- Prozkoumali jsme data o meziročních změnách cen potravin a mezd a hledali rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %). Výsledky ukazují, že takový rok neexistuje 

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? - Prostudovali jsme data o výšce HDP v jednotlivých letech a analyzovali jsme jejich vztah k mzdám a cenám potravin. Zajímalo nás, zda výrazný nárůst HDP v jednom roce ovlivní mzdy a ceny potravin ve stejném nebo následujícím roce výraznějším růstem. 

Rok	     růst mezd (%)	růst cen potravin (%)	růst HDP (%)
2006→2007	14.96	             9.26	                 5.57
2007→2008	15.65	             8.91	                 2.69
2008→2009	10.57	            -6.58	                -4.66
2009→2010	09.8	             1.52	                 2.43
2010→2011	9.25	             4.85	                 1.76
2011→2012	9.92	             7.47	                -0.79
2012→2013	5.57	             06.1	                -0.05
2013→2014	8.43	            -0.62	                 2.26
2014→2015	08.9	            -0.69	                 5.39
2015→2016	8.62	            -1.41	                 2.54
2016→2017	10.57	             07.6	                 5.17
2017→2018	11.41	             2.41	                 3.20

Celkový závěr 
HDP má určitý vliv na růst mezd, ale není to přímá úměra.
HDP téměř neovlivňuje ceny potravin.
Ceny potravin a mzdy mezi sebou nemají téměř žádný vztah.
Ceny potravin se řídí úplně jinými faktory než HDP či průměrná mzda.

Závěr: 
Na základě analýzy dat jsme získali odpovědi na výzkumné otázky týkající se mezd, cen potravin a jejich vztahu k výšce HDP. Výstupy z úkolů lze získat z tabulek: 
t_huu_viet_nguyen_project_SQL_primary_final t_huu_viet_nguyen_project_SQL_secondary_final 

Vypracoval: Huu Viet Nguyen Dne 9.11.2025
