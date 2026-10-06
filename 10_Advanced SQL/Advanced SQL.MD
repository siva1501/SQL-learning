# 10. Advanced SQL

Advanced SQL concepts are used to build **efficient, reusable, and reliable database applications**.

### Topics Covered

* Views
* Indexes
* Stored Procedures
* Stored Functions
* Triggers
* Transactions
* `COMMIT`
* `ROLLBACK`
* `SAVEPOINT`

---

## 10.1 Views

A **View** is a virtual table created from the result of a SQL query.

### Syntax

```sql
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;
```

### Example

```sql
CREATE VIEW HIGH_SALARY_EMPLOYEES AS
SELECT NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 50000;
```

Use the View:

```sql
SELECT *
FROM HIGH_SALARY_EMPLOYEES;
```

Delete a View:

```sql
DROP VIEW HIGH_SALARY_EMPLOYEES;
```

### Advantages of Views

* Simplifies complex queries
* Improves security
* Hides unnecessary columns
* Makes frequently used queries reusable

---

## 10.2 Indexes

An **Index** is used to make searching and retrieving data faster.

It works similar to the index of a book, allowing the database to find data more efficiently.

### Create an Index

```sql
CREATE INDEX idx_employee_name
ON EMPLOYEES(NAME);
```

Example query:

```sql
SELECT *
FROM EMPLOYEES
WHERE NAME = 'SIVA';
```

### Unique Index

```sql
CREATE UNIQUE INDEX idx_employee_email
ON EMPLOYEES(EMAIL);
```

### Delete an Index

```sql
DROP INDEX idx_employee_name ON EMPLOYEES;
```

### Advantages

* Faster searching
* Faster filtering
* Useful for frequently searched columns

### Disadvantage

Indexes require additional storage and can slow down `INSERT`, `UPDATE`, and `DELETE` operations.

---

## 10.3 Stored Procedures

A **Stored Procedure** is a group of SQL statements stored in the database and executed whenever required.

### Syntax

```sql
DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    SQL statements;
END //

DELIMITER ;
```

### Example

```sql
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEES()
BEGIN
    SELECT *
    FROM EMPLOYEES;
END //

DELIMITER ;
```

Execute the procedure:

```sql
CALL GET_EMPLOYEES();
```

### Procedure with Parameter

```sql
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEE_BY_CITY(IN CITY_NAME VARCHAR(100))
BEGIN
    SELECT *
    FROM EMPLOYEES
    WHERE CITY = CITY_NAME;
END //

DELIMITER ;
```

Call the procedure:

```sql
CALL GET_EMPLOYEE_BY_CITY('HYD');
```

### Advantages

* Reusable SQL code
* Reduces repeated queries
* Accepts parameters
* Useful for business logic

---

## 10.4 Stored Functions

A **Stored Function** is a stored SQL program that **must return a value**.

### Syntax

```sql
DELIMITER //

CREATE FUNCTION function_name(parameter datatype)
RETURNS datatype
DETERMINISTIC
BEGIN
    RETURN value;
END //

DELIMITER ;
```

### Example

Calculate annual salary:

```sql
DELIMITER //

CREATE FUNCTION ANNUAL_SALARY(MONTHLY_SALARY INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN MONTHLY_SALARY * 12;
END //

DELIMITER ;
```

Use the function:

```sql
SELECT NAME, SALARY, ANNUAL_SALARY(SALARY) AS YEARLY_SALARY
FROM EMPLOYEES;
```

### Procedure vs Function

| Stored Procedure                | Stored Function             |
| ------------------------------- | --------------------------- |
| Called using `CALL`             | Used inside SQL expressions |
| Does not have to return a value | Must return a value         |
| Can perform multiple operations | Returns a value             |
| `CALL procedure_name()`         | `SELECT function_name()`    |

---

## 10.5 Triggers

A **Trigger** is automatically executed when a specific event occurs in a table.

Common events:

* `INSERT`
* `UPDATE`
* `DELETE`

### Example

Create an employee table:

```sql
CREATE TABLE EMPLOYEES(
    EMPLOYEE_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    SALARY INT
);
```

Create a log table:

```sql
CREATE TABLE EMPLOYEE_LOG(
    EMPLOYEE_ID INT,
    ACTION VARCHAR(50)
);
```

Create a trigger:

```sql
DELIMITER //

CREATE TRIGGER AFTER_EMPLOYEE_INSERT
AFTER INSERT ON EMPLOYEES
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_LOG
    VALUES (NEW.EMPLOYEE_ID, 'EMPLOYEE INSERTED');
END //

DELIMITER ;
```

Insert an employee:

```sql
INSERT INTO EMPLOYEES
VALUES (1, 'SIVA', 50000);
```

The trigger automatically inserts a record into `EMPLOYEE_LOG`.

```sql
SELECT *
FROM EMPLOYEE_LOG;
```

### `NEW` and `OLD`

* `NEW` → New value
* `OLD` → Previous value

Example:

```sql
NEW.SALARY
```

represents the new salary value.

---

## 10.6 Transactions

A **Transaction** is a group of SQL operations treated as **one unit of work**.

A transaction follows the idea:

```text
Successful Transaction → COMMIT
Failed Transaction     → ROLLBACK
```

### Example

```sql
START TRANSACTION;

UPDATE EMPLOYEES
SET SALARY = 60000
WHERE EMPLOYEE_ID = 1;

UPDATE EMPLOYEES
SET SALARY = 70000
WHERE EMPLOYEE_ID = 2;

COMMIT;
```

Both changes are saved when the transaction is committed.

---

## 10.7 COMMIT

`COMMIT` permanently saves the changes made during a transaction.

### Example

```sql
START TRANSACTION;

UPDATE EMPLOYEES
SET SALARY = 60000
WHERE EMPLOYEE_ID = 1;

COMMIT;
```

After `COMMIT`, the changes are permanently saved.

### Flow

```text
START TRANSACTION
        ↓
      UPDATE
        ↓
      COMMIT
        ↓
 Changes Saved
```

---

## 10.8 ROLLBACK

`ROLLBACK` cancels changes made during the current transaction that have not been committed.

### Example

```sql
START TRANSACTION;

UPDATE EMPLOYEES
SET SALARY = 100000
WHERE EMPLOYEE_ID = 1;

ROLLBACK;
```

The salary change is cancelled.

### Flow

```text
START TRANSACTION
        ↓
      UPDATE
        ↓
    ROLLBACK
        ↓
 Changes Cancelled
```

---

## 10.9 SAVEPOINT

A **SAVEPOINT** creates a checkpoint inside a transaction.

It allows us to roll back to a specific point without cancelling the entire transaction.

### Example

```sql
START TRANSACTION;

UPDATE EMPLOYEES
SET SALARY = 60000
WHERE EMPLOYEE_ID = 1;

SAVEPOINT salary_update;

UPDATE EMPLOYEES
SET SALARY = 70000
WHERE EMPLOYEE_ID = 2;

ROLLBACK TO salary_update;

COMMIT;
```

### Explanation

1. Employee 1 salary is updated.
2. A savepoint is created.
3. Employee 2 salary is updated.
4. `ROLLBACK TO salary_update` cancels the second update.
5. `COMMIT` saves the first update.

### Flow

```text
START TRANSACTION
        ↓
     UPDATE 1
        ↓
    SAVEPOINT
        ↓
     UPDATE 2
        ↓
ROLLBACK TO SAVEPOINT
        ↓
      COMMIT
```

---

## Quick Summary

| Concept            | Purpose                                     |
| ------------------ | ------------------------------------------- |
| `VIEW`             | Creates a virtual table                     |
| `INDEX`            | Improves data searching speed               |
| `STORED PROCEDURE` | Stores reusable SQL operations              |
| `STORED FUNCTION`  | Stores reusable logic that returns a value  |
| `TRIGGER`          | Automatically executes when an event occurs |
| `TRANSACTION`      | Groups SQL operations into one unit         |
| `COMMIT`           | Permanently saves changes                   |
| `ROLLBACK`         | Cancels uncommitted changes                 |
| `SAVEPOINT`        | Creates a checkpoint inside a transaction   |

---

## Advanced SQL Structure

```text
Advanced SQL
│
├── Views
├── Indexes
├── Stored Procedures
├── Stored Functions
├── Triggers
└── Transactions
    ├── COMMIT
    ├── ROLLBACK
    └── SAVEPOINT
```
