explain analyze select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;
-- '-> Limit: 10 row(s)  (cost=2.04 rows=0.61) (actual time=0.114..0.219 rows=10 loops=1)\n    -> Nested loop inner join  (cost=2.04 rows=0.61) (actual time=0.113..0.216 rows=10 loops=1)\n        -> Filter: (u.hometown = \'Hà Nội\')  (cost=0.1 rows=0.1) (actual time=0.0581..0.13 rows=4 loops=1)\n            -> Index scan on u using username (reverse)  (cost=0.1 rows=1) (actual time=0.0509..0.117 rows=11 loops=1)\n        -> Index lookup on p using posts_fk_users (user_id=u.user_id)  (cost=0.994 rows=6.1) (actual time=0.0114..0.0199 rows=2.5 loops=4)\n'
create index idx_hometown on users(hometown);

explain analyze select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;
-- '-> Limit: 10 row(s)  (cost=12.3 rows=10) (actual time=0.186..0.235 rows=10 loops=1)\n    -> Nested loop inner join  (cost=12.3 rows=48.8) (actual time=0.185..0.234 rows=10 loops=1)\n        -> Sort: u.username DESC  (cost=1.43 rows=8) (actual time=0.154..0.155 rows=4 loops=1)\n            -> Index lookup on u using idx_hometown (hometown=\'Hà Nội\')  (cost=1.43 rows=8) (actual time=0.0514..0.0803 rows=8 loops=1)\n        -> Index lookup on p using posts_fk_users (user_id=u.user_id)  (cost=0.826 rows=6.1) (actual time=0.0101..0.0186 rows=2.5 loops=4)\n'

select u.username, p.post_id, p.content
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;