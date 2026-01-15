use social_network;

alter table posts
add column comments_count int default 0;

create table if not exists comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

delimiter //

create procedure sp_post_comment(
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    declare v_post_count int;
    declare v_user_count int;
    declare v_update_ok int default 1;

    declare exit handler for sqlexception
    begin
        rollback;
        select 'rollback toàn bộ giao dịch' as ket_qua;
    end;

    start transaction;

    select count(*) into v_post_count
    from posts
    where post_id = p_post_id;

    if v_post_count = 0 then
        signal sqlstate '45000'
        set message_text = 'post không tồn tại';
    end if;

    select count(*) into v_user_count
    from users
    where user_id = p_user_id;

    if v_user_count = 0 then
        signal sqlstate '45000'
        set message_text = 'user không tồn tại';
    end if;

    insert into comments(post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    savepoint after_insert;

    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    if row_count() = 0 then
        rollback to after_insert;
        set v_update_ok = 0;
    end if;

    if v_update_ok = 1 then
        commit;
        select 'commit thành công' as ket_qua;
    else
        commit;
        select 'rollback partial: chỉ thêm comment, không cập nhật count' as ket_qua;
    end if;

end //

delimiter ;


call sp_post_comment(1, 1, 'Bình luận hợp lệ');
call sp_post_comment(1, 1, 'Test savepoint');

select * from comments;
select post_id, comments_count from posts;
