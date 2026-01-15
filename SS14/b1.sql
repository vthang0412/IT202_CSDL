drop database if exists social_network;
create database social_network;
use social_network;

-- Bảng users
create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

-- Bảng posts
create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

insert into users(username) values ('nguyen_van_a');

start transaction;

insert into posts(user_id, content)
values (1, 'Đây là bài viết hợp lệ');

update users
set posts_count = posts_count + 1
where user_id = 1;

commit;

select * from users;
select * from posts;

start transaction;

insert into posts(user_id, content)
values (999, 'Bài viết gây lỗi');

update users
set posts_count = posts_count + 1
where user_id = 999;

rollback;

select * from users;
select * from posts;
