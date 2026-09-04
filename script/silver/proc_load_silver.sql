/*
===========================================================================================
Store procedure: Load Silver Layer (bronze -> silver)
============================================================================================
Script purpose:
This stored procedure perfomes the ETL(Extract, Transform, Load) process to populate the 'silver'schema table from 'bronze' schema.
it perfoms the following action
  inserts,transformed and cleansed data from bronze into silver table

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/

INSERT INTO silver.olist_order_items_dataset(
order_id,
order_item_id,
product_id,
seller_id,
shipping_limit_date,
price,
freight_value)
SELECT 
TRIM(REPLACE(order_id , '"', ''))AS order_id,
order_item_id,
TRIM(REPLACE(product_id , '"', ''))AS product_id,
TRIM(REPLACE(seller_id , '"', ''))AS seller_id,
shipping_limit_date,
price,
freight_value
FROM(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY order_id ORDER BY order_id)as row_num
FROM bronze.olist_order_items_dataset)t
WHERE row_num = 1;

INSERT INTO silver.olist_customers_dataset(
customer_id,
customer_unique_id,
customer_zip_code_prefix,
customer_city,
customer_state)
SELECT
TRIM(REPLACE (customer_id,'"','')) AS customer_id,
TRIM(REPLACE(customer_unique_id,'"','')) AS customer_unique_id,
TRIM(REPLACE(customer_zip_code_prefix,'"','')) AS customer_zip_code_prefix,
customer_city,
customer_state
FROM bronze.olist_customers_dataset;


INSERT INTO silver.olist_order_payments_dataset(
order_id,
payment_sequential,
payment_type,
payment_installments,
payment_value)
SELECT 
TRIM(REPLACE(order_id,'"','')) AS order_id,
payment_sequential,
TRIM(payment_type) AS payment_type,
payment_installments,
payment_value
FROM(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY order_id ORDER BY order_id)as row_num
FROM bronze.olist_order_payments_dataset)t
WHERE row_num = 1 ;

INSERT INTO silver.olist_orders_dataset(
order_id,
customer_id,
order_status,
order_purchase_timestamp,
order_approved_at,
order_delivered_carrier_date,
order_delivered_customer_date,
order_estimated_delivery_date,
days_taken)
SELECT 
TRIM(REPLACE(order_id,'"',''))AS order_id,
TRIM(REPLACE(customer_id,'"','')) AS customer_id,
TRIM(order_status) AS order_status,
order_purchase_timestamp,
CASE WHEN order_approved_at = 0 THEN null
	 ELSE order_approved_at
END order_approved_at,
CASE WHEN order_delivered_carrier_date = 0 THEN null
	 ELSE order_delivered_carrier_date
END order_delivered_carrier_date,
CASE WHEN order_delivered_customer_date = 0 THEN null
	 ELSE order_delivered_customer_date
END order_delivered_customer_date,
CAST(order_estimated_delivery_date AS DATE) AS order_estimated_delivery_date,
(DATEDIFF(order_delivered_customer_date , order_purchase_timestamp) )AS days_taken
FROM bronze.olist_orders_dataset;


INSERT INTO silver.olist_products_dataset(
product_id,
product_category_name,
product_name_lenght,
product_description_lenght,
product_photos_qty,
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm)
SELECT
TRIM(REPLACE(product_id,'"','') )AS product_id,
TRIM(product_category_name) AS product_category_name,
product_name_lenght,
product_description_lenght,
product_photos_qty,
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm
FROM bronze.olist_products_dataset;


INSERT INTO silver.olist_sellers_dataset(
seller_id,
seller_zip_code_prefix,
seller_city,
seller_state)
SELECT 
TRIM(REPLACE(seller_id,'"','')) AS seller_id,
TRIM(REPLACE(seller_zip_code_prefix,'"',''))AS seller_zip_code_prefix,
TRIM(seller_city) AS seller_city,
TRIM(seller_state) AS seller_state
FROM bronze.olist_sellers_dataset;



INSERT INTO silver.product_category_name_translation(
product_category_name,
product_category_name_english)
SELECT
TRIM(product_category_name) AS product_category_name,
TRIM(product_category_name_english) AS product_category_name_english
FROM bronze.product_category_name_translation;
