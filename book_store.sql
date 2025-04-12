-- creating the database
CREATE DATABASE Book_store;

-- select database to use
use Book_store;

-- creating roles
CREATE ROLE 'developers', 'supervisors', 'sales';

-- Granting privileges to the different roles
GRANT ALL PRIVILEGES ON Book_store.* TO 'developers';
GRANT SELECT, INSERT, DELETE, UPDATE ON Book_store.* TO 'supervisors';
GRANT SELECT, INSERT ON Book_store.* TO 'sales';

-- creating users
CREATE USER
-- developers
'Developer_1'@'localhost' IDENTIFIED BY '123456',
'Developer_2'@'localhost' IDENTIFIED BY '123456',

-- supervisors
'super_1'@'localhost' IDENTIFIED BY 'super_pass1',
'super_2'@'localhost' IDENTIFIED BY 'super_pass2',
'super_3'@'localhost' IDENTIFIED BY 'super_pass3',

-- sales
'sales_1'@'localhost' IDENTIFIED BY 'sale_pass1',
'sales_2'@'localhost' IDENTIFIED BY 'sale_pass2',
'sales_3'@'localhost' IDENTIFIED BY 'sale_pass3',
'sales_4'@'localhost' IDENTIFIED BY 'sale_pass4';

-- Assigning roles to the users
GRANT 'developers' TO 'Developer_1'@'localhost', 'Developer_2'@'localhost';
GRANT 'supervisors' TO 'super_1'@'localhost', 'super_2'@'localhost', 'super_3'@'localhost';
GRANT 'sales' TO 'sales_1'@'localhost', 'sales_2'@'localhost', 'sales_3'@'localhost', 'sales_4'@'localhost';

-- set default roles
SET DEFAULT ROLE 'developers' TO  'Developer_1'@'localhost', 'Developer_2'@'localhost';
SET DEFAULT ROLE 'supervisors' TO 'super_1'@'localhost', 'super_2'@'localhost', 'super_3'@'localhost';
SET DEFAULT ROLE 'sales' TO 'sales_1'@'localhost', 'sales_2'@'localhost', 'sales_3'@'localhost', 'sales_4'@'localhost';

-- 1. creating publisher table
CREATE TABLE publisher(
publisher_id INT PRIMARY KEY AUTO_INCREMENT,
publisher_name VARCHAR(100)
);

-- 2. creating book_language table
CREATE TABLE book_language(
language_id INT PRIMARY KEY AUTO_INCREMENT,
language VARCHAR(50)
);

-- 3. creating author table
CREATE TABLE author(
author_id INT PRIMARY KEY AUTO_INCREMENT,
author_name VARCHAR(100)
);

-- 4. creating book table
CREATE TABLE book(
book_id INT PRIMARY KEY AUTO_INCREMENT,
book_title VARCHAR(100),
no_books INT,
price DECIMAL(5, 2),
publisher_id INT,
language_id INT,
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 5. joining table book_author
CREATE TABLE book_author(
ID INT PRIMARY KEY AUTO_INCREMENT,
author_id INT,
book_id INT,
FOREIGN KEY (author_id) REFERENCES author(author_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 6. creating the adress status table
CREATE TABLE address_status(
status_id INT PRIMARY KEY AUTO_INCREMENT,
address_status ENUM('active','inactive')
);

-- 7. creating the country table
CREATE TABLE country(
country_id INT PRIMARY KEY AUTO_INCREMENT,
country_name VARCHAR(50)
);

-- 8. creating the address table
CREATE TABLE address(
address_id INT PRIMARY KEY AUTO_INCREMENT,
street VARCHAR(100),
city VARCHAR(100),
postal_code INT,
country_id INT,
status_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id),
FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 9. creating customer_address table
CREATE TABLE customer_address (
customer_address_id INT PRIMARY KEY,
address_id INT,
status_id INT,
country_id INT,
FOREIGN KEY (address_id) REFERENCES address(address_id),
FOREIGN KEY (status_id) REFERENCES address_status(status_id),
FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 10. creating customer table
CREATE TABLE customer(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(100),
customer_email VARCHAR(100) UNIQUE,
customer_address_id INT,
FOREIGN KEY (customer_address_id) REFERENCES customer_address(customer_address_id)
);

-- 11. creating shipping method
CREATE TABLE shipping_method(
ID INT PRIMARY KEY AUTO_INCREMENT,
shipping ENUM('LAND','SEA','AIR')
);

-- 12. creating order status table
CREATE TABLE order_status(
order_status_id INT PRIMARY KEY AUTO_INCREMENT,
order_state ENUM('active', 'cancelled')
);

-- 13. customer order table
CREATE TABLE cust_order (
order_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
customer_id INT,
shipping_method_id INT,
status_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(ID),
FOREIGN KEY (status_id) REFERENCES order_status(order_status_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 14. creating order_line table
CREATE TABLE order_line (
order_line_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
quantity INT,
FOREIGN KEY (book_id) REFERENCES cust_order(book_id)
);

 -- 15. creating order_history table
CREATE TABLE order_history (
history_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
status_id INT,
book_id INT,
changed_on DATETIME,
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (book_id) REFERENCES cust_order(book_id),
FOREIGN KEY (status_id) REFERENCES order_status(order_status_id)
);







