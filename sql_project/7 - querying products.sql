USE ecommerce;

DESCRIBE products;

#view sample data
SELECT * FROM products LIMIT 10;

#Total Number of Rows (Count of product_id)
SELECT COUNT(product_id) AS total_products
FROM products;

#To find the count of product_id grouped by product_category_name:
SELECT 
    product_category_name,
    COUNT(product_id) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY total_products DESC;

DESCRIBE product_category_name_translation;

#To include the English translation of product_category_name from the product_category_name_translation table, I am using an INNER JOIN. 
#This will allow me to fetch the English names alongside the counts of products for each category.

SELECT 
    p.product_category_name,
    t.product_category_name_english,
    COUNT(p.product_id) AS total_products
FROM products p
JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY p.product_category_name, t.product_category_name_english
ORDER BY total_products DESC;


