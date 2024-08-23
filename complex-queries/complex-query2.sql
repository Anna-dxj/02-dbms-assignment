-- generate a report of top-selling products getting the
-- product details, total sales, anad number of units sold
-- group by category 

WITH product_sales AS (
   SELECT products.product_name,
    products.product_description,
    products.id AS product_id,
    SUM(order_details.quantity) AS total_units_sold,
    SUM(order_details.quantity * order_details.unit_price) AS total_sales
   FROM order_details
   JOIN products ON products.id = order_details.product_id
   GROUP BY products.product_name, products.id, products.product_description
)
SELECT product_sales.product_name,
    product_sales.total_units_sold,
    product_sales.total_sales,
    product_sales.product_description,
    STRING_AGG(categories.category_name, ', ') AS categories
FROM product_sales
JOIN product_category ON product_sales.product_id = product_category.product_id
JOIN categories ON product_category.category_id = categories.id
GROUP BY product_sales.product_name, product_sales.total_units_sold, product_sales.total_sales, product_sales.product_description
ORDER BY total_sales DESC;