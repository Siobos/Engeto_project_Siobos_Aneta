/* RQ 4) Is there a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10%)? */

-- Creation of new combined_table --

CREATE TABLE combined_table AS
WITH payroll_data AS (
    SELECT 
        year,
        AVG(avg_value) AS avg_payroll_general,
        LEAD(AVG(avg_value), 1) OVER (PARTITION BY code ORDER BY YEAR) AS lead_function_payroll
    FROM czechia_payroll_selection
    WHERE YEAR BETWEEN 2006 AND 2018
    GROUP BY YEAR
),
price_data AS (
    SELECT 
        year, 
        AVG(avg_value) AS avg_price_food_general,
        LEAD(AVG(avg_value), 1) OVER (PARTITION BY code ORDER BY YEAR) AS lead_function_price
    FROM czechia_price_selection
    GROUP BY year
)
SELECT 
    p.year,
    p.avg_payroll_general,
    p.lead_function_payroll,
    pr.avg_price_food_general,
    pr.lead_function_price
FROM payroll_data p
JOIN price_data pr ON p.year = pr.year;

-- YOY_change calculation --
