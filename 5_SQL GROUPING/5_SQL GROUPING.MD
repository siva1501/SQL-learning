## 5. SQL Grouping

SQL grouping is used to **combine rows with the same values** and perform calculations on each group.

The two important clauses are:

* `GROUP BY`
* `HAVING`

Grouping is commonly used with aggregate functions such as:

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

---

### `GROUP BY`

`GROUP BY` is used to group rows that have the same value in a column.

### Syntax

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;
```

### Example Table

```sql
CREATE DATABASE COLLEGE;

USE COLLEGE;

CREATE TABLE STUDENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100),
    AGE INT,
    CITY VARCHAR(100),
    MARKS INT
);
```

Insert sample data:

```sql
INSERT INTO STUDENT (NAME, AGE, CITY, MARKS)
VALUES
('SIVA', 22, 'HYDERABAD', 82),
('RAVI', 25, 'KHAMMAM', 95),
('NAVEEN', 23, 'HYDERABAD', 80),
('DHANUSH', 24, 'KHAMMAM', 86),
('SATISH', 22, 'WARANGAL', 90),
('RAMU', 26, 'HYDERABAD', 87),
('RANI', 21, 'WARANGAL', 60),
('HEMA', 22, 'KHAMMAM', 40);
```

---

## `GROUP BY` with `COUNT()`

`COUNT()` is used to count the number of rows in each group.

### Example

Find the number of students in each city:

```sql
SELECT CITY, COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT
GROUP BY CITY;
```

### Output

| CITY      | TOTAL_STUDENTS |
| --------- | -------------: |
| HYDERABAD |              3 |
| KHAMMAM   |              3 |
| WARANGAL  |              2 |

SQL creates groups like:

```text
HYDERABAD → SIVA, NAVEEN, RAMU
KHAMMAM   → RAVI, DHANUSH, HEMA
WARANGAL  → SATISH, RANI
```

Then `COUNT(*)` counts the students in each group.

---

## `GROUP BY` with `SUM()`

`SUM()` calculates the total value for each group.

### Example

Find the total marks from each city:

```sql
SELECT CITY, SUM(MARKS) AS TOTAL_MARKS
FROM STUDENT
GROUP BY CITY;
```

### Output

| CITY      | TOTAL_MARKS |
| --------- | ----------: |
| HYDERABAD |         249 |
| KHAMMAM   |         221 |
| WARANGAL  |         150 |

---

## `GROUP BY` with `AVG()`

`AVG()` calculates the average value for each group.

### Example

Find the average marks in each city:

```sql
SELECT CITY, AVG(MARKS) AS AVERAGE_MARKS
FROM STUDENT
GROUP BY CITY;
```

### Output

| CITY      | AVERAGE_MARKS |
| --------- | ------------: |
| HYDERABAD |         83.00 |
| KHAMMAM   |         73.67 |
| WARANGAL  |         75.00 |

---

## `GROUP BY` with `MAX()`

`MAX()` finds the highest value in each group.

### Example

Find the highest marks in each city:

```sql
SELECT CITY, MAX(MARKS) AS HIGHEST_MARKS
FROM STUDENT
GROUP BY CITY;
```

### Output

| CITY      | HIGHEST_MARKS |
| --------- | ------------: |
| HYDERABAD |            87 |
| KHAMMAM   |            95 |
| WARANGAL  |            90 |

---

## `GROUP BY` with `MIN()`

`MIN()` finds the lowest value in each group.

### Example

Find the lowest marks in each city:

```sql
SELECT CITY, MIN(MARKS) AS LOWEST_MARKS
FROM STUDENT
GROUP BY CITY;
```

### Output

| CITY      | LOWEST_MARKS |
| --------- | -----------: |
| HYDERABAD |           80 |
| KHAMMAM   |           40 |
| WARANGAL  |           60 |

---

# `HAVING`

`HAVING` is used to **filter groups after `GROUP BY`**.

It is commonly used with aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`.

### Syntax

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name
HAVING condition;
```

---

## `GROUP BY` + `HAVING`

### Example 1: Cities with more than 2 students

```sql
SELECT CITY, COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT
GROUP BY CITY
HAVING COUNT(*) > 2;
```

### Output

| CITY      | TOTAL_STUDENTS |
| --------- | -------------: |
| HYDERABAD |              3 |
| KHAMMAM   |              3 |

`WARANGAL` has only 2 students, so it is not included.

---

## `HAVING` with `AVG()`

### Example

Find cities where the average marks are greater than 75:

```sql
SELECT CITY, AVG(MARKS) AS AVERAGE_MARKS
FROM STUDENT
GROUP BY CITY
HAVING AVG(MARKS) > 75;
```

### Output

| CITY      | AVERAGE_MARKS |
| --------- | ------------: |
| HYDERABAD |         83.00 |

`KHAMMAM` has an average of `73.67`, and `WARANGAL` has an average of `75`, so neither satisfies `> 75`.

---

# `WHERE` + `GROUP BY` + `HAVING`

We can use `WHERE`, `GROUP BY`, and `HAVING` together.

### Example

Find cities that have at least 2 students whose marks are greater than 50.

```sql
SELECT CITY, COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT
WHERE MARKS > 50
GROUP BY CITY
HAVING COUNT(*) >= 2;
```

### How it works

**Step 1 — `WHERE`**

```sql
WHERE MARKS > 50
```

Filters individual students.

**Step 2 — `GROUP BY`**

```sql
GROUP BY CITY
```

Groups the remaining students by city.

**Step 3 — `HAVING`**

```sql
HAVING COUNT(*) >= 2
```

Keeps only cities having at least 2 students.

---

# `WHERE` vs `HAVING`

This is an important SQL interview concept.

| `WHERE`                                     | `HAVING`                                |
| ------------------------------------------- | --------------------------------------- |
| Filters individual rows                     | Filters groups                          |
| Used before `GROUP BY`                      | Used after `GROUP BY`                   |
| Usually works with normal column conditions | Commonly works with aggregate functions |
| Filters data before grouping                | Filters data after grouping             |

### `WHERE` Example

```sql
SELECT *
FROM STUDENT
WHERE MARKS > 80;
```

This filters individual student records.

### `HAVING` Example

```sql
SELECT CITY, AVG(MARKS) AS AVERAGE_MARKS
FROM STUDENT
GROUP BY CITY
HAVING AVG(MARKS) > 80;
```

This filters cities based on the average marks of the group.

### Easy Rule

```text
WHERE  → Filters Rows
HAVING → Filters Groups
```

---

# Multiple Columns with `GROUP BY`

We can group by more than one column.

### Example

```sql
SELECT CITY, AGE, COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT
GROUP BY CITY, AGE;
```

Here SQL groups rows based on the combination of:

```text
CITY + AGE
```

For example:

```text
HYDERABAD + 22
HYDERABAD + 23
HYDERABAD + 26
KHAMMAM + 22
KHAMMAM + 24
WARANGAL + 21
WARANGAL + 22
```

Each unique combination becomes a separate group.

---

# Real-Time Example — Employee Department

Consider an `EMPLOYEE` table:

| NAME   | DEPARTMENT | SALARY |
| ------ | ---------- | -----: |
| SIVA   | IT         |  50000 |
| RAVI   | IT         |  60000 |
| NAVEEN | HR         |  40000 |
| HARI   | HR         |  45000 |
| RAJ    | SALES      |  55000 |

### Count employees in each department

```sql
SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
FROM EMPLOYEE
GROUP BY DEPARTMENT;
```

### Find average salary in each department

```sql
SELECT DEPARTMENT, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT;
```

### Find departments with average salary greater than 50000

```sql
SELECT DEPARTMENT, AVG(SALARY) AS AVERAGE_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT
HAVING AVG(SALARY) > 50000;
```

---

# SQL Execution Order

The important logical order is:

```text
FROM
 ↓
WHERE
 ↓
GROUP BY
 ↓
HAVING
 ↓
SELECT
 ↓
ORDER BY
 ↓
LIMIT
```

For example:

```sql
SELECT CITY, COUNT(*) AS TOTAL_STUDENTS
FROM STUDENT
WHERE MARKS > 50
GROUP BY CITY
HAVING COUNT(*) >= 2
ORDER BY TOTAL_STUDENTS DESC;
```

SQL conceptually performs:

1. Get data from `STUDENT`
2. Filter students using `WHERE`
3. Group students by `CITY`
4. Filter groups using `HAVING`
5. Select the required columns
6. Sort the result

---

# Common `GROUP BY` Patterns

### Count records in each group

```sql
SELECT CITY, COUNT(*)
FROM STUDENT
GROUP BY CITY;
```

### Calculate total for each group

```sql
SELECT CITY, SUM(MARKS)
FROM STUDENT
GROUP BY CITY;
```

### Calculate average for each group

```sql
SELECT CITY, AVG(MARKS)
FROM STUDENT
GROUP BY CITY;
```

### Find maximum value in each group

```sql
SELECT CITY, MAX(MARKS)
FROM STUDENT
GROUP BY CITY;
```

### Find minimum value in each group

```sql
SELECT CITY, MIN(MARKS)
FROM STUDENT
GROUP BY CITY;
```

### Filter groups

```sql
SELECT CITY, COUNT(*)
FROM STUDENT
GROUP BY CITY
HAVING COUNT(*) > 2;
```

---

# `GROUP BY` + Aggregate Functions

| Function  | Purpose             |
| --------- | ------------------- |
| `COUNT()` | Counts rows         |
| `SUM()`   | Calculates total    |
| `AVG()`   | Calculates average  |
| `MAX()`   | Finds highest value |
| `MIN()`   | Finds lowest value  |

---

# Interview Questions

### 1. What is `GROUP BY`?

`GROUP BY` groups rows with the same values so that aggregate calculations can be performed on each group.

### 2. What is `HAVING`?

`HAVING` filters groups created by `GROUP BY`.

### 3. Difference between `WHERE` and `HAVING`?

```text
WHERE  → Filters rows
HAVING → Filters groups
```

### 4. Can `HAVING` be used with aggregate functions?

Yes.

Example:

```sql
HAVING COUNT(*) > 2;
```

### 5. Which aggregate functions are commonly used with `GROUP BY`?

```text
COUNT()
SUM()
AVG()
MIN()
MAX()
```

---

# Quick Revision

```text
GROUP BY
    ↓
Groups rows with the same value

COUNT()
    ↓
Counts rows in each group

SUM()
    ↓
Calculates total for each group

AVG()
    ↓
Calculates average for each group

MAX()
    ↓
Finds highest value in each group

MIN()
    ↓
Finds lowest value in each group

HAVING
    ↓
Filters groups
```

### Most Important Difference

```sql
WHERE MARKS > 80
```

➡️ Filters **rows**

```sql
HAVING AVG(MARKS) > 80
```

➡️ Filters **groups**

### Key Point

> `GROUP BY` is used to create groups, while `HAVING` is used to filter those groups.
