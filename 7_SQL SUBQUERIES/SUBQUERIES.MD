# 7. SQL Subqueries

A **subquery** is a SQL query written **inside another SQL query**.

The inner query is called the **subquery**, and the outer query is called the **main query**.

### Basic Structure

```sql
SELECT column_name
FROM table_name
WHERE column_name = (   
    SELECT column_name
    FROM table_name
    WHERE condition
);
```

Think of it like:

```text
Main Query
    ↓
uses the result of
    ↓
Subquery
```

---

# 7.1 Single-Row Subquery

A **single-row subquery** returns **only one value or one row**.

It is commonly used with operators such as:

* `=`
* `>`
* `<`
* `>=`
* `<=`
* `<>`

### Example Table: `STUDENT`

| id | name    | city      | marks |
| -: | ------- | --------- | ----: |
|  1 | SIVA    | HYDERABAD |    82 |
|  2 | RAVI    | KHAMMAM   |    95 |
|  3 | NAVEEN  | WARANGAL  |    80 |
|  4 | DHANUSH | SATUPALLY |    86 |
|  5 | SATISH  | HYDERABAD |    90 |

### Question

**Find students who scored more marks than SIVA.**

First, find SIVA's marks:

```sql
SELECT marks
FROM student
WHERE name = 'SIVA';
```

Output:

| marks |
| ----: |
|    82 |

Now we can use that result in the main query:

```sql
SELECT *
FROM student
WHERE marks > (
    SELECT marks
    FROM student
    WHERE name = 'SIVA'
);
```

### Output

| id | name    | city      | marks |
| -: | ------- | --------- | ----: |
|  2 | RAVI    | KHAMMAM   |    95 |
|  4 | DHANUSH | SATUPALLY |    86 |
|  5 | SATISH  | HYDERABAD |    90 |

### How it works

The subquery:

```sql
SELECT marks
FROM student
WHERE name = 'SIVA';
```

returns:

```text
82
```

So the main query effectively becomes:

```sql
SELECT *
FROM student
WHERE marks > 82;
```

### Important

A single-row subquery should return **one value** when used with `=`, `>`, `<`, etc.

---

# 7.2 Multi-Row Subquery

A **multi-row subquery** returns **multiple rows or values**.

Because multiple values are returned, we generally use:

* `IN`
* `ANY`
* `ALL`

### Example

Suppose we have a `DEPARTMENT` table:

| department_id | department_name |
| ------------: | --------------- |
|             1 | PYTHON          |
|             2 | SQL             |
|             3 | JAVA            |

And an `EMPLOYEES` table:

| employee_id | name   | department_id | salary |
| ----------: | ------ | ------------: | -----: |
|           1 | SIVA   |             1 |  40000 |
|           2 | RAVI   |             2 |  50000 |
|           3 | NAVEEN |             3 |  45000 |
|           4 | MAHI   |             2 |  60000 |

### Example Using `IN`

Find employees who belong to departments whose names are `PYTHON` or `SQL`.

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM department
    WHERE department_name IN ('PYTHON', 'SQL')
);
```

The subquery returns:

```text
1
2
```

So the main query becomes approximately:

```sql
SELECT *
FROM employees
WHERE department_id IN (1, 2);
```

### Output

| employee_id | name | department_id | salary |
| ----------: | ---- | ------------: | -----: |
|           1 | SIVA |             1 |  40000 |
|           2 | RAVI |             2 |  50000 |
|           4 | MAHI |             2 |  60000 |

---

## `ANY`

`ANY` means the condition should be true for **at least one value** returned by the subquery.

### Example

```sql
SELECT *
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 2
);
```

Suppose the department 2 salaries are:

```text
50000
60000
```

The condition:

```text
salary > ANY (50000, 60000)
```

means the salary must be greater than **at least one** of those values.

For example:

```text
65000 > 50000 → TRUE
```

Therefore, `65000` satisfies the condition.

---

## `ALL`

`ALL` means the condition should be true for **every value** returned by the subquery.

### Example

```sql
SELECT *
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 2
);
```

If the returned salaries are:

```text
50000
60000
```

then the condition must satisfy:

```text
salary > 50000
AND
salary > 60000
```

So the salary must be greater than `60000`.

### Easy Way to Remember

```text
ANY → at least one
ALL → every value
IN  → matches one of the returned values
```

---

# 7.3 Correlated Subquery

A **correlated subquery** is different from a normal subquery.

The subquery **depends on the current row of the outer query**.

In other words:

```text
Outer query gets one row
        ↓
Subquery checks that row
        ↓
Result is returned
        ↓
Outer query moves to next row
        ↓
Subquery runs again
```

### Example

Suppose we have:

| employee_id | name   | department_id | salary |
| ----------: | ------ | ------------: | -----: |
|           1 | SIVA   |             1 |  40000 |
|           2 | RAVI   |             1 |  50000 |
|           3 | NAVEEN |             2 |  45000 |
|           4 | MAHI   |             2 |  60000 |

### Question

**Find employees whose salary is greater than the average salary of their own department.**

We can use a correlated subquery:

```sql
SELECT e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

Notice this condition:

```sql
WHERE e2.department_id = e.department_id
```

The inner query uses:

```text
e.department_id
```

from the **outer query**.

That's what makes it a **correlated subquery**.

### Department 1

Employees:

```text
SIVA = 40000
RAVI = 50000
```

Average:

```text
(40000 + 50000) / 2 = 45000
```

RAVI's salary:

```text
50000 > 45000
```

So RAVI is selected.

### Department 2

Employees:

```text
NAVEEN = 45000
MAHI   = 60000
```

Average:

```text
(45000 + 60000) / 2 = 52500
```

MAHI's salary:

```text
60000 > 52500
```

So MAHI is selected.

### Output

| name | salary | department_id |
| ---- | -----: | ------------: |
| RAVI |  50000 |             1 |
| MAHI |  60000 |             2 |

---

# Normal vs Correlated Subquery

This is an important interview concept.

### Normal Subquery

The subquery can execute **independently**.

```sql
SELECT *
FROM student
WHERE marks > (
    SELECT AVG(marks)
    FROM student
);
```

The inner query:

```sql
SELECT AVG(marks)
FROM student;
```

doesn't depend on the outer query.

---

### Correlated Subquery

The subquery **depends on the outer query**.

```sql
SELECT e.name, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

The inner query uses:

```text
e.department_id
```

from the outer query.

---

# Quick Comparison

| Type       | Returns                   | Depends on outer query? | Common Operators        |
| ---------- | ------------------------- | ----------------------- | ----------------------- |
| Single-row | One value/row             | No                      | `=`, `>`, `<`, `>=`     |
| Multi-row  | Multiple values/rows      | No                      | `IN`, `ANY`, `ALL`      |
| Correlated | Depends on each outer row | **Yes**                 | `=`, `>`, `<`, `EXISTS` |

---

# Real-Time Examples

### Example 1: Employees Earning More Than Company Average

Find employees whose salary is greater than the company's average salary.

```sql
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

**Type:** Single-row subquery.

---

### Example 2: Employees from Selected Departments

Find employees working in the `PYTHON` or `SQL` departments.

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM department
    WHERE department_name IN ('PYTHON', 'SQL')
);
```

**Type:** Multi-row subquery.

---

### Example 3: Employees Above Their Department Average

Find employees whose salary is greater than the average salary of their own department.

```sql
SELECT e.name, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

**Type:** Correlated subquery.

---

# ⭐ Interview Points to Remember

```text
Subquery
   │
   ├── Single-row
   │      └── Returns one value
   │
   ├── Multi-row
   │      └── Returns multiple values
   │      └── IN / ANY / ALL
   │
   └── Correlated
          └── Depends on outer query
          └── Evaluated based on outer rows
```

### Most Important Difference

```text
Normal Subquery
→ Inner query can work independently.

Correlated Subquery
→ Inner query needs a value from the outer query.
```

### Final Memory Trick

```text
Single-Row
→ One result
→ =, >, <, >=, <=

Multi-Row
→ Multiple results
→ IN, ANY, ALL

Correlated
→ Depends on outer query
→ Uses outer query column
→ Evaluated for each outer row
```
