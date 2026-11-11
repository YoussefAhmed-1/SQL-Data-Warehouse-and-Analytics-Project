/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================
IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
WITH base_query AS 
(
SELECT 
	F.order_number,
	F.product_key,
	F.order_date,
	F.sales_amount,
	F.quantity,
	C.customer_key,
	C.customer_number,
	CONCAT(C.first_name,c.last_name) AS customer_name,
	DATEDIFF(YEAR,C.birth_date,GETDATE()) age
FROM gold.fact_sales F
LEFT JOIN gold.dim_customers C
ON C.customer_key = F.customer_key
WHERE F.order_date IS NOT NULL
)
,customer_aggregations AS (

/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT (DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan
FROM base_query
GROUP BY customer_key,customer_number,customer_name,age
)
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,

	CASE WHEN age < 20 THEN 'Under 20'
	     WHEN age BETWEEN 20 AND 29 THEN '20-29'
		 WHEN age BETWEEN 30 AND 39 THEN '30-39'
		 WHEN age BETWEEN 40 AND 49 THEN '40-49'
		 ELSE '50 and above'
	END AS age_group,

	CASE WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
	     WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		 ELSE 'New'
	END AS customer_segment,

	last_order_date,
	DATEDIFF(MONTH,last_order_date,GETDATE()) AS recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,
	-- Compute average order value(AVO)
	CASE WHEN total_orders = 0 THEN 0
		 ELSE total_sales/total_orders 
	END AS avg_order_value,
	--compute average monthly spend
	CASE WHEN lifespan = 0 THEN total_sales
	     ELSE total_sales/lifespan
	END AS average_monthly_spend

FROM customer_aggregations


