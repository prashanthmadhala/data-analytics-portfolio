USE ecommerce; 

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) UNIQUE,        -- Original category name
    product_category_name_english VARCHAR(100)       -- Translated category name in English
);
