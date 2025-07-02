-- CREATE DATA FOR THIS PROJECT
	CREATE DATABASE sales_data;


--  CREATE TABLE
CREATE TABLE retail_sales(
		transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT

);


SELECT * FROM retail_sales;

-- -------------------------DATA CLEANING-------------------------- 
 
-- Q.1 Find all the records in the retail_sales table that contain any NULL (missing) values in important columns.

  SELECT * FROM retail_sales
  WHERE 
  		  transactions_id	IS NULL 
	OR
		  sale_date IS NULL
	OR 
		  sale_time IS NULL
	OR 
		  customer_id IS NULL
	OR 
		  gender IS NULL
	OR 
		  age IS NULL
	OR 
		  category IS NULL
	OR 
		  quantiy IS NULL	
	OR 
		  price_per_unit IS NULL	
	OR 
		  cogs IS NULL	
	OR 
		  total_sale IS NULL;

		  
-- Q.2 Delete all records from the retail_sales table where any important column contains a NULL (missing) value.
-- -------------------DELETE NULL VALUES----------------

	DELETE FROM retail_sales
	 WHERE 
  		  transactions_id	IS NULL 
	OR
		  sale_date IS NULL
	OR 
		  sale_time IS NULL
	OR 
		  customer_id IS NULL
	OR 
		  gender IS NULL
	OR 
		  age IS NULL
	OR 
		  category IS NULL
	OR 
		  quantiy IS NULL	
	OR 
		  price_per_unit IS NULL	
	OR 
		  cogs IS NULL	
	OR 
		  total_sale IS NULL;
	  

-- Data Exploration

-- Q.3 How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- Q.4How many uniuque customers & category we have ?

SELECT DISTINCT (customer_id) as unique_customer FROM retail_sales;
SELECT COUNT(DISTINCT (customer_id)) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;


-- Q.5 Data Analysis & Business Key Problems & Answers
		SELECT * 
		FROM retail_sales;
		
-- Q.6 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
		SELECT * FROM retail_sales
		WHERE sale_date = '2022-11-05';

-- Q.7 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
		ALTER TABLE retail_sales
		rename column quantiy to quantity;
		
		SELECT * FROM retail_sales
		WHERE 
			category = 'Clothing'
			And
				quantity >= 3
			AND
				TO_CHAR(sale_date, 'yyyy-mm') = '2022-11';

-- Q.8 Write a SQL query to calculate the total sales (total_sale) for each category.
		SELECT category ,
		SUM (total_sale) AS total_sale
		FROM retail_sales
	    GROUP BY category;
		
-- Q.9 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
		SELECT
			AVG(age) AS average_age
		FROM retail_sales
		WHERE category ='Beauty ';

-- Q.10 What is the average age of customers for the 'Beauty' category, grouped by gender?
		SELECT GENDER,
				ROUND(AVG(AGE), 2) AS AVG_AGE
			FROM RETAIL_SALES
				WHERE CATEGORY = 'Beauty'
				GROUP BY GENDER;


-- Q.11 Write a SQL query to find all transactions where the total_sale is greater than 1000.
		SELECT  transactions_id ,
				total_sale 
		FROM retail_sales
		WHERE total_sale > 1000;

-- Q.12 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
		SELECT gender,
			   category,	
			   COUNT(transactions_id) AS total_transaction
		FROM retail_sales
		GROUP BY gender , category;		

-- Q.13 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
		SELECT 
				year,
				month,
				total_avg_sale
			FROM
			  (
				SELECT 
					EXTRACT (YEAR FROM sale_date) AS year,
					EXTRACT (MONTH FROM sale_date) AS month,
					AVG(total_sale) AS total_avg_sale,
					RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date)
								ORDER BY AVG(total_sale) DESC) AS rank
				FROM retail_sales
					GROUP BY year , month
					) AS Table1
				WHERE RANK = 1;
						
-- Q.14 Write a SQL query to find the top 5 customers based on the highest total sales 
		SELECT customer_id,
				SUM(total_sale) AS total_sale
		FROM retail_sales
				GROUP BY customer_id
				ORDER BY total_sale desc
				LIMIT 5;
			
-- Q.15 Write a SQL query to find the number of unique customers who purchased items from each category.
		SELECT 
				category , 
				COUNT(DISTINCT(customer_id)) AS unique_customers
		FROM retail_sales
			GROUP BY  category;



