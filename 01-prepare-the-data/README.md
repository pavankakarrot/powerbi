# Data Preparation in Power BI

## 🎯 Learning Objectives
- Understanding different data sources
- Mastering Power Query basics
- Learning data cleaning techniques
- Implementing best practices

## 📚 Data Sources Overview

### Common Data Sources
1. Files
   - Excel (.xlsx, .xls)
   - CSV
   - Text files (.txt)
   - JSON

2. Databases
   - SQL Server
   - MySQL
   - PostgreSQL
   - Oracle

3. Online Services
   - SharePoint
   - Azure
   - Salesforce
   - Web APIs

## 🔄 Power Query Basics

### Essential Transformations
1. Column Management
   ```
   - Remove columns
   - Rename columns
   - Reorder columns
   - Change data types
   ```

2. Row Operations
   ```
   - Filter rows
   - Remove duplicates
   - Sort data
   - Keep/remove top rows
   ```

3. Data Cleaning
   ```
   - Replace values
   - Handle null values
   - Trim spaces
   - Split columns
   ```

## 👩‍💻 Hands-On Practice

### Exercise 1: Basic Data Loading
1. Load sample Excel file
2. Remove unnecessary columns
3. Change data types
4. Create custom column

### Exercise 2: Data Transformation
1. Merge queries
2. Split columns
3. Create calculated columns
4. Handle errors

## ⚠️ Common Issues and Solutions

### Problem 1: Data Type Errors
- Symptom: Numbers importing as text
- Solution: Use 'Changed Type' transformation
- Prevention: Set correct locale settings

### Problem 2: Refresh Errors
- Symptom: Data refresh fails
- Solution: Check data source connectivity
- Prevention: Use robust connection methods

## 📝 Best Practices

1. Data Source Connection
   - Use parameters for file paths
   - Implement error handling
   - Document connection details

2. Query Organization
   - Use clear naming conventions
   - Create reference tables
   - Document transformations

3. Performance Optimization
   - Remove unused columns early
   - Filter data at source
   - Use native queries when possible

## 🎯 Practice Tasks

### Basic Level
1. Connect to Excel file
   - Remove blank rows
   - Change data types
   - Create simple calculated column

### Intermediate Level
1. Merge multiple tables
2. Create parameter queries
3. Implement error handling

### Advanced Level
1. Create custom functions
2. Advanced M language queries
3. Complex transformations

## 📚 Resources

### Official Documentation
- [Power Query M Documentation](https://docs.microsoft.com/en-us/powerquery-m/)
- [Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)

### Recommended Learning Path
1. Start with basic transformations
2. Practice data cleaning
3. Learn about merge and append
4. Explore advanced features

## ✅ Checklist
- [ ] Understand basic data sources
- [ ] Master essential transformations
- [ ] Complete basic exercises
- [ ] Practice error handling
- [ ] Implement best practices

## 📝 Notes Section
Add your notes and learnings here as you progress!
