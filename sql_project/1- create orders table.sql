USE ecommerce; 

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,              -- Unique identifier for each order
    customer_id VARCHAR(50),                       -- Identifier for the customer placing the order
    order_status VARCHAR(20),                      -- Status of the order (e.g., delivered, canceled)
    order_purchase_timestamp DATETIME,             -- When the order was placed
    order_approved_at DATETIME,                    -- When the order was approved
    order_delivered_carrier_date DATETIME,         -- When the order was shipped by the carrier
    order_delivered_customer_date DATETIME,        -- When the order was delivered to the customer
    order_estimated_delivery_date DATETIME         -- Estimated delivery date
);
