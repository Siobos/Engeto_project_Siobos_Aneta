/* STEP 1: PREPARATION OF CZECHIA_PAYROLL */

CREATE TABLE t_aneta_siobos_project_sql_primary_final 
SELECT 
	industry_branch_code, 
	payroll_year, 
	cpib.name, 
	cpvt.name AS additional_code,
	cpu.name AS unit,
	ROUND(AVG(value),2) AS avg_value
FROM czechia_payroll cp 
	LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code	
	LEFT JOIN czechia_payroll_unit cpu
	ON cp.unit_code = cpu.code	
	LEFT JOIN czechia_payroll_value_type cpvt
	ON cp.value_type_code = cpvt.code
GROUP BY additional_code, industry_branch_code, payroll_year; 

/* STEP 2: PREPARATION OF CZECHIA_PRICE */

CREATE TABLE czechia_price_selection
SELECT 
	ROUND(AVG(value),2) AS avg_value,
	YEAR(date_from) AS year,
	category_code,
	cpc.name,
	region_code AS additional_code,
	concat (cpc.price_value, cpc.price_unit) AS price_value_unit
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code
GROUP BY year(date_from), category_code;

/* STEP 3: MERGING NEW TABLES AS PRIMARY FINAL TABLE: t_Aneta_Siobos_project_SQL_primary_final */

CREATE TABLE t_Aneta_Siobos_project_SQL_primary_final
SELECT *
FROM czechia_payroll_selection cps 
UNION ALL
SELECT *
FROM czechia_price_selection cps2;


