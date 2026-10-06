# 12. Advanced Query Concepts

**Advanced Query Concepts** are used to write complex SQL queries in a clean, readable, and powerful way.

In this section, we will learn:

* CTE (Common Table Expressions)
* Window Functions
* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`
* `LEAD()`
* `LAG()`

---

## 12.1 CTE (Common Table Expression)

A **CTE** is a temporary result set that can be used inside another SQL query.

CTEs make complex queries easier to read and understand.

### Syntax

```sql
WITH cte_name AS (
    SELECT column_name
    FROM table_name
    WHERE condition
)
SELECT *
FROM cte_name;
```

### Example

```sql
WITH HIGH_MARKS AS (
    SELECT *
    FROM STUDENT
    WHERE MARKS >= 80
)
SELECT *
FROM HIGH_MARKS;
```

### Explanation

The CTE first finds students whose marks are greater than or equal to `80`.

Then the main query retrieves the data from the CTE.

> A CTE exists only during the execution of the query.

---

# 12.2 Window Functions

A **Window Function** performs a calculation across a set of related rows without combining the rows into a single row.

Unlike `GROUP BY`, window functions keep the original rows.

### Syntax

```sql
SELECT
    column_name,
    WINDOW_FUNCTION() OVER (
        ORDER BY column_name
    )
FROM table_name;
```

### Example

```sql
SELECT
    NAME,
    MARKS,
    RANK() OVER (
        ORDER BY MARKS DESC
    ) AS RANKING
FROM STUDENT;
```

### Output

| NAME   | MARKS | RANKING |
| ------ | ----: | ------: |
| SIVA   |    95 |       1 |
| RAVI   |    85 |       2 |
| NAVEEN |    82 |       3 |

---

# 12.3 ROW_NUMBER()

`ROW_NUMBER()` assigns a **unique sequential number** to every row.

### Syntax

```sql
ROW_NUMBER() OVER (
    ORDER BY column_name
)
```

### Example

```sql
SELECT
    NAME,
    MARKS,
    ROW_NUMBER() OVER (
        ORDER BY MARKS DESC
    ) AS ROW_NUM
FROM STUDENT;
```

### Example Output

| NAME   | MARKS | ROW_NUM |
| ------ | ----: | ------: |
| SIVA   |    95 |       1 |
| RAVI   |    85 |       2 |
| NAVEEN |    82 |       3 |
| MAHI   |    82 |       4 |

Even if two students have the same marks, `ROW_NUMBER()` gives them different numbers.

---

# 12.4 RANK()

`RANK()` assigns the same rank to rows with the same value.

When there is a tie, the next rank is skipped.

### Example

```sql
SELECT
    NAME,
    MARKS,
    RANK() OVER (
        ORDER BY MARKS DESC
    ) AS RANKING
FROM STUDENT;
```

### Output

| NAME   | MARKS | RANKING |
| ------ | ----: | ------: |
| SIVA   |    95 |       1 |
| RAVI   |    85 |       2 |
| NAVEEN |    82 |       3 |
| MAHI   |    82 |       3 |
| HEMA   |    80 |       5 |

The ranking is:

```text
1
2
3
3
5
```

Rank `4` is skipped because two students have rank `3`.

---

# 12.5 DENSE_RANK()

`DENSE_RANK()` is similar to `RANK()`.

The main difference is that `DENSE_RANK()` **does not skip ranks** after a tie.

### Example

```sql
SELECT
    NAME,
    MARKS,
    DENSE_RANK() OVER (
        ORDER BY MARKS DESC
    ) AS DENSE_RANKING
FROM STUDENT;
```

### Output

| NAME   | MARKS | DENSE_RANKING |
| ------ | ----: | ------------: |
| SIVA   |    95 |             1 |
| RAVI   |    85 |             2 |
| NAVEEN |    82 |             3 |
| MAHI   |    82 |             3 |
| HEMA   |    80 |             4 |

The ranking is:

```text
1
2
3
3
4
```

---

# 12.6 LEAD()

`LEAD()` gets a value from the **next row**.

It is useful when we want to compare the current row with the following row.

### Syntax

```sql
LEAD(column_name) OVER (
    ORDER BY column_name
)
```

### Example

```sql
SELECT
    NAME,
    MARKS,
    LEAD(MARKS) OVER (
        ORDER BY MARKS DESC
    ) AS NEXT_MARKS
FROM STUDENT;
```

### Output

| NAME   | MARKS | NEXT_MARKS |
| ------ | ----: | ---------: |
| SIVA   |    95 |         85 |
| RAVI   |    85 |         82 |
| NAVEEN |    82 |         80 |
| HEMA   |    80 |       NULL |

The last row has no next row, so `LEAD()` returns `NULL`.

---

# 12.7 LAG()

`LAG()` gets a value from the **previous row**.

It is useful when we want to compare the current row with the previous row.

### Syntax

```sql
LAG(column_name) OVER (
    ORDER BY column_name
)
```

### Example

```sql
SELECT
    NAME,
    MARKS,
    LAG(MARKS) OVER (
        ORDER BY MARKS DESC
    ) AS PREVIOUS_MARKS
FROM STUDENT;
```

### Output

| NAME   | MARKS | PREVIOUS_MARKS |
| ------ | ----: | -------------: |
| SIVA   |    95 |           NULL |
| RAVI   |    85 |             95 |
| NAVEEN |    82 |             85 |
| HEMA   |    80 |             82 |

The first row has no previous row, so `LAG()` returns `NULL`.

---

# 12.8 PARTITION BY

`PARTITION BY` divides rows into groups before applying a window function.

### Example

```sql
SELECT
    NAME,
    CITY,
    MARKS,
    RANK() OVER (
        PARTITION BY CITY
        ORDER BY MARKS DESC
    ) AS CITY_RANK
FROM STUDENT;
```

Here, students are ranked separately for each city.

For example:

```text
HYDERABAD → 1, 2, 3
KHAMMAM   → 1, 2
WARANGAL  → 1, 2, 3
```

The ranking starts again from `1` for each city.

---

# 12.9 ROW_NUMBER() vs RANK() vs DENSE_RANK()

Suppose the marks are:

```text
95
85
82
82
80
```

### ROW_NUMBER()

```text
1
2
3
4
5
```

Every row gets a unique number.

### RANK()

```text
1
2
3
3
5
```

Same values get the same rank, and the next rank is skipped.

### DENSE_RANK()

```text
1
2
3
3
4
```

Same values get the same rank, but no rank is skipped.

### Comparison

| Function       | Same Values       | Skips Rank |
| -------------- | ----------------- | ---------- |
| `ROW_NUMBER()` | Different numbers | No         |
| `RANK()`       | Same rank         | Yes        |
| `DENSE_RANK()` | Same rank         | No         |

---

# 12.10 LEAD() vs LAG()

| Function | Purpose                              |
| -------- | ------------------------------------ |
| `LEAD()` | Gets the value from the next row     |
| `LAG()`  | Gets the value from the previous row |

### Easy Way to Remember

```text
LAG  → Look backward
LEAD → Look forward
```

---

# 12.11 Complete Example

The following query demonstrates the major window functions:

```sql
SELECT
    NAME,
    CITY,
    MARKS,

    ROW_NUMBER() OVER (
        ORDER BY MARKS DESC
    ) AS ROW_NUM,

    RANK() OVER (
        ORDER BY MARKS DESC
    ) AS RANKING,

    DENSE_RANK() OVER (
        ORDER BY MARKS DESC
    ) AS DENSE_RANKING,

    LEAD(MARKS) OVER (
        ORDER BY MARKS DESC
    ) AS NEXT_MARKS,

    LAG(MARKS) OVER (
        ORDER BY MARKS DESC
    ) AS PREVIOUS_MARKS

FROM STUDENT;
```

This query shows:

* Row numbering
* Ranking
* Dense ranking
* Next-row values
* Previous-row values

---

# 12.12 Quick Summary

| Concept             | Purpose                                           |
| ------------------- | ------------------------------------------------- |
| **CTE**             | Creates a temporary named result set              |
| **Window Function** | Performs calculations across related rows         |
| `ROW_NUMBER()`      | Gives every row a unique number                   |
| `RANK()`            | Gives equal values the same rank and skips ranks  |
| `DENSE_RANK()`      | Gives equal values the same rank without skipping |
| `LEAD()`            | Gets the value from the next row                  |
| `LAG()`             | Gets the value from the previous row              |
| `PARTITION BY`      | Divides rows into groups for window calculations  |

---

## Important Interview Points

```text
ROW_NUMBER → 1, 2, 3, 4
RANK       → 1, 2, 3, 3, 5
DENSE_RANK → 1, 2, 3, 3, 4

LAG  → Previous row
LEAD → Next row

CTE → Temporary named result used inside a query
```

**These concepts are commonly used in real-world SQL queries, data analysis, reporting, and SQL interviews.**
