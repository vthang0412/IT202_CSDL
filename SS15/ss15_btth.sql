drop database if exists mini_social_network;
create database mini_social_network;

use mini_social_network;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    like_count int default 0,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id) on delete cascade,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    user_id int,
    post_id int,
    created_at datetime default current_timestamp,
    primary key (user_id, post_id),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table friends (
    user_id int,
    friend_id int,
    status varchar(20) default 'pending',
    created_at datetime default current_timestamp,
    primary key (user_id, friend_id),
    check (status in ('pending','accepted')),
    check (user_id <> friend_id),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (friend_id) references users(user_id) on delete cascade
);
