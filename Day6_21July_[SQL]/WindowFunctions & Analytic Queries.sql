USE geeksforgeeks_db

SHOW TABLES

SELECT * FROM employees
-- Corresponding to each location [employee], 
-- what is the total count of employee belonging to that location and the average salary of them.
/*
	location		total_employee		avg_salary
	Bengaluru		3					(30000+10000+25000)/3
    Noida			1					45000
    Pune			1					100000
    Hyderabad		1					250000
*/

SELECT location, COUNT(location) AS total_employee, AVG(salary) AS avg_salary
FROM employees
GROUP BY location

-- what is the firstName, lastName, location, total count of employee belonging to that location and the average salary of them.
-- subqueries -> one query and inside that there is another query

-- Approach 1 - Joins (Computationally Expensive Task [time required to execute the command is more])
SELECT first_name, last_name, employees.Location, total_employee, avg_salary
FROM employees
JOIN
(SELECT Location, count(Location) as total_employee, avg(salary) as avg_salary
FROM employees
GROUP BY Location) as temp
ON employees.Location = temp.Location

select * from employees

SELECT first_name, last_name, location, count(location) as total_employee, avg(salary) as avg_salary
FROM employees
GROUP BY first_name, last_name, location


-- Approach 2 - Window Functions
SELECT first_name, last_name, location,
COUNT(location) OVER (PARTITION BY location) as total_employee,
AVG(salary) OVER (PARTITION BY location) as avg_salary
FROM employees


-- Priorities of employees as per the salaries in the descending order
SELECT first_name, last_name, salary,
ROW_NUMBER() OVER (ORDER BY salary DESC) as Priority_Salary
FROM employees

-- Inserting two records in employee table having salary as 100000 and 45000
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Pramod", "Kumar", 26, 10000, "Noida");
INSERT INTO employees(first_name, last_name, age, salary, location) VALUES ("Rohan", "Bhatia", 27, 45000, "Hyderabad");

-- RANK() -> ranking with skipping numeric data for which the ranks are same
SELECT first_name, last_name, salary,
RANK() OVER (ORDER BY salary DESC) as Priority_Salary
FROM employees

-- DENSE_RANK() -> ranking without skipping any numeric data
SELECT first_name, last_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) as Priority_Salary
FROM employees

-- ROW_NUMBER() vs RANK() vs DENSE_RANK()

-- Give me the details of those employee who are having 2nd highest salary
SELECT * FROM
(SELECT first_name, last_name, salary,
DENSE_RANK() OVER (ORDER BY salary DESC) as Priority_Salary
FROM employees) as temp
WHERE Priority_Salary = 2








