insert into orders (order_id, customer_id, order_date, status, total_amount) values
(106, 1, '2024-02-10', 'completed', 5200000),
(107, 1, '2024-02-15', 'completed', 4300000),
(108, 2, '2024-02-18', 'completed', 6100000),
(109, 3, '2024-02-20', 'completed', 4800000),
(110, 3, '2024-02-22', 'completed', 4500000);

select
    c.customer_id,
    c.full_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_spent,
    avg(o.total_amount) as avg_order_value
from customers c
join orders o on c.customer_id = o.customer_id
where o.status = 'completed'
group by c.customer_id, c.full_name
having count(o.order_id) >= 1
   and sum(o.total_amount) > 10000000
order by total_spent desc;
