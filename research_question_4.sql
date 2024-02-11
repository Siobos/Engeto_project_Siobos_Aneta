/* RQ 4) Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)? */

WITH czechia_price_selection_YOY_change AS (
    SELECT *,
           LEAD(avg_value, 1) OVER (PARTITION BY code ORDER BY YEAR) lead_function
    FROM czechia_price_selection
)
, czechia_payroll_selection_YOY_change AS (
    SELECT *,
           LEAD(avg_value, 1) OVER (PARTITION BY code ORDER BY YEAR) lead_function
    FROM czechia_payroll_selection
)
SELECT 
    p.year,
    p.avg_value AS avg_value_food_price,
    pr.YEAR AS year,
    p.lead_function AS lead_function_price,
    pr.avg_value AS avg_value_food_price ,
    ROUND((p.lead_function - p.avg_value) / p.avg_value * 100, 2) AS YOY_change_food_price,
    pr.lead_function AS lead_function_payroll,
    ROUND((pr.lead_function - pr.avg_value) / pr.avg_value * 100, 2) AS YOY_change_payroll
FROM czechia_price_selection_YOY_change p
INNER JOIN czechia_payroll_selection_YOY_change pr ON p.year = pr.YEAR
GROUP BY pr.year;
