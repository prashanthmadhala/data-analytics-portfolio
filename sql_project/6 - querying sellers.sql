USE ecommerce;

DESCRIBE sellers;

#view sample data
SELECT * FROM sellers LIMIT 10;

#total rows in the sellers table
SELECT COUNT(*) AS total_rows FROM sellers;


SELECT DISTINCT seller_city FROM sellers;

#Total Number of Rows (Count of seller_id)
SELECT COUNT(seller_id) AS total_sellers
FROM sellers;

#Count of seller_id for Each City
SELECT 
    seller_city,
    COUNT(seller_id) AS total_sellers
FROM sellers
GROUP BY seller_city
ORDER BY total_sellers DESC;

#Count of seller_id for Each State
SELECT 
    seller_state,
    COUNT(seller_id) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

#Combine City and State Counts
SELECT 
    seller_state,
    seller_city,
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers
GROUP BY seller_state, seller_city
ORDER BY unique_sellers DESC;

#To find the count of seller_id based on seller_zip_code_prefix:
SELECT 
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    COUNT(seller_id) AS total_sellers
FROM sellers
GROUP BY seller_zip_code_prefix, seller_city, seller_state
ORDER BY total_sellers DESC;



