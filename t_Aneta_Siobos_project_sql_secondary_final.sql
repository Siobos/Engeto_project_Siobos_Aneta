CREATE TABLE t_Aneta_Siobos_project_SQL_secondary_final
SELECT YEAR, ROUND(GDP,0)
FROM economies e 
WHERE COUNTRY = 'Czech republic'
AND YEAR BETWEEN 2006 AND 2018
ORDER BY YEAR ASC;
