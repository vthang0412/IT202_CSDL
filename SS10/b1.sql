create view view_users_firstname as
select user_id, username, full_name, email, created_at
from users
where full_name like 'Nguyễn%';

select * from view_users_firstname;

insert into users (username, full_name, email, password, gender, hometown) 
values ('nguyena', 'Nguyễn Văn A', 'nguyenmoi@test.com', '123456', 'Nam', 'Hà Nội');
select * from view_users_firstname;

delete from users where username = 'nguyena';
select * from view_users_firstname;
