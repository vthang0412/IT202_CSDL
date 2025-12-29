CREATE DATABASE b1_ss03;
USE b1_ss03;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES
(1, 'Nguyễn Văn An', '2004-05-12', 'an.nguyen@gmail.com'),
(2, 'Trần Thị Bình', '2003-11-20', 'binh.tran@gmail.com'),
(3, 'Lê Văn Cường', '2004-02-08', 'cuong.le@gmail.com');

SELECT * FROM Student;

SELECT student_id, full_name
FROM Student;
