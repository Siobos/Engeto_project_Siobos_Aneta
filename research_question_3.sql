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
