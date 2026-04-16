
/*  Sorting Data  */

-- Retrieve all customers and sort the result by the highest score first.
/*
SELECT *

FROM customers
ORDER BY score DESC;
*/

-- Retrieve all customers and sort the result by the lowest score first.
/*
SeLECT *
From customers
ORDER BY score ASC;

*/

/* Nested Sorting */

-- Retrieve all customers and sort the result by the country and then by the highest score within each country.
/*
SeLECT *
From customers
ORDER BY country ASC, score DESC;
*/

/* -- Aggregate and Group by-- this commes between from and order by in queries-- */

-- Find the total score for each country.
/*
SELECT
	country,
	SUM(score) AS total_score  -- As (Alias) shorthand name (Label) assigned to a column or table in a query.
FROM customers

Group by country

*/

-- Find the total score and total number of customers for each country.

SELECT
	country,
	SUM(score) AS total_score,
	COUNT(id) AS total_customers
From customers
Group by country


