DROP DATABASE IF EXISTS SocialNetworkDB;
CREATE DATABASE SocialNetworkDB;
USE SocialNetworkDB;

-- Bảng users
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    total_posts INT DEFAULT 0
);

-- Bảng posts
CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Bảng post_audits
CREATE TABLE post_audits (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    old_content TEXT,
    new_content TEXT,
    changed_at DATETIME
);

DELIMITER //

CREATE TRIGGER tg_CheckPostContent
BEFORE INSERT ON posts
FOR EACH ROW
BEGIN
    IF (NEW.content IS NULL or trim(new.content) = '') THEN
        SIGNAL SQLSTATE '45000' SET 
        MESSAGE_TEXT = 'Nội dung bài viết không được để trống!';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_UpdatePostCountAfterInsert
AFTER INSERT ON posts
FOR EACH ROW
BEGIN
    UPDATE users
    SET total_posts = total_posts + 1
    WHERE user_id = NEW.user_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_LogPostChanges
AFTER UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_audits (
            post_id,
            old_content,
            new_content,
            changed_at
        )
        VALUES (
            OLD.post_id,
            OLD.content,
            NEW.content,
            NOW()
        );
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_UpdatePostCountAfterDelete
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    UPDATE users
    SET total_posts = total_posts - 1
    WHERE user_id = OLD.user_id;
END;
//

DELIMITER ;

-- 1. Tạo user mới
INSERT INTO users (username) VALUES ('thang');

-- 2. Insert bài viết hợp lệ
INSERT INTO posts (user_id, content)
VALUES (1, 'Bài viết đầu tiên');

-- Kiểm tra total_posts (phải = 1)
SELECT user_id, total_posts FROM users WHERE user_id = 1;

-- 3. Insert bài viết trống (PHẢI BỊ CHẶN)
-- Lệnh này sẽ báo lỗi: "Nội dung bài viết không được để trống!"
-- INSERT INTO posts (user_id, content)
-- VALUES (1, '   ');

-- 4. Update nội dung bài viết
UPDATE posts
SET content = 'Nội dung đã được chỉnh sửa'
WHERE post_id = 1;

-- Kiểm tra log chỉnh sửa
SELECT * FROM post_audits;

-- 5. Xóa bài viết
DELETE FROM posts WHERE post_id = 1;

-- Kiểm tra total_posts (phải = 0)
SELECT user_id, total_posts FROM users WHERE user_id = 1;

DROP TRIGGER IF EXISTS tg_CheckPostContent;
DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterInsert;
DROP TRIGGER IF EXISTS tg_LogPostChanges;
DROP TRIGGER IF EXISTS tg_UpdatePostCountAfterDelete;

