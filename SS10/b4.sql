explain analyze select post_id, content, created_at 
from posts 
where user_id = 1 and year(created_at) = 2026;
-- '-> Filter: (year(posts.created_at) = 2026)  (cost=1.65 rows=9) (actual time=0.0233..0.0412 rows=9 loops=1)\n    
-- -> Index lookup on posts using posts_fk_users (user_id=1)  (cost=1.65 rows=9) (actual time=0.0199..0.0366 rows=9 loops=1)\n'
create index idx_created_at_user_id on posts(user_id, created_at);

explain analyze select post_id, content, created_at 
from posts 
where user_id = 1 and year(created_at) = 2026;
-- '-> Filter: (year(posts.created_at) = 2026)  (cost=1.65 rows=9) (actual time=0.0578..0.103 rows=9 loops=1)\n    
-- -> Index lookup on posts using posts_fk_users (user_id=1)  (cost=1.65 rows=9) (actual time=0.055..0.0985 rows=9 loops=1)\n'
explain analyze select user_id, username, email 
from users 
where email = 'anh@gmail.com';
-- '-> Rows fetched before execution  (cost=0..0 rows=1) (actual time=300e-6..400e-6 rows=1 loops=1)\n'
create unique index idx_email on users(email);

explain analyze select user_id, username, email 
from users 
where email = 'anh@gmail.com';
-- '-> Rows fetched before execution  (cost=0..0 rows=1) (actual time=100e-6..200e-6 rows=1 loops=1)\n'

drop index idx_created_at_user_id on posts;
drop index idx_email on users;
