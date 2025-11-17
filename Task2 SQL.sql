/*2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období 
v dostupných datech cen a mezd?*/

#mleko 114201
#chleb 111301

SELECT MIN(payroll_year) AS first_year,
       MAX(payroll_year) AS last_year
FROM t_huu_viet_nguyen_project_SQL_primary_final
WHERE ib_code IS NULL
    AND food_code IN (114201, 111301);

SELECT 
    payroll_year,
    food_code,
    food_name,
    value,
    salary,
    ROUND(salary / value, 0) AS kolik_si_koupim
FROM t_huu_viet_nguyen_project_SQL_primary_final
WHERE ib_code IS NULL
  AND food_code IN (114201, 111301)
  AND payroll_year IN (
        (SELECT MIN(payroll_year) 
         FROM t_huu_viet_nguyen_project_SQL_primary_final 
         WHERE ib_code IS NULL AND food_code IN (114201, 111301)),
        (SELECT MAX(payroll_year) 
         FROM t_huu_viet_nguyen_project_SQL_primary_final 
         WHERE ib_code IS NULL AND food_code IN (114201, 111301))
    )
ORDER BY payroll_year, food_code;


