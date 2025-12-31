create database ss05;
use ss05;

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    status ENUM('active', 'inactive') DEFAULT 'active'
);

INSERT INTO Product (product_name, price, stock, status) VALUES
('Laptop Dell', 15000000, 10, 'active'),
('Chuột Logitech', 500000, 50, 'active'),
('Bàn phím cơ', 1200000, 20, 'active'),
('Màn hình cũ', 3000000, 5, 'inactive'),
('Tai nghe Bluetooth', 800000, 30, 'active');

SELECT *
FROM Product;

SELECT *
FROM Product
WHERE status = 'active';

SELECT *
FROM Product
WHERE price > 1000000;

SELECT *
FROM Product
WHERE status = 'active'
ORDER BY price ASC;
