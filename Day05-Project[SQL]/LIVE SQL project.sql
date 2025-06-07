CREATE database ecommerce_db

use ecommerce_db

show tables

CREATE TABLE `Sales_Dataset` (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(10) NOT NULL, 
	ship_date VARCHAR(10) NOT NULL, 
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


-- Load the entire csv data into the mysq1 workbench
-- Famous error: MySQL is running at secure-file-private-error
LOAD DATA INFILE 'C:/Code/Sales_Dataset.csv'
INTO TABLE Sales_Dataset
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select * from Sales_Dataset

-- Data Analysis

-- Provide the details of the customers whose ship date = '2011-05-01'
select * 
from Sales_Dataset
where ship_date = '01-05-2011'

-- Give me the details of avg sales happening each year
 select year, avg(sales) as Avg_sales
 from Sales_Dataset
 group by year
 
 -- Give me the details of avg sales year
select year, avg(sales) as Avg_sales
from Sales_Dataset
group by year
order by avg_sales desc
limit 1

-- Provide the details of the customers whose ship_date is after '2011-05-01'
select * 
from Sales_Dataset
where ship_date > '01-05-2011'

-- Give me the details of sum of the sales happening each year
 select year, sum(sales) as Avg_sales
 from Sales_Dataset
 group by year
 
 
 -- Can you provide me a cost to company(ctc)
select * from Sales_Dataset
 
select (discount*sales+shipping_cost) as CTC
from Sales_Dataset

-- Provide the details of the orders between 2011-02-01 to 2011-03-01
select *
from Sales_Dataset
where order_date between '01-02-2011' and '01-03-2011'

-- Display a new column 'discounted flag' and it contains 'yes' if the discount > 0.000 else no
-- order_id, discounted_flag (to display the results)
select order_id,
	case 
		when discount > 0.000
		then 'yes'
		else 'no'
    end as discounted_flag
from Sales_Dataset

-- Display the top 5 products(sub_category) as per the sales
select sub_category as products, sum(sales) as total_sales
from Sales_Dataset
group by products
order by total_sales desc
limit 5

-- Provide state-wise the sum of the shipping cost in a given data in a descending order
SELECT state, SUM(shipping_cost) as total_shipping_cost
FROM Sales_Dataset
GROUP BY state
order by total_shipping_cost desc

-- Calculate the average profit margin per category [profit margin is profit/ sales]
select * from Sales_Dataset

select category, avg(profit/sales) as profit_margin
from Sales_Dataset
group by category

-- List the products with a profit margin of more than 20%
select product_name
from sales_dataset
where (profit/sales) > 0.20

-- List the products and corresponding profit margin of those products whose pm >20%
SELECT product_name, (profit / sales) as profit_margin
FROM sales_dataset
Where (profit / sales) > 0.20

-- Calculate the total quantity sold(total of sales * quantity) for each sub-category
select sub_category,sum(sales*quantity) as Total_Quantity_Sold
from Sales_Dataset
group by sub_category

select * from Sales_Dataset

-- Calculate the total sales and profit for each year using a CTE
WITH year_sales_profit AS (
	SELECT year,
    SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM sales_dataset
	GROUP BY year
)
SELECT * FROM year_sales_profit

-- Using a CTE, identify the top 3 states with the highest shipping costs
with Highest_shipping_costs as (
	select state, sum(shipping_cost) as Total_shipping_Cost
    from sales_dataset
    group by state
    order by Total_shipping_Cost desc
    limit 3
)select * from Highest_shipping_costs

select * from Sales_Dataset

-- Display the sum of sales per year
SELECT 
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year, 
    SUM(sales) AS sales
FROM 
    sales_dataset
GROUP BY 
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'));