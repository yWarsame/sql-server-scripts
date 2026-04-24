/* ==============================================================================
   SQL CASE Statement
-------------------------------------------------------------------------------
   This script demonstrates various use cases of the SQL CASE statement, including
   data categorization, mapping, quick form syntax, handling nulls, and conditional 
   aggregation.
   
   Table of Contents:
     1. Categorize Data
     2. Mapping
     3. Quick Form of Case Statement
     4. Handling Nulls
     5. Conditional Aggregation
=================================================================================
*/ 

/* ==============================================================================
   USE CASE: CATEGORIZE DATA
===============================================================================*/

/* TASK 1: 
   Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/
SELECT
    Category,
    SUM(Sales) AS TotalSales
FROM (
    SELECT
        OrderID,
        Sales,
        CASE
            WHEN Sales > 50 THEN 'High'
            WHEN Sales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS Category
    FROM Sales.Orders
) AS t
GROUP BY Category
ORDER BY TotalSales DESC;

/* ==============================================================================
   USE CASE: MAPPING
===============================================================================*/

/* TASK 2: 
   Retrieve customer details with abbreviated country codes 
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE 
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;
/* TASK 3: 
   Retrieve employee details with gender desplayed as full text  
*/
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Gender,
CASE
    WHEN Gender = 'M' THEN 'Male'
    WHEN Gender = 'F'  THEN 'Female'
    ELSE 'n/a'
END AS GenderFullText
FROM Sales.Employees;

/* ==============================================================================
   QUICK FORM SYNTAX
===============================================================================*/

/* TASK 4: 
   Retrieve customer details with abbreviated country codes using quick form 
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE 
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr,
    -- Quick format and this case is = operator
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr2
FROM Sales.Customers;

/* ==============================================================================
   HANDLING NULLS
===============================================================================*/

/* TASK 4: 
   Calculate the average score of customers, treating NULL as 0,
   and provide CustomerID and LastName details.
*/
SELECT
    CustomerID,
    LastName,
    Score,
    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS ScoreClean,
    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS AvgCustomerClean,
    AVG(Score) OVER () AS AvgCustomer
FROM Sales.Customers;

/* ==============================================================================
   CONDITIONAL AGGREGATION
   Apply aggregate functions only on subsets of data that fulfill certain conditions.
===============================================================================*/

/* TASK 5: 
   Count how many orders each customer made with sales greater than 30 
*/
SELECT 
    --OrderID,
    CustomerID,
    --Sales,
   SUM( CASE
        WHEN Sales > 30 THEN 1
        ELSE 0
    END )TotalOrdersHighSales,
    Count(*) AS TotalOrdersAll
FROM Sales.Orders
--ORDER BY CustomerID
-- step 1:Flag Binary indicator )1,0) to be summarized to show how many times the condition is true
--step 2: Summarize the binary flag
GROUP BY CustomerID


/*  
CASE STATEMENT Summary: 

Evaluates a list of conditions and returns a value when the first condition is met.  

Rules:  
- The data type of the results must be matching.  

Use cases:  
- Derive New Information  
  - Categorizing Data  
  - Mapping Values  
  - Handling Nulls  
  - Conditional Aggregations  
*/