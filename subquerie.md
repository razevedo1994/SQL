# Subqueries

### What exactly is a subquery?

 A subquery is a query within a query.
- As a reminder, a query has both SELECT and FROM clauses to signify what you want to extract from a table and what table you’d like to pull data from. A query that includes subquery, as a result, has multiple SELECT and FROM clauses.
- The subquery that sits nested inside a larger query is called an INNER QUERY. This inner query can be fully executed on its own and often is run independently before when trying to troubleshoot bugs in your code.

### Example:

```
SELECT product_id,
       name,
       price
FROM db.product
Where price > (SELECT AVG(price)
              FROM db.product)
```

### When do you need to use a subquery?

You need to use a subquery when you have the need to manipulate an existing table to “pseudo-create” a table that is then used as a part of a larger query. In the examples below, existing tables cannot be joined together to solve the problem at hand. Instead, an existing table needs to be manipulated, massaged, or aggregated in some way to then join to another table in the dataset to answer the posed question.

### Set of Problems:

Identify the top-selling Amazon products in months where sales have exceeded $1m
- Existing Table: Amazon daily sales;
- Subquery Aggregation: Daily to Monthly;

Examine the average price of a brand’s products for the highest-grossing brands
- Existing Table: Product pricing data across all retailers;
- Subquery Aggregation: Individual to Average;

Order the annual salary of employees that are working less than 150 hours a month
- Existing Table: Daily time-table of employees;
- Subquery Aggregation: Daily to Monthly;

Subqueries are great tools for aggregating across specific dimensions in your dataset.

# Subqueries vs. Joins

Often, SQL users will question the differences between joins and subqueries. After all, they essentially do the same thing: join tables together to create a single output. However, there are times when subqueries are more appropriate than joins and vice versa. In this section of our lesson, we’ll cover the differences between the two and when to use each.

### Differences between Subqueries and Joins

**Use Cases:**
*Subquery*: When an existing table needs to be manipulated or aggregated to then be joined to a larger table.

*Joins*: A fully flexible and discretionary use case where a user wants to bring two or more tables together and select and filter as needed.

**Syntax:**
*Subquery*: A subquery is a query within a query. The syntax, as a result, has multiple SELECT and FROM clauses.

*Joins*: A join is simple stitching together multiple tables with a common key or column. A join clause cannot stand and be run independently.

**Dependencies:**
*Subquery*: A subquery clause can be run completely independently. When trying to debug code, subqueries are often run independently to pressure test results before running the larger query.

*Joins*: A join clause cannot stand and be run independently.

### Similarities between Subqueries and Joins

**Output:**
Both subqueries and joins are essentially bringing multiple tables together (whether an existing table is first manipulated or not) to generate a single output.

# Subquery Basics

### Fundamentals to Know about Subqueries:
- Subqueries must be fully placed inside parentheses.
- Subqueries must be fully independent and can be executed on their own
- Subqueries have two components to consider:
  - Where it’s placed
  - Dependencies with the outer/larger query

### A caveat with subqueries being independent:

In almost all cases, subqueries are fully independent. They are "interim”/temp tables that can be fully executed on their own. However, there is an exception. When a subquery, typically in the form of a nested or inline subquery, is correlated to its outer query, it cannot run independently. This is most certainly an edge case since correlated subqueries are rarely implemented compared to standalone, simple subqueries.

### Placement:
There are four places where subqueries can be inserted within a larger query:

- With
- Nested
- Inline
- Scalar

### Dependencies:
A subquery can be dependent on the outer query or independent of the outer query.

# Subqueries: Placement

The key concept of placement is where exactly the subquery is placed within the context of the larger query. There are four different places where a subquery can be inserted. The decision of which placement to leverage stems from (1) the problem at hand and (2) the readability of the query.

### Subquery Placement:
**With**: This subquery is used when you’d like to “pseudo-create” a table from an existing table and **visually scope** the temporary table at the top of the larger query.
```
WITH subquery_name (column_name1, ...) AS
 (SELECT ...)
SELECT ...
```

**Nested**: This subquery is used when you’d like the temporary table to act as a filter within the larger query, which implies that it often sits within the **where clause**.
```
SELECT s.s_id, s.s_name, g.final_grade
FROM student s, grades g
WHERE s.s_id = g.s_id
IN (SELECT final_grade
    FROM grades g
    WHERE final_grade >3.7
   );

```

**Inline**: This subquery is used in the same fashion as the **WITH** use case above. However, instead of the temporary table sitting on top of the larger query, it’s embedded within the **from clause**.
```
SELECT student_name
FROM
  (SELECT student_id, student_name, grade
   FROM student
   WHERE teacher =10)
WHERE grade >80;
```

**Scalar**: This subquery is used when you’d like to generate a scalar value to be used as a benchmark of some sort.
```
SELECT s.student_name
  (SELECT AVG(final_score)
   FROM grades g
   WHERE g.student_id = s.student_id) AS
     avg_score
FROM student s;
```

For example, when you’d like to calculate the average salary across an entire organization to compare to individual employee salaries. Because it’s often a single value that is generated and used as a benchmark, the scalar subquery often sits within the select clause.

### Advantages:
**Readability**: With and Nested subqueries are most advantageous for readability.

**Performance**: Scalar subqueries are advantageous for performance and are often used on smaller datasets.


