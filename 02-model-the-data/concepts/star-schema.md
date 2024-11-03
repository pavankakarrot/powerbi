# Star Schema & Data Modeling in Power BI

## Star Schema Fundamentals

### Fact Tables
1. Characteristics
   - Contains metrics/measures
   - Numerical values
   - Foreign keys to dimensions
   
2. Common Examples
```
FactSales
- OrderID (Key)
- CustomerID (FK)
- ProductID (FK)
- DateID (FK)
- Quantity (Measure)
- Amount (Measure)
- Cost (Measure)

FactOrders
- OrderID (Key)
- CustomerID (FK)
- OrderDate (FK)
- ShipDate (FK)
- Amount (Measure)
```

### Dimension Tables
1. Characteristics
   - Descriptive attributes
   - Primary keys
   - Hierarchies

2. Common Examples
```
DimCustomer
- CustomerID (PK)
- CustomerName
- CustomerType
- Country
- Region
- Segment

DimProduct
- ProductID (PK)
- ProductName
- Category
- Subcategory
- Brand
- Size
```

## Relationships

### Types of Relationships
1. One-to-Many (Most Common)
   ```
   DimProduct[ProductID] -> FactSales[ProductID]
   DimCustomer[CustomerID] -> FactSales[CustomerID]
   ```

2. Many-to-Many
   ```
   Using bridge tables:
   Products -> Bridge -> Categories
   ```

3. Role-Playing Dimensions
   ```
   DimDate related multiple times:
   - OrderDate
   - ShipDate
   - DueDate
   ```

## Best Practices

### Model Design
1. Naming Conventions
   ```
   - Fact tables: Fact or F prefix
   - Dimension tables: Dim or D prefix
   - Measures: No spaces, PascalCase
   ```

2. Key Management
   ```
   - Use integers for keys
   - Avoid composite keys
   - Consistent key names across tables
   ```

3. Date Tables
   ```
   - Mark official date table
   - Include all possible dates
   - Create standard hierarchies
   ```

### Performance Optimization
1. Table Structure
   - Remove unused columns
   - Appropriate data types
   - Optimize cardinality

2. Relationships
   - Avoid bidirectional
   - Limit number of relationships
   - Use inactive relationships wisely

## Common Patterns

### Slowly Changing Dimensions (SCD)
1. Type 1: Overwrite
   ```
   - Update existing records
   - No history maintained
   ```

2. Type 2: Historical
   ```
   - Keep history
   - Start/End dates
   - Current flag
   ```

### Snowflake Schema
```
Product -> Subcategory -> Category
Customer -> Region -> Country
```

## Implementation Steps
1. Identify Facts & Dimensions
2. Define Keys
3. Create Relationships
4. Set Up Hierarchies
5. Optimize Model

## Common Issues & Solutions

### Performance Problems
1. Issue: Slow Refresh
   ```
   Solution:
   - Check relationship cardinality
   - Review data types
   - Implement aggregations
   ```

2. Issue: Memory Usage
   ```
   Solution:
   - Remove unused columns
   - Use appropriate data types
   - Consider composite models
   ```

### Relationship Issues
1. Issue: Circular Dependencies
   ```
   Solution:
   - Use bridge tables
   - Redesign model
   - Create calculated tables
   ```

2. Issue: Multiple Paths
   ```
   Solution:
   - Use inactive relationships
   - Create role-playing dimensions
   - Use USERELATIONSHIP
   ```

## Model Documentation Template
```
Table Name:
- Purpose:
- Key Columns:
- Relationships:
- Special Considerations:
- Performance Notes:
```
