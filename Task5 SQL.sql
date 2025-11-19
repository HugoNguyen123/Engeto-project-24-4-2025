/*5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?*/

WITH mzdy_ceny AS (
    SELECT 
        t1.payroll_year AS payroll_year,
        ROUND(((AVG(t2.salary) - AVG(t1.salary)) / NULLIF(AVG(t1.salary),0)) * 100, 2) AS rozdil_mezd,
        ROUND(AVG(t1.value), 2) AS cena_potravin,
        ROUND(AVG(t2.value), 2) AS cena_potravin_dalsi_rok,
        ROUND(AVG(((t2.value - t1.value) / NULLIF(t1.value,0)) * 100), 2) AS rozdil_potravin
    FROM t_huu_viet_nguyen_project_SQL_primary_final t1
    JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
        ON t1.payroll_year = t2.payroll_year - 1
        AND t1.food_code = t2.food_code
    WHERE t1.ib_code IS NULL
    GROUP BY t1.payroll_year
),
hdp AS (
    SELECT 
        s1.year AS rok,
        ROUND(((s2.GDP_mil_dollars - s1.GDP_mil_dollars) / NULLIF(s1.GDP_mil_dollars,0)) * 100, 2) AS procentualni_rozdil_HDP
    FROM t_huu_viet_nguyen_project_SQL_secondary_final s1
    JOIN t_huu_viet_nguyen_project_SQL_secondary_final s2
        ON s1.year = s2.year - 1
        AND s1.country = s2.country
    WHERE s1.country = 'Czech Republic'
)
SELECT
    m.payroll_year,
    m.payroll_year + 1 AS next_year,
    m.rozdil_mezd,
    m.rozdil_potravin,
    h.procentualni_rozdil_HDP
FROM mzdy_ceny m
JOIN hdp h
    ON m.payroll_year = h.rok
ORDER BY m.payroll_year;

