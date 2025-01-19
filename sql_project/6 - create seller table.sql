USE ecommerce; 


CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,         -- Unique identifier for each seller
    seller_zip_code_prefix INT,               -- ZIP code prefix
    seller_city VARCHAR(100),                 -- Name of the city (without numbers)
    seller_state CHAR(2)                      -- Two-character state abbreviation
);
