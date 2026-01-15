use social_network;

create table if not exists delete_log (
    log_id int primary key auto_increment,
    post_id int not null,
    deleted_by int not null,
    deleted_at datetime default current_timestamp
);

delimiter //

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_owner_id int;
	declare v_posts_count int;

    declare exit handler for sqlexception
    begin
        rollback;
        select 'xóa bài viết thất bại và thực hiện rollback' as ket_qua;
    end;

    start transaction;

    select user_id
    into v_owner_id
    from posts
    where post_id = p_post_id;

    if v_owner_id is null then
        signal sqlstate '45000'
        set message_text = 'bài viết không tồn tại';
    end if;

    if v_owner_id <> p_user_id then
        signal sqlstate '45000'
        set message_text = 'không có quyền xóa bài viết này';
    end if;

    delete from likes
    where post_id = p_post_id;

    delete from comments
    where post_id = p_post_id;

    delete from posts
    where post_id = p_post_id;

	select posts_count
	into v_posts_count
	from users
	where user_id = p_user_id;

	if v_posts_count > 0 then
		update users
		set posts_count = posts_count - 1
		where user_id = p_user_id;
	end if;

    insert into delete_log(post_id, deleted_by)
    values (p_post_id, p_user_id);

    commit;
    select 'xóa bài viết thành công và thực hiện commit' as ket_qua;
end //

delimiter ;

insert into posts (user_id, content)
values (1, 'bài viết sắp bị xóa');

set @new_post_id = last_insert_id();

update users
set posts_count = posts_count + 1
where user_id = 1;

call sp_delete_post(@new_post_id, 999);

select * from posts where post_id = @new_post_id;
select * from delete_log;

call sp_delete_post(@new_post_id, 1);

select * from posts where post_id = @new_post_id;
select * from users where user_id = 1;
select * from delete_log;
