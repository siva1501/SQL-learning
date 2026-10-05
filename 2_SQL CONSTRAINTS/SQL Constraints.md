# SQL Constraints

SQL Constraints are rules applied to table columns to control what data can be stored in a database.

## Topics Covered

* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* AUTO_INCREMENT
* DEFAULT
* CHECK

---

## 1. NOT NULL

`NOT NULL` ensures that a column cannot contain `NULL` values.

### Example

```sql
CREATE TABLE student (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    age INT
);
```

The `id` and `name` columns must contain a value.

### Valid

```sql
INSERT INTO student (id, name, age)
VALUES (1, 'Siva', 22);
```

### Invalid

```sql
INSERT INTO student (id, age)
VALUES (2, 21);
```

`name` is `NOT NULL`, so a value must be provided.

---

## 2. UNIQUE

`UNIQUE` ensures that duplicate values are not allowed in a column.

### Example

```sql
CREATE TABLE student (
    id INT,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);
```

### Valid

```sql
INSERT INTO student
VALUES (1, 'Siva', 'siva@gmail.com');
```

### Invalid

```sql
INSERT INTO student
VALUES (2, 'Ravi', 'siva@gmail.com');
```

The email already exists, so the duplicate value is rejected.

---

## 3. PRIMARY KEY

`PRIMARY KEY` uniquely identifies each record in a table.

A primary key is:

```text
NOT NULL + UNIQUE
```

### Example

```sql
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
```

### Insert Data

```sql
INSERT INTO student
VALUES (1, 'Siva', 22);

INSERT INTO student
VALUES (2, 'Ravi', 21);
```

The `id` identifies each student uniquely.

---

## 4. FOREIGN KEY

`FOREIGN KEY` creates a relationship between two tables.

It references a key in another table and helps maintain referential integrity.

### Parent Table

```sql
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
```

### Insert Data

```sql
INSERT INTO department
VALUES
(101, 'Python'),
(102, 'Java');
```

### Child Table

```sql
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES department(department_id)
);
```

### Insert Data

```sql
INSERT INTO student
VALUES (1, 'Siva', 101);

INSERT INTO student
VALUES (2, 'Ravi', 102);
```

Here:

```text
department.department_id
          ↑
          |
student.department_id
```

The `student` table uses `department_id` as a foreign key.

---

## 5. AUTO_INCREMENT

`AUTO_INCREMENT` automatically generates a new numeric value for each inserted record.

### Example

```sql
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
```

### Insert Data

```sql
INSERT INTO student (name)
VALUES ('Siva');

INSERT INTO student (name)
VALUES ('Ravi');

INSERT INTO student (name)
VALUES ('Kiran');
```

### Output

```text
+----+-------+
| id | name  |
+----+-------+
|  1 | Siva  |
|  2 | Ravi  |
|  3 | Kiran |
+----+-------+
```

The `id` is generated automatically.

---

## 6. DEFAULT

`DEFAULT` provides a default value when no value is supplied.

### Example

```sql
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50) DEFAULT 'Hyderabad'
);
```

### Insert Data

```sql
INSERT INTO student (id, name)
VALUES (1, 'Siva');
```

### Output

```text
+----+------+-----------+
| id | name | city      |
+----+------+-----------+
|  1 | Siva | Hyderabad |
+----+------+-----------+
```

Since `city` was not provided, the default value `Hyderabad` is used.

---

## 7. CHECK

`CHECK` ensures that inserted values satisfy a specified condition.

### Example

```sql
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT CHECK (age >= 18)
);
```

### Valid

```sql
INSERT INTO student
VALUES (1, 'Siva', 22);
```

### Invalid

```sql
INSERT INTO student
VALUES (2, 'Ravi', 15);
```

The value `15` does not satisfy:

```text
age >= 18
```

Therefore, the value is rejected.

---

# All Constraints Together


CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    city VARCHAR(50) DEFAULT 'Hyderabad',
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES department(department_id)
);

# Quick Revision

| Constraint       | Purpose                         |
| ---------------- | ------------------------------- |
| `NOT NULL`       | Column cannot contain NULL      |
| `UNIQUE`         | Prevents duplicate values       |
| `PRIMARY KEY`    | Uniquely identifies each record |
| `FOREIGN KEY`    | Connects two tables             |
| `AUTO_INCREMENT` | Automatically generates numbers |
| `DEFAULT`        | Provides a default value        |
| `CHECK`          | Validates a condition           |

## Easy Way to Remember

NOT NULL       → Must have a value
UNIQUE         → No duplicates
PRIMARY KEY    → Identifies a row
FOREIGN KEY    → Connects tables
AUTO_INCREMENT → Generates ID automatically
DEFAULT        → Gives a default value
CHECK          → Validates a condition
