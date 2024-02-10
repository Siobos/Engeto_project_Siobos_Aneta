/* RQ 2) How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available price and wage data? */

SELECT 
	YEAR, 
	ROUND(avg(avg_value),2) AS avg_value, unit
	FROM t_aneta_siobos_project_sql_primary_final taspspf  
WHERE YEAR IN (2006, 2018) AND unit = 'Kč' 
GROUP BY YEAR
UNION
SELECT 
	YEAR, 
	avg_value, 
	unit
FROM t_aneta_siobos_project_sql_primary_final taspspf  
WHERE YEAR IN (2006, 2018) AND code IN ('111301','114201')
GROUP BY YEAR, code;

/* More accurate results can be obtained by finding average wages directly from the input data (Czechia_payroll), 
where there are data for which the sector was not specified more closely. The required primary table (t_aneta_siobos_project_sql_primary_final) 
has been purged of this data. */

CREATE TABLE average_payroll_2006_2018
SELECT 
	payroll_year,
	round(avg(value),2) AS average_payroll_per_year
FROM czechia_payroll
WHERE value_type_code = 5958 AND calculation_code = 200 AND payroll_year IN (2006,2018)
GROUP BY payroll_year;
