USE novacart;
-- Novacart Sales Analysis
-- SQL Project
-- DATE: 12 October 2026
SHOW TABLES;
-- Novacart Data Validation
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'employees', COUNT(*) FROM employees;
-- Inspect the customers table 
SELECT *
FROM customers
LIMIT 10;
-- Find duplicate customer IDs
SELECT customer_id, COUNT(*) AS occurences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
-- Find customers with missing gender
SELECT * 
FROM customers
WHERE gender = NULL OR TRIM(gender) = "";
-- Count orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
-- Find duplicate order IDs
SELECT order_id, COUNT(*) AS occurences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- Inspect distinct payment methods
SELECT DISTINCT payment_method
FROM orders
ORDER BY payment_method;
-- Find missing or negative shipping fees
SELECT order_id, shipping_fee
FROM orders
WHERE shipping_fee IS NULL
OR shipping_fee < 0
ORDER BY shipping_fee;
-- Find unmatched product IDs
SELECT oi.product_id
FROM order_items oi  
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
-- Find unusually high discount
SELECT *
FROM order_items
WHERE discount > 0.5
ORDER BY discount DESC;
-- Calculate revenue by product
SELECT p.product_id, p.product_name, ROUND(SUM(
    p.unit_price * oi.quantity * (1 - oi.discount)
), 2) AS total_revenue
FROM products p   
JOIN order_items oi  
ON p.product_id = oi.product_id
JOIN orders o  
ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;
-- Calculate total completed revenue
SELECT ROUND(SUM(p.unit_price * oi.quantity * (1 - oi.discount)), 2) AS completed_revenue
FROM products p  
JOIN order_items oi  
ON p.product_id = oi.product_id
JOIN orders o  
ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';
-- Completed revenue by payment method
SELECT LOWER(TRIM(o.payment_method)) AS payment_method, 
ROUND(SUM(p.unit_price * oi.quantity * (1 - oi.discount)), 2) AS completed_revenue
FROM products p  
JOIN order_items oi  
ON p.product_id = oi.product_id
JOIN orders o  
ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY LOWER(TRIM(o.payment_method))
ORDER BY completed_revenue DESC;
-- Monthly completed revenue
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
ROUND(SUM(p.unit_price * oi.quantity * (1 - oi.discount)), 2) AS completed_revenue
FROM products p  
JOIN order_items oi  
ON p.product_id = oi.product_id
JOIN orders o  
ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;
-- Compare monthly revenue
WITH monthly_revenue AS(
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month, 
    SUM(p.unit_price * oi.quantity * (1 - oi.discount)) AS completed_revenue 
    FROM products p  
    JOIN order_items oi  
    ON oi.product_id = p.product_id
    JOIN orders o  
    ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT sales_month, 
ROUND(completed_revenue, 2) AS monthly_revenue,
ROUND(LAG(completed_revenue) OVER (ORDER BY sales_month), 2) AS previous_month_revenue
FROM monthly_revenue
ORDER BY sales_month;
-- Month-on-Month revenue growth
WITH monthly_revenue AS(
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month, 
    SUM(p.unit_price * oi.quantity * (1 - oi.discount)) AS completed_revenue 
    FROM products p  
    JOIN order_items oi  
    ON oi.product_id = p.product_id
    JOIN orders o  
    ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
), revenue_comparison AS (
    SELECT sales_month, completed_revenue,
    LAG(completed_revenue) OVER (ORDER BY sales_month) AS previous_monthly_revenue
    FROM monthly_revenue
)
SELECT sales_month, 
ROUND(completed_revenue, 2) AS monthly_revenue,
ROUND(previous_monthly_revenue, 2) AS previous_monthly_revenue,
ROUND(100.0 * (completed_revenue) / NULLIF(previous_monthly_revenue, 0), 2) AS growth_percentage
FROM revenue_comparison
ORDER BY sales_month;
-- Top 10 product by revenue
SELECT p.product_id, p.product_name, ROUND(SUM(p.unit_price * oi.quantity * (1 - oi.discount)), 2) AS total_revenue
FROM products p  
JOIN order_items oi  
ON p.product_id = oi.product_id
JOIN orders o  
ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;
-- Products ranked by units sold
WITH product_units AS (
    SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold
    FROM products AS p
    JOIN order_items AS oi
    ON p.product_id = oi.product_id
    JOIN orders AS o
    ON oi.order_id = o.order_id
    WHERE LOWER(TRIM(o.order_status)) = 'completed'
    GROUP BY
    p.product_id,
    p.product_name
)
SELECT
    product_id,
    product_name,
    units_sold,
    DENSE_RANK() OVER (
    ORDER BY units_sold DESC
    ) AS sales_rank
FROM product_units
ORDER BY sales_rank, product_name;
-- Top 10 customers by completed revenue
SELECT c.customer_id, c.customer_name,
ROUND(SUM(p.unit_price * oi.quantity * (1 - oi.discount)), 2) AS total_revenue
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN products AS p
ON oi.product_id = p.product_id
WHERE LOWER(TRIM(o.order_status)) = 'completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;
-- Comparison of September and October product
SELECT p.product_id, p.product_name,
 SUM(
    CASE WHEN o.order_date >= '2025-09-01'
         AND o.order_date < '2025-10-01'
         THEN oi.quantity
         ELSE 0
         END) AS september_units,
 SUM(
    CASE WHEN o.order_date >= '2025-10-01'
         AND o.order_date < '2025-11-01'
         THEN oi.quantity
        ELSE 0
        END) AS october_units,
ROUND(SUM(
    CASE WHEN o.order_date >= '2025-09-01'
         AND o.order_date < '2025-10-01'
         THEN p.unit_price * oi.quantity * (1 - oi.discount)
         ELSE 0
         END), 2) AS september_revenue,

 ROUND(SUM(
     CASE WHEN o.order_date >= '2025-10-01'
         AND o.order_date < '2025-11-01'
         THEN p.unit_price * oi.quantity * (1 - oi.discount)
         ELSE 0
         END), 2) AS october_revenue
FROM products AS p
JOIN order_items AS oi
ON p.product_id = oi.product_id
JOIN orders AS o
ON oi.order_id = o.order_id
WHERE LOWER(TRIM(o.order_status)) = 'completed'
AND o.order_date >= '2025-09-01'
AND o.order_date < '2025-11-01'
GROUP BY p.product_id, p.product_name
ORDER BY october_revenue DESC;
-- Analyze employee performane
DESCRIBE employees;
DESCRIBE orders;
-- What drove October's revenue growth
WITH monthly_metrics AS (
    SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity) AS units_sold,
    SUM(p.unit_price * oi.quantity * (1 - oi.discount)) AS revenue
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN products AS p
ON oi.product_id = p.product_id
WHERE LOWER(TRIM(o.order_status)) = 'completed'
AND o.order_date >= '2025-09-01'
AND o.order_date < '2025-11-01'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT sales_month, units_sold,
ROUND(revenue, 2) AS revenue,
ROUND(revenue / NULLIF(units_sold, 0), 2) AS revenue_per_unit
FROM monthly_metrics
ORDER BY sales_month;
-- Check if unmatched product ID P999 is a completed order
SELECT oi.product_id, o.order_id, oi.quantity, oi.discount, o.order_date
FROM orders o
JOIN order_items oi 
ON o.order_id = oi.order_id
LEFT JOIN products p
ON p.product_id = oi.product_id
WHERE LOWER(TRIM(o.order_status)) = 'Completed'
AND p.product_id = NULL;
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT order_id) AS unique_orders, MIN(order_id) AS first_order, MAX(order_id) AS last_order
FROM orders;
