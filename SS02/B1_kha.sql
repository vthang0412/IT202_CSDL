CREATE DATABASE Bai1;
USE Bai1;

CREATE TABLE Class (
    class_id CHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year VARCHAR(9) NOT NULL
);

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    class_id CHAR(10) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

