/*
=============================================================================================
Quality checks
=============================================================================================
Script purpose:
This script performs various quality checks for data consistency,acuracy.
It includes checks for null or duplicates 
unwanted spaces and data consistency
null dates 

Usage notes:
Run these checks after data loading

*/


## check duplicates
##expectation No results


SELECT order_id,
COUNT(*)
FROM gold.olist_final
GROUP BY order_id
HAVING COUNT(*)>1 or order_id IS NULL;

SELECT customer_id,
COUNT(*)
FROM gold.olist_final
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL;

##check for unwanted spaces
##expectation No result

SELECT product_id
FROM gold.olist_final
WHERE product_id != TRIM(product_id);

SELECT payment_type
FROM silver.olist_order_payments_dataset
WHERE payment_type != TRIM(payment_type);


SELECT order_status
FROM silver.olist_orders_dataset
WHERE order_status != TRIM(order_status);

SELECT seller_state
FROM silver.olist_sellers_dataset
WHERE seller_state != TRIM(seller_state);

#checking 0 dates
SELECT order_delivered_carrier_date
FROM gold.olist_final
WHERE order_delivered_carrier_date=0;



#cheking null dates
SELECT product_category_name
FROM gold.olist_final
WHERE product_category_name IS NULL;
