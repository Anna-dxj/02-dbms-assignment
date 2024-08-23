-- implement a transaction where a customer places an order:
-- insert new order
-- insert corresponding line items in order_details table
-- update product inventory levels
-- ensure that the transaction is atomic, consistent, and durable (ACID properties)

-- create trigger function to automatically chek the stock if it's zero and if it's not zero then to automatically update it
CREATE OR REPLACE FUNCTION check_and_update_stock()
RETURNS TRIGGER
AS $$
BEGIN
	IF (SELECT stock FROM products WHERE id = NEW.product_id) < NEW.quantity THEN 
		RAISE EXCEPTION 'Insufficient stock for %', NEW.product_name;
	END IF;

	UPDATE products
	SET stock = stock - NEW.quantity
	WHERE id = NEW.product_id;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- set up trigger to occur before an insert on order_details
CREATE TRIGGER check_stock_trigger
BEFORE INSERT ON order_details
FOR EACH ROW
EXECUTE FUNCTION check_and_update_stock();

-- transaction
BEGIN;

INSERT INTO orders (customer_id, order_date, is_shipped) VALUES
(6, '2024-08-22', FALSE);

-- pre trigger:
SELECT  * FROM products WHERE id = 659 OR id = 507 ORDER BY id ASC;

INSERT INTO order_details (product_id, order_id, quantity, unit_price) VALUES
(659, 45, 2, 12.00),
(507, 45, 1, 59.99);

-- check trigger:
SELECT * FROM products WHERE id = 659 OR id = 507 ORDER BY id ASC;

COMMIT;
ROLLBACK;