#using the database
USE ecommerce;

#showing all the tables in the database
SHOW TABLES;

#describes the variable names, variable type, whether it contains NULL or not, key (if primary or foreign)
DESCRIBE customers;

#total rows in the customers table
SELECT COUNT(*) AS total_rows FROM customers;

#view sample data
SELECT * FROM customers LIMIT 10;

SELECT DISTINCT customer_city FROM customers;

#Total Number of Rows (Count of customer_id)
SELECT COUNT(customer_id) AS total_customers
FROM customers;

#Count of customer_id for Each City
SELECT 
    customer_city,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC;

#Unique Counts by customer_id for Each City
SELECT 
    customer_city,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_city
ORDER BY unique_customers DESC;


#Count of customer_id for Each State
SELECT 
    customer_state,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

#Unique Counts by customer_id for Each State
SELECT 
    customer_state,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_state
ORDER BY unique_customers DESC;

#Combine City and State Counts
SELECT 
    customer_state,
    customer_city,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers
GROUP BY customer_state, customer_city
ORDER BY unique_customers DESC;

#To find the count of customer_id based on customer_zip_code_prefix:
SELECT 
    customer_zip_code_prefix,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_zip_code_prefix
ORDER BY total_customers DESC;

SELECT 
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_zip_code_prefix, customer_city, customer_state
ORDER BY total_customers DESC;

#Query with WHERE Clause
SELECT 
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    COUNT(customer_id) AS total_customers
FROM customers
WHERE customer_state = 'RJ'  -- Example filter for Rio De Janeiro (state)
GROUP BY customer_zip_code_prefix, customer_city, customer_state
ORDER BY total_customers DESC;
