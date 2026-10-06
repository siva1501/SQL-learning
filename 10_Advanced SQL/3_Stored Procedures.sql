-- Stored Procedures
-- A Stored Procedure is a group of SQL statements stored inside the database that can be executed whenever required.
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