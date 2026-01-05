/* =========================================================
   FILE SQL: ecommerce_practice.sql
   MÔN HỌC : CƠ SỞ DỮ LIỆU / SQL
   CHỦ ĐỀ  : JOIN – AGGREGATE – GROUP BY – HAVING
   MÔ TẢ   : CSDL mẫu hệ thống thương mại điện tử (eCommerce)
   ========================================================= */


/* =========================================================
   1. TẠO CƠ SỞ DỮ LIỆU
   ========================================================= */

CREATE DATABASE btth_ss06;
USE btth_ss06;


/* =========================================================
   2. TẠO BẢNG KHÁCH HÀNG
   ========================================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,        -- Mã khách hàng
    customer_name VARCHAR(100),            -- Tên khách hàng
    email         VARCHAR(100),            -- Email
    city          VARCHAR(50)               -- Thành phố
);


/* =========================================================
   3. TẠO BẢNG SẢN PHẨM
   ========================================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,          -- Mã sản phẩm
    product_name VARCHAR(100),              -- Tên sản phẩm
    price        DECIMAL(12,2),              -- Giá bán
    category     VARCHAR(50)                -- Loại sản phẩm
);


/* =========================================================
   4. TẠO BẢNG ĐƠN HÀNG
   ========================================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,            -- Mã đơn hàng
    customer_id INT,                        -- Khách hàng đặt
    order_date  DATE,                       -- Ngày đặt hàng
    status      VARCHAR(30),                -- Trạng thái đơn
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* =========================================================
   5. TẠO BẢNG CHI TIẾT ĐƠN HÀNG
   ========================================================= */

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,          -- Mã chi tiết đơn
    order_id      INT,                      -- Mã đơn hàng
    product_id    INT,                      -- Mã sản phẩm
    quantity      INT,                      -- Số lượng
    unit_price    DECIMAL(12,2),             -- Giá bán tại thời điểm đặt
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* =========================================================
   6. DỮ LIỆU MẪU - KHÁCH HÀNG
   ========================================================= */

INSERT INTO customers VALUES
(1, 'Nguyen Van An',  'an@gmail.com',   'Ha Noi'),
(2, 'Tran Thi Binh',  'binh@gmail.com', 'Da Nang'),
(3, 'Le Van Cuong',   'cuong@gmail.com','Ho Chi Minh'),
(4, 'Pham Thi Dao',   'dao@gmail.com',  'Ha Noi'),
(5, 'Hoang Van Em',   'em@gmail.com',   'Can Tho');


/* =========================================================
   7. DỮ LIỆU MẪU - SẢN PHẨM
   ========================================================= */

INSERT INTO products VALUES
(1, 'Laptop Dell',          20000000, 'Electronics'),
(2, 'iPhone 15',            25000000, 'Electronics'),
(3, 'Tai nghe Bluetooth',    1500000, 'Accessories'),
(4, 'Chuột không dây',        500000, 'Accessories'),
(5, 'Bàn phím cơ',           2000000, 'Accessories');


/* =========================================================
   8. DỮ LIỆU MẪU - ĐƠN HÀNG
   ========================================================= */

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 'Completed'),
(102, 2, '2025-01-06', 'Completed'),
(103, 3, '2025-01-07', 'Completed'),
(104, 1, '2025-01-08', 'Completed'),
(105, 4, '2025-01-09', 'Completed'),
(106, 5, '2025-01-10', 'Completed'),
(107, 2, '2025-01-11', 'Completed'),
(108, 3, '2025-01-12', 'Completed');


/* =========================================================
   9. DỮ LIỆU MẪU - CHI TIẾT ĐƠN HÀNG
   ========================================================= */

INSERT INTO order_items VALUES
-- Đơn 101
(1, 101, 1, 1, 20000000),
(2, 101, 3, 2, 1500000),

-- Đơn 102
(3, 102, 2, 1, 25000000),
(4, 102, 4, 1, 500000),

-- Đơn 103
(5, 103, 5, 2, 2000000),
(6, 103, 3, 1, 1500000),

-- Đơn 104
(7, 104, 1, 1, 20000000),
(8, 104, 5, 1, 2000000),

-- Đơn 105
(9, 105, 4, 3, 500000),

-- Đơn 106
(10, 106, 3, 5, 1500000),

-- Đơn 107
(11, 107, 2, 1, 25000000),
(12, 107, 3, 2, 1500000),

-- Đơn 108
(13, 108, 1, 1, 20000000),
(14, 108, 4, 2, 500000);


/* =========================================================
   10. KIỂM TRA NHANH DỮ LIỆU (OPTIONAL)
   ========================================================= */

-- Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products  FROM products;
SELECT COUNT(*) AS total_orders    FROM orders;
SELECT COUNT(*) AS total_items     FROM order_items;

select
    o.order_id,
    o.order_date,
    c.customer_name
from orders o
join customers c on o.customer_id = c.customer_id;

select
    o.order_id,
    p.product_name,
    oi.quantity
from orders o
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id;

select count(*) as total_orders
from orders;

select
    sum(oi.quantity * oi.unit_price) as total_revenue
from order_items oi;

select
    o.order_id,
    sum(oi.quantity * oi.unit_price) as total_amount
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id;

select
    c.customer_name,
    sum(oi.quantity * oi.unit_price) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name;

select
    p.product_name,
    sum(oi.quantity * oi.unit_price) as revenue
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_name;

select
    c.customer_name,
    sum(oi.quantity * oi.unit_price) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_name
having sum(oi.quantity * oi.unit_price) > 5000000;

select
    p.product_name,
    sum(oi.quantity) as total_quantity
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_name
having sum(oi.quantity) > 100;

select
    c.city,
    count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.city
having count(o.order_id) > 5;


