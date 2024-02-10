/* STEP 1: PREPARATION OF CZECHIA_PAYROLL */

CREATE TABLE czechia_payroll_selection 
SELECT 
	ROUND(AVG(value),0) AS avg_value,
	payroll_year AS year, 
	industry_branch_code AS code, 
	cpib.name, 
	cpu.name AS unit
FROM czechia_payroll cp 
	LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code	
	LEFT JOIN czechia_payroll_unit cpu
	ON cp.unit_code = cpu.code
WHERE value_type_code = 5958 AND calculation_code = 200 AND cp.industry_branch_code IS NOT NULL
GROUP BY industry_branch_code, payroll_year;

/* STEP 2: PREPARATION OF CZECHIA_PRICE */

CREATE TABLE czechia_price_selection
SELECT 
	ROUND(AVG(value),2) AS avg_value,
	YEAR(date_from) AS year,
	category_code AS code,
	cpc.name,
	concat ('Kč/', cpc.price_value, cpc.price_unit) AS unit
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc 
ON cp.category_code = cpc.code
GROUP BY category_code, YEAR;

/* STEP 3: MERGING NEW TABLES AS PRIMARY FINAL TABLE: t_Aneta_Siobos_project_SQL_primary_final */

CREATE TABLE t_Aneta_Siobos_project_sql_primary_final
SELECT *
FROM czechia_payroll_selection cps 
UNION ALL
SELECT *
FROM czechia_price_selection cps2;


