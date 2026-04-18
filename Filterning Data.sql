
/*
 -----------------------------------------------------------------------------------------------------------------------------------
	Comparsion Operators: it is used to compare two values and return a boolean result. The common comparison operators include:
	 = (equal to), <> =! (not equal to), > (greater than), < (less than), >= (greater than or equal to), <= (less than or equal to)
 ------------------------------------------------------------------------------------------------------------------------------------
 */
 -- Retrieve all customers from Germany

 SELECT *
 From dbo.customers
 Where country = 'Germany'
 --Retrieve all customers who are not from Germany

 SELECT *
 From dbo.customers
 Where country <> 'Germany'
 --Retrieve all customers with a score greater than 500
 SELECT *
 From dbo.customers
 Where score > 500

 --Retrieve all customers with a score a 500 or more 
 SELECT *
 From dbo.customers
 Where score >= 500

 --Retrieve all customers with a score less than 500

 SELECT *
 From dbo.customers
 Where score < 500

 -- Retrieve all customers with a score of 500 or less
 SELECT *
 From dbo.customers
 Where score <= 500

 /*
 ------------------------------------------------------------------------------------------------------------------------------------
 Logical Operators: it is used to combine multiple conditions in a WHERE clause. The common logical operators include:ANd, OR, NOT
 -- AND: returns true if both conditions are true
 -- OR: returns true if at least one condition is true
 -- NOT: returns true if the condition is false
 -------------------------------------------------------------------------------------------------------------------------------------
 */

 -- Retrieve all customers from USA with a score greater than 500
 SELECT *
 From dbo.customers
 Where country = 'USA' AND score > 500

 -- Retrieve all customers who are from USA or have a score greater than 500
 SELECT *
 FRom dbo.customers
 Where country = 'USA' OR score > 500

 -- NOT ist Reverse Excludes matching Values or Conditions
 --Retrieve all customers who are not from USA
 SELECT *
 FRom dbo.customers
 Where NOT country = 'USA'
 -- Retrieve all customers with a score Not less than 500
 SELECT *
 From dbo.customers
 Where NOT score < 500

 --Between Operator: it is used to filter the result set within a specified range Lower and Upper Bound.
 -- the values lower and upper bound are inclusive.

 -- Retrieve all customers whose score falls in the range between 100 and 500
 SELECT *
 From dbo.customers
 Where score BETWEEN 100 AND 500
 -- or other way
 SELECT *
 From dbo.customers
 Where score >= 100 AND score <= 500

 --Membership Operators: it is used to filter the result set based on a list of values. 
 --The common membership operators include: IN, NOT IN
 -- IN: returns true if the value matches any value in the list
 -- NOT IN: returns true if the value does not match any value in the list

 -- Retrieve all customers from USA, Germarny.

 SELECT *
 FROM dbo.customers
 Where country IN ('USA', 'Germany')
 -- Retrieve all customers who are not from USA, Germany
 SELECT *
 FROM dbo.customers
 Where country NOT IN ('USA', 'Germany')

 --Searche Operators: it is used to filter the result set based on a specified pattern. 
 --The common search operators include: LIKE, NOT LIKE
 -- LIKE: returns true if the value matches the specified pattern
 -- NOT LIKE: returns true if the value does not match the specified pattern
--Find all customers whose first name starts with 'M'
SELECT *
From dbo.customers
Where first_name LIKE 'M%'

--Find all customers whose first name ends with 'n'
SELECT *
From dbo.customers
Where first_name LIKE '%n'

--Find all customers whose first name contains 'r'
SELECT *
From dbo.customers
Where first_name LIKE '%r%'
--find all customers whose first name has 'r' as the 3rd position
SELECT *
From dbo.customers
Where first_name LIKE '__r%'

--Retrieve all customers whose first name does not contain 'r'
SELECT *
FROM dbo.customers
WHERE first_name NOT LIKE '%r%';