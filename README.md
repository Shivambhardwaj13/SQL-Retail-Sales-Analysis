# 🛒 SQL-Retail-Sales-Analysis📊

This is a beginner-friendly SQL case study that analyzes a retail sales dataset. It covers data cleaning, exploratory data analysis, and business-driven insights using SQL.

## 🗃️ Project Info

- **Database Name**: `sales_data`
- **Table Name**: `retail_sales`
- **Level**: Beginner
- **Tools**: PostgreSQL 

## 🛠️ Project Structure 🎯

1. **Database Setup**: Set up and structure a retail sales database.
2. **Data Cleaning**: Perform data cleaning by handling missing/null values.
3. **Exploratory Analysis**: Find patterns, trends, and category insights.
4. **Business Questions**: Use SQL to answer real-world business questions.
5. **Generate insights from customer and sales behavior.**

## 📁 1. Project Structure
- **Database Setup.
- **Data Cleaning & Exploration.
- **Business Analysis via SQL Queries.
- **Insights & Reporting.

## 🛠️ 1. Database Setup

**🗃️  Create Database** :The project begins by creating a database named `sales_datas`.
**Table Creation** : A table named retail_sales is created to store the sales data. The table structure includes columns for ```transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount```.

```sql
CREATE DATABASE sales_datas;
```

**📦 Create Table**
A table named retail_sales is created to store detailed transaction data.
```sql
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 🔍 2. Data Exploration & Cleaning

**🧾 1. Record Count**
Determine the total number of records in the dataset.
```sql
SELECT COUNT(*) FROM retail_sales;
```
**👥 2. Unique Customers**
Find how many unique customers made purchases.

```sql
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
```
**🛍️ 3. Product Categories**
Identify all unique product categories.

```sql
SELECT DISTINCT category FROM retail_sales;
```
**⚠️ 4. Null Value Check**
Check if any important fields contain NULL (missing) values.

```sql
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```
**❌ 5. Delete Null Records**
Remove all rows that contain NULLs in key columns.

```sql
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```

### 📊 3. Business Analysis Using SQL Queries

**📅 6. Sales on a Specific Date**
Get all sales records from 2022-11-05.

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```
**👕 7. Clothing Sales in November 2022**
Find all clothing sales with quantity ≥ 3 in November 2022.

```sql
SELECT * FROM retail_sales
WHERE 
    category = 'Clothing'
    AND quantity >= 3
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```
**💰 8. Total Sales by Category**
Calculate total sales value for each product category.

```sql
SELECT category, SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY category;
```
**👤 9. Average Age of Beauty Category Buyers**
Get the average age of customers who bought Beauty products.

```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```
**👩‍🦰 10. Gender-wise Average Age for Beauty**
Average age of customers by gender in the Beauty category.
```sql
SELECT gender, ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY gender;
```
**💸 11.High Value Transactions**
List all transactions where total sale > 1000.

```sql
SELECT transactions_id, total_sale
FROM retail_sales
WHERE total_sale > 1000;
```
**📂 12. Transactions by Gender and Category**
Count transactions per gender in each product category.

```sql
SELECT gender, category, COUNT(transactions_id) AS total_transaction
FROM retail_sales
GROUP BY gender, category;
```
**📆 13. Best-Selling Month Per Year**
Find the top-performing month for each year based on average sales.

```sql
SELECT year, month, total_avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS total_avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS Table1
WHERE rank = 1;
```
**🏆 14. Top 5 Customers by Total Purchase**
Identify the top 5 customers with the highest total sales.

```sql
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

**📦 15. Unique Buyers per Category**
Get the number of distinct customers for each product category.

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

## 📈 4. Findings & Insights
- **Customer Details**: Customers span across multiple age groups and genders, with varied category preferences.
- **High-Value Transactions**: Transactions above ₹1000 indicate premium buyers and products.
- **Seasonal Trends**: Sales volume varies month-to-month, with some months consistently performing better.
- **Top Customers**: A small segment of customers contributes significantly to total sales.

## 📊 Reports
**💵 Sales Summary**
- **Shows the total number of sales and total sale amount.
- **Gives details about customer age and gender.
- **Shows how each product category performed.
- **Helps understand which products are most popular.

## 📈 Sales Trends
- **Tracks sales across different months to find high-performing months.
- **Shows average sales by month and year.
- **Breaks down order times into Morning, Afternoon, and Evening.
- **Helps find peak times when most sales happen.

## 👥 Customer Overview
- **Lists top 5 customers with the highest total purchase.
- **Counts how many unique customers bought from each category.
- **Shows the average age of customers by product type.
- **Compares buying patterns by gender

  
