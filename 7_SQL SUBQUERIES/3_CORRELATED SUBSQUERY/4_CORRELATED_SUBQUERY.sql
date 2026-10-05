-- Correlated Subquery
-- A correlated subquery is different from a normal subquery.
-- The subquery depends on the current row of the outer query.
-- Outer query gets one row
--         ↓
-- Subquery checks that row
--         ↓
-- Result is returned
--         ↓
-- Outer query moves to next row
--         ↓
-- Subquery runs again

CREATE DATABASE COMPENY;
USE COMPENY;
CREATE TABLE DEPARTMENT(
    DEPARTMENT_ID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(100)
);

INSERT INTO DEPARTMENT
VALUES
(1, 'PYTHON'),
(2, 'JAVA'),
(3, 'SQL');

CREATE TABLE EMPLOYEES(
	EMPLOYEE_ID INT ,
    NAME VARCHAR(100),
    DEPARTMENT_ID INT,
    SALARY INT);
INSERT INTO EMPLOYEES
VALUES
(1,'SIVA',1,40000),
(2,'RAVI',2,50000),
(3,'NAAEEN',3,45000),
(4,'MAHI',3,60000),
(5,'NANI',1,65000);

SELECT *
FROM DEPARTMENT D
WHERE EXISTS (
    SELECT 1
    FROM EMPLOYEES E
    WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
);
