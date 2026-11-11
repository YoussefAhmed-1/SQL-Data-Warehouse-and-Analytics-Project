/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

--Segment products into cost ranges and count how many products fall into each segment
SELECT 
cost_range,
COUNT(product_key) AS total_product
FROM
(
    SELECT 
    product_key,
    product_name,
    cost,
    CASE WHEN cost < 100 THEN 'Below 100'
         WHEN cost BETWEEN 100 AND 500 THEN '100-500'
         WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
         ELSE 'Above 1000'
    END cost_range
    FROM gold.dim_products
)t
GROUP BY cost_range
ORDER BY total_product DESC;
--=============================================================================================
/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS 
(
SELECT 
C.customer_key,
SUM(F.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM gold.fact_sales F
LEFT JOIN gold.dim_customers C
ON F.customer_key = C.customer_key
GROUP BY C.customer_key
)
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM
(
    SELECT
    customer_key,
    total_spending,
    lifespan,
    CASE WHEN lifespan >= 12 AND total_spending >  5000 THEN 'VIP'
         WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
         ELSE 'NEW'
    END customer_segment

    FROM customer_spending
 )t
 GROUP BY customer_segment
 ORDER BY total_customers DESC
--============================================================================================
-- Total Customer by Age
SELECT
    COUNT(customer_key) AS total_customers,
    DATEDIFF(YEAR,(birth_date), GETDATE()) AS age
FROM gold.dim_customers
GROUP BY DATEDIFF(YEAR,(birth_date), GETDATE()) 
ORDER BY COUNT(customer_key) DESC;

