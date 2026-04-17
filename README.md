# SQL Learning Journey

A comprehensive collection of SQL concepts, techniques, and hands-on projects for data analysis and database management.

## Course Structure

| 01 | SQL Introduction | Basics, database concepts |
| 02 | Querying Data (SELECT) | Basic queries, filtering |
| 03 | Data Definition (DDL) | CREATE, ALTER, DROP tables |
| 04 | Data Manipulation (DML) | INSERT, UPDATE, DELETE |
| 05 | Filtering Data | WHERE, AND/OR, IN, BETWEEN, LIKE |
| 06 | JOINS & SET Operations | INNER/LEFT/RIGHT/FULL JOIN, UNION |
| 07 | Row-Level Functions | String, date, math functions |
| 08 | Aggregation & Analytics | GROUP BY, HAVING, SUM, AVG, COUNT |
| 09 | Advanced SQL Techniques | Subqueries, CTEs, window functions |
| 10 | Performance Optimization | Indexing, query tuning |
| 11 | AI & SQL | AI-assisted query writing |
| 12 | SQL Projects | Practice projects |
| 13 | Data Analytics Projects | Real-world analysis scenarios |
| 14 | ETL Projects | Extract, Transform, Load workflows |

##  Purpose

This repository documents my SQL learning path from fundamentals to advanced techniques, including practical projects in data analytics and ETL processes.

## Technologies

- SQL Server
- T-SQL
- Various database tools (Edge/SSMS)

##  Key Skills Covered

-  Writing complex queries with multiple clauses
-  Data filtering and aggregation
-  Table joins and set operations
-  Subqueries and CTEs
-  Window functions
-  Query performance optimization
-  Real-world data projects

##  Quick Example

```sql
-- Find top-performing countries based on customer scores
SELECT TOP 3 
    country,
    COUNT(DISTINCT id) AS total_customers,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING COUNT(id) >= 2 AND AVG(score) > 400
ORDER BY avg_score DESC;
