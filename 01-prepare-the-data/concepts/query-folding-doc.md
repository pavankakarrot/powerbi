# Query Folding

## Table of Contents
- [Overview](#overview)
- [Key Concepts](#key-concepts)
- [Implementation](#implementation)
- [Best Practices](#best-practices)
- [Common Pitfalls](#common-pitfalls)
- [Advanced Considerations](#advanced-considerations)
- [References](#references)
- [Contributing](#contributing)

## Overview
Query Folding is a critical performance optimization technique in Power Query/Power BI that translates data transformation steps into native queries (like SQL) for direct execution at the data source. This process significantly improves performance by pushing computations to the source database rather than loading all data locally first.


## Key Concepts

### Query Translation
- Power Query steps are converted to source-native queries
- Not all transformations can be folded
- Translation depends on data source capabilities

### Push-down Computation
- Transformations executed at data source
- Reduces data transfer volume
- Leverages source system's processing power

### Performance Benefits
- Minimized data transfer
- Reduced memory usage
- Faster refresh times
- Better resource utilization

## Implementation

### Checking Query Folding Status

```M
// View native query in Power Query
let
    Source = Sql.Database("server", "database"),
    Table = Source{[Schema="dbo",Item="TableName"]}[Data],
    FilteredRows = Table.SelectRows(Table, each [Column] > 100),
    // View native query
    NativeQuery = Value.NativeQuery(FilteredRows)
in
    NativeQuery
```

### Common Foldable Operations

```M
// Example of typically foldable operations
let
    Source = #"Previous Step",
    
    // Filtering - Foldable
    Filtered = Table.SelectRows(Source, each [Date] > #date(2024,1,1)),
    
    // Column Selection - Foldable
    SelectedColumns = Table.SelectColumns(Filtered, {"Column1", "Column2"}),
    
    // Grouping - Foldable
    Grouped = Table.Group(SelectedColumns, {"Category"}, {
        {"Count", each Table.RowCount(_), Int64.Type},
        {"Average", each List.Average([Sales]), type number}
    })
in
    Grouped
```

### Diagnostic Techniques

```M
// Enable query diagnostics in Power Query
// View > Query Diagnostics > Start Diagnostics
```

## Best Practices

### Query Design
1. Start with foldable operations
2. Keep transformation steps simple
3. Match data types with source
4. Use native functions when possible

### Performance Optimization
1. Monitor query folding status
2. Test with representative data volumes
3. Review generated native queries
4. Optimize data source connections

### Maintenance
1. Document folding decisions
2. Regular performance testing
3. Monitor source system impact
4. Update queries as needed

## Common Pitfalls

### Technical Issues
- Using custom functions that break folding
- Mixing data sources too early
- Incorrect data type conversions
- Complex transformations that can't fold

### Process Issues
- Not validating folding status
- Ignoring performance metrics
- Poor documentation
- Lack of testing

## Advanced Considerations

### Performance Monitoring
- Query execution plans
- Resource utilization
- Refresh time tracking
- Source system impact

### Optimization Strategies
- Partition large tables
- Implement incremental refresh
- Use query parameters
- Optimize source queries

## References

### Official Documentation
- [Microsoft Power Query Documentation](https://learn.microsoft.com/en-us/power-query/)
- [Power BI Performance Optimization Guide](https://learn.microsoft.com/en-us/power-bi/guidance/power-query-folding)

### Community Resources
- Power BI Community Forums
- Power Query M Reference
- SQL Server Documentation

## Contributing
Feel free to contribute to this documentation by:
1. Reporting issues
2. Suggesting improvements
3. Adding examples
4. Sharing best practices
