-- Create a new database
CREATE DATABASE IF NOT EXISTS geeksforgeeks_db
SHOW DATABASES

-- Use selected database
USE geeksforgeeks_db

-- Verify your current database
SELECT DATABASE()

-- Create a new table - "employees"
CREATE TABLE employees(
	emp_id	INT AUTO_INCREMENT,
    first_name	VARCHAR(30)		NOT NULL,
    last_name	VARCHAR(30)		NOT NULL,
    age		INT		NOT NULL,
    salary	INT		NOT NULL,
    location	VARCHAR(30)	DEFAULT "Noida"	NOT NULL,
    PRIMARY KEY(emp_id)
)

SELECT * FROM employees

DROP TABLE employees

-- Verify the available tables in a given database
SHOW TABLES

-- Insert the employee details in the table named "employees"
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Ram", "Mehta", 31, 30000, "Bengaluru");
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Priya", "Bhatia", 26, 10000, "Bengaluru");
INSERT INTO employees(first_name, last_name, age, salary) VALUES ("Ajay", "Mishra", 28, 45000);
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Harshit", "Sidhwa", 28, 100000, "Pune");
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Rashmi", "Tanwar", 25, 25000, "Bengaluru");
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Saurabh", "Mishra", 31, 250000, "Hyderabad");
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Harsh", "Mehta", 29, 125000, "Hyderabad");

-- Read the records
SELECT * FROM employees

-- Data Retrieval Operations

-- Give me the records of the employees having salary more than 30000
-- SELECT (retrieve the records from a given table)
-- WHERE (to filter the records as per the given constraints)
SELECT first_name, last_name, age, Salary FROM employees
WHERE salary > 30000


-- Give me the records of the employee having age more than 28
SELECT * FROM employees
WHERE age > 28






