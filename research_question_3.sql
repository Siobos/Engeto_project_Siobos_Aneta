/* RQ 3) Which food category has the lowest percentage year-on-year increase in price?? */

WITH czechia_price_selection_calculation AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY code
ORDER BY year
	) lead_function
FROM czechia_price_selection
)
SELECT *, ROUND((lead_function-avg_value)/(avg_value)*100,2) AS YOY_change
FROM czechia_price_selection_calculation
GROUP BY code, YEAR;

--Better detail--

WITH czechia_price_selection_calculation AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY code
ORDER BY year
	) lead_function
FROM czechia_price_selection
)
SELECT 
	code, 
	name, 
	unit, 
	ROUND((lead_function-avg_value)/(avg_value)*100,2) AS YOY_change
FROM czechia_price_selection_calculation
GROUP BY code
ORDER BY YOY_change;
