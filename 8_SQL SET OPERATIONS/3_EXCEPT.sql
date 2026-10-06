-- EXCEPT
-- EXCEPT returns rows that exist in the first query but not in the second query.

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

NOT EXISTS

SELECT NAME 
FROM SQL_STUDENTS;

-- Give me names in Python students that are not in SQL students.