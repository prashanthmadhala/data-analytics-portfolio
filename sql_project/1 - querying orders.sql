USE ecommerce;

DESCRIBE orders;

#view sample data (limited to first 10 rows)
SELECT * FROM orders LIMIT 10;

#total rows in the orders table
SELECT COUNT(*) AS total_rows FROM orders;

#Total Number of Rows (Count of order_id)
SELECT COUNT(order_id) AS total_orders
FROM orders;

#Total Number of Rows (Count of customer_id)
SELECT COUNT(customer_id) AS total_customers
FROM orders;

#To find the total order count grouped by order_status:
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

#"delivered" status
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_status
ORDER BY total_orders DESC;

#"delivered" status and by year
SELECT 
    YEAR(order_purchase_timestamp) AS order_year,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_year
ORDER BY order_year ASC;

#order_year, order_month, total_orders
SELECT 
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY order_year, order_month
ORDER BY order_year ASC, order_month ASC;

