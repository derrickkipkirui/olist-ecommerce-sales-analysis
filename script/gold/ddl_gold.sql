/*
==========================================================================
DDL Script: Create gold table
==========================================================================
Script purpose:
This script creates table in the gold schema dropping existing table if they already exists.
Run this script to re-define the DDL structure of 'gold' table.
its a clean, enriched, and businnes ready dataset

Usage
it can be quired directly for analytics and reporting
*/

DROP TABLE IF EXISTS gold.olist_final;
CREATE TABLE gold.olist_final(
order_id VARCHAR(50),
customer_id VARCHAR(50),
product_id VARCHAR(50),
seller_id VARCHAR(50),
order_item_id VARCHAR(50),
product_category_name_english VARCHAR(50),
order_status VARCHAR(50),
order_purchase_timestamp DATETIME,
order_delivered_customer_date DATETIME,
order_estimated_delivery_date DATE,
days_taken INT,
customer_state VARCHAR(50),
seller_state VARCHAR(10),
payment_type VARCHAR(50),
price FLOAT,
freight_value FLOAT ,
payment_value FLOAT);
