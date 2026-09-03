/*
==========================================================================
DDL Script: Create silver table
==========================================================================
Script purpose:
This script creates table in the silver schema dropping existing table if they already exist.
Run this script to re-define the DDL structure of 'silver' table
*/

DROP TABLE IF EXISTS silver.olist_order_items_dataset;
CREATE TABLE silver.olist_order_items_dataset(
order_id VARCHAR(50),
order_item_id VARCHAR(50),
product_id VARCHAR(50),
seller_id VARCHAR(50),
shipping_limit_date DATETIME,
price FLOAT,
freight_value FLOAT 
);

DROP TABLE IF EXISTS silver.olist_customers_dataset;
CREATE TABLE silver.olist_customers_dataset(
customer_id VARCHAR(50),
customer_unique_id VARCHAR(50),
customer_zip_code_prefix VARCHAR(50),
customer_city VARCHAR(50),
customer_state VARCHAR(50)
);


DROP TABLE IF EXISTS silver.olist_order_payments_dataset;
CREATE TABLE silver.olist_order_payments_dataset(
order_id VARCHAR(50),
payment_sequential INT,
payment_type VARCHAR(50),
payment_installments INT,
payment_value FLOAT
);


DROP TABLE IF EXISTS silver.olist_orders_dataset;
CREATE TABLE silver.olist_orders_dataset(
order_id VARCHAR(50),
customer_id VARCHAR(50),
order_status VARCHAR(50),
order_purchase_timestamp DATETIME,
order_approved_at DATETIME,
order_delivered_carrier_date DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATE,
days_taken INT
);

DROP TABLE IF EXISTS silver.olist_products_dataset;
CREATE TABLE silver.olist_products_dataset(
product_id VARCHAR(50),
product_category_name VARCHAR(50),
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT 
);

DROP TABLE IF EXISTS silver.olist_sellers_dataset;
CREATE TABLE silver.olist_sellers_dataset(
seller_id VARCHAR(50),
seller_zip_code_prefix VARCHAR(50),
seller_city VARCHAR(50),
seller_state VARCHAR(10)
);

DROP TABLE IF EXISTS silver.product_category_name_translation;
CREATE TABLE silver.product_category_name_translation(
product_category_name VARCHAR(50),
product_category_name_english VARCHAR(50)
);

