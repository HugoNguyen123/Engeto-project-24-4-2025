#1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT *
FROM t_huu_viet_nguyen_project_SQL_primary_final;

/*
Pokud plat meziročně vzrostl nebo zůstal stejný potom ve sloupci growing bude 0 
Pokud se naopak snížil tak ve sloupci growing najdeme text: salary is lower than previous year
*/
DROP VIEW IF EXISTS industry_salary_with_growth;

CREATE VIEW industry_salary_with_growth AS
WITH salary_growth AS (
    SELECT
        ib_code,
        ib_name,
        payroll_year,
        AVG(salary) AS salary,
        LEAD(AVG(salary)) OVER (PARTITION BY ib_code ORDER BY payroll_year) AS salary_nextyear
    FROM t_huu_viet_nguyen_project_SQL_primary_final
    GROUP BY ib_code, ib_name, payroll_year
)
SELECT
    ib_code,
    ib_name,
    payroll_year,
    salary,
    salary_nextyear,
    CASE
        WHEN salary_nextyear < salary THEN 'salary is lower than previous year'
        ELSE '0'
    END AS growing,
    salary_nextyear - salary AS diff
FROM salary_growth
WHERE salary_nextyear IS NOT NULL
ORDER BY 
    CASE WHEN salary_nextyear - salary < 0 THEN 1 ELSE 0 END DESC,
    ib_code,
    payroll_year;

/*
 Seřazení dat podle toho jestli mzdy klesaly a podle odvětví a roku
 */

SELECT * 
FROM industry_salary_with_growth

-- Příklad konkrétních odvětví a let
SELECT *
FROM industry_salary_with_growth
WHERE ib_code IN ('A', 'B', 'C')  -- konkrétní odvětví pro ukázku
  AND payroll_year IN (2015, 2016, 2017)  -- konkrétní roky
ORDER BY 
    CASE WHEN salary_nextyear - salary < 0 THEN 1 ELSE 0 END DESC,
    ib_code,
    payroll_year;
	
