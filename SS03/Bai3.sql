CREATE DATABASE b3_ss03;
USE b3_ss03;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES
(1, 'Nguyễn Văn An', '2004-05-12', 'an.nguyen@gmail.com'),
(2, 'Trần Thị Bình', '2003-11-20', 'binh.tran@gmail.com'),
(3, 'Lê Văn Cường', '2004-02-08', 'cuong.le@gmail.com');

INSERT INTO Subject (subject_id, subject_name, credit)
VALUES
(101, 'Cơ sở dữ liệu', 3),
(102, 'Lập trình C', 4),
(103, 'Cấu trúc dữ liệu', 3);

UPDATE Subject
SET credit = 5
WHERE subject_id = 102;

UPDATE Subject
SET subject_name = 'Hệ quản trị CSDL'
WHERE subject_id = 101;


