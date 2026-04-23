

-- Retrieve customers with a score not equal to 0
/*
SELECT *

FROM customers
WHERE score <> 0;
--WHERE score != 0; -- Alternative syntax for not equal to in SQL 
*/

-- Retrieve customers from germany 
/*
SELECT *
From customers
WHERE country = 'Germany';
*/

-- Retrieve first name and country of customers from germany
SELECT 
	first_name,
	country
From customers
WHERE country = 'Germany';