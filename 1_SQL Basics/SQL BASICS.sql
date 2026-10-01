-- SQL BASICS
CREATE DATABASE college;
USE college;
CREATE TABLE student (
	id INT,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);
INSERT INTO student
VALUES (1, 'Siva', 22, 'Hyderabad');
INSERT INTO student
VALUES(2,'Ravi',22,'bengulure'),
(3,'nani',25,'channai'),
(4,'ramu',52,'mumbai');
SELECT * FROM student;
SELECT Name,Age FROM Student;
SELECT Name FROM Student;    
    
