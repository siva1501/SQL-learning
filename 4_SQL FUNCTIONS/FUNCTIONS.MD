    # SQL Functions

SQL Functions are built-in operations used to perform calculations, manipulate data, and work with strings, dates, numbers, and multiple rows.

## Topics Covered

* Aggregate Functions
* String Functions
* Date Functions
* Numeric Functions

---

# 1. Aggregate Functions

Aggregate functions perform calculations on multiple rows and return a single result.

### Functions

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

### Example Table

```sql
CREATE DATABASE COLLEGE;

USE COLLEGE;

CREATE TABLE STUDENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    AGE INT,
    CITY VARCHAR(100),
    MARKS INT,
    EMAIL VARCHAR(100) UNIQUE
);

INSERT INTO STUDENT (NAME, AGE, CITY, MARKS, EMAIL)
VALUES
('SIVA', 22, 'HYDERABAD', 82, 'SIVA@GMAIL.COM'),
('RAVI', 25, 'KHAMMAM', 95, 'RAVI@GMAIL.COM'),
('HARSHI', 23, 'HYDERABAD', 88, 'HARSHI@GMAIL.COM'),
('NANI', 21, 'WARANGAL', 65, 'NANI@GMAIL.COM'),
('RAJU', 24, 'KHAMMAM', 75, 'RAJU@GMAIL.COM');
```

---

## COUNT()

`COUNT()` counts rows or non-NULL values.

### Count all students

```sql
SELECT COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT;
```

Output:

```text
TOTAL_STUDENTS
5
```

### Count students from Hyderabad

```sql
SELECT COUNT(*) AS HYDERABAD_STUDENTS
FROM STUDENT
WHERE CITY = 'HYDERABAD';
```

Output:

```text
HYDERABAD_STUDENTS
2
```

### Important

```sql
COUNT(*)
```

Counts all rows.

```sql
COUNT(EMAIL)
```

Counts only rows where `EMAIL` is not `NULL`.

---

# SUM()

`SUM()` calculates the total of a numeric column.

```sql
SELECT SUM(MARKS) AS TOTAL_MARKS
FROM STUDENT;
```

Calculation:

```text
82 + 95 + 88 + 65 + 75 = 405
```

Output:

```text
TOTAL_MARKS
405
```

### Real-time Example

Find the total marks of Hyderabad students:

```sql
SELECT SUM(MARKS) AS TOTAL_MARKS
FROM STUDENT
WHERE CITY = 'HYDERABAD';
```

---

# AVG()

`AVG()` calculates the average value.

```sql
SELECT AVG(MARKS) AS AVERAGE_MARKS
FROM STUDENT;
```

Calculation:

```text
405 / 5 = 81
```

Output:

```text
AVERAGE_MARKS
81
```

---

# MIN()

`MIN()` finds the smallest value.

```sql
SELECT MIN(MARKS) AS LOWEST_MARKS
FROM STUDENT;
```

Output:

```text
LOWEST_MARKS
65
```

---

# MAX()

`MAX()` finds the largest value.

```sql
SELECT MAX(MARKS) AS HIGHEST_MARKS
FROM STUDENT;
```

Output:

```text
HIGHEST_MARKS
95
```

---

# Using Multiple Aggregate Functions

Multiple aggregate functions can be used in the same query.

```sql
SELECT
    COUNT(*) AS TOTAL_STUDENTS,
    SUM(MARKS) AS TOTAL_MARKS,
    AVG(MARKS) AS AVERAGE_MARKS,
    MIN(MARKS) AS LOWEST_MARKS,
    MAX(MARKS) AS HIGHEST_MARKS
FROM STUDENT;
```

Output:

| TOTAL_STUDENTS | TOTAL_MARKS | AVERAGE_MARKS | LOWEST_MARKS | HIGHEST_MARKS |
| -------------: | ----------: | ------------: | -----------: | ------------: |
|              5 |         405 |            81 |           65 |            95 |

---

# 2. String Functions

String functions are used to work with text values.

### Common String Functions

* `UPPER()`
* `LOWER()`
* `LENGTH()`
* `CONCAT()`
* `SUBSTRING()`
* `TRIM()`

---

## UPPER()

Converts text into uppercase.

```sql
SELECT UPPER(NAME) AS NAME
FROM STUDENT;
```

Example:

```text
siva → SIVA
ravi → RAVI
```

---

## LOWER()

Converts text into lowercase.

```sql
SELECT LOWER(NAME) AS NAME
FROM STUDENT;
```

Example:

```text
SIVA → siva
RAVI → ravi
```

---

## LENGTH()

Returns the length of a string.

```sql
SELECT NAME, LENGTH(NAME) AS NAME_LENGTH
FROM STUDENT;
```

Example:

```text
SIVA → 4
RAVI → 4
HARSHI → 6
```

---

## CONCAT()

Joins two or more strings.

```sql
SELECT CONCAT(NAME, ' - ', CITY) AS STUDENT_DETAILS
FROM STUDENT;
```

Example output:

```text
SIVA - HYDERABAD
RAVI - KHAMMAM
HARSHI - HYDERABAD
```

---

## SUBSTRING()

`SUBSTRING()` extracts a specific part of a string.

### Syntax

```sql
SUBSTRING(string, start_position, length)
```

Example:

```sql
SELECT SUBSTRING('SIVA', 1, 2);
```

Output:

```text
SI
```

Example:

```sql
SELECT NAME, SUBSTRING(NAME, 1, 3) AS SHORT_NAME
FROM STUDENT;
```

Output:

```text
SIVA   → SIV
RAVI   → RAV
HARSHI → HAR
```

---

## TRIM()

Removes spaces from the beginning and end of a string.

```sql
SELECT TRIM('   SIVA   ');
```

Output:

```text
SIVA
```

---

# 3. Date Functions

Date functions are used to work with dates and times.

### Common Date Functions

* `CURDATE()`
* `NOW()`
* `YEAR()`
* `MONTH()`
* `DAY()`
* `DAYNAME()`
* `MONTHNAME()`
* `DATEDIFF()`
* `DATE_ADD()`
* `DATE_SUB()`

---

## CURDATE()

Returns the current date.

```sql
SELECT CURDATE();
```

Example output:

```text
2026-10-02
```

The result changes according to the current date.

---

## NOW()

Returns the current date and time.

```sql
SELECT NOW();
```

Example:

```text
2026-10-02 00:10:25
```

### Difference

```text
CURDATE() → Date only
NOW()     → Date + Time
```

---

## YEAR()

Extracts the year from a date.

```sql
SELECT YEAR('2023-06-15');
```

Output:

```text
2023
```

---

## MONTH()

Extracts the month number.

```sql
SELECT MONTH('2023-06-15');
```

Output:

```text
6
```

---

## DAY()

Extracts the day of the month.

```sql
SELECT DAY('2023-06-15');
```

Output:

```text
15
```

---

## DAYNAME()

Returns the name of the weekday.

```sql
SELECT DAYNAME('2023-06-15');
```

Output:

```text
Thursday
```

---

## MONTHNAME()

Returns the name of the month.

```sql
SELECT MONTHNAME('2023-06-15');
```

Output:

```text
June
```

---

## DATEDIFF()

Calculates the difference between two dates in days.

### Syntax

```sql
DATEDIFF(date1, date2)
```

Example:

```sql
SELECT DATEDIFF('2026-10-02', '2026-10-01');
```

Output:

```text
1
```

### Real-time Example

Find how many days have passed since an employee joined:

```sql
SELECT
    NAME,
    JOINING_DATE,
    DATEDIFF(CURDATE(), JOINING_DATE) AS DAYS_WORKED
FROM EMPLOYEE;
```

This can be used for:

* Employee experience
* Subscription duration
* Order tracking
* Account age

---

## DATE_ADD()

Adds a specified amount of time to a date.

### Add 10 days

```sql
SELECT DATE_ADD('2026-10-02', INTERVAL 10 DAY);
```

Output:

```text
2026-10-12
```

### Real-time Example

Calculate a 30-day subscription expiry date:

```sql
SELECT DATE_ADD(CURDATE(), INTERVAL 30 DAY) AS EXPIRY_DATE;
```

---

## DATE_SUB()

Subtracts a specified amount of time from a date.

```sql
SELECT DATE_SUB('2026-10-02', INTERVAL 10 DAY);
```

Output:

```text
2026-09-22
```

### Real-time Example

Find the date 30 days before today:

```sql
SELECT DATE_SUB(CURDATE(), INTERVAL 30 DAY) AS PREVIOUS_DATE;
```

---

# 4. Numeric Functions

Numeric functions are used to perform mathematical operations.

### Common Numeric Functions

* `ROUND()`
* `CEIL()`
* `FLOOR()`
* `ABS()`
* `MOD()`

---

## ROUND()

Rounds a decimal number.

```sql
SELECT ROUND(85.678);
```

Output:

```text
86
```

### Specify decimal places

```sql
SELECT ROUND(85.678, 2);
```

Output:

```text
85.68
```

---

## CEIL()

Rounds a number upward to the nearest integer.

```sql
SELECT CEIL(85.2);
```

Output:

```text
86
```

---

## FLOOR()

Rounds a number downward to the nearest integer.

```sql
SELECT FLOOR(85.9);
```

Output:

```text
85
```

---

## ABS()

Returns the absolute value of a number.

```sql
SELECT ABS(-25);
```

Output:

```text
25
```

---

## MOD()

Returns the remainder after division.

```sql
SELECT MOD(10, 3);
```

Calculation:

```text
10 ÷ 3

Remainder = 1
```

Output:

```text
1
```

---

# SQL Functions Quick Reference

| Category  | Function      | Purpose                    |
| --------- | ------------- | -------------------------- |
| Aggregate | `COUNT()`     | Counts rows/values         |
| Aggregate | `SUM()`       | Calculates total           |
| Aggregate | `AVG()`       | Calculates average         |
| Aggregate | `MIN()`       | Finds minimum              |
| Aggregate | `MAX()`       | Finds maximum              |
| String    | `UPPER()`     | Converts to uppercase      |
| String    | `LOWER()`     | Converts to lowercase      |
| String    | `LENGTH()`    | Finds string length        |
| String    | `CONCAT()`    | Joins strings              |
| String    | `SUBSTRING()` | Extracts part of a string  |
| String    | `TRIM()`      | Removes extra spaces       |
| Date      | `CURDATE()`   | Current date               |
| Date      | `NOW()`       | Current date and time      |
| Date      | `YEAR()`      | Extracts year              |
| Date      | `MONTH()`     | Extracts month             |
| Date      | `DAY()`       | Extracts day               |
| Date      | `DAYNAME()`   | Gets weekday name          |
| Date      | `MONTHNAME()` | Gets month name            |
| Date      | `DATEDIFF()`  | Difference between dates   |
| Date      | `DATE_ADD()`  | Adds time to a date        |
| Date      | `DATE_SUB()`  | Subtracts time from a date |
| Numeric   | `ROUND()`     | Rounds a number            |
| Numeric   | `CEIL()`      | Rounds upward              |
| Numeric   | `FLOOR()`     | Rounds downward            |
| Numeric   | `ABS()`       | Returns absolute value     |
| Numeric   | `MOD()`       | Returns remainder          |

---

# Key Points

```text
Aggregate Functions → Work with multiple rows
String Functions    → Work with text
Date Functions      → Work with dates and time
Numeric Functions   → Work with numbers
```

## Important Functions to Practice

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()

UPPER()
LOWER()
LENGTH()
CONCAT()
SUBSTRING()
TRIM()

CURDATE()
NOW()
YEAR()
MONTH()
DAY()
DATEDIFF()
DATE_ADD()
DATE_SUB()

ROUND()
CEIL()
FLOOR()
ABS()
MOD()
```

These SQL functions are useful for **real-time database applications, data analysis, reporting, and SQL interview questions**.
