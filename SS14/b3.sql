use social_network;

alter table users
add column following_count int default 0,
add column followers_count int default 0;

create table if not exists followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);
delimiter //

create procedure sp_follow_user(
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int;

    declare exit handler for sqlexception
    begin
        rollback;
        select 'follow thất bại' as ket_qua;
    end;

    start transaction;

    select count(*) into v_count
    from users
    where user_id in (p_follower_id, p_followed_id);

    if v_count < 2 then
        signal sqlstate '45000'
        set message_text = 'User không tồn tại';
    end if;

    if p_follower_id = p_followed_id then
        signal sqlstate '45000'
        set message_text = 'Không được tự follow chính mình';
    end if;

    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        signal sqlstate '45000'
        set message_text = 'Đã follow trước đó';
    end if;

    insert into followers(follower_id, followed_id)
    values (p_follower_id, p_followed_id);

    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;

    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;

    commit;
    select 'follow thành công' as ket_qua;

end //

delimiter ;

call sp_follow_user(1, 2);
call sp_follow_user(1, 999);
call sp_follow_user(1, 1);
call sp_follow_user(1, 2);

select * from users;
select * from followers;
