# Power Query Parameters

## Overview
Power Query parameters are reusable values that can be referenced across multiple queries, enabling dynamic and flexible data transformations, and allowing for easy maintenance and updates of common values.

## 🎯 Key Concepts
1. **Parameter Creation:** Create parameters to store values like file paths, dates, or numbers, which can be easily adjusted.
2. **Dynamic Filtering:** Use parameters to filter data dynamically, such as setting a date range for records to include.
3. **Parameterized Queries:** Some databases support parameterized queries, allowing you to pass parameters directly in SQL queries or data connections for flexible data retrieval.
4. **Parameter Types:** Choose from types like text, number, date, or logical (true/false) to ensure parameters are compatible with transformations.
5. **Parameterization of Data Source Connections:** Useful for connecting to different environments (e.g., development vs. production) by changing the source path or server name via a parameter.
6. **User-Defined Inputs:** Configure parameters to accept user inputs, making it easy for users to adjust reports without changing the query itself.
7. **Parameter Dependencies:** Parameters can depend on each other, which is useful for settings that control related values, like minimum and maximum limits.
8. **Parameterized Reports:** Enable users to customize report outputs by inputting parameter values, like selecting a product category or date range.

## 📋 Types of Parameters

### 1. Basic Parameter Types
- Text
- Number
- Date/Time
- True/False
- Any
- Binary
- Date
- DateTime
- DateTimeZone
- Duration
- List
- None
- Record
- Table
- Time

## 🛠️ Implementation Guide

### Creating Parameters
```powerquery
// Basic Parameter Creation
let
    Source = DateTime.LocalNow(),
    CurrentYear = Number.From(Date.Year(Source)),
    #"Parameter Year" = CurrentYear
in
    #"Parameter Year"
```

### Common Parameter Usage Patterns

1. **Dynamic File Path**
```powerquery
let
    Source = Excel.Workbook(
        File.Contents(
            FilePath & FileName
        )
    )
in
    Source
```

2. **Dynamic Date Filtering**
```powerquery
let
    Source = Table.SelectRows(
        PreviousStep, 
        each [Date] >= StartDate and [Date] <= EndDate
    )
in
    Source
```

## 💡 Best Practices

1. **Naming Conventions**
   - Use clear, descriptive names
   - Follow consistent capitalization
   - Add prefixes for type indication

2. **Parameter Organization**
   - Group related parameters
   - Document parameter purpose
   - Set appropriate default values

3. **Security Considerations**
   - Avoid storing sensitive data
   - Use encrypted connections
   - Implement proper access controls

## ⚠️ Common Pitfalls
1. Hardcoding values instead of parameters
2. Incorrect parameter types
3. Missing error handling
4. Unclear parameter names
5. Redundant parameters

## 📊 Example Scenarios

### 1. Date Range Reports
```powerquery
let
    StartDate = #date(2024, 1, 1),
    EndDate = #date(2024, 12, 31),
    Source = Table.SelectRows(
        Data,
        each [Date] >= StartDate and [Date] <= EndDate
    )
in
    Source
```

### 2. Dynamic File Selection
```powerquery
let
    FolderPath = "C:\Data\",
    FileName = "Report.xlsx",
    FullPath = FolderPath & FileName,
    Source = Excel.Workbook(File.Contents(FullPath))
in
    Source
```

## 🔍 Testing & Validation
1. Parameter bounds checking
2. Type validation
3. Error handling
4. Performance impact
5. Refresh reliability

## 📈 Performance Considerations
- Parameter caching
- Query folding impact
- Refresh frequency
- Memory usage
- Processing time

## 🔄 Integration Patterns
1. Cross-query parameters
2. Template queries
3. Parameterized functions
4. Dynamic data sources
5. Conditional logic

## 📚 Related Topics
- Query Folding
- Custom Functions
- Error Handling
- Dynamic Data Loading
- Template Queries

## 🎓 Advanced Techniques
1. List parameters for multiple selections
2. Record parameters for complex configurations
3. Function parameters for dynamic logic
4. Date parameters with relative ranges
5. Conditional parameter usage
