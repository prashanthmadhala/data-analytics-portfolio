USE ecommerce;

DESCRIBE order_items;

#view sample data
SELECT * FROM order_items LIMIT 10;

#Total Count of order_id
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM order_items;

#Total Count of order_item_id
SELECT COUNT(order_item_id) AS total_order_items
FROM order_items;

#average of freight_value and average of price
SELECT 
    AVG(freight_value) AS avg_freight_value,
    AVG(price) AS avg_price
FROM order_items;


#Total Count of order_item_id with freight_value > 20
SELECT COUNT(DISTINCT order_id) AS total_order_ids_with_high_freight
FROM order_items
WHERE freight_value > 20;

# Total Count of order_id with price > 120
SELECT COUNT(DISTINCT order_id) AS total_order_ids_with_high_price
FROM order_items
WHERE price > 120;

# Total Count of order_id with price > 120 AND freight_value > 20
SELECT COUNT(DISTINCT order_id) AS total_order_ids_with_high_price_and_freight
FROM order_items
WHERE price > 120 AND freight_value > 20;

SELECT 
    COUNT(DISTINCT order_id) AS total_order_ids,
    COUNT(order_item_id) AS total_order_items,
    COUNT(DISTINCT CASE WHEN freight_value > 20 THEN order_id END) AS total_order_ids_with_avg_freight,
    COUNT(DISTINCT CASE WHEN price > 120 THEN order_id END) AS total_order_ids_with_avg_price,
    COUNT(DISTINCT CASE WHEN price > 120 AND freight_value > 20 THEN order_id END) AS total_order_ids_with_avg_price_and_freight
FROM order_items;

SELECT *
FROM order_items
WHERE freight_value > 20 AND price > 120
LIMIT 10;


