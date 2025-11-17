/*5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?*/



WITH mzdy AS (
    SELECT 
        t1.payroll_year,
        ROUND(((t2.salary - t1.salary) / t1.salary) * 100, 2) AS yoy_mzdy
    FROM (
        SELECT payroll_year, AVG(salary) AS salary
        FROM t_huu_viet_nguyen_project_SQL_primary_final
        WHERE ib_code IS NOT NULL
        GROUP BY payroll_year
    ) t1
    JOIN (
        SELECT payroll_year, AVG(salary) AS salary
        FROM t_huu_viet_nguyen_project_SQL_primary_final
        WHERE ib_code IS NOT NULL
        GROUP BY payroll_year
    ) t2
        ON t2.payroll_year = t1.payroll_year + 1
),

potraviny AS (
    SELECT 
        t1.payroll_year,
        ROUND(AVG(((t2.value - t1.value) / t1.value) * 100), 2) AS yoy_potraviny
    FROM t_huu_viet_nguyen_project_SQL_primary_final t1
    JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
        ON t2.food_code = t1.food_code
        AND t2.payroll_year = t1.payroll_year + 1
    GROUP BY t1.payroll_year
),

hdp AS (
    SELECT 
        s1.year AS year,
        ROUND(((s2.GDP_mil_dollars - s1.GDP_mil_dollars) / s1.GDP_mil_dollars) * 100, 2) 
            AS yoy_hdp
    FROM t_huu_viet_nguyen_project_SQL_secondary_final s1
    JOIN t_huu_viet_nguyen_project_SQL_secondary_final s2
        ON s2.year = s1.year + 1
        AND s1.country = s2.country
    WHERE s1.country = 'Czech Republic'
)

SELECT
    h.year,
    h.yoy_hdp,
    m.yoy_mzdy,
    p.yoy_potraviny,
    (m.yoy_mzdy - h.yoy_hdp) AS mzdy_minus_hdp,
    (p.yoy_potraviny - h.yoy_hdp) AS potraviny_minus_hdp
FROM hdp h
LEFT JOIN mzdy m 
    ON m.payroll_year = h.year
LEFT JOIN potraviny p
    ON p.payroll_year = h.year
ORDER BY h.year;
