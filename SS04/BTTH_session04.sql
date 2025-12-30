CREATE DATABASE OnlineLearning;
USE OnlineLearning;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    total_sessions INT NOT NULL CHECK (total_sessions > 0),
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    mid_score DECIMAL(3,1) CHECK (mid_score >= 0 AND mid_score <= 10),
    final_score DECIMAL(3,1) CHECK (final_score >= 0 AND final_score <= 10),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Student (full_name, dob, email) VALUES
('Nguyen Van A','2004-01-10','a@gmail.com'),
('Tran Thi B','2004-02-15','b@gmail.com'),
('Le Van C','2004-03-20','c@gmail.com'),
('Pham Thi D','2004-04-25','d@gmail.com'),
('Hoang Van E','2004-05-30','e@gmail.com');

INSERT INTO Teacher (full_name, email) VALUES
('Thay Minh','minh@uni.edu'),
('Co Lan','lan@uni.edu'),
('Thay Hung','hung@uni.edu'),
('Co Hoa','hoa@uni.edu'),
('Thay Long','long@uni.edu');

INSERT INTO Course (course_name, description, total_sessions, teacher_id) VALUES
('SQL Co Ban','Nhap mon SQL',15,1),
('Lap trinh C','C co ban',20,2),
('Java Co Ban','Java can ban',18,3),
('HTML CSS','Thiet ke web',12,4),
('JavaScript','Lap trinh frontend',16,5);

INSERT INTO Enrollment (student_id, course_id, enroll_date) VALUES
(1,1,'2024-08-01'),
(1,2,'2024-08-02'),
(2,1,'2024-08-01'),
(3,3,'2024-08-03'),
(4,4,'2024-08-04');

INSERT INTO Score (student_id, course_id, mid_score, final_score) VALUES
(1,1,7.5,8.0),
(1,2,6.5,7.0),
(2,1,8.0,8.5),
(3,3,7.0,7.5),
(4,4,9.0,9.2);

UPDATE Student
SET email = 'newa@gmail.com'
WHERE student_id = 1;

UPDATE Course
SET description = 'SQL tu co ban den nang cao'
WHERE course_id = 1;

UPDATE Score
SET final_score = 9.0
WHERE student_id = 1 AND course_id = 1;

DELETE FROM Enrollment
WHERE student_id = 4 AND course_id = 4;

DELETE FROM Score
WHERE student_id = 4 AND course_id = 4;

SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Score;
