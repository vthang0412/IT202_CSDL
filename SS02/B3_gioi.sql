CREATE DATABASE Bai3;
USE Bai3;

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL
);

CREATE TABLE Subject (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL,
    CHECK (credits > 0)
);

CREATE TABLE Enrollment (
    student_id CHAR(10) NOT NULL,
    subject_id CHAR(10) NOT NULL,
    enroll_date DATE NOT NULL,
    
    PRIMARY KEY (student_id, subject_id),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
