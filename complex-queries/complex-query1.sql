-- retrieve a list of customers who have made purchases over a specific amount in a given time frame
-- include customer details, total amount spent, and number of orders
SELECT c.first_name || ' ' || c.last_name AS customer_name, 
c.email,
s.street_address || ', ' || s.city || ', ' || s.state_district || ' ' || s.post_code || ', ' || s.country AS full_address,
COUNT(o.customer_id) AS num_of_orders,
SUM(d.quantity * d.unit_price) AS price
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_details d ON d.order_id = o.id
JOIN shippings s on s.customer_id = c.id
WHERE order_date BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY first_name, last_name, email, street_address, city, state_district, post_code, country
HAVING SUM(d.quantity * d.unit_price) >= 100;