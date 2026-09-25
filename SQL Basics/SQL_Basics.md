1. What is SQL?

SQL = Structured Query Language

SQL is a language used to communicate with a database.

We use SQL to:

Create databases and tables
Insert data
Read data
Update data
Delete data

Example:

SELECT * FROM student;

This means: show all data from the student table.
------------------------------------------------------------------------------------------------
2. Database & DBMS
Database

A database is an organized collection of data.

For example, a college database might contain:

Student
Teacher
Course
Marks
DBMS

DBMS = Database Management System

It is software that helps us create, store, manage, and access databases.

Examples:

MySQL
PostgreSQL
Oracle
SQL Server
SQLite

You are learning MySQL, so we'll use MySQL examples.

Simple relationship
SQL
 ↓
DBMS (MySQL)
 ↓
Database
 ↓
Tables
 ↓
Rows + Columns

-------------------------------------------------------------------------------------------------

3. Tables, Rows, Columns

Suppose we have a student table:

id	name	age	city
1	Siva	22	Hyderabad
2	Ravi	21	Chennai
3	Anil	23	Mumbai
Table

student is the table.

Columns

These are:

id
name
age
city

Columns describe what type of information we store.

Rows

Each complete record is a row.

For example:

1, Siva, 22, Hyderabad

is one row.
-----------------------------------------------------------------------------------------------------------

4. CREATE DATABASE

We use CREATE DATABASE to create a new database.

CREATE DATABASE college;

Now the database college is created.

Select the database
USE college;

Now SQL commands will work inside the college database.

Check databases
SHOW DATABASES;

You may see:

college
information_schema
mysql
performance_schema
------------------------------------------------------------------------------------------------------
5. CREATE TABLE

After creating a database, we can create tables.

CREATE TABLE student (
    id INT,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

Here:

id   → INT
name → VARCHAR(50)
age  → INT
city → VARCHAR(50)
Check tables
SHOW TABLES;
See table structure
DESC student;

or

DESCRIBE student;

You might get:

+-------+-------------+
| Field | Type        |
+-------+-------------+
| id    | int         |
| name  | varchar(50) |
| age   | int         |
| city  | varchar(50) |
+-------+-------------+

-------------------------------------------------------------------------------------------------------
6. INSERT

INSERT is used to add data into a table.

Insert one row
INSERT INTO student
VALUES (1, 'Siva', 22, 'Hyderabad');
Insert multiple rows
INSERT INTO student
VALUES
(2, 'Ravi', 21, 'Chennai'),
(3, 'Anil', 23, 'Mumbai'),
(4, 'Kiran', 22, 'Delhi');

Now the table contains:

id	name	age	city
1	Siva	22	Hyderabad
2	Ravi	21	Chennai
3	Anil	23	Mumbai
4	Kiran	22	Delhi
----------------------------------------------------------------------------------------------------

7. SELECT

SELECT is used to retrieve/read data from a table.

Select everything
SELECT * FROM student;

* means all columns.

Select specific columns
SELECT name, age
FROM student;

Output:

Siva   22
Ravi   21
Anil   23
Kiran  22
Select one column
SELECT name FROM student;

Output:

Siva
Ravi
Anil
Kiran
Complete Program

You can practice all the basics together:

CREATE DATABASE college;

USE college;

CREATE TABLE student (
    id INT,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

INSERT INTO student
VALUES
(1, 'Siva', 22, 'Hyderabad'),
(2, 'Ravi', 21, 'Chennai'),
(3, 'Anil', 23, 'Mumbai');

SELECT * FROM student;

SELECT name, age
FROM student;
----------------------------------------------------------------------------------------------

Remember this flow
--------------------
CREATE DATABASE
       ↓
USE DATABASE
       ↓
CREATE TABLE
       ↓
INSERT DATA
       ↓
SELECT DATA

---------------------------------------------------------------------------------------
Quick interview definitions
Topic	Simple definition
SQL	Language used to communicate with databases
Database	Organized collection of data
DBMS	Software used to manage databases
Table	Collection of related data in rows and columns
Row	One complete record
Column	One attribute/field of a table
CREATE DATABASE	Creates a database
CREATE TABLE	Creates a table
INSERT	Adds data
SELECT	Retrieves data