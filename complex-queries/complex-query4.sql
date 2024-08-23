-- create a view that shows order details
-- include customer name, product details, order date, total order amount for all orders made in the last month

-- customers: name (first_name || last_name combine)
-- orders: order_date
-- order_details: total amount (-> quantity * unit price),
-- products: product_name, product_description

SELECT
	first_name||' '||last_name AS customer_name,
	order_date, 
	STRING_AGG(product_name, ', ') AS product_names,
	SUM(order_details.quantity * order_details.unit_price) AS total_order_amount
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_details ON order_details.order_id = orders.id
JOIN products ON products.id = order_details.product_id
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY first_name, last_name, order_date
ORDER BY order_date ASC;