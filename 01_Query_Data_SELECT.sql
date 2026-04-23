
/*-----------------------------------------------------------------------------------------------
 sorting data in SQL Server
 -----------------------------------------------------------------------------------------------*/

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

/*-----------------------------------------------------------------------------------------------
 Nested Sorting: Sort by Multiple Columns
 -----------------------------------------------------------------------------------------------*/

-- Retrieve all customers and sort the result by the country and then by the highest score within each country.
/*
SeLECT *
From customers
ORDER BY country ASC, score DESC;
*/

/*-----------------------------------------------------------------------------------------------
  -- Aggregate and Group by-- this commes between from and order by in queries-- 
 ------------------------------------------------------------------------------------------------ */

-- Find the total score for each country.
/*
SELECT
	country,
	SUM(score) AS total_score  -- As (Alias) shorthand name (Label) assigned to a column or table in a query.
FROM customers

Group by country

*/

-- Find the total score and total number of customers for each country.
/*
SELECT
	country,
	SUM(score) AS total_score,
	COUNT(id) AS total_customers
From customers
Group by country

*/

/*-----------------------------------------------------------------------------------------------
  --- Having Clause: Filter Groups Based on Aggregate Conditions--- 
 ------------------------------------------------------------------------------------------------ */


/*-----------------------------------------------------------------------------------------------
 Find the average score for each country considering only customers with a score not equal to 0
 And return only those countries with an average score greater then 450
 -----------------------------------------------------------------------------------------------*/
 

 /*
SELECT
	country,
	AVG(score) As avg_score
FROM customers
WHERE score !=0
GROUP BY country
HAVING AVG(score) >450

*/

/*-----------------------------------------------------------------------------------------------
               DISTINCT Keyword to Remove Duplicates
 ------------------------------------------------------------------------------------------------*/

 -- Return Unique list of countries from the customers table.
 /*
 SELECT DISTINCT country
 FROM customers
 */
 
/*-----------------------------------------------------------------------------------------------
               Top Keyword to Limit Results
	Ristrict the number of rows returned by a query to the top N rows based on a specified order.
 ------------------------------------------------------------------------------------------------*/

 -- Retrieve only 3 customers.
 /*
 SELECT TOP 3 *
 FROM customers
 */
-- Retrieve the top 3 customers with the highest scores.
 /*
 SELECT TOP 3 *
 FROM customers
 ORDER BY score DESC
 */
 --Retrieve the lowest 2 customers based on the score.
 /*
SELECT TOP 2 *
FROM customers
ORDER BY score ASC
*/

--Get the two most recent orders
/*
 Select Top 2  *
 From orders
 Order by order_date DESC
 */

/*-----------------------------------------------------------------------------------------------
   Comprehensive Query: Combining Multiple Sorting, Aggregation, Grouping, 
   Filtering with HAVING, DISTINCT, and TOP
-----------------------------------------------------------------------------------------------*/

-- Find the top 3 countries that have:
--   1. At least 2 customers with scores not equal to 0
--   2. An average score greater than 400
--   3. Show unique countries (no duplicates)
--   4. Sort by highest average score first
--   5. Include total customers and total score for each country

SELECT TOP 3 
    country,
    COUNT(DISTINCT id) AS total_customers,
    SUM(score) AS total_score,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING COUNT(id) >= 2 AND AVG(score) > 400
ORDER BY avg_score DESC;
 