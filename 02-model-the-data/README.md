# Data Modeling in Power BI

## 🎯 Learning Objectives
- Understanding data modeling concepts
- Creating effective data relationships
- Writing basic to advanced DAX
- Optimizing model performance

## 📊 Data Modeling Fundamentals

### Star Schema
1. Fact Tables
   - Contain measures and metrics
   - Usually numerical data
   - Transaction-level details

2. Dimension Tables
   - Contain descriptive attributes
   - Looking information
   - Categories and hierarchies

### Common Relationships
1. One-to-Many (Most Common)
   ```
   Products [ProductID] -> Sales [ProductID]
   Customers [CustomerID] -> Sales [CustomerID]
   ```

2. Many-to-Many
   - Using bridge tables
   - Handling complex relationships
   - When to use them

## 📝 DAX Basics

### Common Calculations
1. Simple Measures
   ```dax
   Total Sales = SUM(Sales[Amount])
   Average Price = AVERAGE(Products[Price])
   Total Quantity = SUM(Sales[Quantity])
   ```

2. Time Intelligence
   ```dax
   YTD Sales = 
   CALCULATE(
       SUM(Sales[Amount]),
       DATESYTD(Calendar[Date])
   )
   ```

3. Filter Context
   ```dax
   Sales YoY Growth = 
   VAR CurrentSales = [Total Sales]
   VAR PreviousSales = 
        CALCULATE(
            [Total Sales],
            SAMEPERIODLASTYEAR(Calendar[Date])
        )
   RETURN
   DIVIDE(
       CurrentSales - PreviousSales,
       PreviousSales
   )
   ```

## 🔧 Performance Optimization

### Best Practices
1. Model Design
   - Minimize table relationships
   - Use integers for keys
   - Avoid bidirectional filtering

2. Memory Usage
   - Remove unused columns
   - Use appropriate data types
   - Implement data archiving

3. Calculation Optimization
   - Use variables in DAX
   - Avoid complex calculations in visuals
   - Implement incremental refresh

## 👩‍💻 Exercises

### Basic Modeling
1. Create a star schema
   - Set up fact table
   - Create dimension tables
   - Establish relationships

### DAX Practice
1. Basic Calculations
   - Create sum measures
   - Calculate percentages
   - Use time intelligence

### Advanced Topics
1. Complex Relationships
   - Many-to-many relationships
   - Role-playing dimensions
   - Slowly changing dimensions

## ⚠️ Common Issues and Solutions

### Performance Problems
- Symptom: Slow report refresh
- Solution: Optimize relationships
- Prevention: Follow best practices

### DAX Errors
- Symptom: Wrong calculations
- Solution: Check filter context
- Prevention: Use variables

## ✅ Checklist
- [ ] Understand star schema
- [ ] Create basic relationships
- [ ] Write simple DAX measures
- [ ] Implement time intelligence
- [ ] Optimize performance

## 📚 Additional Resources
- Microsoft DAX Documentation
- Power BI Community Forums
- Video Tutorials
- Practice Datasets
