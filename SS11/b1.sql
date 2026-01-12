delimiter //

create procedure u_users(
    p_user_id int
)
begin
    select 
        post_id,
        content,
        created_at
    from posts
    where post_id = p_user_id;
end //

delimiter ;

call u_users(88);
drop procedure if exists u_users;
