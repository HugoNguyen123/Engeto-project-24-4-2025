/*5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?*/

--mzdy a ceny potravin
SELECT 
    t1.payroll_year AS payroll_year,
    AVG(t1.salary) AS salary,
    AVG(t2.salary) AS salary_nextyear,
    ROUND(((AVG(t2.salary) - AVG(t1.salary))/NULLIF(AVG(t1.salary),0))*100, 2) AS rozdil_mezd,
    AVG(t1.value) AS cena_potravin,
    AVG(t2.value) AS cena_potravin_dalsi_rok,
    AVG(ROUND(((t2.value - t1.value)/NULLIF(t1.value,0))*100, 2)) AS rozdil_potravin
FROM t_huu_viet_nguyen_project_SQL_primary_final t1
JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
    ON t1.payroll_year = t2.payroll_year - 1
    AND t1.food_code = t2.food_code
WHERE t1.ib_code IS NOT NULL
GROUP BY t1.payroll_year
ORDER BY t1.payroll_year;

--HDP
SELECT 
    secondary1.country,
    secondary1.year AS rok,
    secondary2.year AS rok_plus_1,
    secondary1.GDP_mil_dollars,
    ROUND(((secondary2.GDP_mil_dollars - secondary1.GDP_mil_dollars)/NULLIF(secondary1.GDP_mil_dollars,0) * 100), 2) AS procentualni_rozdil_HDP
FROM t_huu_viet_nguyen_project_SQL_secondary_final secondary1
JOIN t_huu_viet_nguyen_project_SQL_secondary_final secondary2
    ON secondary1.year = secondary2.year - 1
    AND secondary1.country = secondary2.country
WHERE secondary1.country = 'Czech Republic'
AND secondary1.GDP_mil_dollars IS NOT NULL;


DROP VIEW IF EXISTS vhled_mzdy_ceny;

CREATE VIEW vhled_mzdy_ceny AS
WITH mzdy_ceny AS (
    SELECT 
        t1.payroll_year AS payroll_year,
        ROUND(((AVG(t2.salary) - AVG(t1.salary)) / NULLIF(AVG(t1.salary),0))*100, 2) AS rozdil_mezd,
        AVG(t1.value) AS cena_potravin,
        AVG(t2.value) AS cena_potravin_dalsi_rok,
        ROUND(AVG((t2.value - t1.value) / NULLIF(t1.value,0)) * 100, 2) AS rozdil_potravin
    FROM t_huu_viet_nguyen_project_SQL_primary_final t1
    JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
        ON t1.payroll_year = t2.payroll_year - 1
        AND t1.food_code = t2.food_code
    WHERE t1.ib_code IS NULL
    GROUP BY t1.payroll_year
)
SELECT * FROM mzdy_ceny;

DROP VIEW IF EXISTS vhled_hdp;

CREATE VIEW vhled_hdp AS
WITH hdp AS (
    SELECT 
        s1.year AS rok,
        ROUND(((s2.GDP_mil_dollars - s1.GDP_mil_dollars) / NULLIF(s1.GDP_mil_dollars,0)) * 100, 2) AS procentualni_rozdil_HDP
    FROM t_huu_viet_nguyen_project_SQL_secondary_final s1
    JOIN t_huu_viet_nguyen_project_SQL_secondary_final s2
        ON s1.year = s2.year - 1
        AND s1.country = s2.country
    WHERE s1.country = 'Czech Republic'
)
SELECT * FROM hdp;

-- Hlavní dotaz: vliv HDP na mzdy a ceny potravin ve stejném i následujícím roce
DROP VIEW IF EXISTS vhled_finalni_analyza;

CREATE VIEW vhled_finalni_analyza AS
SELECT
    m.payroll_year,
    m.payroll_year + 1 AS next_year,
    m.rozdil_mezd,
    m.rozdil_potravin,
    h.procentualni_rozdil_HDP
FROM vhled_mzdy_ceny m
JOIN vhled_hdp h
    ON m.payroll_year = h.rok
ORDER BY m.payroll_year;

SELECT * FROM vhled_finalni_analyza;
