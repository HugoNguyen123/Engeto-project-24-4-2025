#4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

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
        ROUND(AVG(((t2.value / t1.value) - 1) * 100), 2) AS yoy_potraviny
    FROM t_huu_viet_nguyen_project_SQL_primary_final t1
    JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
        ON t2.food_code = t1.food_code
        AND t2.payroll_year = t1.payroll_year + 1
    GROUP BY t1.payroll_year
)

SELECT 
    p.payroll_year AS year,
    p.yoy_potraviny,
    m.yoy_mzdy,
    (p.yoy_potraviny - m.yoy_mzdy) AS rozdil,
    CASE WHEN p.yoy_potraviny - m.yoy_mzdy > 10 
         THEN 'ANO – růst cen > růst mezd o více než 10 %'
         ELSE 'NE'
    END AS extremni_narust
FROM potraviny p
JOIN mzdy m USING (payroll_year)
ORDER BY year;

	