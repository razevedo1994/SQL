# Data Normalization

A denormalized table is, succinctly put, a "free-for-all". The only thing consistent about it is that it fits into rows and columns.

Some examples of things that can make data denormalized are:

- Inconsistent data types
- Repeating columns
- Repeating values

Denormalized data exhibits many issues:

- Inconsistent data types across a given column, making it difficult to manage and reason about
- Repeated columns, which disable us from scaling the number of items of related data
- Repeated values in a column, which make querying on those values more challenging
- The inability to uniquely identify rows of data to target them for manipulation
- Irrelevant dependencies, which cause repetitions and anomalies

# First Normal Form

Going from denormalized to First Normal Form — 1NF:

- Make all values in a column consistently of the same data type
- Make sure each cell contains only a single value
- Make sure there are no repeating columns for the same data (e.g. category 1, 2, 3…)
- Enable the rows of data to be uniquely identified through a column or combination of columns

- `Candidate key`: a set of one or more columns that can uniquely identify a row in a table
- `Primary key`: the key we choose from the candidate keys to uniquely represent a row in a table.