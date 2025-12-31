
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    city VARCHAR(255),
    status ENUM('active', 'inactive') DEFAULT 'active'
);

INSERT INTO customers (full_name, email, city, status) VALUES
('Nguyễn Văn An', 'an@gmail.com', 'TP.HCM', 'active'),
('Trần Thị Bình', 'binh@gmail.com', 'Hà Nội', 'active'),
('Lê Văn Cường', 'cuong@gmail.com', 'Đà Nẵng', 'inactive'),
('Phạm Thị Dung', 'dung@gmail.com', 'TP.HCM', 'active'),
('Hoàng Văn Em', 'em@gmail.com', 'Hà Nội', 'inactive');

SELECT *
FROM customers;

SELECT *
FROM customers
WHERE city = 'TP.HCM';

SELECT *
FROM customers
WHERE status = 'active'
  AND city = 'Hà Nội';

SELECT *
FROM customers
ORDER BY full_name ASC;
