-- Creation of a new database
CREATE DATABASE ecommerce_db

drop database ecommerce_db

USE ecommerce_db
SHOW TABLES

-- Creation of a new table
CREATE TABLE Sales_Dataset (
	order_id VARCHAR(15) NOT NULL, 
	order_date DATE NOT NULL, 
	ship_date DATE NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 5) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	year DECIMAL(38, 0) NOT NULL
);

-- Load the entire csv data into the mysql workbench
-- Famous error: MySQL is running at secure-file-priv error

LOAD DATA INFILE 'C:/Code/Sales_Dataset.csv'
INTO TABLE Sales_Dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
	order_id,
	@order_date,
	@ship_date,
	ship_mode,
	customer_name,
	segment,
	state,
	country,
	market,
	region,
	product_id,
	category,
	sub_category,
	product_name,
	sales,
	quantity,
	discount,
	profit,
	shipping_cost,
	order_priority,
	year
)
SET 
	order_date = STR_TO_DATE(@order_date, '%d-%m-%Y'),
	ship_date = STR_TO_DATE(@ship_date, '%d-%m-%Y');;
-- ⚠️ NOTE:
-- This custom LOAD DATA INFILE command handles DATE FORMAT issues.
-- The CSV has dates in 'DD-MM-YYYY' format (e.g., '01-02-2011'), but MySQL expects 'YYYY-MM-DD'.
-- We use STR_TO_DATE() to convert @order_date and @ship_date into proper DATE format.
-- This avoids NULLs or errors when querying with YEAR(), comparisons, or range filters.
-- Don’t skip this or your future self will hate your past self. You've been warned.

    

SELECT * FROM sales_dataset

-- Data Analysis

-- Provide the details of the customers whose ship_date = '2011-05-01'
SELECT * FROM sales_dataset
WHERE ship_date = '2011-05-01'

-- Give me the details of avg sales happening each year
SELECT year, AVG(sales) as avg_sales
FROM sales_dataset
GROUP BY year

-- Give me the highest avg sales year
SELECT year, AVG(sales) as avg_sales
FROM sales_dataset
GROUP BY year
ORDER BY avg_sales DESC
LIMIT 1

-- Provide the details of the customers whose ship_date is after '2011-05-01'
SELECT * FROM sales_dataset
WHERE ship_date > '2011-05-01'

-- Give me the details of sum of the sales happening each year
SELECT year, SUM(sales) as avg_sales
FROM sales_dataset
GROUP BY year

-- Can you provide the cost to company(ctc) in a given data
SELECT (discount*sales + shipping_cost) as ctc
FROM sales_dataset

-- Provide the details of the orders between '2011-02-01' to '2011-03-01'
SELECT * FROM sales_dataset
WHERE order_date BETWEEN '2011-02-01' AND '2011-03-01'

-- Display a new column 'discounted_flag' and it contains 'yes' if the discount > 0.000 else no
-- order_id, discount, discounted_flag (to display the results)
SELECT order_id, discount, 
CASE 
	WHEN discount > 0.000 THEN 'yes' 
    ELSE 'no' END as discounted_flag
FROM sales_dataset

-- Display the top 5 products(sub_category) as per the sales
SELECT sub_category as products, SUM(sales) as total_sales
FROM sales_dataset
GROUP BY products
ORDER BY total_sales desc
LIMIT 5

-- Provide state-wise the sum of the shipping cost in a given data in a descending order
SELECT state, SUM(shipping_cost) as total_shipping_cost
FROM sales_dataset
GROUP BY state
ORDER BY total_shipping_cost DESC

-- Calculate the average profit margin per category [profit margin is profit/sales]
SELECT category, AVG(profit/sales) as profit_margin
FROM sales_dataset
GROUP BY category

-- List the products with a profit margin of more than 20%
SELECT product_name
FROM sales_dataset
Where (profit / sales) > 0.20

-- List the products and corresponding profit margin of those products whose pm > 20%
SELECT product_name, (profit / sales) as profit_margin
FROM sales_dataset
WHERE (profit / sales) > 0.20


-- Calculate the total quantity sold(total of sales * quantity) for each sub-category
SELECT sub_category ,(SUM(sales * quantity) ) AS total_quantity_sold 
FROM sales_dataset
GROUP BY sub_category

-- Calculate the total sales and profit for each year using a CTE
WITH year_sales_profit AS (
	SELECT year, SUM(sales) AS total_sales, SUM(profit) AS total_profit
    FROM sales_dataset
    GROUP BY year
)
SELECT * FROM year_sales_profit

-- Using a CTE, identify the top 3 states with the highest shipping costs.
WITH top_states AS(
	SELECT state, SUM(shipping_cost) as total_shipping_cost 
	FROM sales_dataset
	GROUP BY state
	ORDER BY total_shipping_cost DESC
    LIMIT 3
)
SELECT * FROM top_states

-- Display the sum of sales per year
SELECT YEAR(order_date) AS order_year, SUM(sales) AS sales
FROM sales_dataset
GROUP BY YEAR(order_date)

-- LAG in Window Functions
WITH year_sales AS (
    SELECT YEAR(order_date) AS order_year, SUM(sales) AS sales
    FROM sales_dataset
    GROUP BY YEAR(order_date)
)
SELECT *, LAG(sales,1,0) OVER (ORDER BY order_year) as prev_year_sales
FROM year_sales
ORDER BY order_year;

-- LEAD in Window Functions
WITH year_sales AS (
    SELECT YEAR(order_date) AS order_year, SUM(sales) AS sales
    FROM sales_dataset
    GROUP BY YEAR(order_date)
)
SELECT *, LEAD(sales,1,0) OVER (ORDER BY order_year) as prev_year_sales
FROM year_sales
ORDER BY order_year;

-- LIMIT vs OFFSET 
-- OFFSET - skip the number of rows mentioned by the user
-- LIMIT - display that many number of records mentioned by the user
WITH year_sales AS (
    SELECT YEAR(order_date) AS order_year, SUM(sales) AS sales
    FROM sales_dataset
    GROUP BY YEAR(order_date)
)
SELECT *, LEAD(sales,1,0) OVER (ORDER BY order_year) as prev_year_sales
FROM year_sales
ORDER BY order_year
LIMIT 2
OFFSET 2;


-- UNION vs UNION ALL
-- UNION -> It will merge all the tables after removing all the duplicates
-- UNION ALL -> It will merge all the table without removal of duplicate records






















