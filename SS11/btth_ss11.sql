create database Sociallab;
use Sociallab;

create table posts (
    post_id int primary key auto_increment,
    content text,
    author varchar(255),
    likes_count int default 0
);

delimiter //

create procedure sp_createpost (
    p_content text,
    p_author varchar(255),
    out p_post_id int
)
begin
    insert into posts (content, author)
    values (p_content, p_author);

    set p_post_id = last_insert_id();
end //

delimiter ;

delimiter //

create procedure sp_searchpost (
    p_keyword varchar(255)
)
begin
    select *
    from posts
    where content like concat('%', p_keyword, '%');
end //

delimiter ;

delimiter //

create procedure sp_increaselike (
    p_post_id int,
    inout p_likes int
)
begin
    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    select likes_count
    into p_likes
    from posts
    where post_id = p_post_id;
end //

delimiter ;

delimiter //

create procedure sp_deletepost (
    p_post_id int
)
begin
    delete from posts
    where post_id = p_post_id;
end //

delimiter ;

call sp_createpost('hello everyone', 'thang', @post1_id);
call sp_createpost('this is a second post', 'admin', @post2_id);

select @post1_id as post1_id, @post2_id as post2_id;

call sp_searchpost('hello');

-- lấy số like hiện tại
select likes_count into @current_likes
from posts
where post_id = @post1_id;

-- tăng like
call sp_increaselike(@post1_id, @current_likes);

-- kiểm tra kết quả
select @current_likes as likes_after_update;

call sp_deletepost(@post2_id);

drop procedure if exists sp_createpost;
drop procedure if exists sp_searchpost;
drop procedure if exists sp_increaselike;
drop procedure if exists sp_deletepost;
