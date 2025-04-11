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









