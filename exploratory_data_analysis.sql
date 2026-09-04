/*
Gold layer - Exploratory Data Analysis
Project: Olist-ecommerce-sales-analysis
Description: Key business insights from gold layer
*/

SELECT *
FROM gold.olist_final;
/*data check*/
SELECT COUNT(*) - COUNT(order_id) AS null_orders,COUNT(*) - COUNT(payment_value) AS null_payment
FROM gold.olist_final;

/*first order*/
SELECT MIN(order_purchase_timestamp) AS first_order
FROM gold.olist_final;


/*last order*/
SELECT MAX(order_purchase_timestamp) AS last_order
FROM gold.olist_final;

/*total sales*/
SELECT ROUND(SUM(payment_value),2)AS total_sales
FROM gold.olist_final;

/*total items*/
SELECT COUNT(*)AS total_items
FROM gold.olist_final;

/*total orders*/
SELECT COUNT(DISTINCT order_id)AS total_orders
FROM gold.olist_final;

/*total product*/
SELECT COUNT(DISTINCT product_category_name_english)AS total_products
FROM gold.olist_final;

/*total customers*/
SELECT COUNT(DISTINCT customer_id)AS total_customers
FROM gold.olist_final;


/*average price*/
SELECT ROUND(AVG(price),2)AS average_price
FROM gold.olist_final;


/*payment type*/
SELECT payment_type,COUNT(*) AS orders,ROUND(SUM(payment_value),2) AS revenue
FROM gold.olist_final
GROUP BY payment_type
ORDER BY revenue DESC;


/*delivery time*/
SELECT ROUND(AVG(days_taken),1) AS avg_days,MIN(days_taken) AS min_days,
MAX(days_taken) AS max_days,SUM(CASE WHEN days_taken>15 THEN 1 ELSE 0 END) AS delayed_order
FROM gold.olist_final;


/*total customers by state*/
SELECT customer_state, COUNT(DISTINCT customer_id)AS customers
FROM gold.olist_final
GROUP BY customer_state
ORDER BY customers DESC;


/*products by category*/
SELECT product_category_name_english, COUNT(*)AS products_count
FROM gold.olist_final
GROUP BY product_category_name_english
ORDER BY products_count DESC;


/*average cost by category*/
SELECT product_category_name_english, ROUND(AVG(price),2)AS average_price
FROM gold.olist_final
GROUP BY product_category_name_english
ORDER BY average_price DESC;


/*total revenue by category*/
SELECT product_category_name_english, ROUND(SUM(payment_value),2)AS total_revenue
FROM gold.olist_final
GROUP BY product_category_name_english
ORDER BY total_revenue DESC;


/*distribution of products across states*/
SELECT customer_state,product_category_name_english, COUNT(*) AS quantity
FROM gold.olist_final
GROUP BY customer_state,product_category_name_english
ORDER BY customer_state,quantity DESC;


/*product with the highest revenue*/
SELECT product_category_name_english, ROUND(SUM(payment_value),2)AS revenue
FROM gold.olist_final
GROUP BY product_category_name_english
ORDER BY revenue DESC
LIMIT 1;


/*top 10 states by revenue*/
SELECT customer_state, ROUND(SUM(payment_value),2)AS revenue
FROM gold.olist_final
GROUP BY customer_state
ORDER BY revenue DESC
LIMIT 10;


/*sales performance over date*/
SELECT DATE(order_purchase_timestamp) AS order_date,ROUND(SUM(payment_value),2) AS daily_revenue,
COUNT(DISTINCT order_id) AS daily_orders
FROM gold.olist_final
GROUP BY DATE(order_purchase_timestamp)
ORDER BY order_date;

/*total sales per month*/
SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,ROUND(SUM(payment_value),2) AS monthly_revenue,
COUNT(DISTINCT order_id) AS monthly_orders
FROM gold.olist_final
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY month;

/*which category contributes the most to ovaral sales*/
SELECT product_category_name_english,ROUND(SUM(payment_value),2) AS revenue,
ROUND(SUM(payment_value)/(SELECT SUM(payment_value) FROM gold.olist_final)*100,2)AS percent_of_total
FROM gold.olist_final
GROUP BY product_category_name_english
ORDER BY revenue DESC;
