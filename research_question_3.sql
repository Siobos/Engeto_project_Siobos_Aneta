/* RQ 3) Which food category has the lowest percentage year-on-year increase in price?? */

WITH czechia_price_selection_calculation AS (
SELECT *,
	LEAD(avg_value, 11) OVER (   -- a shift of 11 will cause a year-on-year comparison of the starting year and the last year for the monitored period --
	PARTITION BY code
ORDER BY year
	) lead_function
FROM czechia_price_selection
)
SELECT *, ROUND((lead_function-avg_value)/(avg_value)*100,2) AS YOY_change
FROM czechia_price_selection_calculation
WHERE YEAR = 2006
GROUP BY code, YEAR
ORDER BY YOY_change;
