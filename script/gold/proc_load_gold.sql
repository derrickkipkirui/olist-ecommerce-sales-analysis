/*
===========================================================================================
Store procedure: Load Gold Layer (silver -> gold)
============================================================================================
Script purpose:
This stored procedure perfomes the ETL(Extract, Transform, Load) process to populate the 'gold'schema table from 'silver' schema.
it perfoms the following action
  Trancates the gold table before loading data
  inserts,transformed and cleansed data from silver into gold table

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/


TRUNCATE TABLE gold.olist_final;
INSERT INTO gold.olist_final(
order_id,
customer_id,
product_id,
seller_id,
order_item_id,
product_category_name_english,
order_status,
order_purchase_timestamp,
order_delivered_customer_date,
order_estimated_delivery_date,
days_taken,
customer_state,
seller_state,
payment_type,
price,
freight_value,
payment_value)
SELECT
od.order_id,
od.customer_id,
oi.product_id,
oi.seller_id,
oi.order_item_id,
COALESCE(cn.product_category_name_english,'unknown') AS product_category_name_english,
od.order_status,
od.order_purchase_timestamp,
od.order_delivered_customer_date,
od.order_estimated_delivery_date,
DATEDIFF(od.order_delivered_customer_date , od.order_purchase_timestamp)AS days_taken,
cs.customer_state,
sl.seller_state,
op.payment_type,
oi.price,
oi.freight_value,
op.payment_value
FROM silver.olist_orders_dataset od
JOIN silver.olist_customers_dataset cs
ON od.customer_id = cs.customer_id
JOIN silver.olist_order_payments_dataset op
ON od.order_id = op.order_id
JOIN silver.olist_order_items_dataset oi
ON od.order_id = oi.order_id
JOIN silver.olist_sellers_dataset sl
ON oi.seller_id = sl.seller_id
LEFT JOIN silver.olist_products_dataset pr
ON oi.product_id = pr.product_id
LEFT JOIN silver.product_category_name_translation cn
ON pr.product_category_name = cn.product_category_name 
WHERE od.order_status = 'delivered' AND od.order_delivered_customer_date IS NOT NULL 
;
