/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     3. Multiple Table Joins (4 Tables)
=================================================================================
*/

/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN
-- returns only the matching rows from both tables, so will get only where we have overlapping .
/* Get all customers along with their orders
   but only for customers who have placed an order */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id

-- LEFT JOIN : Return All rows from Left and only Matching rows from Right
/* Get all customers along with their orders, 
   including those without orders */
   /* because of left join, we will get all data from customers tabe inlcuding whose don't place order*/
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- RIGHT JOIN :Return All rows from Right and only Matching rows from Left
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
RIGHT JOIN orders AS o 
ON c.id = o.customer_id

-- Alternative to RIGHT JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id

-- FULL JOIN : Return All rows from both tables, with NULLs in place where there is no match
/* Get all customers and all orders, even if there’s no match */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.id = o.customer_id

/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN : Return rows from left that has NO match in right
/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN : Return rows from right that has NO match in left
/* Get all orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */
SELECT *
FROM orders AS o 
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL

-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
FULL JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NULL or c.id IS NULL

/*
Get all customers along with their orders, but only for customer who have  placed an order and orders 
                                (without using inner join) 
*/
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c 
LEFT JOIN orders AS o 
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL
--alternative NO Join Keyword at all

SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
FROM customers AS c, orders AS o
WHERE c.id = o.customer_id


-- CROSS JOIN
/* Generate all possible combinations of customers and orders  " Cartesian Join"*/
SELECT *
FROM customers
CROSS JOIN orders

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

USE SalesDB
SELECT 
    o.OrderID,
    o.Sales,
    c.FirstName As CustomerFirstName,
    c.LastName AS CustomerLastName,
    p.Product AS ProductName,
    p.Price,
    e.FirstName AS EmployeeFirstName,
    e.LastName AS EmployeeLastName
FROM Sales.Orders As o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID

/*
## SQL Join Selection Decision Tree

To determine which join type to use, first identify your primary goal regarding the relationship between the two tables:

### 1. Goal: Only Matching Rows
* **Condition:** You only want rows where there is a match in both tables.
* **Result:** **INNER JOIN**
---

### 2. Goal: All Rows (Matches + Extra)
If you want to keep data even when there isn't a direct match, you must decide which side is the priority:

* **One Side (Master Table):**
    * **Condition:** You want all rows from the primary "Left" table, regardless of whether they have a match in the second table.
    * **Result:** **LEFT JOIN**

* **Both Sides (Both Important):**
    * **Condition:** You want every single row from both tables, combining them where they match and keeping them separate where they don't.
    * **Result:** **FULL JOIN**
---

### 3. Goal: Only Unmatching Rows (Anti-Joins)
If you are looking for "missing" data or gaps where records do *not* exist in the other table:

* **One Side (Master Table):**
    * **Condition:** You want rows that exist in the "Left" table but have **no** corresponding match in the right table.
    * **Result:** **LEFT ANTI JOIN**

* **Both Sides (Both Important):**
    * **Condition:** You want all rows that exist in either table but **exclude** any rows that have a match between them.
    * **Result:** **FULL ANTI JOIN** 
*/