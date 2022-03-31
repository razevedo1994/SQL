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


# Placement: WITH

### Use Case for With subquery:
- When a user wants to create a version of an existing table to be used in a larger query (e.g., aggregate daily prices to an average price table).
- It is advantageous for readability purposes.

### Sample 'With' subquery

```
WITH average_price as
( SELECT brand_id, AVG(product_price) as brand_avg_price
  FROM product_records
),
SELECT a.brand_id, a.total_brand_sales, b.brand_avg_price
FROM brand_table a
JOIN average_price b
ON b.brand_id = a.brand_id
ORDER BY a.total_brand_sales desc;
```

### CTE stands for Common Table Expression. A Common Table Expression in SQL allows you to define a temporary result, such as a table, to then be referenced in a later part of the query.

# WITH Quizzes

<p align="center">
  <img src="erd.png" >
</p>

- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
```
WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC), 
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;
```

- For the region with the largest sales total_amt_usd, how many total orders were placed?
```
WITH t1 AS (
   SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY r.name), 
t2 AS (
   SELECT MAX(total_amt)
   FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);
```

- For the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?
```
WITH t1 AS (
  SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
  FROM accounts a
  JOIN orders o
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1), 
t2 AS (
  SELECT a.name
  FROM orders o
  JOIN accounts a
  ON a.id = o.account_id
  GROUP BY 1
  HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;
```

- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
```
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;
```

- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
```
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;
```

- What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
```
WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;
```

# Placement: Nested

### Use Case for a Nested Subquery
- When a user wants to filter an output using a condition met from another table.
- This type of placement also has advantages for making the code easy to read.

### Example Nested Subquery
```
SELECT *
FROM students
WHERE student_id
IN (SELECT DISTINCT student_id
    FROM gpa_table
    WHERE gpa>3.5
    );
```

### Placement: Inline

### Use Case for Inline Subquery

- It is a very similar use case to ‘With’ subqueries.
  -Inline subqueries create a “pseudo table” that aggregates or manipulates an existing table to be used in a larger query.
- The disadvantage of the inline subquery is that it is not easy to read.

### Example Inline Query
```
SELECT dept_name,
       max_gpa
FROM department_db x
     (SELECT dept_id
             MAX(gpa) as max_gpa
      FROM students
      GROUP BY dept_id
      )y
WHERE x.dept_id = y.dept_id
ORDER BY dept_name;
```

### Placement: Scalar

### Use Case for Scalar subquery placement

- It selects only one column or expression and returns one row, used in the select clause of the main query
- It has the advantage of performance or if the data set is small

### Details:

- If a scalar subquery does not find a match, it returns a NULL.
- If a scalar subquery finds multiple matches, it returns an ERROR.

### Example Scalar Query
```
SELECT 
   (SELECT MAX(salary) FROM employees_db) AS top_salary,
   employee_name
FROM employees_db;
```

# Subqueries: Dependencies

### Simple Subquery
```
WITH dept_average AS 
  (SELECT dept, AVG(salary) AS avg_dept_salary
   FROM employee
   GROUP BY employee.dept
  )
SELECT E.eid, E.ename, D.avg_dept_salary
FROM employee E
JOIN dept.average D
ON E.dept = D.dept
WHERE E.salary > D.avg_dept_salary
```

### Correlated Subquery
```
SELECT employee_id,
       name
FROM employees_db emp
WHERE salary > 
      (SELECT AVG(salary)
       FROM employees_db
       WHERE department = emp.department
      );
```

The second concept to consider before writing any code is the dependency of your subquery to the larger query. A subquery can either be simple or correlated. In my experience, it’s better to keep subqueries simple to increase readability for other users that might leverage your code to run or adjust.

**Simple Subquery**: The inner subquery is completely independent of the larger query.

**Correlated Subquery**: The inner subquery is dependent on the larger query.

### When to use Correlated Query
However, sometimes, it’s slick to include a correlated subquery, specifically when the value of the inner query is dependent on a value outputted from the main query (e.g., the filter statement constantly changes). In the example below, you’ll notice that the value of the inner query -- average GPA -- keeps adjusting depending on the university the student goes to. THAT is a great use case for the correlated subquery.

```
SELECT first_name, last_name, GPA, university
 FROM student_db outer_db
 WHERE GPA >
                (SELECT AVG(GPA)
                 FROM student_db
                 WHERE university = outer_db.university);
```

