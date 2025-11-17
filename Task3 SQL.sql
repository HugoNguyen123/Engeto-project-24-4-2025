#3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH growth AS (
    SELECT 
        t1.food_code,
        t1.food_name,
        ROUND(((t2.value::numeric / t1.value::numeric) - 1) * 100, 2) AS yoy_growth
    FROM t_huu_viet_nguyen_project_SQL_primary_final t1
    JOIN t_huu_viet_nguyen_project_SQL_primary_final t2
        ON t2.payroll_year = t1.payroll_year + 1
        AND t1.food_code = t2.food_code
)
SELECT 
    g.food_code,
    g.food_name,
    ROUND(AVG(g.yoy_growth::numeric), 2) AS avg_yoy_growth_percentage
FROM growth g
GROUP BY g.food_code, g.food_name
ORDER BY avg_yoy_growth_percentage;

