# Assignment Operator

The **Assignment Operator (`=`)** is used to **assign a value to a column** when inserting or updating data.

In SQL, the `=` operator is also commonly used for **comparison** inside conditions.

---

## 1. Assignment Operator (`=`)

The `=` operator is used with the `SET` clause to assign a new value to a column.

### Syntax

```sql
UPDATE table_name
SET column_name = value
WHERE condition;
```

### Example

```sql
UPDATE EMPLOYEES
SET SALARY = 90000
WHERE EMPLOYEE_ID = 1;
```

This query changes the salary of the employee whose `EMPLOYEE_ID` is `1` to `90000`.

### Before Update

| EMPLOYEE_ID | NAME | CITY | SALARY |
| ----------: | ---- | ---- | -----: |
|           1 | SIVA | HYD  |  40000 |

### After Update

| EMPLOYEE_ID | NAME | CITY | SALARY |
| ----------: | ---- | ---- | -----: |
|           1 | SIVA | HYD  |  90000 |

---

## 2. `=` for Comparison

The same `=` operator is also used to compare values in a `WHERE` condition.

### Example

```sql
SELECT *
FROM EMPLOYEES
WHERE CITY = 'KHMM';
```

This returns employees whose city is `KHMM`.

### Output

| EMPLOYEE_ID | NAME | CITY | SALARY |
| ----------: | ---- | ---- | -----: |
|           2 | RAVI | KHMM |  50000 |
|           5 | NANI | KHMM |  65000 |

---

## 3. Difference Between Assignment and Comparison

| Usage      | Example               | Meaning                      |
| ---------- | --------------------- | ---------------------------- |
| Assignment | `SET SALARY = 90000`  | Assign `90000` to SALARY     |
| Comparison | `WHERE CITY = 'KHMM'` | Check whether CITY is `KHMM` |

### Easy Way to Remember

```text
SET column = value
       ↓
   Assignment
```

```text
WHERE column = value
        ↓
    Comparison
```

---

## 4. Complete Example

```sql
CREATE DATABASE COMPENY;
USE COMPENY;

CREATE TABLE EMPLOYEES(
    EMPLOYEE_ID INT,
    NAME VARCHAR(100),
    DEPARTMENT_ID INT,
    CITY VARCHAR(100),
    SALARY INT,
    EMAIL VARCHAR(100)
);

INSERT INTO EMPLOYEES
VALUES
(1, 'SIVA', 1, 'HYD', 40000, 'SIVA@GAMIL.COM'),
(2, 'RAVI', 2, 'KHMM', 50000, NULL),
(3, 'NAVEEN', 3, 'SPL', 45000, 'NAVEEN@GMAIL.COM'),
(4, 'MAHI', 3, 'SPL', 60000, NULL),
(5, 'NANI', 1, 'KHMM', 65000, 'NANI@GMAIL.COM');

UPDATE EMPLOYEES
SET SALARY = 90000
WHERE EMPLOYEE_ID = 1;
```

Check the updated data:

```sql
SELECT *
FROM EMPLOYEES;
```

---

## Key Points

* `=` is called the **Assignment Operator** when used with `SET`.
* It assigns a value to a column.
* `UPDATE` is commonly used with assignment.
* `=` is also used for **comparison** in `WHERE`.
* Always use a `WHERE` condition when updating a specific row.
* Without `WHERE`, the `UPDATE` statement can modify **all rows**.

### Example Without `WHERE`

```sql
UPDATE EMPLOYEES
SET SALARY = 90000;
```

This updates the salary of **every employee** to `90000`.

So, be careful when using `UPDATE`.
