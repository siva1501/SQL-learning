# 9. Database Modification

Database Modification commands are used to **change, update, remove, or modify data and table structures**.

The main Database Modification commands are:

* `UPDATE`
* `DELETE`
* `ALTER TABLE`
* `DROP`
* `TRUNCATE`

---

## 1. UPDATE

The `UPDATE` command is used to **modify existing records** in a table.

### Syntax

```sql
UPDATE table_name
SET column_name = value
WHERE condition;
```

### Example

```sql
UPDATE STUDENT
SET MARKS = 90
WHERE ID = 1;
```

This changes the marks of the student whose `ID` is `1`.

### Update Multiple Columns

```sql
UPDATE STUDENT
SET CITY = 'HYDERABAD',
    MARKS = 95
WHERE ID = 1;
```

### Important

Always use a `WHERE` condition when updating specific records.

```sql
UPDATE STUDENT
SET MARKS = 90;
```

The above query updates **all rows** because there is no `WHERE` condition.

---

## 2. DELETE

The `DELETE` command is used to **remove records from a table**.

### Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

### Example

```sql
DELETE FROM STUDENT
WHERE ID = 3;
```

This removes the student whose `ID` is `3`.

### Delete Multiple Records

```sql
DELETE FROM STUDENT
WHERE MARKS < 50;
```

This removes all students whose marks are below `50`.

### Delete All Records

```sql
DELETE FROM STUDENT;
```

This removes all rows, but the **table structure remains**.

---

## 3. ALTER TABLE

`ALTER TABLE` is used to **modify the structure of an existing table**.

It can be used to:

* Add a column
* Modify a column
* Rename a column
* Drop a column

---

### Add a Column

```sql
ALTER TABLE STUDENT
ADD EMAIL VARCHAR(100);
```

This adds an `EMAIL` column to the `STUDENT` table.

---

### Modify a Column

```sql
ALTER TABLE STUDENT
MODIFY NAME VARCHAR(150);
```

This changes the definition of the `NAME` column.

---

### Rename a Column

```sql
ALTER TABLE STUDENT
RENAME COLUMN NAME TO STUDENT_NAME;
```

This changes the column name from `NAME` to `STUDENT_NAME`.

---

### Drop a Column

```sql
ALTER TABLE STUDENT
DROP COLUMN EMAIL;
```

This removes the `EMAIL` column from the table.

---

## 4. DROP

The `DROP` command is used to **completely remove a database object**.

### Drop a Table

```sql
DROP TABLE STUDENT;
```

This removes:

* The table structure
* All data in the table

### Drop a Database

```sql
DROP DATABASE COLLEGE;
```

This removes the entire database and its tables.

> **Important:** Use `DROP` carefully because the database object is completely removed.

---

## 5. TRUNCATE

The `TRUNCATE` command is used to **remove all records from a table while keeping the table structure**.

### Syntax

```sql
TRUNCATE TABLE table_name;
```

### Example

```sql
TRUNCATE TABLE STUDENT;
```

After executing this command:

* All rows are removed.
* The table still exists.
* Columns and table structure remain.
* New records can be inserted.

---

# DELETE vs TRUNCATE vs DROP

| Command    | Removes Rows | Removes Table Structure | WHERE |
| ---------- | ------------ | ----------------------- | ----- |
| `DELETE`   | Yes          | No                      | Yes   |
| `TRUNCATE` | All rows     | No                      | No    |
| `DROP`     | Yes          | Yes                     | No    |

### Easy Way to Remember

```text
DELETE
→ Remove selected rows

TRUNCATE
→ Remove all rows

DROP
→ Remove the table/database
```

---

# UPDATE vs ALTER TABLE

`UPDATE` changes **data**.

```sql
UPDATE STUDENT
SET MARKS = 90
WHERE ID = 1;
```

`ALTER TABLE` changes the **table structure**.

```sql
ALTER TABLE STUDENT
ADD EMAIL VARCHAR(100);
```

---

# Quick Revision

| Command       | Purpose                               |
| ------------- | ------------------------------------- |
| `UPDATE`      | Modify existing data                  |
| `DELETE`      | Remove rows                           |
| `ALTER TABLE` | Modify table structure                |
| `TRUNCATE`    | Remove all rows but keep the table    |
| `DROP`        | Completely remove a table or database |

---

## Key Points

* `UPDATE` is used to change existing records.
* `DELETE` is used to remove specific or all rows.
* `ALTER TABLE` is used to modify table structure.
* `TRUNCATE` removes all rows but keeps the table.
* `DROP` removes the table or database completely.
* Use `WHERE` carefully with `UPDATE` and `DELETE`.
* `DELETE` can remove selected rows using `WHERE`.
* `TRUNCATE` always removes all rows.
* `DROP` removes both the data and structure.
