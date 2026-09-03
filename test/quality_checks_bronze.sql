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

SELECT*
FROM bronze.olist_order_items_dataset;
## check duplicates
##expectation No results

SELECT order_id,COUNT(*)
FROM bronze.olist_order_items_dataset
GROUP BY order_id
HAVING COUNT(*)>1;

SELECT*
FROM bronze.olist_order_items_dataset
WHERE order_id = 'e928cc82f61f2dcab3ad58d6e7200224';


##check for unwanted spaces
##expectation No result

SELECT product_id
FROM bronze.olist_order_items_dataset
WHERE product_id != TRIM(product_id);

##checking duplicates or null in primary key
##expectation no results
SELECT *
FROM bronze.olist_customers_dataset;

SELECT customer_id,
COUNT(*)
FROM bronze.olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL;

##Checking unwanted space
##expectation No results

SELECT customer_city
FROM bronze.olist_customers_dataset
WHERE customer_city!=TRIM(customer_city);

#checking for unwanted spaces
##expectation No result
SELECT *
FROM bronze.olist_order_payments_dataset;

SELECT payment_type
FROM bronze.olist_order_payments_dataset
WHERE payment_type != TRIM(payment_type);

## check for duplicates and null in primary key
## expectation No result found
SELECT *
FROM bronze.olist_orders_dataset;

SELECT order_id,
COUNT(*)
FROM bronze.olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) >1 OR order_id IS NULL;

## check for unwanted spaces
## expectation no result

SELECT order_status
FROM bronze.olist_orders_dataset
WHERE order_status != TRIM(order_status);

SELECT DISTINCT order_status
FROM bronze.olist_orders_dataset;

#checking 0 dates
SELECT order_estimated_delivery_date
FROM bronze.olist_orders_dataset
WHERE order_estimated_delivery_date=0;

## check for duplicates or null on primary key
##expectation No result found
SELECT *
FROM bronze.olist_products_dataset;

SELECT product_id,
COUNT(*)
FROM bronze.olist_products_dataset
GROUP BY product_id
HAVING COUNT(*) >1 OR product_id IS NULL;

SELECT product_category_name
FROM bronze.olist_products_dataset
WHERE product_category_name IS NULL;

## check for duplicates
## expectation No resulst
SELECT *
FROM bronze.olist_sellers_dataset;

SELECT seller_id, COUNT(*)
FROM bronze.olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*)> 1 OR seller_id IS NULL;

SELECT seller_state
FROM bronze.olist_sellers_dataset
WHERE seller_state != TRIM(seller_state);

## check for unwanted spaces
SELECT *
FROM bronze.product_category_name_translation;

SELECT product_category_name 
FROM bronze.product_category_name_translation
WHERE product_category_name != TRIM(product_category_name ) ;
