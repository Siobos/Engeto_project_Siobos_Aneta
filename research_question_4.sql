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
