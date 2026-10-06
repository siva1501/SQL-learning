# 8. SQL Set Operations

SQL **Set Operations** are used to combine the results of two or more `SELECT` queries.

The main Set Operations are:

* `UNION`
* `UNION ALL`
* `INTERSECT`
* `EXCEPT`

## Important Rules

For Set Operations:

* Both queries should return the **same number of columns**.
* Corresponding columns should have **compatible data types**.
* The columns should be in the **same order**.

---

## 8.1 UNION

`UNION` combines the results of two `SELECT` queries and **removes duplicate rows**.

### Syntax

```sql
SELECT column_name
FROM table1

UNION

SELECT column_name
FROM table2;
```

### Example

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION

SELECT NAME
FROM SQL_STUDENTS;
```

### Example Data

**PYTHON_STUDENTS**

| ID | NAME   |
| -: | ------ |
|  1 | SIVA   |
|  2 | RAVI   |
|  3 | NAVEEN |

**SQL_STUDENTS**

| ID | NAME   |
| -: | ------ |
|  4 | MAHI   |
|  5 | RANI   |
|  3 | NAVEEN |

### Output

| NAME   |
| ------ |
| SIVA   |
| RAVI   |
| NAVEEN |
| MAHI   |
| RANI   |

`NAVEEN` exists in both tables, but `UNION` returns it only once.

---

## 8.2 UNION ALL

`UNION ALL` combines the results of two `SELECT` queries and **keeps duplicate rows**.

### Syntax

```sql
SELECT column_name
FROM table1

UNION ALL

SELECT column_name
FROM table2;
```

### Example

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION ALL

SELECT NAME
FROM SQL_STUDENTS;
```

### Output

| NAME   |
| ------ |
| SIVA   |
| RAVI   |
| NAVEEN |
| MAHI   |
| RANI   |
| NAVEEN |

Here, `NAVEEN` appears twice because the duplicate is not removed.

---

## 8.3 UNION vs UNION ALL

| UNION                                 | UNION ALL                          |
| ------------------------------------- | ---------------------------------- |
| Removes duplicates                    | Keeps duplicates                   |
| Returns unique rows                   | Returns all rows                   |
| Performs duplicate removal            | Does not remove duplicates         |
| Used when unique results are required | Used when all results are required |

### Example

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION

SELECT NAME
FROM SQL_STUDENTS;
```

Duplicate rows are removed.

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION ALL

SELECT NAME
FROM SQL_STUDENTS;
```

Duplicate rows are kept.

---

## 8.4 INTERSECT

`INTERSECT` returns only the rows that are **common to both queries**.

### Syntax

```sql
SELECT column_name
FROM table1

INTERSECT

SELECT column_name
FROM table2;
```

### Example

```sql
SELECT NAME
FROM PYTHON_STUDENTS

INTERSECT

SELECT NAME
FROM SQL_STUDENTS;
```

### Output

| NAME   |
| ------ |
| NAVEEN |

`NAVEEN` is present in both tables, so it is returned.

### Simple Meaning

```text
PYTHON_STUDENTS ∩ SQL_STUDENTS
        ↓
   Common Records
```

> **Note:** `INTERSECT` is supported in MySQL 8.0.31 and later.

---

## 8.5 EXCEPT

`EXCEPT` returns the rows that are present in the **first query but not in the second query**.

### Syntax

```sql
SELECT column_name
FROM table1

EXCEPT

SELECT column_name
FROM table2;
```

### Example

```sql
SELECT NAME
FROM PYTHON_STUDENTS

EXCEPT

SELECT NAME
FROM SQL_STUDENTS;
```

### Output

| NAME |
| ---- |
| SIVA |
| RAVI |

`SIVA` and `RAVI` exist only in `PYTHON_STUDENTS`.

`NAVEEN` exists in both tables, so it is removed.

### Important

The order of the queries matters.

```sql
A EXCEPT B
```

means:

> Records in A that are not present in B.

---

## 8.6 INTERSECT vs EXCEPT

| Operation   | Meaning                                    |
| ----------- | ------------------------------------------ |
| `INTERSECT` | Common rows in both queries                |
| `EXCEPT`    | Rows in the first query but not the second |

Example:

```text
Python Students = {SIVA, RAVI, NAVEEN}
SQL Students    = {NAVEEN, MAHI, RANI}

INTERSECT
→ {NAVEEN}

EXCEPT
→ {SIVA, RAVI}
```

---

## 8.7 Complete Example

### Create Tables

```sql
CREATE TABLE PYTHON_STUDENTS(
    ID INT,
    NAME VARCHAR(100)
);

CREATE TABLE SQL_STUDENTS(
    ID INT,
    NAME VARCHAR(100)
);
```

### Insert Data

```sql
INSERT INTO PYTHON_STUDENTS
VALUES
(1, 'SIVA'),
(2, 'RAVI'),
(3, 'NAVEEN');

INSERT INTO SQL_STUDENTS
VALUES
(4, 'MAHI'),
(5, 'RANI'),
(3, 'NAVEEN');
```

### UNION

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION

SELECT NAME
FROM SQL_STUDENTS;
```

**Result:**

```text
SIVA
RAVI
NAVEEN
MAHI
RANI
```

### UNION ALL

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION ALL

SELECT NAME
FROM SQL_STUDENTS;
```

**Result:**

```text
SIVA
RAVI
NAVEEN
MAHI
RANI
NAVEEN
```

### INTERSECT

```sql
SELECT NAME
FROM PYTHON_STUDENTS

INTERSECT

SELECT NAME
FROM SQL_STUDENTS;
```

**Result:**

```text
NAVEEN
```

### EXCEPT

```sql
SELECT NAME
FROM PYTHON_STUDENTS

EXCEPT

SELECT NAME
FROM SQL_STUDENTS;
```

**Result:**

```text
SIVA
RAVI
```

---

## 8.8 ORDER BY with Set Operations

`ORDER BY` can be used to sort the final combined result.

```sql
SELECT NAME
FROM PYTHON_STUDENTS

UNION

SELECT NAME
FROM SQL_STUDENTS

ORDER BY NAME;
```

This sorts the final result alphabetically.

---

## 8.9 Quick Comparison

| Set Operation | Purpose                           | Duplicate Handling |
| ------------- | --------------------------------- | ------------------ |
| `UNION`       | Combines two results              | Removes duplicates |
| `UNION ALL`   | Combines two results              | Keeps duplicates   |
| `INTERSECT`   | Finds common results              | Removes duplicates |
| `EXCEPT`      | Finds results only in first query | Removes duplicates |

---

## Interview Definition

**Set operations in SQL are used to combine the results of multiple `SELECT` queries. `UNION` removes duplicates, `UNION ALL` keeps duplicates, `INTERSECT` returns common rows, and `EXCEPT` returns rows that exist in the first query but not in the second query.**
