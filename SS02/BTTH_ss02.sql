CREATE DATABASE QuanLyDangKyHoc;
USE QuanLyDangKyHoc;

CREATE TABLE SinhVien (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Nam', 'Nu') NOT NULL,
    email VARCHAR(100),
    class_name VARCHAR(20)
);

CREATE TABLE MonHoc (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit_hours INT NOT NULL,
    CHECK (credit_hours > 0)
);
CREATE TABLE DangKy (
    student_id CHAR(10),
    subject_id CHAR(10),
    regist DATE NOT NULL,
    semester VARCHAR(10) NOT NULL,

    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES SinhVien(student_id),
    FOREIGN KEY (subject_id) REFERENCES MonHoc(subject_id)
);

ALTER TABLE SinhVien
ADD phone CHAR(10);
-- Thêm cột phone để lưu số điện thoại sinh viên

ALTER TABLE SinhVien
ADD UNIQUE (email);
-- Email là thông tin định danh, không được trùng nhau

ALTER TABLE DangKy
MODIFY semester VARCHAR(10);
-- Đổi kiểu semester để có thể lưu dạng chữ (VD: HK1_2024)

ALTER TABLE MonHoc
ADD CHECK (credit_hours > 0);
-- Số tín chỉ phải là số dương

ALTER TABLE SinhVien
DROP class_name;
-- Thông tin lớp nên tách thành bảng riêng để tránh dư thừa dữ liệu

