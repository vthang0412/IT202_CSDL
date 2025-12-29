CREATE DATABASE course_registration;
USE course_registration;

DROP TABLE DangKy;
DROP TABLE MonHoc;
DROP TABLE SinhVien;

CREATE TABLE SinhVien (
    student_id int AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender CHAR(1),
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),

    CONSTRAINT pk_sinhvien PRIMARY KEY (student_id),
    CONSTRAINT uq_sinhvien_email UNIQUE (email),
    CONSTRAINT ck_sinhvien_gender CHECK (gender IN ('M', 'F'))
);

CREATE TABLE MonHoc (
    course_id INT,
    course_name VARCHAR(100) NOT NULL,
    credits INT,

    CONSTRAINT pk_monhoc PRIMARY KEY (course_id),
    CONSTRAINT ck_monhoc_credits CHECK (credits > 0)
);

CREATE TABLE DangKy (
    registration_id INT AUTO_INCREMENT,
    student_id int NOT NULL,
    course_id INT NOT NULL,
    semester VARCHAR(20),
    registration_date DATE DEFAULT (CURRENT_DATE),

    CONSTRAINT pk_dangky PRIMARY KEY (registration_id),

    CONSTRAINT fk_dangky_sinhvien
        FOREIGN KEY (student_id)
        REFERENCES SinhVien(student_id),

    CONSTRAINT fk_dangky_monhoc
        FOREIGN KEY (course_id)
        REFERENCES MonHoc(course_id)
);

DESCRIBE SinhVien;
DESCRIBE MonHoc;
DESCRIBE DangKy;

INSERT INTO SinhVien (full_name, date_of_birth, gender, email, phone)
VALUES
('Nguyen Van A', '2004-01-10', 'M', 'a@gmail.com', '0900000001'),
('Tran Thi B', '2004-02-12', 'F', 'b@gmail.com', '0900000002'),
('Le Van C', '2003-03-15', 'M', 'c@gmail.com', '0900000003'),
('Pham Thi D', '2004-04-18', 'F', 'd@gmail.com', '0900000004'),
('Hoang Van E', '2003-05-20', 'M', 'e@gmail.com', '0900000005'),
('Nguyen Thi F', '2004-06-22', 'F', 'f@gmail.com', '0900000006'),
('Tran Van G', '2003-07-25', 'M', 'g@gmail.com', '0900000007'),
('Le Thi H', '2004-08-28', 'F', 'h@gmail.com', '0900000008'),
('Pham Van I', '2003-09-30', 'M', 'i@gmail.com', '0900000009'),
('Do Thi K', '2004-10-05', 'F', 'k@gmail.com', '0900000010');

INSERT INTO MonHoc (course_id, course_name, credits)
VALUES
(1, 'Co so du lieu', 3),
(2, 'Lap trinh C', 4),
(3, 'Lap trinh Java', 3),
(4, 'Cau truc du lieu', 4),
(5, 'Mang may tinh', 3),
(6, 'He dieu hanh', 3),
(7, 'Cong nghe Web', 3),
(8, 'Nhap mon AI', 2),
(9, 'Phan tich thiet ke HT', 3),
(10, 'An toan thong tin', 2);

INSERT INTO DangKy (student_id, course_id, semester, registration_date)
VALUES
(1, 1, '2024HK1', '2024-08-20'),
(2, 2, '2024HK1', '2024-08-21'),
(3, 3, '2024HK1', '2024-08-22'),
(4, 4, '2024HK1', '2024-08-23'),
(5, 5, '2024HK1', '2024-08-24'),
(6, 6, '2024HK2', '2025-01-10'),
(7, 7, '2024HK2', '2025-01-11'),
(8, 8, '2024HK2', '2025-01-12'),
(9, 9, '2024HK2', '2025-01-13'),
(10, 10, '2024HK2', '2025-01-14');

SELECT student_id, full_name
FROM SinhVien;

SELECT course_name, credits
FROM MonHoc;

SELECT student_id, course_id
FROM DangKy;

UPDATE SinhVien
SET email = 'newemail@gmail.com'
WHERE student_id = 1;

UPDATE MonHoc
SET credits = 5
WHERE course_id = 2;

UPDATE DangKy
SET semester = '2025HK1'
WHERE registration_id = 21;

DELETE FROM DangKy
WHERE registration_id = 10;

DELETE FROM SinhVien
WHERE student_id = 10;




