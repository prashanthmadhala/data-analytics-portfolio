USE ecommerce;

DESCRIBE order_payments;

#view sample data
SELECT * FROM order_payments LIMIT 10;

#Total Number of Rows (Count of order_id)
SELECT COUNT(order_id) AS total_orders
FROM order_payments;

#To find the total order count grouped by payment_type:
SELECT 
    payment_type,
    COUNT(order_id) AS total_orders
FROM order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;

#To calculate the average payment_installments and average payment_value based on each order_id, grouped by payment_type:
SELECT 
    order_id,
    payment_type,
    AVG(payment_installments) AS avg_payment_installments,
    AVG(payment_value) AS avg_payment_value
FROM order_payments
GROUP BY order_id, payment_type
ORDER BY order_id ASC, payment_type ASC;

#grand averages
SELECT 
    payment_type,
    AVG(payment_installments) AS avg_payment_installments,
    AVG(payment_value) AS avg_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY avg_payment_value DESC;

WITH RankedPayments AS (
    SELECT 
        payment_type,
        payment_installments,
        payment_value,
        ROW_NUMBER() OVER (PARTITION BY payment_type ORDER BY payment_installments) AS rn_asc,
        ROW_NUMBER() OVER (PARTITION BY payment_type ORDER BY payment_installments DESC) AS rn_desc,
        COUNT(*) OVER (PARTITION BY payment_type) AS total_rows,
        ROW_NUMBER() OVER (PARTITION BY payment_type ORDER BY payment_value) AS rn_value_asc,
        ROW_NUMBER() OVER (PARTITION BY payment_type ORDER BY payment_value DESC) AS rn_value_desc
    FROM order_payments
)
SELECT 
    payment_type,
    AVG(CASE 
        WHEN rn_asc = rn_desc OR rn_asc + 1 = rn_desc THEN payment_installments
    END) AS median_payment_installments,
    AVG(CASE 
        WHEN rn_value_asc = rn_value_desc OR rn_value_asc + 1 = rn_value_desc THEN payment_value
    END) AS median_payment_value
FROM RankedPayments
GROUP BY payment_type;
