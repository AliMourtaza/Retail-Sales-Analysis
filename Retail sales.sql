ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;


Select count(*)
from retail_sales


Select *
from retail_sales
Where
	transactions_id is  null
	or
	sale_date is  null
	or
	sale_time is  null
	or
	gender is  null
	or
	category is  null
	or
	quantity is  null
	or
	total_sale is null
	or
	cogs is null


Delete from retail_sales
Where
	transactions_id is  null
	or
	sale_date is  null
	or
	sale_time is  null
	or
	gender is  null
	or
	category is  null
	or
	quantity is  null
	or
	total_sale is null
	or
	cogs is null

--- Data Exploration
--- How many sales we have
SELECT COUNT(*)
From retail_sales

--- How many unique customers we have
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales

--- Unique category we have
SELECT DISTINCT category
FROM retail_sales

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
Select *
FROM retail_sales
WHERE
	sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE
    category = 'Clothing'
    AND quantity >= 4
    AND EXTRACT(YEAR FROM sale_date) = 2022
    AND EXTRACT(MONTH FROM sale_date) = 11;

-- Q.3 Write a SQL query to calculate each category's total sales (total_sale).
SELECT
	category,
	SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
	category,
	ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY 1
-- Q.5 Write an SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale >=1000
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
	gender,
	category,
	COUNT(transactionS_id) AS total_transaction
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,2
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	year,
	month
FROM(
SELECT
    EXTRACT(YEAR FROM sale_date) AS year,
    TO_CHAR(sale_date, 'Mon') AS month,
	AVG(total_sale) AS average_sale,
	RANK() OVER(PARTITION BY  EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY year, month)
WHERE rank =1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
	customer_id,
	SUM(total_sale)
FROM retail_sales
GROUP BY 1
ORDER BY 1 DESC
LIMIT 5
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category,    
    COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH shift
AS
(
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'Evening'
    END AS shift,
	transactions_id
FROM retail_sales
)
SELECT
	shift,
	COUNT(transactions_id) AS total_orders
FROM shift
GROUP BY 1



