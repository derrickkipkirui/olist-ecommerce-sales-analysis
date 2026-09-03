/*
=============================================================================================
Quality checks
=============================================================================================
Script purpose:
This script performs various quality checks for data consistency,acuracy.
It includes checks for null or duplicates 
unwanted spaces and data consistency

Usage notes:
Run these checks after data loading

*/

## check duplicates
##expectation No results


SELECT order_id,
COUNT(*)
FROM silver.olist_order_items_dataset
GROUP BY order_id
HAVING COUNT(*)>1 or order_id IS NULL;

##check for unwanted spaces
##expectation No result

SELECT product_id
FROM silver.olist_order_items_dataset
WHERE product_id != TRIM(product_id);

##check for duplicates 
##expextation No results
SELECT customer_id,
COUNT(*)
FROM silver.olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL;

#checking for unwanted spaces
##expectation No result
SELECT *
FROM silver.olist_order_payments_dataset;

SELECT order_id,
COUNT(*)
FROM silver.olist_order_payments_dataset
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL;

SELECT payment_type
FROM silver.olist_order_payments_dataset
WHERE payment_type != TRIM(payment_type);

## check for duplicates and null in primary key
## expectation No result found
SELECT *
FROM silver.olist_orders_dataset;



SELECT order_id,
COUNT(*)
FROM silver.olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) >1 OR order_id IS NULL;

## check for unwanted spaces
## expectation no result

SELECT order_status
FROM silver.olist_orders_dataset
WHERE order_status != TRIM(order_status);

SELECT  *
FROM silver.olist_orders_dataset;

#checking 0 dates
SELECT order_delivered_carrier_date
FROM silver.olist_orders_dataset
WHERE order_delivered_carrier_date=0;

## check for duplicates or null on primary key
##expectation No result found
SELECT *
FROM silver.olist_products_dataset;

SELECT product_id,
COUNT(*)
FROM silver.olist_products_dataset
GROUP BY product_id
HAVING COUNT(*) >1 OR product_id IS NULL;

SELECT product_category_name
FROM silver.olist_products_dataset
WHERE product_category_name IS NULL;

## check for duplicates
## expectation No resulst
SELECT *
FROM silver.olist_sellers_dataset;

SELECT seller_id, COUNT(*)
FROM silver.olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*)> 1 OR seller_id IS NULL;

SELECT seller_state
FROM silver.olist_sellers_dataset
WHERE seller_state != TRIM(seller_state);
