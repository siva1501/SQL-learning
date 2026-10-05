# 6. SQL Joins

SQL **Joins** are used to combine data from two or more tables based on a related column.

Joins are very important in real-world databases because data is usually stored in multiple tables.

---

## Table of Contents

* [What is a Join?](#what-is-a-join)
* [Sample Tables](#sample-tables)
* [1. INNER JOIN](#1-inner-join)
* [2. LEFT JOIN](#2-left-join)
* [3. RIGHT JOIN](#3-right-join)
* [4. CROSS JOIN](#4-cross-join)
* [5. SELF JOIN](#5-self-join)
* [JOIN Comparison](#join-comparison)
* [Real-World Use Cases](#real-world-use-cases)
* [Interview Points](#interview-points)

---

## What is a Join?

A **JOIN** is used to retrieve related data from multiple tables.

For example, a student table may contain student information, while a department table contains department information.

The common column can be used to connect the tables.

```text
student.department_id
        ↓
department.department_id
```

---

# Sample Tables

We will use the following tables to understand SQL Joins.

## Student Table

```sql
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department_id INT
);
```

### Insert Data

```sql
INSERT INTO student (name, department_id)
VALUES
('SIVA', 101),
('RAVI', 102),
('NAVEEN', 103),
('RAMU', 104);
```

### Student Data

| id | name   | department_id |
| -: | ------ | ------------: |
|  1 | SIVA   |           101 |
|  2 | RAVI   |           102 |
|  3 | NAVEEN |           103 |
|  4 | RAMU   |           104 |

---

## Department Table

```sql
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
```

### Insert Data

```sql
INSERT INTO department
VALUES
(101, 'Python'),
(102, 'Java'),
(103, 'SQL'),
(105, 'Django');
```

### Department Data

| department_id | department_name |
| ------------: | --------------- |
|           101 | Python          |
|           102 | Java            |
|           103 | SQL             |
|           105 | Django          |

---

# 1. INNER JOIN

`INNER JOIN` returns only the rows that have a matching value in **both tables**.

### Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT
    student.name,
    department.department_name
FROM student
INNER JOIN department
ON student.department_id = department.department_id;
```

### Output

| name   | department_name |
| ------ | --------------- |
| SIVA   | Python          |
| RAVI   | Java            |
| NAVEEN | SQL             |

`RAMU` is not returned because department ID `104` does not exist in the department table.

### Important Point

```text
INNER JOIN → Only matching records
```

---

# 2. LEFT JOIN

`LEFT JOIN` returns:

* All rows from the **left table**
* Matching rows from the **right table**
* `NULL` when there is no matching row

### Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT
    student.name,
    department.department_name
FROM student
LEFT JOIN department
ON student.department_id = department.department_id;
```

### Output

| name   | department_name |
| ------ | --------------- |
| SIVA   | Python          |
| RAVI   | Java            |
| NAVEEN | SQL             |
| RAMU   | NULL            |

`RAMU` is included because `student` is the left table.

### Important Point

```text
LEFT JOIN → Everything from the LEFT table
```

---

# 3. RIGHT JOIN

`RIGHT JOIN` returns:

* All rows from the **right table**
* Matching rows from the left table
* `NULL` when there is no matching row

### Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;
```

### Example

```sql
SELECT
    student.name,
    department.department_name
FROM student
RIGHT JOIN department
ON student.department_id = department.department_id;
```

### Output

| name   | department_name |
| ------ | --------------- |
| SIVA   | Python          |
| RAVI   | Java            |
| NAVEEN | SQL             |
| NULL   | Django          |

`Django` is included because it exists in the right table.

### Important Point

```text
RIGHT JOIN → Everything from the RIGHT table
```

---

# 4. CROSS JOIN

`CROSS JOIN` returns **every possible combination** of rows from two tables.

There is normally no `ON` condition.

### Syntax

```sql
SELECT columns
FROM table1
CROSS JOIN table2;
```

### Example

```sql
SELECT
    student.name,
    department.department_name
FROM student
CROSS JOIN department;
```

There are:

```text
4 students × 4 departments = 16 combinations
```

### Example Output

| name   | department_name |
| ------ | --------------- |
| SIVA   | Python          |
| SIVA   | Java            |
| SIVA   | SQL             |
| SIVA   | Django          |
| RAVI   | Python          |
| RAVI   | Java            |
| RAVI   | SQL             |
| RAVI   | Django          |
| NAVEEN | Python          |
| NAVEEN | Java            |
| ...    | ...             |

### Important Point

```text
CROSS JOIN → Every possible combination
```

### Formula

```text
Number of rows =
Rows in Table 1 × Rows in Table 2
```

---

# 5. SELF JOIN

A **SELF JOIN** means joining a table with itself.

It is useful when rows in the same table have relationships with other rows in the same table.

For example, employees and their managers can be stored in the same table.

## Employee Table

```sql
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
);
```

### Insert Data

```sql
INSERT INTO employees
VALUES
(1, 'SIVA', NULL),
(2, 'NANI', 1),
(3, 'NAVEEN', 1),
(4, 'MAHI', 2);
```

### Employee Data

| employee_id | name   | manager_id |
| ----------: | ------ | ---------: |
|           1 | SIVA   |       NULL |
|           2 | NANI   |          1 |
|           3 | NAVEEN |          1 |
|           4 | MAHI   |          2 |

Here:

```text
NANI   → Manager ID 1 → SIVA
NAVEEN → Manager ID 1 → SIVA
MAHI   → Manager ID 2 → NANI
```

### Self Join Query

```sql
SELECT
    employee.name AS employee,
    manager.name AS manager
FROM employees AS employee
LEFT JOIN employees AS manager
ON employee.manager_id = manager.employee_id;
```

### Output

| employee | manager |
| -------- | ------- |
| SIVA     | NULL    |
| NANI     | SIVA    |
| NAVEEN   | SIVA    |
| MAHI     | NANI    |

### How does it work?

The same table is used twice:

```text
employees AS employee
        +
employees AS manager
```

The aliases allow us to treat the same table as two different roles.

```sql
employee.manager_id = manager.employee_id
```

### Important Point

```text
SELF JOIN → A table joined with itself
```

---

# JOIN Comparison

| JOIN         | Result                                    |
| ------------ | ----------------------------------------- |
| `INNER JOIN` | Only matching records                     |
| `LEFT JOIN`  | All left records + matching right records |
| `RIGHT JOIN` | All right records + matching left records |
| `CROSS JOIN` | Every possible combination                |
| `SELF JOIN`  | Table joined with itself                  |

---

# Visual Understanding

Suppose we have:

```text
TABLE A                  TABLE B

1                        1
2                        2
3                        3
4                        5
```

### INNER JOIN

```text
A ∩ B

1
2
3
```

Only matching records.

---

### LEFT JOIN

```text
ALL A + matching B

1
2
3
4
```

All records from A are preserved.

---

### RIGHT JOIN

```text
ALL B + matching A

1
2
3
5
```

All records from B are preserved.

---

### CROSS JOIN

```text
Every A × Every B
```

If A has 4 rows and B has 4 rows:

```text
4 × 4 = 16 rows
```

---

### SELF JOIN

```text
TABLE A
   ↓
TABLE A
```

The same table is used twice with different aliases.

---

# JOIN with WHERE

Joins can also be combined with `WHERE`.

### Example

Find students who belong to the SQL department.

```sql
SELECT
    student.name,
    department.department_name
FROM student
INNER JOIN department
ON student.department_id = department.department_id
WHERE department.department_name = 'SQL';
```

### Output

| name   | department_name |
| ------ | --------------- |
| NAVEEN | SQL             |

---

# JOIN with ORDER BY

We can also sort joined results.

```sql
SELECT
    student.name,
    department.department_name
FROM student
INNER JOIN department
ON student.department_id = department.department_id
ORDER BY student.name;
```

---

# JOIN with GROUP BY

Joins are commonly used with aggregate functions and `GROUP BY`.

For example, suppose we want to count students in each department.

```sql
SELECT
    department.department_name,
    COUNT(student.id) AS total_students
FROM department
LEFT JOIN student
ON department.department_id = student.department_id
GROUP BY department.department_name;
```

### Output

| department_name | total_students |
| --------------- | -------------: |
| Python          |              1 |
| Java            |              1 |
| SQL             |              1 |
| Django          |              0 |

Using `LEFT JOIN` allows us to display departments that currently have **zero students**.

---

# Real-World Use Cases

SQL Joins are used in many real-world applications.

### E-Commerce

```text
customers
    ↓
orders
```

Find which customers placed orders.

### College Management

```text
students
    ↓
departments
```

Find which department each student belongs to.

### Company Management

```text
employees
    ↓
managers
```

Find employees and their managers using a Self Join.

### Banking

```text
customers
    ↓
accounts
    ↓
transactions
```

Find customer account and transaction information.

### Online Shopping

```text
products
    ↓
categories
```

Find products and their categories.

---

# Important SQL JOIN Concepts

### `ON`

The `ON` clause specifies how two tables are related.

```sql
ON student.department_id = department.department_id
```

---

### Table Aliases

Aliases make queries shorter and easier to understand.

```sql
FROM employees AS employee
LEFT JOIN employees AS manager
```

Instead of repeatedly writing:

```sql
employees
```

we can use:

```text
employee
manager
```

---

### `NULL` in Joins

When there is no matching record, SQL returns `NULL` for columns from the table that has no match.

Example:

```text
RAMU → NULL
```

This means there is no matching department.

---

# Common Interview Questions

### 1. What is a JOIN?

A JOIN is used to combine data from two or more tables based on a related column.

### 2. What is the difference between INNER JOIN and LEFT JOIN?

```text
INNER JOIN → Only matching records

LEFT JOIN → All records from the left table
             + matching records from the right table
```

### 3. What is the difference between LEFT JOIN and RIGHT JOIN?

```text
LEFT JOIN  → Keeps all records from LEFT table

RIGHT JOIN → Keeps all records from RIGHT table
```

### 4. What is a CROSS JOIN?

A CROSS JOIN produces every possible combination of rows from two tables.

### 5. What is a SELF JOIN?

A SELF JOIN joins a table with itself.

### 6. Why are aliases used in a SELF JOIN?

Aliases allow the same table to be treated as two different instances or roles.

Example:

```sql
employees AS employee
employees AS manager
```

### 7. Which JOIN returns only matching records?

```text
INNER JOIN
```

### 8. Which JOIN returns all records from the left table?

```text
LEFT JOIN
```

### 9. Which JOIN returns all records from the right table?

```text
RIGHT JOIN
```

### 10. Which JOIN produces a Cartesian product?

```text
CROSS JOIN
```

---

# Quick Revision

```text
INNER JOIN
    ↓
Only matching rows

LEFT JOIN
    ↓
All LEFT rows + matching RIGHT rows

RIGHT JOIN
    ↓
All RIGHT rows + matching LEFT rows

CROSS JOIN
    ↓
Every possible combination

SELF JOIN
    ↓
Table joined with itself
```

---

# SQL Joins Roadmap

```text
SQL JOINS
│
├── INNER JOIN
│   └── Matching records
│
├── LEFT JOIN
│   └── All LEFT records
│
├── RIGHT JOIN
│   └── All RIGHT records
│
├── CROSS JOIN
│   └── Every combination
│
└── SELF JOIN
    └── Table joined with itself
```

## Key Takeaway

> **SQL Joins allow us to combine related information stored in different tables.**

The most commonly used joins in real-world SQL are **INNER JOIN** and **LEFT JOIN**. `SELF JOIN` is especially useful for hierarchical data such as employees and managers.
