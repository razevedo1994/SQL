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

