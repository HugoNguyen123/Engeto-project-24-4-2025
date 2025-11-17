DROP TABLE IF EXISTS t_huu_viet_nguyen_project_SQL_primary_final;

CREATE TABLE t_huu_viet_nguyen_project_SQL_primary_final AS
WITH cp AS (
    SELECT
        EXTRACT(YEAR FROM cp.date_from)::int AS date_from,
        ROUND(AVG(cp.value)::numeric, 2) AS value,
        cpc.code AS food_code,
        cpc.name AS food_name,
        cpc.price_value AS price_value,
        cpc.price_unit AS price_unit
    FROM czechia_price cp
    LEFT JOIN czechia_price_category cpc 
        ON cp.category_code = cpc.code
    WHERE cp.region_code IS NULL
    GROUP BY cpc.code, cpc.name, cpc.price_value, cpc.price_unit, EXTRACT(YEAR FROM cp.date_from)
),
cpay AS (
    SELECT 
        cpay.value_type_code AS value_type_code,
        cpay.unit_code AS unit_code,
        cpay_u.name AS unit_code_name,
        ROUND(AVG(cpay.value)::numeric, 2) AS salary,
        cpay.payroll_year AS payroll_year,
        cpay.calculation_code AS calculation_code,
        cpay_c.name AS cpc_name,
        cpay.industry_branch_code AS ib_code,
        cpay_ib.name AS ib_name
    FROM czechia_payroll cpay
    LEFT JOIN czechia_payroll_calculation cpay_c 
        ON cpay.calculation_code = cpay_c.code
    LEFT JOIN czechia_payroll_industry_branch cpay_ib 
        ON cpay.industry_branch_code = cpay_ib.code 
    LEFT JOIN czechia_payroll_unit cpay_u
        ON cpay.unit_code = cpay_u.code 
    LEFT JOIN czechia_payroll_value_type cpay_vt
        ON cpay.value_type_code = cpay_vt.code
    WHERE cpay.value_type_code = 5958
    GROUP BY cpay.payroll_year, cpay.industry_branch_code, cpay.value_type_code, cpay.unit_code, cpay_u.name, cpay.calculation_code, cpay_c.name, cpay_ib.name
)
SELECT 
    cpay.payroll_year,
    cpay.ib_name,
    cpay.ib_code,
    cpay.salary,
    cpay.value_type_code,
    cp.food_code,
    cp.food_name,
    cp.value
FROM cp
INNER JOIN cpay 
    ON cp.date_from = cpay.payroll_year;


-- Drop table if exists to allow re-creation
DROP TABLE IF EXISTS t_huu_viet_nguyen_project_SQL_secondary_final;

CREATE TABLE t_huu_viet_nguyen_project_SQL_secondary_final AS
SELECT 
    c.country,
    c.capital_city, 
    e.year, 
    ROUND(e.GDP::numeric / 1000000, 2) AS GDP_mil_dollars,
    e.population,
    e.gini
FROM countries c
JOIN economies e 
    ON c.country = e.country
WHERE c.continent = 'Europe'
ORDER BY c.country, e.year;
