create index idx_user_gender on users(gender);

create view view_highly_interactive_users as
select u.user_id, u.username, count(c.comment_id) as comment_count
from users u
join comments c on u.user_id = c.user_id
group by u.user_id, u.username
having count(c.comment_id) > 5;

select * from view_highly_interactive_users;

select v.username, count(c.comment_id) as sum_comment_user
from view_highly_interactive_users v
join posts p on v.user_id = p.user_id
join comments c on p.post_id = c.post_id
group by v.username
order by sum_comment_user desc;