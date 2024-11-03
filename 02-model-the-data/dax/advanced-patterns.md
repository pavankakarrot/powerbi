# Advanced DAX Patterns

## Advanced Calculation Patterns

### Dynamic TopN Pattern
```dax
// Dynamic Top N Selection
Top N Sales = 
VAR TopN = SELECTEDVALUE('Parameters'[TopN], 10)
VAR RankedCustomers = 
    ADDCOLUMNS(
        ALL(Customer[CustomerID]),
        "Sales", [Total Sales],
        "Rank", RANKX(ALL(Customer[CustomerID]), [Total Sales])
    )
RETURN
CALCULATE(
    [Total Sales],
    FILTER(
        RankedCustomers,
        [Rank] <= TopN
    )
)
```

### Parent-Child Hierarchy
```dax
// Recursive Category Total
Category Hierarchy Total = 
VAR CurrentNode = SELECTEDVALUE(Category[CategoryID])
VAR ChildCategories = 
    FILTER(
        Category,
        Category[ParentCategoryID] = CurrentNode
    )
RETURN
CALCULATE(
    [Total Sales],
    TREATAS(ChildCategories, Category)
)
```

### ABC Analysis Pattern
```dax
// ABC Classification
Product ABC Class = 
VAR CurrentProduct = SELECTEDVALUE(Product[ProductID])
VAR TotalSales = [Total Sales]
VAR CumulativeShare = 
    DIVIDE(
        CALCULATE(
            [Total Sales],
            FILTER(
                ALL(Product),
                [Total Sales] >= TotalSales
            )
        ),
        CALCULATE([Total Sales], ALL(Product))
    )
RETURN
SWITCH(
    TRUE(),
    CumulativeShare <= 0.7, "A",
    CumulativeShare <= 0.9, "B",
    "C"
)
```

## Complex Filter Contexts

### Dynamic Period Comparison
```dax
// Dynamic Time Comparison
Sales Variance = 
VAR SelectedPeriod = SELECTEDVALUE('Parameters'[Period])
VAR CurrentSales = [Total Sales]
VAR ComparisonSales = 
    SWITCH(
        SelectedPeriod,
        "YOY", CALCULATE([Total Sales], DATEADD('Calendar'[Date], -1, YEAR)),
        "MOM", CALCULATE([Total Sales], DATEADD('Calendar'[Date], -1, MONTH)),
        "QOQ", CALCULATE([Total Sales], DATEADD('Calendar'[Date], -1, QUARTER))
    )
RETURN
CurrentSales - ComparisonSales
```

### Market Share Analysis
```dax
// Market Share with Hierarchy
Market Share = 
VAR CurrentSales = [Total Sales]
VAR MarketTotal = 
    CALCULATE(
        [Total Sales],
        ALL(Product),
        ALL(Geography)
    )
VAR CategoryTotal = 
    CALCULATE(
        [Total Sales],
        ALL(Product[SubCategory]),
        ALL(Geography[City])
    )
RETURN
DIVIDE(
    CurrentSales,
    MarketTotal,
    0
)
```

## Statistical Patterns

### Moving Statistics
```dax
// Statistical Control Limits
Control Limits = 
VAR AvgValue = [3M Moving Avg]
VAR StdDev = 
    STDEV.P(
        DATESINPERIOD(
            'Calendar'[Date],
            LASTDATE('Calendar'[Date]),
            -3,
            MONTH
        )
    )
RETURN
AVERAGEX(
    DATESINPERIOD(
        'Calendar'[Date],
        LASTDATE('Calendar'[Date]),
        -3,
        MONTH
    ),
    [Total Sales]
) + 2 * StdDev
```

### Basket Analysis
```dax
// Product Affinity
Product Affinity = 
VAR Product1 = SELECTEDVALUE(Product[ProductID])
VAR Product2 = SELECTEDVALUE(RelatedProduct[ProductID])
VAR CommonOrders = 
    CALCULATE(
        DISTINCTCOUNT(Sales[OrderID]),
        FILTER(
            ALL(Sales),
            Sales[ProductID] = Product1 ||
            Sales[ProductID] = Product2
        )
    )
RETURN
DIVIDE(
    CommonOrders,
    DISTINCTCOUNT(Sales[OrderID])
)
```

## Advanced Time Patterns

### Custom Calendar Patterns
```dax
// Fiscal Period Calculations
Fiscal Period Sales = 
VAR FiscalStart = DATE(YEAR(MAX('Calendar'[Date])), 7, 1)
VAR CurrentPeriod = 
    DATEDIFF(
        FiscalStart,
        MAX('Calendar'[Date]),
        MONTH
    )
RETURN
CALCULATE(
    [Total Sales],
    DATESINPERIOD(
        'Calendar'[Date],
        FiscalStart,
        CurrentPeriod,
        MONTH
    )
)
```

## Performance Optimization Patterns

### Aggregation Pattern
```dax
// Pre-aggregated Sales
Optimized Sales = 
VAR GrainLevel = SELECTEDVALUE('Parameters'[GrainLevel])
RETURN
SWITCH(
    GrainLevel,
    "Day", [Detailed Sales],
    "Month", [Monthly Sales],
    "Quarter", [Quarterly Sales],
    [Yearly Sales]
)
```

### Virtual Table Pattern
```dax
// Virtual Fact Table
Virtual Sales = 
SUMMARIZE(
    Sales,
    'Calendar'[Date],
    Product[Category],
    "Sales", SUM(Sales[Amount])
)
```

## Best Practices
1. Use variables for complex calculations
2. Comment code extensively
3. Consider performance implications
4. Test with different filter contexts
5. Document patterns for reuse

## Troubleshooting Complex Patterns
1. Verify filter context
2. Check relationship flow
3. Test edge cases
4. Monitor performance
5. Use DAX Studio for debugging
