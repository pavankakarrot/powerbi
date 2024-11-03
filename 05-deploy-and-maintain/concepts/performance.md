# Power BI Performance Optimization

## 📊 Model Optimization

### 1. Data Model
```
Best Practices:
- Star schema
- Appropriate data types
- Remove unused columns
- Optimize relationships
```

### 2. Query Folding
```
Implementation:
- Source transformations
- Native queries
- Avoid custom columns
- Minimize steps
```

## 🔄 DAX Optimization

### 1. Measure Optimization
```dax
// Poor Performance
Bad_Measure = 
CALCULATE(
    SUM(Sales[Amount]),
    FILTER(ALL(Calendar), Calendar[Year] = 2023)
)

// Better Performance
Good_Measure = 
CALCULATE(
    SUM(Sales[Amount]),
    REMOVEFILTERS(Calendar),
    Calendar[Year] = 2023
)
```

### 2. Variable Usage
```dax
// Optimized with Variables
Optimized_Measure = 
VAR CurrentSales = SUM(Sales[Amount])
VAR PreviousSales = 
    CALCULATE(
        SUM(Sales[Amount]),
        DATEADD(Calendar[Date], -1, YEAR)
    )
RETURN
DIVIDE(
    CurrentSales - PreviousSales,
    PreviousSales
)
```

## 🚀 Report Performance

### 1. Visual Optimization
```
Guidelines:
- Limit visuals per page
- Use bookmarks
- Implement filtering
- Avoid overlapping
```

### 2. Interaction Settings
```
Configuration:
- Visual interactions
- Filter impact
- Drill-through
- Cross-filtering
```

## 💾 Data Refresh

### 1. Incremental Refresh
```
Setup:
- Date ranges
- Policies
- Parameters
- Partition strategy
```

### 2. Refresh Optimization
```
Strategies:
- Schedule optimization
- Parallel loading
- Error handling
- Monitoring
```

## 📈 Monitoring Tools

### 1. Performance Analyzer
```
Metrics:
- DAX query time
- Visual display time
- Resources used
- Bottlenecks
```

### 2. DAX Studio
```
Analysis:
- Query plans
- Server timings
- Memory usage
- Storage engine
```

## 🎯 Optimization Techniques

### 1. Aggregations
```
Implementation:
- Usage patterns
- Storage modes
- Grain level
- Benefits analysis
```

### 2. Composite Models
```
Configuration:
- DirectQuery
- Import
- Dual
- Storage mode
```

## ⚡ Advanced Optimization

### 1. Vertical Filtering
```dax
// Optimize Column Selection
Optimized_Filter = 
CALCULATETABLE(
    SELECTCOLUMNS(
        Sales,
        "Date", Sales[Date],
        "Amount", Sales[Amount]
    ),
    Sales[Date] >= DATE(2023,1,1)
)
```

### 2. Horizontal Filtering
```dax
// Early Filtering
Early_Filter = 
VAR FilteredDates = 
    FILTER(
        Calendar,
        Calendar[Year] = 2023
    )
RETURN
CALCULATE(
    [Sales Amount],
    FilteredDates
)
```

## 📝 Documentation

### 1. Performance Log
```
Recording:
- Issue description
- Solutions applied
- Impact measurement
- Future recommendations
```

### 2. Optimization Registry
```
Tracking:
- Optimization attempts
- Results
- Benchmarks
- Best practices
```

## ✅ Performance Checklist

### 1. Model Review
- [ ] Data model structure
- [ ] Relationships
- [ ] Data types
- [ ] Unused items

### 2. Query Review
- [ ] Query folding
- [ ] Transform efficiency
- [ ] Native queries
- [ ] Load performance

### 3. Visual Review
- [ ] Number of visuals
- [ ] Interaction settings
- [ ] Filter impact
- [ ] Resource usage

### 4. Regular Maintenance
- [ ] Performance monitoring
- [ ] Optimization updates
- [ ] User feedback
- [ ] Documentation
