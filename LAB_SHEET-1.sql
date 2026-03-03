CREATE DATABASE customer_sale;
USE customer_sale;
CREATE TABLE Customer (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL
);

CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL,
    price INT NOT NULL CHECK (price > 0)
);

CREATE TABLE Sale (
    bill_no INT PRIMARY KEY,
    bill_date DATE NOT NULL,
    cust_id INT,
    item_id INT,
    qty_sold INT NOT NULL CHECK (qty_sold > 0),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);
INSERT INTO Customer VALUES
(1,'Aman'),
(2,'Riya'),
(3,'Karan'),
(4,'Sneha'),
(5,'Rahul'),
(6,'Priya'),
(7,'Vikas'),
(8,'Neha'),
(9,'Arjun'),
(10,'Pooja');
INSERT INTO Item VALUES
(101,'Pen',20),
(102,'Notebook',50),
(103,'Bag',800),
(104,'Shoes',1200),
(105,'Watch',1500),
(106,'Bottle',150),
(107,'Headphones',700),
(108,'Keyboard',900),
(109,'Mouse',400),
(110,'Charger',300);
INSERT INTO Sale VALUES
(1001,CURDATE(),1,101,5),
(1002,CURDATE(),2,103,1),
(1003,CURDATE(),3,104,2),
(1004,CURDATE(),4,102,3),
(1005,CURDATE(),5,105,1),
(1006,CURDATE()-1,6,109,2),
(1007,CURDATE()-2,7,108,1),
(1008,CURDATE()-3,8,110,4),
(1009,CURDATE(),9,107,2),
(1010,CURDATE(),10,106,6);
SELECT s.bill_no,
       s.bill_date,
       c.cust_name,
       s.item_id
FROM Sale s
JOIN Customer c ON s.cust_id = c.cust_id
WHERE s.bill_date = CURDATE();
SELECT s.bill_no,
       c.cust_name,
       i.item_name,
       s.qty_sold,
       i.price,
       (s.qty_sold * i.price) AS final_amount
FROM Sale s
JOIN Customer c ON s.cust_id = c.cust_id
JOIN Item i ON s.item_id = i.item_id;
SELECT DISTINCT c.cust_id,
       c.cust_name
FROM Customer c
JOIN Sale s ON c.cust_id = s.cust_id
JOIN Item i ON s.item_id = i.item_id
WHERE i.price > 200;
SELECT c.cust_id,
       c.cust_name,
       SUM(s.qty_sold) AS total_products
FROM Customer c
JOIN Sale s ON c.cust_id = s.cust_id
GROUP BY c.cust_id, c.cust_name;
SELECT i.item_name,
       s.qty_sold
FROM Sale s
JOIN Item i ON s.item_id = i.item_id
WHERE s.cust_id = 5;
SELECT DISTINCT i.item_id,
       i.item_name,
       i.price
FROM Item i
JOIN Sale s ON i.item_id = s.item_id
WHERE s.bill_date = CURDATE();
CREATE VIEW Bill_Details AS
SELECT s.bill_no,
       s.bill_date,
       s.cust_id,
       s.item_id,
       i.price,
       s.qty_sold,
       (i.price * s.qty_sold) AS amount
FROM Sale s
JOIN Item i ON s.item_id = i.item_id;
SELECT * FROM Bill_Details;
CREATE VIEW Weekly_Sales AS
SELECT s.bill_date,
       SUM(i.price * s.qty_sold) AS total_daily_sales
FROM Sale s
JOIN Item i ON s.item_id = i.item_id
WHERE s.bill_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY s.bill_date;
SELECT * FROM Weekly_Sales;