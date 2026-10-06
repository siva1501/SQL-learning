-- Views
-- A View is a virtual table created from the result of a SQL query.
-- It does not normally store the actual data separately. It displays data from one or more existing tables.
-- CREATE VIEW view_name AS
-- SELECT column1, column2
-- FROM table_name
-- WHERE condition;


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

SELECT *
FROM STUDENT;

CREATE VIEW HIGH_MARKS_STUDENTS AS
SELECT NAME, MARKS
FROM STUDENT
WHERE MARKS > 90;
-- Now we can use the view like a table:
SELECT * FROM COLLEGE.HIGH_MARKS_STUDENTS;

CREATE VIEW CITYS AS 
SELECT NAME,CITY
FROM STUDENT;

-- Now we can use the view like a table:
SELECT * FROM COLLEGE.CITYS;