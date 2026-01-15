use social_network;

alter table posts
add column likes_count int default 0;

-- Bảng likes
create table if not exists likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    unique key unique_like (post_id, user_id),
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);
delimiter //

create procedure sp_like_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_count int;

    declare exit handler for sqlexception
    begin
        rollback;
        select 'like thất bại' as ket_qua;
    end;

    start transaction;

    select count(*) into v_count
    from posts
    where post_id = p_post_id;

    if v_count = 0 then
        signal sqlstate '45000'
        set message_text = 'Post không tồn tại';
    end if;

    select count(*) into v_count
    from users
    where user_id = p_user_id;

    if v_count = 0 then
        signal sqlstate '45000'
        set message_text = 'User không tồn tại';
    end if;

    insert into likes(post_id, user_id)
    values (p_post_id, p_user_id);

    update posts
    set likes_count = likes_count + 1
    where post_id = p_post_id;

    commit;
    select 'like thành công → đã commit' as ket_qua;
end //

delimiter ;

call sp_like_post(1, 1);
call sp_like_post(1, 1);
select * from likes;
select post_id, likes_count from posts;
