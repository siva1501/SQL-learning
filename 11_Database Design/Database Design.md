# 11. Database Design

**Database Design** is the process of organizing data into tables and defining relationships between those tables.

Good database design helps to:

* Avoid duplicate data
* Keep data consistent
* Make data easy to maintain
* Improve data accuracy
* Create relationships between tables

---

## 11.1 Database Relationships

A **database relationship** describes how tables are connected to each other.

There are three common types of relationships:

### 1. One-to-One (1:1)

One record in Table A is related to one record in Table B.

**Example:**

One student has one student ID card.

```text
STUDENT
---------
ID
NAME

STUDENT_CARD
------------
CARD_ID
STUDENT_ID
```

Relationship:

```text
STUDENT  1 ───── 1  STUDENT_CARD
```

---

### 2. One-to-Many (1:N)

One record in Table A can be related to many records in Table B.

**Example:**

One department can have many employees.

```text
DEPARTMENT
----------
DEPARTMENT_ID
DEPARTMENT_NAME
```

```text
EMPLOYEE
--------
EMPLOYEE_ID
NAME
DEPARTMENT_ID
```

Relationship:

```text
DEPARTMENT  1 ───── N  EMPLOYEE
```

Here, `DEPARTMENT_ID` in the `EMPLOYEE` table is a **Foreign Key**.

---

### 3. Many-to-Many (M:N)

Many records in Table A can be related to many records in Table B.

**Example:**

A student can enroll in many courses, and a course can have many students.

```text
STUDENT
-------
STUDENT_ID
NAME
```

```text
COURSE
------
COURSE_ID
COURSE_NAME
```

A junction table is used to create the relationship:

```text
STUDENT_COURSE
--------------
STUDENT_ID
COURSE_ID
```

Relationship:

```text
STUDENT  N ───── M  COURSE
```

---

# 11.2 ER Diagrams

**ER** stands for **Entity-Relationship**.

An **ER Diagram** is a visual representation of:

* Entities
* Attributes
* Relationships

### Example

```text
┌──────────────────┐
│    DEPARTMENT    │
├──────────────────┤
│ PK department_id │
│ department_name  │
└────────┬─────────┘
         │
         │ 1
         │
         │ N
┌────────▼─────────┐
│     STUDENT      │
├──────────────────┤
│ PK student_id    │
│ name             │
│ department_id FK │
└──────────────────┘
```

This means:

> One department can have many students.

### Common ER Diagram Terms

| Term        | Meaning                                    |
| ----------- | ------------------------------------------ |
| Entity      | A real-world object represented as a table |
| Attribute   | A property represented as a column         |
| Primary Key | Unique identifier                          |
| Foreign Key | Connects two tables                        |
| 1:1         | One-to-One                                 |
| 1:N         | One-to-Many                                |
| M:N         | Many-to-Many                               |

---

# 11.3 Normalization

**Normalization** is the process of organizing database tables to reduce **data duplication** and improve **data consistency**.

The main normal forms are:

```text
1NF → 2NF → 3NF
```

Each normal form improves the database structure.

---

# 11.4 First Normal Form (1NF)

A table is in **1NF** when:

1. Each column contains **atomic values**.
2. There are no repeating groups.
3. Each row can be uniquely identified.

### Not in 1NF

```text
STUDENT
--------------------------------
ID | NAME | SUBJECTS
--------------------------------
1  | SIVA | SQL, Python, Java
2  | RAVI | SQL, Java
```

The `SUBJECTS` column contains multiple values.

### In 1NF

```text
STUDENT
-------------------------
ID | NAME | SUBJECT
-------------------------
1  | SIVA | SQL
1  | SIVA | Python
1  | SIVA | Java
2  | RAVI | SQL
2  | RAVI | Java
```

Now each cell contains a single value.

---

# 11.5 Second Normal Form (2NF)

A table is in **2NF** when:

1. It is already in **1NF**.
2. There is **no partial dependency**.

Partial dependency occurs when a non-key column depends on only part of a **composite key**.

### Example

```text
STUDENT_COURSE
--------------------------------
STUDENT_ID | COURSE_ID | STUDENT_NAME
--------------------------------
1          | 101       | SIVA
1          | 102       | SIVA
2          | 101       | RAVI
```

Suppose the primary key is:

```text
(STUDENT_ID, COURSE_ID)
```

But:

```text
STUDENT_ID → STUDENT_NAME
```

`STUDENT_NAME` depends only on `STUDENT_ID`, not on the complete composite key.

This is called a **partial dependency**.

### Convert to 2NF

Create separate tables:

```text
STUDENT
----------------
STUDENT_ID
STUDENT_NAME
```

```text
COURSE
----------------
COURSE_ID
COURSE_NAME
```

```text
STUDENT_COURSE
------------------------
STUDENT_ID
COURSE_ID
```

Now there is no partial dependency.

---

# 11.6 Third Normal Form (3NF)

A table is in **3NF** when:

1. It is already in **2NF**.
2. There is **no transitive dependency**.

### Example

```text
EMPLOYEE
---------------------------------------------
EMPLOYEE_ID | EMPLOYEE_NAME | DEPT_ID | DEPT_NAME
---------------------------------------------
1           | SIVA          | 10      | PYTHON
2           | RAVI          | 20      | JAVA
3           | NAVEEN        | 10      | PYTHON
```

Here:

```text
EMPLOYEE_ID → DEPT_ID
DEPT_ID → DEPT_NAME
```

Therefore:

```text
EMPLOYEE_ID → DEPT_NAME
```

This is a **transitive dependency**.

### Convert to 3NF

Create two tables.

**EMPLOYEE**

```text
EMPLOYEE
------------------------------
EMPLOYEE_ID | EMPLOYEE_NAME | DEPT_ID
```

**DEPARTMENT**

```text
DEPARTMENT
-------------------------
DEPT_ID | DEPT_NAME
```

Now the department name is stored only once.

---

# 11.7 Database Keys

A **key** is a column or combination of columns used to identify records or create relationships between tables.

Important database keys are:

* Primary Key
* Foreign Key
* Candidate Key
* Composite Key

---

## Primary Key

A **Primary Key** uniquely identifies each row in a table.

Properties:

* Must be unique
* Cannot contain `NULL`
* A table can have one primary key constraint
* A primary key can contain one or multiple columns

### Example

```sql
CREATE TABLE STUDENT (
    ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    CITY VARCHAR(100)
);
```

Here, `ID` is the **Primary Key**.

---

## Foreign Key

A **Foreign Key** is used to create a relationship between two tables.

It references a **Primary Key** or unique key in another table.

### Example

```sql
CREATE TABLE DEPARTMENT (
    DEPARTMENT_ID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(100)
);
```

```sql
CREATE TABLE STUDENT (
    STUDENT_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    DEPARTMENT_ID INT,
    FOREIGN KEY (DEPARTMENT_ID)
        REFERENCES DEPARTMENT(DEPARTMENT_ID)
);
```

Here:

```text
DEPARTMENT.DEPT_ID
        ↑
        |
        | Foreign Key
        |
STUDENT.DEPT_ID
```

---

# Candidate Key

A **Candidate Key** is a column or combination of columns that can uniquely identify a row.

A table can have multiple candidate keys, but one of them is selected as the **Primary Key**.

### Example

```text
STUDENT
--------------------------------
ID | EMAIL            | NAME
--------------------------------
1  | siva@gmail.com   | SIVA
2  | ravi@gmail.com   | RAVI
3  | naveen@gmail.com | NAVEEN
```

Both `ID` and `EMAIL` can uniquely identify a student.

Therefore:

```text
Candidate Keys:
    ID
    EMAIL
```

If we select `ID` as the Primary Key:

```text
Primary Key = ID
Candidate Key = EMAIL
```

---

# Composite Key

A **Composite Key** is a key made up of **two or more columns**.

It is useful when one column alone cannot uniquely identify a record.

### Example

```text
STUDENT_COURSE
---------------------------
STUDENT_ID | COURSE_ID
---------------------------
1          | 101
1          | 102
2          | 101
```

Neither `STUDENT_ID` nor `COURSE_ID` is unique by itself.

But together:

```text
STUDENT_ID + COURSE_ID
```

uniquely identifies each record.

### SQL Example

```sql
CREATE TABLE STUDENT_COURSE (
    STUDENT_ID INT,
    COURSE_ID INT,
    PRIMARY KEY (STUDENT_ID, COURSE_ID)
);
```

Here:

```text
(STUDENT_ID, COURSE_ID)
```

is the **Composite Primary Key**.

---

# Quick Summary

| Concept               | Meaning                                           |
| --------------------- | ------------------------------------------------- |
| Database Relationship | Connection between tables                         |
| ER Diagram            | Visual representation of tables and relationships |
| Normalization         | Organizing data to reduce duplication             |
| 1NF                   | Atomic/single values                              |
| 2NF                   | No partial dependency                             |
| 3NF                   | No transitive dependency                          |
| Primary Key           | Uniquely identifies each row                      |
| Foreign Key           | Connects tables                                   |
| Candidate Key         | Possible unique identifier                        |
| Composite Key         | Key made from multiple columns                    |

---

# Normalization Flow

```text
             NORMALIZATION
                   │
                   ▼
                  1NF
           Atomic Values
                   │
                   ▼
                  2NF
        No Partial Dependency
                   │
                   ▼
                  3NF
       No Transitive Dependency
```

---

## Interview Points

* **Primary Key** uniquely identifies a row.
* **Foreign Key** creates a relationship between tables.
* **Candidate Key** is a possible key that can uniquely identify a row.
* **Composite Key** contains two or more columns.
* **1NF** removes multiple values from a single cell.
* **2NF** removes partial dependency.
* **3NF** removes transitive dependency.
* **ER Diagram** visually represents entities and their relationships.
* **Normalization** helps reduce duplicate data and improve consistency.
