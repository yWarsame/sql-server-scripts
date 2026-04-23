/*
-------------------------------------------------------------------------------------------------------------------------------
Data Manipulation Language (DML) is a subset of SQL that allows you to manipulate data within a database. 
It includes commands such as SELECT, INSERT, UPDATE, and DELETE. 
These commands enable you to retrieve, add, modify, and remove data from database tables.
-------------------------------------------------------------------------------------------------------------------------------
*/
INSERT INTO customers (id, first_name, country,score)
VALUES (6, 'Anna', 'USA', NULL),
	   (7, 'Sam', NULL, 100);

-- lazy way to insert data into the orders table
INSERT INTO customers 
VALUES (8, 'Andreas', 'Germany', NULL);

SELECT * FROM customers;

-- you can skip some columns if they allow NULL values
INSERT INTO customers (id, first_name)
	VALUES (9, 'John');

INSERT INTO customers (id, first_name)
	VALUES (10, 'Sahra');

-- inserting data automatically from source tables steps :
--selecting data from source table and result table as value to another table

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
	id,
	first_name,
	Null,
	'Unknown'
FROM customers;

-- Update is used to modify existing records in a table.

/*  Change the score of the customer 6 to */
SELECT * FROM customers
WHERE id = 6;

UPDATE  customers
SET score = 0
WHERE id = 6;


-- Change the score of customer 10 to 0, and updated the country to UK
UPDATE  customers
SET score = 0, 
	country = 'UK'
WHERE id = 10;

/* Update all customers that have a NULL score to 0 */

Update customers
SET score = 0
WHERE score IS NULL;

-- Delete is used to remove records from a table.

-- Delete all customers with an id greater than 5

DELETE FROM customers
WHERE id > 5;

-- Delete all data from table persons
DELETE FROM persons;
TRUNCATE TABLE persons;
-- or you can use TRUNCATE TABLE to delete all data from a table, 
--but it is faster and does not log individual row deletions. 
--However, it cannot be used if there are foreign key constraints referencing the table.