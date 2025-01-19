USE ecommerce;

CREATE TABLE order_items (
    order_id VARCHAR(50),                     -- Unique identifier for each order
    order_item_id INT,                        -- Unique identifier for each item in the order
    product_id VARCHAR(50),                   -- Unique identifier for each product
    seller_id VARCHAR(50),                    -- Unique identifier for each seller
    shipping_limit_date DATETIME,             -- Shipping deadline
    price DECIMAL(10, 2),                     -- Price of the item
    freight_value DECIMAL(10, 2),             -- Freight cost
    PRIMARY KEY (order_id, order_item_id),    -- Composite key to ensure unique items per order
    FOREIGN KEY (product_id) REFERENCES products(product_id), -- Reference to products
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)     -- Reference to sellers
);

