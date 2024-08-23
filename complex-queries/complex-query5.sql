-- aggregate total payments received by payment method (eg. credit card, paypal)
-- show the distribution of payment methods across orders

-- payment method: name, total orders
-- orders: number that use that payment

SELECT payments.method AS payment_method, 
    COUNT(order_id) AS num_of_orders
FROM payments
join payment_orders ON payment_orders.payment_id = payments.id
GROUP BY payments.method, payments.id
ORDER BY payments.id ASC;