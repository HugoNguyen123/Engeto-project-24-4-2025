/*2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období 
v dostupných datech cen a mezd?*/

#mleko 114201
#chleb 111301

WITH years AS (
    SELECT 
        MIN(payroll_year) AS first_year,
        MAX(payroll_year) AS last_year
    FROM t_huu_viet_nguyen_project_SQL_primary_final
    WHERE ib_code IS NULL
      AND food_code IN (114201, 111301)
),
aggregated AS (
    SELECT
        payroll_year,
        food_code,
        food_name,
        AVG(value) AS avg_value,
        AVG(salary) AS avg_salary
    FROM t_huu_viet_nguyen_project_SQL_primary_final
    WHERE ib_code IS NULL
      AND food_code IN (114201, 111301)
    GROUP BY payroll_year, food_code, food_name
)
SELECT
    payroll_year,
    food_code,
    food_name,
    avg_value AS value,
    avg_salary AS salary,
    ROUND(avg_salary / avg_value, 0) AS how_much_I_can_buy
FROM aggregated a
JOIN years y
  ON a.payroll_year IN (y.first_year, y.last_year)
ORDER BY payroll_year, food_code;
  


