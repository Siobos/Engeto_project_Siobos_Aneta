/* RESEARCH QUESTIONS (RQ): 

RQ 1) Are wages rising in all industries over the years, or falling in some? */

WITH t_aneta_siobos_project_sql_primary_final_calculations AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY category_code
ORDER BY year
	) results
FROM t_aneta_siobos_project_sql_primary_final taspspf
)
SELECT *,
	CASE
        WHEN results > avg_value THEN 'increase'
        WHEN results < avg_value THEN 'decrease'
        WHEN results = avg_value THEN 'stagnation'
        ELSE '-'
    END AS grow
FROM t_aneta_siobos_project_sql_primary_final_calculations
WHERE category_code IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S') AND YEAR BETWEEN 2011 AND 2020
ORDER BY grow, category_code, year;

/* RQ 2) How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available price and wage data? */

SELECT YEAR, 
	ROUND(avg(avg_value),2) AS avg_value, unit
FROM t_aneta_siobos_project_sql_primary_final taspspf  
WHERE YEAR IN (2006, 2018) AND category_code IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S')
GROUP BY YEAR
UNION
SELECT YEAR, avg_value, unit
FROM t_aneta_siobos_project_sql_primary_final taspspf  
WHERE YEAR IN (2006, 2018) AND category_code IN ('111301','114201')
GROUP BY YEAR, category_code;

/* RQ 3) Which food category is increasing in price the slowest (has the lowest percentage year-on-year increase)? */

WITH czechia_price_selection_calculation AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY category_code
ORDER BY year
	) lead_function
FROM czechia_price_selection
)
SELECT *, ROUND((lead_function-avg_value)/(avg_value)*100,0) AS YOY_change
FROM czechia_price_selection_calculation;

/* Better detail: */

WITH czechia_price_selection_calculation AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY category_code
ORDER BY year
	) lead_function
FROM czechia_price_selection
)
SELECT category_code, name, unit, ROUND(AVG(lead_function-avg_value)/(avg_value)*100,2) AS AVG_YOY_change
FROM czechia_price_selection_calculation
GROUP BY category_code;

/* RQ 4) Has there been a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)? */

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

/* RQ 5) Does the level of GDP affect changes in wages and food prices? Or, if the GDP increases more significantly in one year, will this be reflected in food prices or wages in the same or the following year */ by a more significant increase?

/* Note: Using the previous selection (RQ 4) to create new table czechia_price_and_payroll_selection, which will then be joined to the table t_aneta_siobos_project_sql_secondary_final */

/* STEP 1: */

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

/* STEP 2: */

SELECT 
	cpaps.YEAR, 
	YOY_change_price, 
	YOY_change_payroll, 
	GDP
FROM czechia_price_and_payroll_selection cpaps 
JOIN t_aneta_siobos_project_sql_secondary_final taspssf ON cpaps.YEAR = taspssf.YEAR;
