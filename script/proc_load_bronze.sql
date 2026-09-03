/*
===========================================================================================
Store procedure: Load Bronze Layer (source -> bronze)
============================================================================================
Script purpose:
This stored procedure loads data into the 'bronze'schema from external csv files.
it perfoms the following action
  Trancates the bronze table before loading data

Paramiters:
none
this stored procedure does not accept any paramiters or return any value.
*/




TRUNCATE TABLE bronze.olist_order_items_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_order_items_dataset.csv'
INTO TABLE bronze.olist_order_items_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;

SELECT*
FROM bronze.olist_order_items_dataset;

TRUNCATE TABLE bronze.olist_customers_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_customers_dataset.csv'
INTO TABLE bronze.olist_customers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;
SELECT *
FROM bronze.olist_customers_dataset;



TRUNCATE TABLE bronze.olist_order_payments_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_order_payments_dataset.csv'
INTO TABLE bronze.olist_order_payments_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;

SELECT *
FROM bronze.olist_order_payments_dataset;



TRUNCATE TABLE bronze.olist_orders_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_orders_dataset.csv'
INTO TABLE bronze.olist_orders_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;

SELECT *
FROM bronze.olist_orders_dataset;


TRUNCATE TABLE bronze.olist_products_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_products_dataset.csv'
INTO TABLE bronze.olist_products_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;


SELECT *
FROM bronze.olist_products_dataset;

TRUNCATE TABLE bronze.olist_sellers_dataset;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\olist_sellers_dataset.csv'
INTO TABLE bronze.olist_sellers_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;

SELECT *
FROM bronze.olist_sellers_dataset;

TRUNCATE TABLE bronze.product_category_name_translation;
LOAD DATA LOCAL INFILE 'C:\\Users\\USER\\Downloads\\archive\\product_category_name_translation.csv'
INTO TABLE bronze.product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY ""
IGNORE 1 ROWS
;

SELECT *
FROM bronze.product_category_name_translation;
