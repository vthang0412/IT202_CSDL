CREATE DATABASE Bai6;
USE Bai6;

CREATE TABLE Class (
    class_id CHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year VARCHAR(9) NOT NULL
);

CREATE TABLE Student (
    student_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    dob DATE,
    class_id CHAR(10),
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

CREATE TABLE Teacher (
    teacher_id CHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Subject (
    subject_id CHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL,
    teacher_id CHAR(10),

    CHECK (credits > 0),
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id CHAR(10),
    subject_id CHAR(10),
    enroll_date DATE NOT NULL,

    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
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
