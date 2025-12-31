CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    sold_quantity INT DEFAULT 0
);

INSERT INTO products (product_name, price, sold_quantity) VALUES
('Laptop Dell', 15000000, 120),
('iPhone 13', 18000000, 200),
('Tai nghe Bluetooth', 800000, 350),
('Chuột Logitech', 500000, 420),
('Bàn phím cơ', 1200000, 310),
('Màn hình Samsung', 3500000, 180),
('Sạc nhanh', 300000, 500),
('USB 64GB', 250000, 600),
('Ổ cứng SSD', 2200000, 260),
('Loa Bluetooth', 900000, 290),
('Webcam', 700000, 150),
('Router Wifi', 1300000, 170);

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 10;

SELECT *
FROM products
ORDER BY sold_quantity DESC
LIMIT 5 OFFSET 10;

SELECT *
FROM products
WHERE price < 2000000
ORDER BY sold_quantity DESC;
