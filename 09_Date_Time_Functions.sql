/* ==============================================================================
   SQL Date & Time Functions
-------------------------------------------------------------------------------
   This script demonstrates various date and time functions in SQL.
   It covers functions such as GETDATE, DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, DAY, EOMONTH, FORMAT, CONVERT, CAST, DATEADD, DATEDIFF,
   and ISDATE.
   
   Table of Contents:
     1. GETDATE | Date Values
     2. Date Part Extractions (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
     3. DATETRUNC
     4. EOMONTH
     5. Date Parts
     6. FORMAT
     7. CONVERT
     8. CAST
     9. DATEADD / DATEDIFF
    10. ISDATE
===============================================================================
*/

/* ==============================================================================
   GETDATE() | DATE VALUES
   Returns the current date and time at the moment when the query is executed.
===============================================================================*/
-- Example of GETDATE() to retrieve the current system date and time.
SELECT 
    OrderID,
    OrderDate,
    ShipDate,
    CreationTime
    FROM Sales.Orders
/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date.
*/
SELECT
    OrderID,
    CreationTime,
    '2020-10-13' AS HardCoded,
    GETDATE() AS Today
FROM Sales.Orders;

/* ==============================================================================
   DATE PART EXTRACTIONS
   (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
===============================================================================*/

/* TASK 2:
   Extract various parts of CreationTime using DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, and DAY.
*/
SELECT
    OrderID,
    CreationTime,
     -- DATEPART Examples
    DATEPART(year, CreationTime) AS Year_dp,
    DATEPART(month, CreationTime) AS Month_dp,
    DATEPART(day, CreationTime) AS Day_dp,
    DATEPART(hour, CreationTime) AS Hour_dp,
    DATEPART(quarter, CreationTime) AS Quarter_dp,
    DATEPART(week, CreationTime) AS Week_dp,
    YEAR(CreationTime) AS Year,
    MONTH(CreationTime) AS Month,
    DAY(CreationTime) AS Day,
        -- DATENAME Examples
/* 
        Datename(day) returns the number of the day in the month, and stored as String  'datatype String'
        Datepart(day) returns the number of the day in the month, and stored as Integer 'datatype Int' 
        As well the Year
 */
    DATENAME(month, CreationTime) AS Month_dn,
    DATENAME(weekday, CreationTime) AS Weekday_dn,
    DATENAME(day, CreationTime) AS Day_dn,
    DATENAME(year, CreationTime) AS Year_dn,

    -- DATETRUNC Examples
/*
    Datetrunc(day) returns the date with the day part truncated to 1, and stored as Date 'datatype Date'
    Time part is truncated to 00:00:00.0000000
     and date part reset to the first day of the month, and stored as Date 'datatype Date'
*/

    DATETRUNC(year, CreationTime) AS Year_dt,
    DATETRUNC(day, CreationTime) AS Day_dt,
    DATETRUNC(minute, CreationTime) AS Minute_dt
FROM Sales.Orders;


/*

Summary of Date Part Functions:

Which Part?

Day, Month?     -> DAY(), MONTH(), YEAR()
Other Parts?    -> DATEPART() for numeric, DATENAME() for name

DATEPART() examples (numeric result):
- quarter    -> DATEPART(quarter, '2025-04-20')     -- 2
- week       -> DATEPART(week, '2025-04-20')        -- 16
- dayofyear  -> DATEPART(dayofyear, '2025-04-20')   -- 110
- weekday    -> DATEPART(weekday, '2025-04-20')     -- 1 (depends on SET DATEFIRST)
- hour, minute, second, etc.

DATENAME() examples (name result):
- quarter    -> DATENAME(quarter, '2025-04-20')     -- 2 (or Q2)
- month      -> DATENAME(month, '2025-04-20')       -- April
- weekday    -> DATENAME(weekday, '2025-04-20')     -- Sunday

Common date parts for DATEPART/DATENAME:
year, quarter, month, dayofyear, day, week, weekday, hour, minute, second
*/


/* ==============================================================================
   DATETRUNC() DATA AGGREGATION
===============================================================================*/

/* TASK 3:
   Aggregate orders by year using DATETRUNC on CreationTime.
*/
SELECT
    DATETRUNC(year, CreationTime) AS Creation,
    COUNT(*) AS OrderCount
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime);

-- Monthly aggregation using DATETRUNC
SELECT
    DATETRUNC(month, CreationTime) AS Creation,
    COUNT(*) AS OrderCount
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime);

/* ==============================================================================
   EOMONTH()
===============================================================================*/

/* TASK 4:
   Display OrderID, CreationTime, and the end-of-month date for CreationTime.
*/
SELECT
    OrderID,
    CreationTime,
    EOMONTH(CreationTime) AS EndOfMonth
FROM Sales.Orders;

SELECT
    OrderID,
    CreationTime,
    EOMONTH(CreationTime) AS EndOfMonth,
    FORMAT(EOMONTH(CreationTime), 'MMM dd') AS EndOfMonthShort
FROM Sales.Orders;


SELECT 
    OrderID,
    CreationTime,
    FORMAT(EOMONTH(CreationTime), 'MMM dd') AS EndOfMonthShort,
    FORMAT(DATETRUNC(month, CreationTime), 'MMM dd') AS StartOfMonthShort
FROM Sales.Orders;

/* ==============================================================================
   DATE PARTS | USE CASES
===============================================================================*/

/* TASK 5:
   How many orders were placed each year?
*/
SELECT 
    YEAR(OrderDate) AS OrderYear, 
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);

/* TASK 6:
   How many orders were placed each month?
*/
SELECT 
    MONTH(OrderDate) AS OrderMonth, 
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

/* TASK 7:
   How many orders were placed each month (using friendly month names)?
*/
SELECT 
    DATENAME(month, OrderDate) AS OrderMonth, 
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate);

/* TASK 8:
   Show all orders that were placed during the month of February.
*/
SELECT
    *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2;

/* Filtering Data using an Interger is faster than using a String
    Avoid Using DATENAME for filtering data, instead use DATEPART
*/

/* ==============================================================================
   FORMAT()
   Formatting ist Changing the format of a value from one to another.
   Date format yyyy-MM-dd, (ISO 8601)
   Syntax: FORMAT(value, format[, culture])
   ==============================================================================*/

/* TASK 9:
   Format CreationTime into various string representations.
*/
SELECT
    OrderID,
    CreationTime,
    FORMAT(CreationTime, 'MM-dd-yyyy') AS USA_Format,
    FORMAT(CreationTime, 'dd-MM-yyyy') AS EURO_Format,
    FORMAT(CreationTime, 'dd') AS dd,
    FORMAT(CreationTime, 'ddd') AS ddd,
    FORMAT(CreationTime, 'dddd') AS dddd,
    FORMAT(CreationTime, 'MM') AS MM,
    FORMAT(CreationTime, 'MMM') AS MMM,
    FORMAT(CreationTime, 'MMMM') AS MMMM
FROM Sales.Orders;

/* TASK 10:
   Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/
SELECT
    OrderID,
    CreationTime,
    'Day ' + FORMAT(CreationTime, 'ddd MMM') +
    ' Q' + DATENAME(quarter, CreationTime) + ' ' +
    FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CustomFormat -- tt ist for AM/PM
FROM Sales.Orders;

/* TASK 11:
   How many orders were placed each year, formatted by month and year (e.g., "Jan 25")?
*/
SELECT
    FORMAT(CreationTime, 'MMM yy') AS OrderDate,
    COUNT(*) AS TotalOrders
FROM Sales.Orders
GROUP BY FORMAT(CreationTime, 'MMM yy');

/* ==============================================================================
   CONVERT()
   6 like 20 Aug 25
   or 12 like 20250820 

===============================================================================*/

/* TASK 12:
   Demonstrate conversion using CONVERT.
*/
SELECT
    CONVERT(INT, '123') AS [String to Int CONVERT],
    CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
    CreationTime,
    CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
    CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
    CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders;

/* ==============================================================================
   CAST()
   Channging the date type from one to another, 
===============================================================================*/

/* TASK 13:
   Convert data types using CAST.
*/
SELECT
    CAST('123' AS INT) AS [String to Int],
    CAST(123 AS VARCHAR) AS [Int to String],
    CAST('2025-08-20' AS DATE) AS [String to Date],
    CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
    CreationTime,
    CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders;

/* =============================================================================================================================
   DATEADD() / : Adds or Subtracts a specified time interval to / from a date, and calculates the difference between two dates.
================================================================================================================================*/
/* DATEDIFF() / : Calculates the difference between two dates.

*/

/* TASK 14:
   Perform date arithmetic on OrderDate.
*/
SELECT
    OrderID,
    OrderDate,
    DATEADD(day, -10, OrderDate) AS TenDaysBefore,
    DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
    DATEADD(year, 2, OrderDate) AS TwoYearsLater
FROM Sales.Orders;

/* TASK 15:
   Calculate the age of employees.
*/
SELECT
    EmployeeID,
    BirthDate,
    DATEDIFF(year, BirthDate, GETDATE()) AS Age
FROM Sales.Employees;

/* TASK 16:
   Find the average shipping duration in days for each month.
*/
SELECT
    MONTH(OrderDate) AS OrderMonth,
    AVG(DATEDIFF(day, OrderDate, ShipDate)) AS AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

/* TASK 17:
   Time Gap Analysis: Find the number of days between each order and the previous order.
*/

-- Time Gap Analysis: Find the number of days between each order and the previous order using LAG and DATEDIFF.
SELECT
    OrderID,
    OrderDate AS CurrentOrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS NrOfDays
FROM Sales.Orders;

/* ==============================================================================
   ISDATE() : Validates whether a string can be converted to a date.
===============================================================================*/

/* TASK 18:
   Validate OrderDate using ISDATE and convert valid dates.
*/
SELECT
    OrderDate,
    ISDATE(OrderDate) AS IsValidDate,
    CASE 
        WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
        ELSE '9999-01-01'
    END AS NewOrderDate
FROM (
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
) AS t
-- WHERE ISDATE(OrderDate) = 0