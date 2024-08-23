CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE shippings(
    id SERIAL PRIMARY KEY,
    customer_id INT UNIQUE, 
    street_address VARCHAR(100),
    city VARCHAR(50),
    state_district VARCHAR(100),
    post_code VARCHAR(50),
    country CHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE  orders(
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    is_shipped BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL
);

CREATE TABLE payments(
    id SERIAL PRIMARY KEY,
    method VARCHAR(50)
);

CREATE TABLE payment_orders(
    payment_id INT,
    order_id INT,
    PRIMARY KEY (payment_id, order_id),
    FOREIGN KEY (payment_id) REFERENCES payments(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE vendors(
    id SERIAL PRIMARY KEY, 
    vendor_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    vendor_id INT,
    price NUMERIC(7, 2) NOT NULL,
    product_name VARCHAR(200) NOT NULL,
    product_description TEXT,
    stock INT NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES vendors(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE product_category (
    product_id INT,
    category_id INT,
    PRIMARY KEY(product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    id SERIAL PRIMARY KEY, 
    product_id INT,
    order_id INT,
    quantity INT NOT NULL,
    unit_price NUMERIC(5, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);