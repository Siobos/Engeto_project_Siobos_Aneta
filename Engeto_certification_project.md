# Engeto_project_Siobos_Aneta
Engeto Certification project from 2023/2024

ENTRY
This is a project for obtaining data analyst certification. The data sets that have been provided can be used to obtain a suitable data base. The desired output of the project is 2 tables (t_{name}_{surname}_project_SQL_...) from which the research questions can be answered and SQL scipts as well. 

Data sets that can be used to obtain a suitable data base:
Primary tables:
czechia_payroll – Information on wages in various industries over a period of several years. The data set comes from the Open Data Portal of the Czech Republic.
czechia_payroll_calculation – Number of calculations in the salary table.
czechia_payroll_industry_branch – Sector number in the wage table.
czechia_payroll_unit – Numeral of the units of the values ​​in the wage table.
czechia_payroll_value_type – Index of value types in the salary table.
czechia_price – Information on the prices of selected foods over a period of several years. The data set comes from the Open Data Portal of the Czech Republic.
czechia_price_category – Index of food categories that appear in our overview.

Codes of shared information about the Czech Republic:
czechia_region – Code of the regions of the Czech Republic according to the standard CZ-NUTS 2.
czechia_district – Code of the districts of the Czech Republic according to the standard LAU.

Additional tables:
countries - All kinds of information about countries in the world, for example the capital, currency, national food or average height of the population.
economies - GDP, GINI, tax burden, etc. for a given state and year.

METHODOLOGY AND ANALYSE
The creation of required tables is described in t_Aneta_Siobos_project_SQL_primary_final and t_Aneta_Siobos_project_SQL_secondary_final.
The necessary scripts with notes that support these answers below (analyse) are in research_questions_SQL_cripts. In all cases, the SQL language was used.

RESEARCHING QUESTIONS (RQ) AND ANSWEARS

RQ 1) Are wages rising in all industries over the years, or falling in some?
Wages for the monitored period (2011 - 2020) are decreasing in the sectors and years listed below. The listed sectors are in the Czech language:

2020	A Zemědělství, lesnictví, rybářství
2012	B Těžba a dobývání
2013	B	Těžba a dobývání
2015	B	Těžba a dobývání
2012	D	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
2014	D	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
2012	E	Zásobování vodou; činnosti související s odpady a sanacemi
2012	F	Stavebnictví
2020	F	Stavebnictví
2012	G	Velkoobchod a maloobchod; opravy a údržba motorových vozidel
2019	I	Ubytování, stravování a pohostinství
2012	J	Informační a komunikační činnosti
2012	K	Peněžnictví a pojišťovnictví
2012	L	Činnosti v oblasti nemovitostí
2019	L	Činnosti v oblasti nemovitostí
2012	M	Profesní, vědecké a technické činnosti
2012	N	Administrativní a podpůrné činnosti
2020	O	Veřejná správa a obrana; povinné sociální zabezpečení
2020	P	Vzdělávání
2012	R	Kulturní, zábavní a rekreační činnosti
2020	R	Kulturní, zábavní a rekreační činnosti

RQ 2) How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available price and wage data?
The common comparable periods are 2006 and 2018. The average salary for all industries in 2006 and 2018 and the average price of 2 categories in 2006 and 2018 are compared. 
On average in 2006, it is possible to buy 1297 kilograms of bread or 1482 liters of milk. In 2018, it is possible to purchase 1356 kilograms of bread or 1627 liters of milk.

2006	Kč	20753,74	all sectors	
2018	Kč	32535,89	all sectors	

2006	1kg	16,00	bread	
2006	1l	14,00	milk	
2018	1kg	24,00	bread	
2018	1l	20,00	milk	

RQ 3 ) Which food category is increasing in price the slowest (has the lowest percentage year-on-year increase)?
The lowest percentage increase is for sugar and tomatoes. Values ​​are negative. Bananas and pork roast with bone are also slowly increasing in price (below 1 %). 

crystal sugar	1kg	-2.27
tomatoes red	1kg	-2.01
bananas yelow	1kg	0.62
pork roast with bone	1kg	0.95

RQ 4) Has there been a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 10 %)?
Yes, in 2006 and 2007 the year-on-year increase in food prices was significantly higher than wage growth. The gap between wage growth and food growth was the largest in 2007.

2006	YOY_price: 14.29 %	YOY_payroll: 9,27 %
2007	YOY_price: 37.50 %	YOY_payroll: 9,73 %

RQ 5 ) Does the level of GDP affect changes in wages and food prices? Or, if the GDP increases more significantly in one year, will this be reflected in food prices or wages in the same or the following year by a more significant increase?

From the given data, it is not possible to clearly demonstrate a correlation between the development of GDP, average food prices and average wages. The situation was significantly affected by the economic crisis of 2008/2009.

