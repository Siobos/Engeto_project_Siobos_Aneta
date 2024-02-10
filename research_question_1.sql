/* RESEARCH QUESTIONS (RQ): 

RQ 1) Are wages rising in all industries over the years, or falling in some? */

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
WHERE unit = 'Kč' AND YEAR BETWEEN 2011 AND 2020
ORDER BY grow, code, YEAR;
