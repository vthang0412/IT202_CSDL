create view view_user_activity_status as
select 
  user_id, 
  username, 
  gender, 
  created_at,
  case 
    when exists(select 1 from posts where posts.user_id = users.user_id) 
      or exists(select 1 from comments where comments.user_id = users.user_id) 
    then 'Active'
    else 'Inactive'
  end as status
from users;

select * from view_user_activity_status;

select status, count(*) as user_count
from view_user_activity_status
group by status
order by user_count desc;