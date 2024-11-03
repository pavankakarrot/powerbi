# Time Intelligence in DAX

## Basic Time Intelligence Functions

### Year-to-Date (YTD)
```dax
// Sales YTD
Sales YTD = 
TOTALYTD([Total Sales], 'Calendar'[Date])

// Profit YTD
Profit YTD = 
TOTALYTD([Total Profit], 'Calendar'[Date])

// YTD with Filter
Sales YTD (Product) = 
CALCULATE(
    [Sales YTD],
    KEEPFILTERS(Product[Category] = "Electronics")
)
```

### Quarter-to-Date (QTD)
```dax
// Sales QTD
Sales QTD = 
TOTALQTD([Total Sales], 'Calendar'[Date])

// Running Quarter Total
Running Quarter Sales = 
CALCULATE(
    [Total Sales],
    DATESQTD('Calendar'[Date])
)
```

### Month-to-Date (MTD)
```dax
// Sales MTD
Sales MTD = 
TOTALMTD([Total Sales], 'Calendar'[Date])

// MTD Comparison
MTD vs Previous =
VAR CurrentMTD = [Sales MTD]
VAR PreviousMTD = 
    CALCULATE(
        [Sales MTD],
        DATEADD('Calendar'[Date], -1, MONTH)
    )
RETURN
CurrentMTD - PreviousMTD
```

## Previous Period Comparisons

### Previous Year
```dax
// Previous Year Sales
PY Sales = 
CALCULATE(
    [Total Sales],
    SAMEPERIODLASTYEAR('Calendar'[Date])
)

// Year over Year Growth
YoY Growth = 
DIVIDE(
    [Total Sales] - [PY Sales],
    [PY Sales],
    0
)

// Year over Year Growth %
YoY Growth % = 
DIVIDE(
    [Total Sales] - [PY Sales],
    [PY Sales],
    0
) * 100
```

### Previous Quarter
```dax
// Previous Quarter Sales
PQ Sales = 
CALCULATE(
    [Total Sales],
    DATEADD('Calendar'[Date], -1, QUARTER)
)

// Quarter over Quarter Growth
QoQ Growth = 
DIVIDE(
    [Total Sales] - [PQ Sales],
    [PQ Sales],
    0
)
```

### Previous Month
```dax
// Previous Month Sales
PM Sales = 
CALCULATE(
    [Total Sales],
    DATEADD('Calendar'[Date], -1, MONTH)
)

// Month over Month Growth
MoM Growth = 
DIVIDE(
    [Total Sales] - [PM Sales],
    [PM Sales],
    0
)
```

## Moving Averages

### 3-Month Moving Average
```dax
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
```

### 12-Month Moving Average
```dax
12M Moving Avg = 
AVERAGEX(
    DATESINPERIOD(
        'Calendar'[Date],
        LASTDATE('Calendar'[Date]),
        -12,
        MONTH
    ),
    [Total Sales]
)
```

## Parallel Period

### Same Period Last Year
```dax
// Same Period Last Year
SPLY Sales = 
CALCULATE(
    [Total Sales],
    PARALLELPERIOD('Calendar'[Date], -12, MONTH)
)
```

## Custom Time Intelligence

### Rolling 30 Days
```dax
Rolling 30 Days Sales = 
CALCULATE(
    [Total Sales],
    DATESINPERIOD(
        'Calendar'[Date],
        LASTDATE('Calendar'[Date]),
        -30,
        DAY
)
)
```

### Custom Year-to-Date
```dax
// Fiscal YTD (Starting July)
Fiscal YTD = 
VAR FiscalYear = YEAR('Calendar'[Date]) + 
    IF(MONTH('Calendar'[Date]) < 7, -1)
RETURN
CALCULATE(
    [Total Sales],
    FILTER(
        ALL('Calendar'),
        YEAR('Calendar'[Date]) = FiscalYear &&
        'Calendar'[Date] <= MAX('Calendar'[Date])
    )
)
```

## Common Patterns & Best Practices

### Pattern 1: Period over Period
```dax
// Generic Period Comparison
Period Comparison = 
VAR CurrentValue = [Current Period Measure]
VAR PreviousValue = [Previous Period Measure]
VAR Result = 
    SWITCH(
        TRUE(),
        ISBLANK(CurrentValue) && ISBLANK(PreviousValue), BLANK(),
        ISBLANK(PreviousValue), 1,
        DIVIDE(
            CurrentValue - PreviousValue,
            PreviousValue,
            0
        )
    )
RETURN
Result
```

### Pattern 2: Year to Date Growth
```dax
YTD Growth = 
VAR CurrentYTD = [Sales YTD]
VAR PreviousYTD = 
    CALCULATE(
        [Sales YTD],
        DATEADD('Calendar'[Date], -1, YEAR)
    )
RETURN
DIVIDE(
    CurrentYTD - PreviousYTD,
    PreviousYTD,
    0
)
```

## Troubleshooting Tips
1. Check Date Table is marked
2. Verify continuous dates
3. Confirm relationship direction
4. Test filter context
5. Validate calendar hierarchy
