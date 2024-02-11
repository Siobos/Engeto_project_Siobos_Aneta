/* RQ 5) /* Does the level of GDP in Czech Republic affect changes in incomes and food prices in the same or follwoing year? */

/* Note: Using the previous selection (RQ 4) to create new table czechia_price_and_payroll_selection, 
which will then be joined to the table t_aneta_siobos_project_sql_secondary_final */

-- STEP 1: --

CREATE TABLE czechia_price_and_payroll_selection
WITH czechia_price_selection_YOY_change AS (
    SELECT *,
           LEAD(avg_value, 1) OVER (PARTITION BY category_code ORDER BY YEAR) lead_function
    FROM czechia_price_selection
    GROUP BY YEAR
)
, czechia_payroll_selection_YOY_change AS (
    SELECT *,
           LEAD(avg_value, 1) OVER (PARTITION BY category_code ORDER BY YEAR) lead_function
    FROM czechia_payroll_selection
    GROUP BY YEAR
)
SELECT 
    p.year,
    p.avg_value AS avg_value_price,
    p.lead_function AS lead_function_price,
    pr.avg_value AS avg_value_payroll,
    ROUND((p.lead_function - p.avg_value) / p.avg_value * 100, 2) AS YOY_change_price,
    pr.lead_function AS lead_function_payroll,
    ROUND((pr.lead_function - pr.avg_value) / pr.avg_value * 100, 2) AS YOY_change_payroll
FROM czechia_price_selection_YOY_change p
INNER JOIN czechia_payroll_selection_YOY_change pr ON p.year = pr.YEAR;

-- STEP 2: --

SELECT 
	cpaps.YEAR, 
	YOY_change_price, 
	YOY_change_payroll, 
	GDP
FROM czechia_price_and_payroll_selection cpaps 
JOIN t_aneta_siobos_project_sql_secondary_final taspssf ON cpaps.YEAR = taspssf.YEAR;
