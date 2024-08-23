-- display a list of vendors and the total value of products they have supplied
-- include vendor details, number of products supplied, total sales per vendor 

-- vendors: vendor_name, email
-- products: COUNT product by vendor_id, 
-- order_details: total sales

WITH product_sales AS (
	SELECT products.vendor_id AS vendor_id, 
		SUM(quantity * unit_price) AS total_sales
	FROM order_details
	JOIN products ON products.id = order_details.product_id
	GROUP BY products.vendor_id
),
-- count 
vendor_products AS (
	SELECT products.vendor_id AS vendor_id, 
		COUNT(products.id) AS products_provided
	FROM products
	GROUP BY products.vendor_id
)
SELECT vendor_name, email, total_sales, products_provided 
FROM vendors
LEFT JOIN vendor_products ON vendor_products.vendor_id = vendors.id
LEFT JOIN product_sales ON product_sales.vendor_id = vendors.id
ORDER BY total_sales DESC;