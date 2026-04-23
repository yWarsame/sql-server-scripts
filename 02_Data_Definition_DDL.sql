/*------------------------------------------------------------------------------------------------
- Data Definition Language (DDL) statements are used to define and manage database				
  objects such as tables, views, indexes, and stored procedures.								
  DDL statements include commands like CREATE, ALTER, and DROP.									
  These statements allow you to create new database objects, modify existing ones, 
  and remove them when they are no longer needed. DDL is essential for structuring 
  the database and ensuring that it meets the requirements of the applications that will use it.

--------------------------------------------------------------------------------------------------*/

-- SQL Task: Create a new table called persons, with columns: id, person_name, birth_date, and phone.

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(64) NOT NULL,
	birth_date DATE,
	phone VARCHAR(20) NOT NULL,
	CONSTRAINT PK_persons PRIMARY KEY (id)
);
-- Alter the persons table to add a new column called email of type varchar(255).
-- Alter is used to modify the structure of an existing database object, such as a table.

ALTER TABLE persons
ADD email VARCHAR(100) NOT NULL;

-- Removing columns from a table is done using the DROP COLUMN clause in an ALTER TABLE statement.

-- Remove the phone column from the persons table.
ALTER TABLE persons
DROP COLUMN phone;

SELECT * FROM persons;
-- The DROP TABLE statement is used to delete an entire table and all of its data from the database.

DROP TABLE persons;