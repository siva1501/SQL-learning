# 3. SQL Filtering & Sorting

Filtering and Sorting are used to **filter specific records** and **arrange the query results**.

---

## 1. `WHERE`

`WHERE` is used to filter records based on a condition.

### Syntax

```sql
SELECT *
FROM student
WHERE condition;
```

### Example

```sql
SELECT *
FROM student
WHERE city = 'Hyderabad';
```

This returns only the students whose city is Hyderabad.

---

## 2. `AND`

`AND` is used when **both conditions must be true**.

### Syntax

```sql
SELECT *
FROM student
WHERE condition1
AND condition2;
```

### Example

```sql
SELECT *
FROM student
WHERE city = 'Hyderabad'
AND marks > 85;
```

This returns students who are:

* From Hyderabad
* AND have marks greater than 85

Both conditions must be satisfied.

### Example

```sql
SELECT *
FROM student
WHERE marks >= 70
AND age >= 20;
```

---

## 3. `OR`

`OR` is used when **at least one condition must be true**.

### Example

```sql
SELECT *
FROM student
WHERE city = 'Hyderabad'
OR city = 'Warangal';
```

This returns students from either Hyderabad or Warangal.

### Difference between `AND` and `OR`

```text
AND → Both conditions must be TRUE
OR  → At least one condition must be TRUE
```

---

## 4. `NOT`

`NOT` is used to **reverse a condition**.

### Example

```sql
SELECT *
FROM student
WHERE NOT city = 'Hyderabad';
```

This returns students who are not from Hyderabad.

Another way:

```sql
SELECT *
FROM student
WHERE city != 'Hyderabad';
```

---

## 5. `IN`

`IN` is used to check **multiple values**.

Instead of writing:

```sql
SELECT *
FROM student
WHERE city = 'Hyderabad'
OR city = 'Warangal'
OR city = 'Khammam';
```

We can use:

```sql
SELECT *
FROM student
WHERE city IN ('Hyderabad', 'Warangal', 'Khammam');
```

This is shorter and easier to read.

### `NOT IN`

```sql
SELECT *
FROM student
WHERE city NOT IN ('Hyderabad', 'Warangal');
```

This returns students whose city is not Hyderabad or Warangal.

---

## 6. `BETWEEN`

`BETWEEN` is used to check whether a value is within a range.

### Example

```sql
SELECT *
FROM student
WHERE marks BETWEEN 70 AND 90;
```

This returns students whose marks are from **70 to 90**.

`BETWEEN` includes both boundary values.

```text
70 <= marks <= 90
```

### Another Example

```sql
SELECT *
FROM student
WHERE age BETWEEN 20 AND 25;
```

---

## 7. `LIKE`

`LIKE` is used for **pattern matching**.

It is mainly used with text values.

### Important Wildcards

```text
% → Zero or more characters
_ → Exactly one character
```

### Starts with `S`

```sql
SELECT *
FROM student
WHERE name LIKE 'S%';
```

Example matches:

```text
Siva
Suresh
Sanjay
```

### Ends with `a`

```sql
SELECT *
FROM student
WHERE name LIKE '%a';
```

### Contains `a`

```sql
SELECT *
FROM student
WHERE name LIKE '%a%';
```

### Exactly 4 characters

```sql
SELECT *
FROM student
WHERE name LIKE '____';
```

Each `_` represents exactly one character.

For example:

```text
Siva  → 4 characters → Match
Ravi  → 4 characters → Match
Nani  → 4 characters → Match
Kiran → 5 characters → No match
```

---

## 8. `IS NULL`

`NULL` means **no value / missing value**.

To find NULL values, use `IS NULL`.

### Example

```sql
SELECT *
FROM student
WHERE email IS NULL;
```

This returns students whose email is missing.

### Do NOT use

```sql
WHERE email = NULL;
```

Use:

```sql
WHERE email IS NULL;
```

### `IS NOT NULL`

To find records where a value exists:

```sql
SELECT *
FROM student
WHERE email IS NOT NULL;
```

---

## 9. `ORDER BY`

`ORDER BY` is used to **sort the result**.

### Ascending Order

```sql
SELECT *
FROM student
ORDER BY marks ASC;
```

`ASC` means:

```text
Small → Large
```

Example:

```text
65
72
78
85
90
```

### Descending Order

```sql
SELECT *
FROM student
ORDER BY marks DESC;
```

`DESC` means:

```text
Large → Small
```

Example:

```text
90
85
78
72
65
```

### Example

```sql
SELECT name, marks
FROM student
ORDER BY marks DESC;
```

This displays students from highest marks to lowest marks.

---

## 10. `LIMIT`

`LIMIT` is used to **restrict the number of rows returned**.

### Example

```sql
SELECT *
FROM student
LIMIT 3;
```

Only the first 3 rows are returned.

### Top 3 students

We can combine `ORDER BY` and `LIMIT`.

```sql
SELECT *
FROM student
ORDER BY marks DESC
LIMIT 3;
```

This returns the **3 students with the highest marks**.

---

# Combining Filtering & Sorting

SQL commands can be combined to create more useful queries.

### Example 1

```sql
SELECT *
FROM student
WHERE city = 'Hyderabad'
AND marks > 80
ORDER BY marks DESC;
```

Meaning:

1. Find Hyderabad students
2. Marks must be greater than 80
3. Sort marks from highest to lowest

---

### Example 2

```sql
SELECT *
FROM student
WHERE city IN ('Hyderabad', 'Warangal')
AND marks >= 70
ORDER BY marks DESC
LIMIT 3;
```

Meaning:

1. Students must be from Hyderabad or Warangal
2. Marks must be at least 70
3. Sort by marks from highest to lowest
4. Show only 3 rows

---

# SQL Query Order

When using these commands together, remember this order:

```sql
SELECT
FROM
WHERE
ORDER BY
LIMIT;
```

### Example

```sql
SELECT name, marks
FROM student
WHERE marks >= 70
ORDER BY marks DESC
LIMIT 3;
```

---

# Quick Revision

| Command    | Purpose                             |
| ---------- | ----------------------------------- |
| `WHERE`    | Filter records                      |
| `AND`      | All conditions must be true         |
| `OR`       | At least one condition must be true |
| `NOT`      | Reverse a condition                 |
| `IN`       | Check multiple values               |
| `BETWEEN`  | Check a range                       |
| `LIKE`     | Pattern matching                    |
| `IS NULL`  | Find missing values                 |
| `ORDER BY` | Sort records                        |
| `LIMIT`    | Limit the number of records         |

---

## Key Points to Remember

```text
WHERE   → Filter
AND     → Both conditions
OR      → Either condition
NOT     → Opposite condition
IN      → Multiple values
BETWEEN → Range
LIKE    → Pattern
IS NULL → Missing value
ORDER BY → Sort
LIMIT   → Number of rows
```

### Example of a complete query

```sql
SELECT name, city, marks
FROM student
WHERE city IN ('Hyderabad', 'Warangal')
AND marks BETWEEN 70 AND 90
ORDER BY marks DESC
LIMIT 3;
```

This is a combination of **Filtering + Sorting + Limiting**.
