create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into products values
(1, 'dien thoai', 6000000),
(2, 'laptop', 15000000),
(3, 'tai nghe', 1000000),
(4, 'chuot', 500000),
(5, 'ban phim', 800000);

insert into order_items values
(101, 1, 2),
(101, 3, 3),
(102, 2, 1),
(103, 1, 3),
(104, 5, 4),
(105, 2, 2);

select
    p.product_id,
    p.product_name,
    sum(oi.quantity) as total_sold
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;

select
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price) as revenue
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
