/* RESEARCH QUESTIONS (RQ): 

RQ 1) Are average incomes increasing in all industries over the years? Or are there industries in Czech Republic where average incomes are decreasing? */

/* Control of year-on-year wage changes by individual sector */
WITH t_aneta_siobos_project_sql_primary_final_calculations AS (
SELECT *,
	LEAD(avg_value, 1) OVER (
	PARTITION BY code
ORDER BY year
	) results
FROM t_aneta_siobos_project_sql_primary_final taspspf
)
SELECT *,
	CASE
        WHEN results > avg_value THEN 'increase'
        WHEN results < avg_value THEN 'decrease'
        ELSE '-'
    END AS grow
FROM t_aneta_siobos_project_sql_primary_final_calculations
WHERE unit = 'Kč' AND YEAR BETWEEN 2011 AND 2020              -- unit "Kč" limits the selection in the table to wages only" --
ORDER BY grow, code, YEAR;

/* Comparison of 2011 and 2020 for individual sectors */
SELECT *
FROM t_aneta_siobos_project_sql_primary_final taspspf 
WHERE unit = 'Kč' AND YEAR IN ('2011', '2020')
ORDER BY code, YEAR;
