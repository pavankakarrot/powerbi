# Power BI Scripts and Code Repository

## 📚 Categories
- DAX Scripts
- Power Query (M) Scripts
- Templates
- Custom Functions

## 📊 DAX Scripts

### Sales Calculations
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

// Sales Growth %
Sales Growth % = 
VAR CurrentSales = [Total Sales]
VAR PreviousSales = [PY Sales]
RETURN
DIVIDE(
    CurrentSales - PreviousSales,
    PreviousSales,
    BLANK()
)
```

### Financial Metrics
```dax
// Gross Margin
Gross Margin = 
SUMX(
    Sales,
    Sales[Amount] - Sales[Cost]
)

// Gross Margin %
Gross Margin % = 
DIVIDE(
    [Gross Margin],
    [Total Sales],
    0
)

// Running Total
Running Total = 
CALCULATE(
    [Total Sales],
    FILTER(
        ALL('Calendar'),
        'Calendar'[Date] <= MAX('Calendar'[Date])
    )
)
```

## 🔄 Power Query Scripts

### Data Cleaning
```powerquery
// Remove Special Characters
let
    Source = Table.TransformColumns(
        PreviousStep,
        {{"ColumnName", each Text.Clean(_)}}
    )
in
    Source

// Split Address into Components
let
    Source = Table.SplitColumn(
        PreviousStep,
        "Address",
        Splitter.SplitTextByDelimiter(",", QuoteStyle.None),
        {"Street", "City", "State"}
    )
in
    Source
```

### Data Transformation
```powerquery
// Unpivot Multiple Columns
let
    Source = Table.UnpivotOtherColumns(
        PreviousStep,
        {"ID", "Name"},
        "Attribute",
        "Value"
    )
in
    Source

// Combine Multiple Files
let
    Source = Folder.Files("C:\Data"),
    FilteredFiles = Table.SelectRows(
        Source,
        each [Extension] = ".xlsx"
    ),
    ImportedTables = Table.AddColumn(
        FilteredFiles,
        "Data",
        each Excel.Workbook([Content])
    )
in
    ImportedTables
```

## 📝 Custom Functions

### Date Functions
```powerquery
// Create Date Table
let
    CreateDateTable = (StartDate as date, EndDate as date) =>
    let
        DatesTable = List.Dates(
            StartDate,
            Duration.Days(EndDate - StartDate) + 1,
            #duration(1,0,0,0)
        ),
        TableFromList = Table.FromList(
            DatesTable,
            Splitter.SplitByNothing(),
            {"Date"}
        ),
        ChangedType = Table.TransformColumnTypes(
            TableFromList,
            {{"Date", type date}}
        )
    in
        ChangedType
in
    CreateDateTable
```

### Text Functions
```powerquery
// Clean Text Function
let
    CleanText = (text as text) =>
    let
        Trimmed = Text.Trim(text),
        Cleaned = Text.Clean(Trimmed),
        Proper = Text.Proper(Cleaned)
    in
        Proper
in
    CleanText
```

## 🎯 Templates

### Report Templates
1. Sales Dashboard Template
2. Financial Report Template
3. Inventory Analysis Template

### Query Templates
1. Data Load Template
2. Error Handling Template
3. Parameter Query Template

## ⚡ Performance Optimization

### Query Folding
```powerquery
// Ensure Query Folding
let
    Source = Sql.Database("server", "database"),
    FilteredRows = Table.SelectRows(
        Source,
        each [Date] >= #date(2023,1,1)
    )
in
    FilteredRows
```

### DAX Optimization
```dax
// Use Variables for Better Performance
Optimized Measure = 
VAR CurrentDate = MAX('Calendar'[Date])
VAR CurrentSales = CALCULATE([Total Sales], 'Calendar'[Date] = CurrentDate)
VAR PreviousSales = CALCULATE([Total Sales], 'Calendar'[Date] = DATEADD(CurrentDate, -1, YEAR))
RETURN
DIVIDE(
    CurrentSales - PreviousSales,
    PreviousSales
)
```

## 📚 Usage Instructions
1. Copy relevant code
2. Modify parameters as needed
3. Test in development environment
4. Document changes
5. Deploy to production

## ⚠️ Best Practices
1. Comment your code
2. Use consistent naming
3. Test edge cases
4. Document dependencies
5. Version control changes

## 🔄 Version History
- v1.0: Initial scripts
- v1.1: Added financial metrics
- v1.2: Added custom functions
- v1.3: Performance optimization

## 📝 Notes
Add your own scripts and modifications here!
