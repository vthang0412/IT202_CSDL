select
    order_date,
    sum(total_amount) as total_revenue,
    count(order_id) as total_orders
from orders
where status = 'completed'
group by order_date;

select
    order_date,
    sum(total_amount) as total_revenue,
    count(order_id) as total_orders
from orders
where status = 'completed'
group by order_date
having sum(total_amount) > 10000000;

insert into orders (order_id, customer_id, order_date, status, total_amount) values
(111, 1, '2024-02-25', 'completed', 3000000),
(112, 2, '2024-02-25', 'completed', 2500000),
(113, 3, '2024-02-25', 'completed', 2800000),
(114, 1, '2024-02-25', 'completed', 2200000),
(115, 2, '2024-02-25', 'completed', 1800000);
