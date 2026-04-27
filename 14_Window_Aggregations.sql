/* ==============================================================================
   SQL Window Aggregate Functions
-------------------------------------------------------------------------------
   These functions allow you to perform aggregate calculations over a set 
   of rows without the need for complex subqueries. They enable you to compute 
   counts, sums, averages, minimums, and maximums while still retaining access 
   to individual row details.

   Table of Contents:
    1. COUNT :(*) or (1) Returns the number of rows within a window , count (column_name) counts only non-null values
    2. SUM : Returns the sum of values within a window
    3. AVG
    4. MAX / MIN
    5. ROLLING SUM & AVERAGE Use Case
===============================================================================
*/

/* ============================================================
   SQL WINDOW AGGREGATION | COUNT
   ============================================================ */

/* TASK 1:
   Find the Total Number of Orders and the Total Number of Orders for Each Customer
*/
SELECT
    OrderID,
    OrderDate,
    CustomerID,
    COUNT(*) OVER() AS TotalOrders,
    COUNT(*) OVER(PARTITION BY CustomerID) AS OrdersByCustomers
FROM Sales.Orders

/* TASK 2:
   - Find the Total Number of Customers
   - Find the Total Number of Scores for Customers
   - Find the Total Number of Countries
*/
SELECT
    *,
    COUNT(*) OVER () AS TotalCustomersStar,
    COUNT(1) OVER () AS TotalCustomersOne,
    COUNT(Score) OVER() AS TotalScores,
    COUNT(Country) OVER() AS TotalCountries
FROM Sales.Customers

/* TASK 3:
   Check whether the table 'OrdersArchive' contains any duplicate rows
*/
SELECT 
    * 
FROM (
    SELECT 
        *,
        COUNT(*) OVER(PARTITION BY OrderID) AS CheckDuplicates
    FROM Sales.OrdersArchive
) t
WHERE CheckDuplicates > 1

/* Summary Count  Use Cases:
1.Overall Analysis
2.Category Analysis
3.Quality checks: Identify NULLs
4.Quality checks: Identify duplicates
*/



/* ============================================================
   SQL WINDOW AGGREGATION | SUM
   ============================================================ */

/* TASK 4:
   - Find the Total Sales Across All Orders 
   - Find the Total Sales for Each Product
*/
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    SUM(Sales) OVER () AS TotalSales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS SalesByProduct
FROM Sales.Orders

/* TASK 5:
   Find the Percentage Contribution of Each Product's Sales to the Total Sales
   Percentage Contribution = (Product's Sales / Total Sales) * 100
   This called Part-To-Whole Analysis. shows the contribution of each data point to the overall dataset 
*/
SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS TotalSales,
    ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Sales.Orders

/* ============================================================================
   SQL WINDOW AGGREGATION | AVG
   Returns the average of the values in the window. It ignores NULL values.
   Sum/Count
   =========================================================================== */

/* TASK 6:
   - Find the Average Sales Across All Orders 
   - Find the Average Sales for Each Product
   - Additionally provide details such order Id, order date.
*/
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) OVER () AS AvgSales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgSalesByProduct
FROM Sales.Orders

/* TASK 7:
   -Find the Average Scores of Customers.
   -Additionally , Provide details such as Customer ID and Last Name
*/
SELECT
    CustomerID,
    LastName,
    Score,
    COALESCE(Score, 0) AS CustomerScore,
    AVG(Score) OVER () AS AvgScore,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
FROM Sales.Customers

/* TASK 8:
   Find all orders where Sales are higher than the Average Sales across all orders.
*/
SELECT 
*
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER () AS AvgSales
    FROM Sales.Orders
) t WHERE Sales > AvgSales



/* ============================================================
   SQL WINDOW AGGREGATION | MAX Highest Value / MIN Lowest Value.
   ============================================================ */

/* TASK 9:
   - Find the Highest and Lowest Sales of all orders
   - Find the Highest and Lowest Sales for Each Product
   - Additionally provide details such order Id, order date, product Id.
*/
SELECT 
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    MIN(Sales) OVER () AS LowestSales,
    MAX(Sales) OVER () AS HighestSales,
    MIN(Sales) OVER (PARTITION BY ProductID) AS LowestSalesByProduct,
    MAX(Sales) OVER (PARTITION BY ProductID) AS HighestSalesByProduct 
FROM Sales.Orders


/* TASK 10:
   Show the employees who have the highest salaries
*/
SELECT *
FROM (
	SELECT *,
		   MAX(Salary) OVER() AS HighestSalary
	FROM Sales.Employees
) t
WHERE Salary = HighestSalary

/* TASK 11:
   Find the deviation of each Sale from the minimum and maximum Sales
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    MAX(Sales) OVER () AS HighestSales,
    MIN(Sales) OVER () AS LowestSales,
    Sales - MIN(Sales) OVER () AS DeviationFromMin,
    MAX(Sales) OVER () - Sales AS DeviationFromMax
FROM Sales.Orders

/* ================================================================================================================================================
   Use Case | Running and ROLLING  Total ( SUM & AVERAGE )
   Running and Rolling Total : They aggregate sequence of members, and the aggregation ,
   is updated each time a new member is added to the sequence.
   Running Total: Aggregate all values from the beginning up to the current point without dropping off older data.
   Rolling Total/ Shifting Window: Aggregate values within a specified window (e.g. 30 days) that moves along with the current point as 
   new data comes in, dropping off older data outside the window.
   The cuncept use for Tracking for example in this case Current Sales with Target Sales.
   Trend Analysis Provides insights into how a particular metric is evolving over time. 
   It helps identify patterns, seasonality, and overall direction of the data, 
   which can be crucial for forecasting and decision-making.
   ================================================================================================================================================ */

/* TASK 12:
   - Calculate the moving (Running) average of Sales for each Product over time.
   - Calculate the moving average of Sales for each Product over time, including only the next order (Rolling Average).
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS MovingAvg,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders

/*

Recap:

WINDOW AGGREGATE FUNCTIONS
-------------------------------------------------------------------------------
Aggregate set of values and return a single aggregated value.

RULES:
- Expressions:
  - Numbers (All Functions)
  - Any Data Type – COUNT()
- All Clauses are Optional

USE CASES:
- Overall Analysis
- Total Per Groups Analysis
- Part-to-Whole Analysis
- Comparison Analysis
- Identify Duplicates
- Average
- Extreme: Highest/Lowest
- Outlier Detection
- Running Total
- Rolling Total
- Moving Average
*/
