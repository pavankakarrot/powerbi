# Query Folding

## Overview
Query folding is the process where Power Query pushes data transformation operations back to the source database, optimizing performance by reducing data transfer and leveraging source system capabilities.

## 🎯 Key Concepts
- Native query generation
- Performance optimization
- Source-side processing
- Query translation

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
