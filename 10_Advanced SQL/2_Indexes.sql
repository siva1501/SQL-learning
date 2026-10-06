-- Indexes
-- An Index is used to make searching and retrieving data from a table faster.
-- Think of an index like the index page of a book. Instead of searching every page, you can quickly find where the required information is located.

CREATE DATABASE COLLEGE;
USE COLLEGE;
CREATE TABLE STUDENT(
	ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    CITY VARCHAR(100),
    MARKS INT);
INSERT INTO STUDENT
VALUES
(1,'SIVA','HYDRABAD',95),
(2,'RAVI','KHAMMAM',85),
(3,'NAVEEN','WARANGLE',82),
(4,'MAHI','SATUPALLI',93),
(5,'NANI','LANKAPALLI',89);

CREATE INDEX idx_STUDENT_name
ON STUDENT(NAME);

SELECT *
FROM STUDENT
WHERE NAME='SIVA';

CREATE UNIQUE INDEX idx_employee_CITY
ON STUDENT(CITYidx_employee_CITY);

-- Drop an Index
DROP INDEX idx_STUDENT_name ON STUDENT;