USE geeksforgeeks_db
SHOW TABLES

SELECT * FROM learners
SELECT * FROM courses

-- Give the courseID, courseName, and the number of enrollments happened in each course
/*
	courseID	courseName 						num_enrollments
	1			DSA								2
    2			Complete Data Analytics			2
	3			Web Development					2
    4			Data Science					0
    5			Complete Excel Mastery			1
    6			Java Programming				0
*/

select course_id, course_name, count(selected_course)as num_enrollments
from courses LEFT JOIN learners
on course_id=selected_course
group by course_id, Course_name;


-- Create a new table "Orders" 

drop table orders

CREATE TABLE orders(
OrderID INT AUTO_INCREMENT,
Order_Date TIMESTAMP NOT NULL, 
Order_Learner_Id INT NOT NULL, 
OrderStatus VARCHAR(30) NOT NULL,
PRIMARY KEY(OrderID),
FOREIGN KEY(Order_Learner_Id) REFERENCES learners(learner_id))

-- Insertion of the records inside the orders table
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-21',1,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-02-22',3,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-15',4,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-16',8,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-13',8,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-14',9,'COMPLETE');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-22',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-12',5,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-25',1,'PENDING');
INSERT INTO Orders(Order_Date, Order_Learner_Id, OrderStatus) VALUES ('2024-01-11',3,'CLOSED');

SELECT * FROM Orders

-- How many total orders placed by each student
/*
	order_learner_id		num_orders
	1						3
    3						2
    4						1
    & so on
*/
SELECT * FROM Orders

SELECT Order_Learner_Id, COUNT(*) as num_orders
FROM orders
GROUP BY order_learner_id

-- How many total orders placed by each student with it's learner firstname,lastname and email information
SELECT order_learner_id, first_name, last_name, email, num_orders
FROM learners JOIN
(SELECT Order_Learner_Id, COUNT(*) as num_orders
FROM orders
GROUP BY order_learner_id) as temp
ON learners.learner_id = temp.order_learner_id

SELECT * FROM Orders
select * from learners

-- Add one more column by the name of 'avg_orders' 
SELECT order_learner_id, first_name, last_name, email, num_orders, AVG(SUM(num_orders)) OVER() as avg_orders
FROM learners JOIN
(SELECT Order_Learner_Id, COUNT(*) as num_orders
FROM orders
GROUP BY order_learner_id) as temp
ON learners.learner_id = temp.order_learner_id
GROUP BY order_learner_id


-- Approach 2
SELECT 
    Order_Learner_Id, 
    first_name, 
    last_name, 
    email, 
    COUNT(Order_Learner_Id) AS num_order, 
    AVG(COUNT(Order_Learner_Id)) OVER() AS avg_order
FROM 
    Learners
JOIN 
    orders 
ON 
    learner_id = Order_Learner_Id
GROUP BY 
    Order_Learner_Id
    
-- Display the premium customers of the website
/*
		num_order > avg_order
*/

SELECT first_name, last_name, num_orders, avg_orders FROM
(SELECT order_learner_id, first_name, last_name, email, num_orders, AVG(SUM(num_orders)) OVER() as avg_orders
FROM learners JOIN
(SELECT Order_Learner_Id as order_learner_id, COUNT(*) as num_orders
FROM orders
GROUP BY order_learner_id) as temp
ON learners.learner_id = temp.order_learner_id
GROUP BY order_learner_id) temp_1
WHERE num_orders > avg_orders

SELECT * FROM learners
SELECT * FROM orders

-- Getting the details of premium vs not premium customers of the website

SELECT 
    O.Order_Learner_Id, 
    L.first_name, 
    L.last_name, 
    L.email, 
    O.num_order, 
    AVG(O.num_order) OVER() AS avg_order,
    CASE 
        WHEN O.num_order > AVG(O.num_order) OVER() THEN 'premium' 
        ELSE 'not premium' 
    END AS premiumUsers
FROM 
    learners L
JOIN 
    (SELECT 
        Order_Learner_Id, 
        COUNT(order_Learner_Id) AS num_order
     FROM 
        orders
     GROUP BY 
        Order_Learner_Id) O
ON 
    L.learner_id = O.Order_Learner_Id;






-- Common Table Expressions

WITH order_counts AS (
SELECT order_learner_id, first_name, last_name, email, num_orders, AVG(SUM(num_orders)) OVER() as avg_orders
FROM learners JOIN
(SELECT Order_Learner_Id as order_learner_id, COUNT(*) as num_orders
FROM orders
GROUP BY order_learner_id) as temp
ON learners.learner_id = temp.order_learner_id
GROUP BY order_learner_id)
SELECT first_name, last_name, num_orders, avg_orders FROM order_counts
WHERE num_orders > avg_orders










