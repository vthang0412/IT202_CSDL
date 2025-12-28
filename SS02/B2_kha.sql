CREATE DATABASE Bai2;
USE Bai2;

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    UNIQUE (student_id)
);

CREATE TABLE Subject (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL,
    CHECK (credits > 0),
    UNIQUE (subject_id)
);
