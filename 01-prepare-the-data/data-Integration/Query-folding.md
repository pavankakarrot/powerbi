# Query Folding

## Overview
Query folding is the process where Power Query pushes data transformation operations back to the source database, optimizing performance by reducing data transfer and leveraging source system capabilities.


## 🎯 Key Concepts
1. **Push-Down Logic:** This is the core idea of query folding. Transformations, like filtering or sorting, are “pushed” to the data source instead of being done locally on your computer. The data source does the work, sending only the necessary results.
2. **Supported Transformations:** Not every data transformation can be folded. Common actions like filtering rows, selecting columns, grouping data, and simple calculations (like adding a column) are usually supported. But complex steps (like custom functions) may not be folded.
3. **Folding Indicators:** Some data tools, like Power Query, show an indicator when query folding is happening. This helps you see which steps are folded (handled by the data source) and which aren’t.
4. **Performance Benefits:** Query folding can make data transformations faster by letting the database do the heavy work. This can be crucial with large datasets because it reduces data transfer and processing load on your machine.
5. **Foldable vs. Non-Foldable Steps:** In a series of steps, some might be foldable, and some might not. Folding will continue only until it reaches a non-foldable step. Once a non-foldable step is hit, the remaining steps are performed locally, stopping the folding process.
6. **Diagnostics for Query Folding:** Some tools offer diagnostics or "view native query" options, where you can see the exact query that’s being sent to the data source. This is useful for debugging and understanding what’s being folded.

## 📋 Common Use Cases
1. Large dataset transformations
2. Complex filtering operations
3. Join operations
4. Aggregations
5. Column selection

## 🛠️ Implementation Guide

### Checking Query Folding Status
```powerquery
let
    Source = Sql.Database("server", "database"),
    Query = Source{[Schema="dbo",Item="TableName"]}[Data],
    FilteredRows = Table.SelectRows(Query, each [Column] > 100)
in
    FilteredRows
```

### Best Practices
1. Keep transformations foldable
   - Use built-in functions
   - Avoid custom functions when possible
   - Maintain data types

2. Monitor query performance
   - View native queries
   - Check execution plans
   - Validate folding status

## ⚠️ Common Pitfalls
- Custom columns breaking folding
- Incorrect data type conversions
- Complex transformations
- Unsupported operations

## 📊 Performance Metrics
| Operation Type | Folded | Not Folded |
|---------------|---------|------------|
| Filtering     | Fast    | Slow       |
| Aggregation   | Fast    | Slow       |
| Joins         | Fast    | Slow       |

## 🔍 Validation Methods
1. View Native Query
2. Check "View Native Query" option
3. Monitor query execution time
4. Analyze data preview loading time

## 📚 Related Topics
- Data Source Optimizations
- Query Optimization Techniques
- Performance Tuning
- Data Loading Patterns

## 🎓 Additional Resources
- Microsoft Documentation
- Community Forums
- Best Practices Guides
