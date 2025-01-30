USE ecommerce; 

#Average Orders per Customer
SELECT 
    AVG(order_count) AS avg_orders_per_customer
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) AS customer_orders;

#Average Products Ordered
SELECT 
    AVG(product_count) AS avg_products_ordered
FROM (
    SELECT order_id, COUNT(order_item_id) AS product_count
    FROM order_items
    GROUP BY order_id
) AS order_products;

#Average Price
SELECT 
    AVG(price) AS avg_price
FROM order_items;

#Average Freight Value 
SELECT 
    AVG(freight_value) AS avg_freight_value
FROM order_items;

#Average Payment Value 
SELECT 
    AVG(payment_value) AS avg_payment_value
FROM order_payments;

#Average Payment Installments
SELECT 
    AVG(payment_installments) AS avg_payment_installments
FROM order_payments;

#Combined 
SELECT 
    -- Average orders per customer
    (SELECT AVG(order_count)
     FROM (
         SELECT customer_id, COUNT(order_id) AS order_count
         FROM orders
         GROUP BY customer_id
     ) AS customer_orders) AS avg_orders_per_customer,
    
    -- Average products ordered
    (SELECT AVG(product_count)
     FROM (
         SELECT order_id, COUNT(order_item_id) AS product_count
         FROM order_items
         GROUP BY order_id
     ) AS order_products) AS avg_products_ordered,

    -- Average price
    (SELECT AVG(price)
     FROM order_items) AS avg_price,
    
    -- Average freight value
    (SELECT AVG(freight_value)
     FROM order_items) AS avg_freight_value,
    
    -- Average payment value
    (SELECT AVG(payment_value)
     FROM order_payments) AS avg_payment_value,
    
    -- Average payment installments
    (SELECT AVG(payment_installments)
     FROM order_payments) AS avg_payment_installments;


#Total Customers Who Bought Each Product (by Product Category Name in English)
SELECT 
    t.product_category_name_english,
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
JOIN orders o ON oi.order_id = o.order_id
GROUP BY t.product_category_name_english
ORDER BY total_customers DESC;

#Total Orders for Each Product Category
SELECT 
    t.product_category_name_english,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_orders DESC;

#Orders from Each Customer City
SELECT 
    c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC;

#Orders from Each State
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

#Highest-Selling Product Category in Each Customer City and State
#corrected query
WITH DeduplicatedOrders AS (
    SELECT DISTINCT 
        oi.order_id,
        c.customer_city,
        c.customer_state,
        t.product_category_name_english
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
),
CategoryTotals AS (
    SELECT 
        customer_city,
        customer_state,
        product_category_name_english,
        COUNT(order_id) AS total_orders  -- No need for DISTINCT here
    FROM DeduplicatedOrders
    GROUP BY customer_city, customer_state, product_category_name_english
),
MaxOrders AS (
    SELECT 
        customer_city,
        customer_state,
        MAX(total_orders) AS max_orders
    FROM CategoryTotals
    GROUP BY customer_city, customer_state
)
SELECT 
    ct.customer_city,
    ct.customer_state,
    ct.product_category_name_english,
    ct.total_orders
FROM CategoryTotals ct
JOIN MaxOrders mo 
    ON ct.customer_city = mo.customer_city
    AND ct.customer_state = mo.customer_state
    AND ct.total_orders = mo.max_orders
ORDER BY ct.customer_state, ct.customer_city;


#CREATE INDEX idx_customer_city ON customers(customer_city);
#CREATE INDEX idx_product_category_name ON products(product_category_name);
#CREATE INDEX idx_order_id ON order_items(order_id);
#CREATE INDEX idx_order_customer_id ON orders(order_id, customer_id);

# separate SQL queries for finding the highest-selling product category
#By City
WITH DeduplicatedOrders AS (
    SELECT DISTINCT 
        oi.order_id,
        c.customer_city,
        c.customer_state,
        t.product_category_name_english
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
),
CategoryTotals AS (
    SELECT 
        customer_city,
        customer_state,
        product_category_name_english,
        COUNT(order_id) AS total_orders
    FROM DeduplicatedOrders
    GROUP BY customer_city, customer_state, product_category_name_english
),
MaxOrders AS (
    SELECT 
        customer_city,
        customer_state,
        MAX(total_orders) AS max_orders
    FROM CategoryTotals
    GROUP BY customer_city, customer_state
)
SELECT 
    ct.customer_city,
    ct.customer_state,
    ct.product_category_name_english,
    ct.total_orders
FROM CategoryTotals ct
JOIN MaxOrders mo 
    ON ct.customer_city = mo.customer_city
    AND ct.customer_state = mo.customer_state
    AND ct.total_orders = mo.max_orders
ORDER BY ct.customer_city, ct.customer_state;  -- Sort by city first


#By State
WITH DeduplicatedOrders AS (
    SELECT DISTINCT 
        oi.order_id,
        c.customer_city,
        c.customer_state,
        t.product_category_name_english
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
),
CategoryTotals AS (
    SELECT 
        customer_state,
        product_category_name_english,
        COUNT(order_id) AS total_orders
    FROM DeduplicatedOrders
    GROUP BY customer_state, product_category_name_english
),
MaxOrders AS (
    SELECT 
        customer_state,
        MAX(total_orders) AS max_orders
    FROM CategoryTotals
    GROUP BY customer_state
)
SELECT 
    ct.customer_state,
    ct.product_category_name_english,
    ct.total_orders
FROM CategoryTotals ct
JOIN MaxOrders mo 
    ON ct.customer_state = mo.customer_state
    AND ct.total_orders = mo.max_orders
ORDER BY ct.customer_state;  -- Sort by state

#trying averages. 
WITH CategoryTotals AS (
    SELECT 
        c.customer_city,
        c.customer_state,
        t.product_category_name_english,
        COUNT(DISTINCT oi.order_id) AS total_orders
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY c.customer_city, c.customer_state, t.product_category_name_english
),
MaxOrders AS (
    SELECT 
        customer_city,
        customer_state,
        MAX(total_orders) AS max_orders
    FROM CategoryTotals
    GROUP BY customer_city, customer_state
)
SELECT 
    ct.customer_city,
    ct.customer_state,
    ct.product_category_name_english,
    ct.total_orders
FROM CategoryTotals ct
JOIN MaxOrders mo 
    ON ct.customer_city = mo.customer_city
    AND ct.customer_state = mo.customer_state
    AND ct.total_orders = mo.max_orders
ORDER BY ct.customer_state, ct.customer_city;

WITH CategoryTotals AS (
    SELECT 
        c.customer_city,
        c.customer_state,
        t.product_category_name_english,
        COUNT(DISTINCT oi.order_id) AS total_orders,  -- Total unique orders
        AVG(op.payment_value) AS avg_payment_value,  -- Average payment value
        AVG(op.payment_installments) AS avg_payment_installments, -- Average payment installments
        AVG(oi.freight_value) AS avg_freight_value, -- Average freight value
        AVG(oi.price) AS avg_price,  -- Average price of products
        COUNT(DISTINCT oi.product_id) AS avg_products_ordered  -- Total unique products per category
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    JOIN order_payments op ON o.order_id = op.order_id
    GROUP BY c.customer_city, c.customer_state, t.product_category_name_english
),
MaxOrders AS (
    SELECT 
        customer_city,
        customer_state,
        MAX(total_orders) AS max_orders
    FROM CategoryTotals
    GROUP BY customer_city, customer_state
)
SELECT 
    ct.customer_city,
    ct.customer_state,
    ct.product_category_name_english,
    ct.total_orders,
    ct.avg_payment_value,
    ct.avg_payment_installments,
    ct.avg_freight_value,
    ct.avg_price,
    ct.avg_products_ordered
FROM CategoryTotals ct
JOIN MaxOrders mo 
    ON ct.customer_city = mo.customer_city
    AND ct.customer_state = mo.customer_state
    AND ct.total_orders = mo.max_orders
ORDER BY ct.customer_state, ct.customer_city;

#for new analysis
SELECT DISTINCT
    o.order_id,
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    c.customer_zip_code_prefix,
    oi.product_id,
    s.seller_id,
    s.seller_city,
    s.seller_state,
    s.seller_zip_code_prefix,
    oi.price,
    oi.freight_value,
    op.payment_value,
    op.payment_type,
    op.payment_sequential,
    op.payment_installments,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    t.product_category_name_english AS product_category_name_english, -- As "sports_leisure"
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
JOIN sellers s ON oi.seller_id = s.seller_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE t.product_category_name_english = 'sports_leisure' -- Filter only for "sports_leisure"
ORDER BY o.order_purchase_timestamp DESC;
