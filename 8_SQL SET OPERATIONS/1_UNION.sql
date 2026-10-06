-- UNION 
-- UNION combines the results of two SELECT queries and removes duplicate rows.

CREATE DATABASE COLLEGE;
USE COLLEGE;
CREATE TABLE PYTHON_STUDENTS(
	ID INT PRIMARY KEY,
    NAME VARCHAR(100));
INSERT INTO PYTHON_STUDENTS
VALUES
(1,'SIVA'),
(2,'RAVI'),
(3,'NAVEEN');

CREATE TABLE SQL_STUDENTS(
	
    ID INT PRIMARY KEY,
    NAME VARCHAR(100));
INSERT INTO SQL_STUDENTS
VALUES
(4,'MAHI'),
(5,'RAVI'),
(6,'NAVEEN');

SELECT NAME
FROM PYTHON_STUDENTS

UNION

SELECT NAME 
FROM SQL_STUDENTS;

-- NAVEEN appears in both tables, but UNION returns it only once.

-- Use

-- Use UNION when you want to combine results without duplicates.
