CREATE DATABASE Bai4;
USE Bai4;

CREATE TABLE Teacher (
    teacher_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Subject (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    teacher_id CHAR(10) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

ALTER TABLE Subject
ADD teacher_id CHAR(10) NOT NULL;

ALTER TABLE Subject
ADD CONSTRAINT fk_subject_teacher
FOREIGN KEY (teacher_id)
REFERENCES Teacher(teacher_id);
