# Data Sources in Power BI

## File-Based Sources
### Excel Files
- Basic connection steps
- Working with multiple sheets
- Named ranges
- Best practices
```
Steps:
1. Get Data > Excel
2. Navigate to file
3. Select sheets/ranges
4. Choose load or transform
```

### CSV Files
- Import considerations
- Delimiter handling
- Text qualifiers
- Common issues
```
Best Practices:
1. Check data types
2. Handle column headers
3. Consider locale settings
```

### Text Files
- Flat file handling
- Fixed width files
- Encoding options

## Database Sources
### SQL Server
- Connection modes
- Native query
- Performance considerations
```sql
-- Example native query
SELECT 
    DateKey,
    SUM(Sales) as TotalSales
FROM FactSales
GROUP BY DateKey
```

### Oracle
- Connection requirements
- Security options
- Performance tips

### MySQL
- Connection string
- Authentication methods
- Common issues

## Cloud Sources
### SharePoint
- File handling
- List connections
- Refresh considerations

### Azure
- Blob storage
- Azure SQL
- Synapse Analytics

## Web Sources
### Web Pages
- Table extraction
- Authentication
- Refresh limitations

### APIs
- REST connections
- Authentication methods
- JSON handling
```json
{
    "endpoint": "/api/data",
    "method": "GET",
    "headers": {
        "Authorization": "Bearer {token}"
    }
}
```

## Common Issues & Solutions

### Connection Problems
1. Issue: Authentication Failed
   ```
   Solution:
   - Check credentials
   - Verify permissions
   - Update gateway settings
   ```

2. Issue: Performance
   ```
   Solution:
   - Use native query
   - Implement query folding
   - Filter at source
   ```

## Best Practices Checklist
- [ ] Use appropriate connection mode
- [ ] Implement error handling
- [ ] Document data sources
- [ ] Plan refresh strategy
- [ ] Consider security implications
