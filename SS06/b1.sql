create database ss06;
use ss06;

create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers values
(1, 'nguyen van a', 'ha noi'),
(2, 'tran thi b', 'hai phong'),
(3, 'le van c', 'da nang'),
(4, 'pham thi d', 'ha noi'),
(5, 'hoang van e', 'tp hcm');

insert into orders values
(101, 1, '2024-01-10', 'completed'),
(102, 1, '2024-01-15', 'pending'),
(103, 2, '2024-01-20', 'completed'),
(104, 3, '2024-02-01', 'cancelled'),
(105, 3, '2024-02-05', 'completed');

select
    o.order_id,
    o.order_date,
    o.status,
    c.full_name
from orders o
join customers c on o.customer_id = c.customer_id;

select
    c.customer_id,
    c.full_name,
    count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

select
    c.customer_id,
    c.full_name,
    count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 1;
