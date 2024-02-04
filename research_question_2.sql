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
