/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH  category_sales AS
(
    SELECT
        P.category,
        SUM(F.sales_amount) AS total_sales
    FROM gold.fact_sales F
    LEFT JOIN gold.dim_products P
    ON P.product_key = F.product_key
    GROUP BY P.category
)
SELECT
category,
total_sales,
SUM(total_sales) OVER() Overall_sales,
ROUND((CAST(total_sales AS FLOAT) / SUM(total_Sales) OVER())*100,2) AS percentage_of_total
FROM category_sales
--#################################################################################################

-- Which countries contribute the most to overall sales?
WITH country_sales AS
(
    SELECT
        C.country,
        SUM(F.sales_amount) AS total_sales
    FROM gold.fact_sales F
    LEFT JOIN gold.dim_customers C
      ON C.customer_key = F.customer_key
    GROUP BY C.country
)

SELECT
    country,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND(
        (CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100,
        2
    ) AS percentage_of_total
FROM country_sales;


