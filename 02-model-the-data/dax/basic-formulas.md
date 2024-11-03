# DAX Formulas and Patterns

## Basic Calculations

### Sales Measures
```dax
// Total Sales
Total Sales = SUM(Sales[Amount])

// Sales YTD
Sales YTD = 
TOTALYTD([Total Sales], 'Calendar'[Date])

// Previous Year Sales
PY Sales = 
CALCULATE(
    [Total Sales],
    SAMEPERIODLASTYEAR('Calendar'[Date])
)

// Sales Growth
Sales Growth = 
VAR CurrentSales = [Total Sales]
VAR PreviousSales = [PY Sales]
RETURN
DIVIDE(
    CurrentSales - PreviousSales,
    PreviousSales,
    BLANK()
)
```

### Customer Metrics
```dax
// Customer Count
Customer Count = 
DISTINCTCOUNT(Sales[CustomerID])

// Average Transaction
Avg Transaction = 
DIVIDE(
    [Total Sales],
    DISTINCTCOUNT(Sales[OrderID])
)

// Customer Ranking
Customer Rank = 
RANKX(
    ALL(Customer),
    [Total Sales]
)
```

## Time Intelligence

### Period Over Period
```dax
// Month over Month
MoM Change = 
VAR CurrentMonth = [Total Sales]
VAR PreviousMonth = 
    CALCULATE(
        [Total Sales],
        DATEADD('Calendar'[Date], -1, MONTH)
    )
RETURN
DIVIDE(
    CurrentMonth - PreviousMonth,
    PreviousMonth
)

// Quarter to Date
QTD Sales = 
TOTALQTD(
    [Total Sales],
    'Calendar'[Date]
)
```

### Moving Calculations
```dax
// Moving Average
3M Moving Avg = 
AVERAGEX(
    DATESINPERIOD(
        'Calendar'[Date],
        LASTDATE('Calendar'[Date]),
        -3,
        MONTH
    ),
    [Total Sales]
)

// Running Total
Running Total = 
CALCULATE(
    [Total Sales],
    DATESBETWEEN(
        'Calendar'[Date],
        FIRSTDATE('Calendar'[Date]),
        LASTDATE('Calendar'[Date])
    )
)
```

## Filter Context

### Context Modification
```dax
// All Time Total
All Time Total = 
CALCULATE(
    [Total Sales],
    ALL('Calendar')
)

// Category Share
Category Share = 
DIVIDE(
    [Total Sales],
    CALCULATE(
        [Total Sales],
        ALL(Product[Category])
    )
)
```

### Top N Analysis
```dax
// Top 10 Customers
Top 10 Flag = 
VAR CurrentCustomer = SELECTEDVALUE(Customer[CustomerID])
VAR Top10List = 
    TOPN(
        10,
        ALL(Customer),
        [Total Sales]
    )
RETURN
SELECTEDVALUE(
    Customer[CustomerID]
) in SELECTCOLUMNS(
    Top10List,
    "CustomerID",
    [CustomerID]
)
```

## Error Handling
```dax
// Safe Division
Safe Divide = 
DIVIDE(
    Sales[Amount],
    Sales[Quantity],
    0
)

// Conditional Format
Status Flag = 
SWITCH(
    TRUE(),
    [Growth] > 0.1, "High",
    [Growth] > 0, "Normal",
    [Growth] < 0, "Low"
)
```

## Best Practices
1. Use Variables
2. Clear Naming
3. Comment Complex Calculations
4. Consider Performance
5. Test Edge Cases

## Common Patterns
1. Year to Date
2. Previous Period
3. Running Totals
4. Ranking
5. Percentage of Total

## Troubleshooting Tips
1. Check Filter Context
2. Verify Table Relationships
3. Test with Sample Data
4. Use EVALUATE in DAX Studio
