CREATE DATABASE b4_ss03;
USE b4_ss03;

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

CREATE TABLE Enrollment (
    student_id INT,
    subject_id INT,
    enroll_date DATE,

    PRIMARY KEY (student_id, subject_id),

    CONSTRAINT fk_enroll_student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    CONSTRAINT fk_enroll_subject
        FOREIGN KEY (subject_id)
        REFERENCES Subject(subject_id)
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

INSERT INTO Enrollment (student_id, subject_id, enroll_date)
VALUES
(1, 101, '2024-08-20'),
(1, 102, '2024-08-21'),
(2, 101, '2024-08-22'),
(2, 103, '2024-08-23');

SELECT * FROM Enrollment;

SELECT *
FROM Enrollment
WHERE student_id = 1;
