CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') NOT NULL
);

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 1500000, '2024-08-01', 'completed'),
(2, 3200000, '2024-08-02', 'pending'),
(3, 2800000, '2024-08-03', 'completed'),
(4, 4500000, '2024-08-04', 'cancelled'),
(5, 5200000, '2024-08-05', 'completed'),
(6, 1800000, '2024-08-06', 'pending'),
(7, 7600000, '2024-08-07', 'completed'),
(8, 2100000, '2024-08-08', 'completed'),
(9, 3900000, '2024-08-09', 'cancelled'),
(10, 6400000, '2024-08-10', 'completed'),
(11, 1700000, '2024-08-11', 'pending'),
(12, 8800000, '2024-08-12', 'completed'),
(13, 2500000, '2024-08-13', 'completed'),
(14, 4100000, '2024-08-14', 'pending'),
(15, 9900000, '2024-08-15', 'completed');

SELECT *
FROM orders
WHERE status = 'completed';

SELECT *
FROM orders
WHERE total_amount > 5000000;

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;

SELECT *
FROM orders
WHERE status = 'completed'
ORDER BY total_amount DESC;
