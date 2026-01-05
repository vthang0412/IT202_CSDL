insert into order_items values
(106, 1, 5),
(106, 3, 4),
(107, 1, 6),
(108, 2, 5),
(109, 2, 4);

select
    p.product_name,
    sum(oi.quantity) as total_sold,
    sum(oi.quantity * p.price) as total_revenue,
    avg(p.price) as avg_price
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.status = 'completed'
group by p.product_id, p.product_name
having sum(oi.quantity) >= 10
order by total_revenue desc
limit 5;
