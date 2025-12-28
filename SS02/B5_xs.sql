CREATE DATABASE Bai5;
USE Bai5;

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50)
);

CREATE TABLE Subject (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE Score (
    student_id CHAR(10),
    subject_id CHAR(10),
    process_score DECIMAL(3,1) DEFAULT 0,
    final_score DECIMAL(3,1) DEFAULT 0,

    CHECK (process_score >= 0 AND process_score <= 10),
    CHECK (final_score >= 0 AND final_score <= 10),

    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
