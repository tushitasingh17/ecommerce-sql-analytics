
-- ================================================
-- ECOMMERCE ANALYTICS DATABASE
-- Author:Tushita Singh
-- Tool: MySQL Workbench
-- ================================================

CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;

-- ================================================
-- PART 1: TABLE CREATION
-- ================================================

-- 1. CUSTOMERS
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    registration_date DATE,
    customer_segment VARCHAR(20)
);

-- 2. CATEGORIES
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50),
    parent_category VARCHAR(50)
);

-- 3. SUPPLIERS
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    rating DECIMAL(3,2)
);

-- 4. PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category_id INT,
    supplier_id INT,
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- 5. ORDERS
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    delivery_date DATE,
    status VARCHAR(20),
    payment_method VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 6. ORDER ITEMS
CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 7. RETURNS
CREATE TABLE returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    return_date DATE,
    reason VARCHAR(100),
    refund_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 8. REVIEWS
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    rating INT,
    review_date DATE,
    review_text VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ================================================
-- PART 2: DATA INSERTION
-- ================================================

-- CATEGORIES
INSERT INTO categories (category_name, parent_category) VALUES
('Smartphones', 'Electronics'),
('Laptops', 'Electronics'),
('Headphones', 'Electronics'),
('Televisions', 'Electronics'),
('Mens Clothing', 'Fashion'),
('Womens Clothing', 'Fashion'),
('Sports Shoes', 'Footwear'),
('Casual Shoes', 'Footwear'),
('Kitchen Appliances', 'Home & Kitchen'),
('Furniture', 'Home & Kitchen');

-- SUPPLIERS
INSERT INTO suppliers (supplier_name, city, state, rating) VALUES
('TechSource India', 'Mumbai', 'Maharashtra', 4.5),
('FashionHub Pvt Ltd', 'Surat', 'Gujarat', 4.2),
('HomeGoods Suppliers', 'Delhi', 'Delhi', 3.8),
('ElectroWholesale', 'Bengaluru', 'Karnataka', 4.7),
('StyleMart India', 'Chennai', 'Tamil Nadu', 4.0),
('KitchenPro Suppliers', 'Hyderabad', 'Telangana', 3.9),
('ShoeMakers Ltd', 'Agra', 'Uttar Pradesh', 4.3),
('FurnitureCo', 'Jaipur', 'Rajasthan', 4.1);

-- CUSTOMERS (50 customers)
INSERT INTO customers (customer_name, email, city, state, registration_date, customer_segment) VALUES
('Aarav Shah', 'aarav.shah@gmail.com', 'Mumbai', 'Maharashtra', '2021-01-15', 'Premium'),
('Priya Mehta', 'priya.mehta@gmail.com', 'Delhi', 'Delhi', '2021-02-20', 'Regular'),
('Rohit Sharma', 'rohit.sharma@gmail.com', 'Bengaluru', 'Karnataka', '2021-03-10', 'Premium'),
('Sneha Patel', 'sneha.patel@gmail.com', 'Ahmedabad', 'Gujarat', '2021-04-05', 'Regular'),
('Vikram Singh', 'vikram.singh@gmail.com', 'Chennai', 'Tamil Nadu', '2021-05-18', 'Budget'),
('Ananya Iyer', 'ananya.iyer@gmail.com', 'Hyderabad', 'Telangana', '2021-06-22', 'Premium'),
('Karan Gupta', 'karan.gupta@gmail.com', 'Pune', 'Maharashtra', '2021-07-14', 'Regular'),
('Deepika Nair', 'deepika.nair@gmail.com', 'Kolkata', 'West Bengal', '2021-08-30', 'Budget'),
('Arjun Reddy', 'arjun.reddy@gmail.com', 'Jaipur', 'Rajasthan', '2021-09-12', 'Regular'),
('Meera Krishnan', 'meera.krishnan@gmail.com', 'Lucknow', 'Uttar Pradesh', '2021-10-07', 'Premium'),
('Rahul Verma', 'rahul.verma@gmail.com', 'Mumbai', 'Maharashtra', '2021-11-19', 'Regular'),
('Pooja Desai', 'pooja.desai@gmail.com', 'Surat', 'Gujarat', '2021-12-25', 'Budget'),
('Aditya Kumar', 'aditya.kumar@gmail.com', 'Delhi', 'Delhi', '2022-01-08', 'Premium'),
('Kavya Rao', 'kavya.rao@gmail.com', 'Bengaluru', 'Karnataka', '2022-02-14', 'Regular'),
('Nikhil Joshi', 'nikhil.joshi@gmail.com', 'Pune', 'Maharashtra', '2022-03-22', 'Regular'),
('Divya Pillai', 'divya.pillai@gmail.com', 'Chennai', 'Tamil Nadu', '2022-04-17', 'Premium'),
('Siddharth Malhotra', 'siddharth.m@gmail.com', 'Hyderabad', 'Telangana', '2022-05-09', 'Budget'),
('Riya Kapoor', 'riya.kapoor@gmail.com', 'Kolkata', 'West Bengal', '2022-06-28', 'Regular'),
('Manish Tiwari', 'manish.tiwari@gmail.com', 'Jaipur', 'Rajasthan', '2022-07-15', 'Premium'),
('Shreya Bansal', 'shreya.bansal@gmail.com', 'Lucknow', 'Uttar Pradesh', '2022-08-03', 'Regular'),
('Amit Saxena', 'amit.saxena@gmail.com', 'Mumbai', 'Maharashtra', '2022-09-11', 'Budget'),
('Nisha Choudhary', 'nisha.c@gmail.com', 'Delhi', 'Delhi', '2022-10-20', 'Regular'),
('Raj Patel', 'raj.patel@gmail.com', 'Ahmedabad', 'Gujarat', '2022-11-05', 'Premium'),
('Sunita Mishra', 'sunita.mishra@gmail.com', 'Bengaluru', 'Karnataka', '2022-12-18', 'Regular'),
('Gaurav Khanna', 'gaurav.khanna@gmail.com', 'Pune', 'Maharashtra', '2023-01-25', 'Budget'),
('Pallavi Shetty', 'pallavi.shetty@gmail.com', 'Chennai', 'Tamil Nadu', '2023-02-12', 'Regular'),
('Vivek Menon', 'vivek.menon@gmail.com', 'Hyderabad', 'Telangana', '2023-03-08', 'Premium'),
('Tanvi Kulkarni', 'tanvi.kulkarni@gmail.com', 'Kolkata', 'West Bengal', '2023-04-19', 'Regular'),
('Harsh Vardhan', 'harsh.v@gmail.com', 'Jaipur', 'Rajasthan', '2023-05-27', 'Budget'),
('Anjali Bose', 'anjali.bose@gmail.com', 'Lucknow', 'Uttar Pradesh', '2023-06-14', 'Regular'),
('Suresh Nambiar', 'suresh.n@gmail.com', 'Mumbai', 'Maharashtra', '2023-07-02', 'Premium'),
('Leela Venkat', 'leela.v@gmail.com', 'Delhi', 'Delhi', '2023-08-16', 'Regular'),
('Pankaj Dubey', 'pankaj.d@gmail.com', 'Ahmedabad', 'Gujarat', '2023-09-23', 'Budget'),
('Swati Agarwal', 'swati.a@gmail.com', 'Bengaluru', 'Karnataka', '2023-10-11', 'Regular'),
('Nitin Bhatt', 'nitin.b@gmail.com', 'Pune', 'Maharashtra', '2023-11-07', 'Premium'),
('Rekha Pillai', 'rekha.p@gmail.com', 'Chennai', 'Tamil Nadu', '2023-12-29', 'Regular'),
('Sameer Qureshi', 'sameer.q@gmail.com', 'Hyderabad', 'Telangana', '2024-01-18', 'Budget'),
('Geeta Sharma', 'geeta.s@gmail.com', 'Kolkata', 'West Bengal', '2024-02-24', 'Regular'),
('Vinod Tiwari', 'vinod.t@gmail.com', 'Jaipur', 'Rajasthan', '2024-03-15', 'Premium'),
('Kavitha Rajan', 'kavitha.r@gmail.com', 'Lucknow', 'Uttar Pradesh', '2024-04-08', 'Regular'),
('Manoj Hegde', 'manoj.h@gmail.com', 'Mumbai', 'Maharashtra', '2024-05-21', 'Budget'),
('Usha Nair', 'usha.n@gmail.com', 'Delhi', 'Delhi', '2024-06-03', 'Regular'),
('Deepak Jain', 'deepak.j@gmail.com', 'Ahmedabad', 'Gujarat', '2024-07-17', 'Premium'),
('Priyanka Ghosh', 'priyanka.g@gmail.com', 'Bengaluru', 'Karnataka', '2024-08-09', 'Regular'),
('Rajesh Pandey', 'rajesh.p@gmail.com', 'Pune', 'Maharashtra', '2024-09-26', 'Budget'),
('Shalini Reddy', 'shalini.r@gmail.com', 'Chennai', 'Tamil Nadu', '2024-10-14', 'Regular'),
('Alok Mishra', 'alok.m@gmail.com', 'Hyderabad', 'Telangana', '2024-11-30', 'Premium'),
('Bharti Singh', 'bharti.s@gmail.com', 'Kolkata', 'West Bengal', '2024-12-06', 'Regular'),
('Chetan Solanki', 'chetan.s@gmail.com', 'Jaipur', 'Rajasthan', '2025-01-22', 'Budget'),
('Madhuri Deshpande', 'madhuri.d@gmail.com', 'Lucknow', 'Uttar Pradesh', '2025-02-11', 'Regular');

-- PRODUCTS (30 products)
INSERT INTO products (product_name, category_id, supplier_id, cost_price, selling_price, stock_quantity) VALUES
('Samsung Galaxy S23', 1, 1, 45000, 62999, 150),
('iPhone 14', 1, 4, 65000, 89999, 80),
('Redmi Note 12', 1, 1, 12000, 18999, 300),
('OnePlus Nord CE 3', 1, 4, 18000, 26999, 200),
('Dell Inspiron 15', 2, 4, 38000, 54999, 60),
('HP Pavilion 14', 2, 1, 35000, 49999, 75),
('Lenovo IdeaPad Slim 5', 2, 4, 32000, 44999, 90),
('MacBook Air M2', 2, 4, 85000, 114999, 40),
('Sony WH-1000XM5', 3, 4, 18000, 29999, 120),
('Boat Rockerz 550', 3, 1, 1500, 3999, 500),
('JBL Tune 760NC', 3, 4, 5000, 8999, 250),
('Samsung 55 inch 4K TV', 4, 4, 35000, 54999, 45),
('LG OLED 48 inch', 4, 1, 65000, 94999, 25),
('Peter England Formal Shirt', 5, 2, 600, 1799, 400),
('Allen Solly Chinos', 5, 2, 900, 2499, 350),
('Levis 511 Jeans', 5, 5, 1200, 3499, 300),
('Fabindia Kurta Set', 6, 2, 800, 2299, 280),
('W for Woman Dress', 6, 5, 700, 1999, 320),
('Biba Salwar Suit', 6, 2, 1000, 2799, 260),
('Nike Air Max', 7, 7, 4000, 8999, 180),
('Adidas Ultraboost', 7, 7, 5500, 12999, 140),
('Puma Running Shoes', 7, 7, 2500, 5999, 220),
('Woodland Casual Shoes', 8, 7, 1800, 4499, 190),
('Red Chief Loafers', 8, 7, 1200, 2999, 240),
('Prestige Induction Cooktop', 9, 6, 2000, 4499, 110),
('Philips Air Fryer', 9, 6, 4500, 8999, 85),
('Bajaj Mixer Grinder', 9, 6, 1200, 2799, 160),
('Godrej Refrigerator 260L', 9, 3, 18000, 27999, 30),
('Nilkamal Study Table', 10, 8, 3500, 7999, 55),
('Pepperfry 3 Seater Sofa', 10, 8, 18000, 34999, 20);

-- ORDERS (100 orders over 3 years)
INSERT INTO orders (customer_id, order_date, delivery_date, status, payment_method) VALUES
(1,'2022-01-05','2022-01-09','Delivered','UPI'),
(3,'2022-01-12','2022-01-16','Delivered','Credit Card'),
(5,'2022-01-20','2022-01-25','Delivered','COD'),
(2,'2022-02-03','2022-02-07','Delivered','Debit Card'),
(7,'2022-02-14','2022-02-18','Delivered','UPI'),
(10,'2022-02-28','2022-03-04','Delivered','Credit Card'),
(4,'2022-03-10','2022-03-14','Delivered','UPI'),
(8,'2022-03-22','2022-03-27','Delivered','COD'),
(12,'2022-04-05','2022-04-09','Delivered','UPI'),
(6,'2022-04-18','2022-04-22','Delivered','Credit Card'),
(15,'2022-05-02','2022-05-06','Delivered','Debit Card'),
(9,'2022-05-15','2022-05-19','Delivered','UPI'),
(11,'2022-05-28','2022-06-01','Delivered','COD'),
(13,'2022-06-10','2022-06-14','Delivered','Credit Card'),
(16,'2022-06-23','2022-06-27','Delivered','UPI'),
(1,'2022-07-04','2022-07-08','Delivered','UPI'),
(18,'2022-07-17','2022-07-21','Delivered','Debit Card'),
(20,'2022-07-30','2022-08-03','Delivered','COD'),
(3,'2022-08-12','2022-08-16','Delivered','Credit Card'),
(22,'2022-08-25','2022-08-29','Delivered','UPI'),
(14,'2022-09-07','2022-09-11','Delivered','UPI'),
(25,'2022-09-20','2022-09-24','Delivered','COD'),
(7,'2022-10-03','2022-10-07','Delivered','Credit Card'),
(17,'2022-10-16','2022-10-20','Delivered','UPI'),
(19,'2022-10-29','2022-11-02','Delivered','Debit Card'),
(2,'2022-11-11','2022-11-15','Delivered','UPI'),
(21,'2022-11-24','2022-11-28','Delivered','COD'),
(23,'2022-12-07','2022-12-11','Delivered','Credit Card'),
(10,'2022-12-20','2022-12-24','Delivered','UPI'),
(26,'2023-01-02','2023-01-06','Delivered','UPI'),
(5,'2023-01-15','2023-01-19','Delivered','COD'),
(28,'2023-01-28','2023-02-01','Delivered','Credit Card'),
(13,'2023-02-10','2023-02-14','Delivered','UPI'),
(30,'2023-02-23','2023-02-27','Delivered','Debit Card'),
(6,'2023-03-08','2023-03-12','Delivered','UPI'),
(32,'2023-03-21','2023-03-25','Delivered','COD'),
(15,'2023-04-03','2023-04-07','Delivered','Credit Card'),
(34,'2023-04-16','2023-04-20','Delivered','UPI'),
(8,'2023-04-29','2023-05-03','Delivered','UPI'),
(36,'2023-05-12','2023-05-16','Delivered','Debit Card'),
(19,'2023-05-25','2023-05-29','Delivered','COD'),
(38,'2023-06-07','2023-06-11','Delivered','Credit Card'),
(11,'2023-06-20','2023-06-24','Delivered','UPI'),
(40,'2023-07-03','2023-07-07','Delivered','UPI'),
(24,'2023-07-16','2023-07-20','Delivered','COD'),
(42,'2023-07-29','2023-08-02','Delivered','Credit Card'),
(16,'2023-08-11','2023-08-15','Delivered','UPI'),
(44,'2023-08-24','2023-08-28','Delivered','Debit Card'),
(27,'2023-09-06','2023-09-10','Delivered','UPI'),
(46,'2023-09-19','2023-09-23','Delivered','COD'),
(20,'2023-10-02','2023-10-06','Delivered','Credit Card'),
(48,'2023-10-15','2023-10-19','Delivered','UPI'),
(31,'2023-10-28','2023-11-01','Delivered','UPI'),
(50,'2023-11-10','2023-11-14','Delivered','COD'),
(33,'2023-11-23','2023-11-27','Delivered','Credit Card'),
(4,'2023-12-06','2023-12-10','Delivered','UPI'),
(35,'2023-12-19','2023-12-23','Delivered','Debit Card'),
(12,'2024-01-01','2024-01-05','Delivered','UPI'),
(37,'2024-01-14','2024-01-18','Delivered','COD'),
(22,'2024-01-27','2024-01-31','Delivered','Credit Card'),
(39,'2024-02-09','2024-02-13','Delivered','UPI'),
(26,'2024-02-22','2024-02-26','Delivered','UPI'),
(41,'2024-03-06','2024-03-10','Delivered','COD'),
(29,'2024-03-19','2024-03-23','Delivered','Credit Card'),
(43,'2024-04-01','2024-04-05','Delivered','UPI'),
(33,'2024-04-14','2024-04-18','Delivered','Debit Card'),
(45,'2024-04-27','2024-05-01','Delivered','UPI'),
(36,'2024-05-10','2024-05-14','Delivered','COD'),
(47,'2024-05-23','2024-05-27','Delivered','Credit Card'),
(38,'2024-06-05','2024-06-09','Delivered','UPI'),
(49,'2024-06-18','2024-06-22','Delivered','UPI'),
(40,'2024-07-01','2024-07-05','Delivered','COD'),
(1,'2024-07-14','2024-07-18','Delivered','Credit Card'),
(42,'2024-07-27','2024-07-31','Delivered','UPI'),
(3,'2024-08-09','2024-08-13','Delivered','Debit Card'),
(44,'2024-08-22','2024-08-26','Delivered','UPI'),
(7,'2024-09-04','2024-09-08','Delivered','COD'),
(46,'2024-09-17','2024-09-21','Delivered','Credit Card'),
(10,'2024-09-30','2024-10-04','Delivered','UPI'),
(48,'2024-10-13','2024-10-17','Delivered','UPI'),
(14,'2024-10-26','2024-10-30','Delivered','COD'),
(50,'2024-11-08','2024-11-12','Delivered','Credit Card'),
(18,'2024-11-21','2024-11-25','Delivered','UPI'),
(2,'2024-12-04','2024-12-08','Delivered','Debit Card'),
(23,'2024-12-17','2024-12-21','Delivered','UPI'),
(27,'2025-01-02','2025-01-06','Delivered','COD'),
(31,'2025-01-15','2025-01-19','Delivered','Credit Card'),
(35,'2025-01-28','2025-02-01','Delivered','UPI'),
(39,'2025-02-10','2025-02-14','Delivered','UPI'),
(43,'2025-02-23','2025-02-27','Delivered','COD'),
(47,'2025-03-08','2025-03-12','Delivered','Credit Card'),
(6,'2025-03-21','2025-03-25','Delivered','UPI'),
(9,'2025-04-03','2025-04-07','Delivered','Debit Card'),
(13,'2025-04-16','2025-04-20','Delivered','UPI'),
(17,'2025-04-29','2025-05-03','Delivered','COD'),
(21,'2025-05-12','2025-05-16','Delivered','Credit Card'),
(25,'2025-05-25','2025-05-29','Delivered','UPI');

-- ORDER ITEMS
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent) VALUES
(1,1,1,62999,5),(1,9,1,29999,0),
(2,8,1,114999,10),(2,11,1,8999,5),
(3,14,2,1799,0),(3,23,1,4499,10),
(4,5,1,54999,8),(4,10,2,3999,0),
(5,17,2,2299,5),(5,22,1,5999,0),
(6,2,1,89999,12),(6,9,1,29999,5),
(7,16,1,3499,0),(7,24,1,2999,10),
(8,19,1,8999,5),(8,14,3,1799,0),
(9,25,1,4499,0),(9,27,1,2799,5),
(10,3,1,18999,0),(10,10,1,3999,0),
(11,6,1,49999,7),(11,11,1,8999,0),
(12,20,1,8999,10),(12,15,2,2499,5),
(13,12,1,54999,5),(13,29,1,7999,0),
(14,4,1,26999,0),(14,22,1,5999,5),
(15,18,2,1999,0),(15,24,1,2999,0),
(16,1,1,62999,5),(16,10,2,3999,10),
(17,28,1,27999,8),(17,27,1,2799,0),
(18,15,1,2499,0),(18,23,1,4499,5),
(19,7,1,44999,6),(19,11,1,8999,0),
(20,21,1,12999,10),(20,16,1,3499,0),
(21,13,1,94999,15),(21,9,1,29999,5),
(22,26,1,8999,0),(22,25,1,4499,5),
(23,3,2,18999,5),(23,14,2,1799,0),
(24,30,1,34999,10),(24,27,1,2799,0),
(25,19,1,8999,0),(25,15,2,2499,5),
(26,5,1,54999,8),(26,10,1,3999,0),
(27,17,1,2299,0),(27,22,1,5999,10),
(28,2,1,89999,12),(28,11,1,8999,0),
(29,20,1,8999,5),(29,16,1,3499,0),
(30,4,1,26999,0),(30,23,1,4499,5),
(31,14,3,1799,0),(31,24,1,2999,0),
(32,6,1,49999,7),(32,9,1,29999,5),
(33,1,1,62999,5),(33,27,1,2799,0),
(34,25,1,4499,0),(34,15,2,2499,5),
(35,12,1,54999,5),(35,10,1,3999,0),
(36,21,1,12999,10),(36,18,1,1999,0),
(37,7,1,44999,6),(37,22,1,5999,5),
(38,28,1,27999,8),(38,11,1,8999,0),
(39,3,1,18999,0),(39,16,1,3499,5),
(40,19,1,8999,5),(40,14,2,1799,0),
(41,13,1,94999,15),(41,27,1,2799,0),
(42,5,1,54999,8),(42,10,1,3999,5),
(43,30,1,34999,10),(43,23,1,4499,0),
(44,20,1,8999,0),(44,15,1,2499,5),
(45,2,1,89999,12),(45,9,1,29999,0),
(46,26,1,8999,5),(46,24,1,2999,0),
(47,4,1,26999,0),(47,22,1,5999,10),
(48,17,2,2299,5),(48,16,1,3499,0),
(49,1,1,62999,5),(49,11,1,8999,0),
(50,8,1,114999,10),(50,27,1,2799,5),
(51,14,2,1799,0),(51,23,1,4499,0),
(52,6,1,49999,7),(52,10,2,3999,5),
(53,21,1,12999,10),(53,15,1,2499,0),
(54,3,1,18999,0),(54,24,1,2999,5),
(55,12,1,54999,5),(55,9,1,29999,0),
(56,19,1,8999,0),(56,16,1,3499,5),
(57,5,1,54999,8),(57,22,1,5999,0),
(58,28,1,27999,8),(58,11,1,8999,5),
(59,7,1,44999,6),(59,27,1,2799,0),
(60,25,1,4499,0),(60,14,2,1799,5),
(61,2,1,89999,12),(61,10,1,3999,0),
(62,30,1,34999,10),(62,23,1,4499,5),
(63,4,1,26999,0),(63,15,2,2499,0),
(64,20,1,8999,5),(64,16,1,3499,0),
(65,13,1,94999,15),(65,9,1,29999,5),
(66,26,1,8999,0),(66,24,1,2999,0),
(67,1,1,62999,5),(67,22,1,5999,10),
(68,17,2,2299,0),(68,11,1,8999,0),
(69,6,1,49999,7),(69,27,1,2799,5),
(70,3,2,18999,5),(70,14,1,1799,0),
(71,8,1,114999,10),(71,10,1,3999,0),
(72,19,1,8999,0),(72,15,1,2499,5),
(73,21,1,12999,10),(73,16,1,3499,0),
(74,5,1,54999,8),(74,23,1,4499,5),
(75,28,1,27999,8),(75,9,1,29999,0),
(76,12,1,54999,5),(76,24,1,2999,0),
(77,2,1,89999,12),(77,22,1,5999,5),
(78,4,1,26999,0),(78,11,1,8999,0),
(79,25,1,4499,5),(79,16,1,3499,0),
(80,7,1,44999,6),(80,27,1,2799,5),
(81,20,1,8999,0),(81,14,2,1799,0),
(82,30,1,34999,10),(82,10,1,3999,5),
(83,3,1,18999,0),(83,15,1,2499,0),
(84,13,1,94999,15),(84,23,1,4499,5),
(85,1,1,62999,5),(85,9,1,29999,0),
(86,6,1,49999,7),(86,11,1,8999,0),
(87,19,1,8999,5),(87,24,1,2999,0),
(88,26,1,8999,0),(88,16,1,3499,5),
(89,5,1,54999,8),(89,22,1,5999,0),
(90,17,1,2299,0),(90,27,1,2799,5),
(91,8,1,114999,10),(91,10,1,3999,0),
(92,21,1,12999,10),(92,14,1,1799,5),
(93,4,1,26999,0),(93,15,2,2499,0),
(94,28,1,27999,8),(94,9,1,29999,5),
(95,12,1,54999,5),(95,23,1,4499,0),
(96,2,1,89999,12),(96,11,1,8999,0),
(97,20,1,8999,0),(97,16,1,3499,5),
(98,7,1,44999,6),(98,24,1,2999,0),
(99,25,1,4499,5),(99,22,1,5999,0),
(100,3,1,18999,0),(100,27,1,2799,5);

SET FOREIGN_KEY_CHECKS = 1;

-- RETURNS
INSERT INTO returns (order_id, product_id, return_date, reason, refund_amount) VALUES
(2,8,'2022-01-20','Defective product',114999),
(6,2,'2022-03-07','Not as described',89999),
(11,6,'2022-06-04','Wrong item delivered',49999),
(21,13,'2022-09-14','Defective product',94999),
(28,2,'2022-12-19','Changed mind',89999),
(32,6,'2023-04-01','Defective product',49999),
(45,2,'2023-08-22','Not as described',89999),
(50,8,'2023-11-24','Defective product',114999),
(65,13,'2024-05-07','Wrong item delivered',94999),
(71,8,'2024-08-19','Defective product',114999),
(77,2,'2024-12-16','Changed mind',89999),
(84,13,'2025-01-31','Not as described',94999),
(91,8,'2025-03-22','Defective product',114999),
(96,2,'2025-04-24','Defective product',89999);

-- REVIEWS
INSERT INTO reviews (customer_id, product_id, rating, review_date, review_text) VALUES
(1,1,5,'2022-01-10','Excellent phone, very fast'),
(3,8,2,'2022-01-20','Had to return it, stopped working'),
(5,14,4,'2022-01-28','Good quality shirt'),
(2,5,5,'2022-02-10','Great laptop for the price'),
(7,17,4,'2022-02-20','Nice kurta, good fabric'),
(10,2,3,'2022-03-06','Expensive but good'),
(4,16,5,'2022-03-17','Perfect fit jeans'),
(8,19,4,'2022-03-30','Comfortable running shoes'),
(12,25,5,'2022-04-12','Works great, heats up fast'),
(6,3,4,'2022-04-25','Good phone for the price'),
(15,6,4,'2022-05-09','Solid laptop, good battery'),
(9,20,5,'2022-05-22','Best running shoes I own'),
(11,14,3,'2022-06-04','Average quality'),
(13,12,5,'2022-06-17','Picture quality is amazing'),
(16,18,4,'2022-06-30','Beautiful dress'),
(1,10,5,'2022-07-11','Great sound for the price'),
(18,28,4,'2022-07-24','Fridge working well'),
(20,15,5,'2022-08-06','Perfect chinos'),
(3,7,4,'2022-08-19','Good laptop'),
(22,21,5,'2022-09-01','Amazing shoes'),
(14,13,2,'2022-09-14','Had to return, was defective'),
(25,26,5,'2022-09-27','Air fryer is a game changer'),
(7,3,4,'2022-10-10','Decent phone'),
(17,30,3,'2022-10-23','Sofa quality could be better'),
(19,19,5,'2022-11-05','Love these shoes'),
(2,2,4,'2022-11-18','iPhone is always reliable'),
(21,27,5,'2022-12-01','Mixer works perfectly'),
(23,20,4,'2022-12-14','Good shoes'),
(10,9,5,'2022-12-27','Best headphones ever'),
(26,4,4,'2023-01-09','Good phone, smooth performance');


-- Check row counts in all 8 tables
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;