-- INTERSECT
-- INTERSECT returns only the rows that are common to both queries.

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

INTERRSECT

SELECT NAME 
FROM SQL_STUDENTS;

-- Output
-- NAME
-- NAVEEN
-- Why?
-- NAVEEN exists in both tables.

-- Important MySQL Note
-- If you are using MySQL, INTERSECT is supported in modern MySQL versions (8.0.31+).