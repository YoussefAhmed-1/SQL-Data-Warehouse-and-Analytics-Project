/*
===============================================================================
Year-over-Year and Average Sales Analysis by Product
===============================================================================
Calculates:
    - Current year's sales
    - Previous year's sales
    - Year-over-year sales difference and trend
    - Product's average annual sales
    - Difference from the product's average and trend
===============================================================================
*/

WITH yearly_product_sales AS
(
    SELECT
        YEAR(F.order_date) AS order_year,
        P.product_name,
        SUM(F.sales_amount) AS current_sales
    FROM gold.fact_sales AS F
    LEFT JOIN gold.dim_products AS P
    ON F.product_key = P.product_key
    WHERE F.order_date IS NOT NULL
    GROUP BY
        YEAR(F.order_date),
        P.product_name
),

sales_metrics AS
(
    SELECT
        order_year,
        product_name,
        current_sales,

        -- Calculate each window metric once so it can be reused below.
        LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,

        AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales

    FROM yearly_product_sales
)

SELECT
    order_year,
    product_name,
    current_sales,
    previous_year_sales,

    -- Year-over-year comparison.
    current_sales - previous_year_sales AS sales_diff,

    CASE
        WHEN current_sales > previous_year_sales THEN 'Increasing'
        WHEN current_sales < previous_year_sales THEN 'Decreasing'
        ELSE 'No Change'
    END AS sales_change,

    avg_sales,

    -- Comparison with the product's average annual sales.
    current_sales - avg_sales AS diff_avg,

    CASE
        WHEN current_sales > avg_sales THEN 'Above Avg'
        WHEN current_sales < avg_sales THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change

FROM sales_metrics
ORDER BY product_name,order_year;

--########################################################################################################

/*
===============================================================================
Month-over-Month and Average Sales Analysis by Product
===============================================================================
Calculates:
    - Current month's sales
    - Previous month's sales
    - Month-over-month sales difference and trend
    - Product's average monthly sales
    - Difference from the product's average and trend
===============================================================================
*/

WITH monthly_product_sales AS
(
    SELECT
        FORMAT(order_date, 'yyyy-MMM') AS order_month,
        P.product_name,
        SUM(F.sales_amount) AS current_sales
    FROM gold.fact_sales AS F
    LEFT JOIN gold.dim_products AS P
    ON F.product_key = P.product_key
    WHERE F.order_date IS NOT NULL

    GROUP BY
        FORMAT(order_date, 'yyyy-MMM'),
        P.product_name
),

sales_metrics AS
(
    SELECT
        order_month,
        product_name,
        current_sales,

        -- Previous month's sales
        LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) AS previous_month_sales,

        -- Average monthly sales for the product
        AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales

    FROM monthly_product_sales
)

SELECT
    order_month,
    product_name,
    current_sales,
    previous_month_sales,

    -- Month-over-month comparison
    current_sales - previous_month_sales AS sales_diff,

    CASE
        WHEN current_sales > previous_month_sales THEN 'Increasing'
        WHEN current_sales < previous_month_sales THEN 'Decreasing'
        ELSE 'No Change'
    END AS sales_change,

    avg_sales,

    -- Comparison with the product's average monthly sales
    current_sales - avg_sales AS diff_avg,

    CASE
        WHEN current_sales > avg_sales THEN 'Above Avg'
        WHEN current_sales < avg_sales THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change

FROM sales_metrics

ORDER BY
    product_name,order_month;
