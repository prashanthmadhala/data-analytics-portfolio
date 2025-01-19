USE ecommerce

CREATE TABLE order_payments (
    order_id VARCHAR(50),                   -- Unique identifier for each order
    payment_sequential INT,                 -- Payment sequence number
    payment_type VARCHAR(20),               -- Type of payment (e.g., credit_card, voucher)
    payment_installments INT,               -- Number of payment installments
    payment_value DECIMAL(10, 2),           -- Payment amount with two decimal precision
    PRIMARY KEY (order_id, payment_sequential) -- Composite primary key to ensure uniqueness for each payment in an order
);
