-- UNION ALL
-- UNION ALL combines the results of two SELECT queries and keeps duplicates.

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

UNION ALL

SELECT NAME 
FROM SQL_STUDENTS;

-- Here, NAVEEN appears twice because he exists in both tables.
-- Use
-- Use UNION ALL when you want all records, including duplicates.