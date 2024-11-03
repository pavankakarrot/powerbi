# Power Query Basics

## Essential Transformations

### Column Operations
```powerquery
// Rename columns
= Table.RenameColumns(Source, {{"OldName", "NewName"}})

// Change type
= Table.TransformColumnTypes(Source, {{"Column", Int64.Type}})

// Remove columns
= Table.RemoveColumns(Source, {"Column1", "Column2"})

// Reorder columns
= Table.ReorderColumns(Source, {"ID", "Name", "Date"})
```

### Row Operations
```powerquery
// Filter rows
= Table.SelectRows(Source, each [Amount] > 100)

// Remove duplicates
= Table.Distinct(Source)

// Sort data
= Table.Sort(Source, {{"Date", Order.Ascending}})
```

### Data Cleaning
```powerquery
// Replace values
= Table.ReplaceValue(Source, null, 0, Replacer.ReplaceValue)

// Trim spaces
= Table.TransformColumns(Source, {{"Column", Text.Trim}})

// Split column
= Table.SplitColumn(Source, "FullName", Splitter.SplitTextByDelimiter(" "))
```

## Error Handling
```powerquery
// Try/otherwise pattern
= Table.TransformColumns(
    Source,
    {{"Amount", each try Number.From(_) otherwise 0}}
)
```

## Custom Functions
```powerquery
// Example custom function
let
    CleanText = (input as text) =>
    let
        Trimmed = Text.Trim(input),
        Cleaned = Text.Clean(Trimmed),
        Lower = Text.Lower(Cleaned)
    in
        Lower
in
    CleanText
```

## Performance Tips
1. Query Folding
2. Reference vs Duplicate
3. Disable Load When Appropriate
4. Early Filtering

## Common Patterns
1. Append Multiple Files
2. Merge Tables
3. Conditional Columns
4. Custom Functions

## Troubleshooting Guide
- Error: Column not found
- Error: Expression.Error
- Error: Data type mismatch
