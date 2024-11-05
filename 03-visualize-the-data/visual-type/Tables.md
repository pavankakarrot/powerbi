# Power BI Tables

## Overview
Tables in Power BI are fundamental visualization types that display data in rows and columns, offering various levels of interactivity, formatting, and analytical capabilities.

## 🎯 Table Types

### 1. Standard Tables
```plaintext
Table Components
│
├── Basic Table
│   ├── Row display
│   ├── Column headers
│   └── Cell values
│
├── Grid Table
│   ├── Fixed columns
│   ├── Scrollable content
│   └── Row numbers
│
└── Custom Tables
    ├── Conditional formatting
    ├── Custom sorting
    └── Interactive elements
```

### 2. Matrix Tables
```plaintext
Matrix Features
│
├── Structure
│   ├── Row hierarchy
│   ├── Column hierarchy
│   └── Values area
│
├── Expansion
│   ├── Drill down/up
│   ├── Expand/collapse
│   └── Level navigation
│
└── Totals
    ├── Row totals
    ├── Column totals
    └── Subtotals
```

## 🛠️ Implementation Guide

### 1. Basic Table Setup
```dax
// Simple Measure for Tables
Table_Measure = 
CALCULATE(
    SUM(Sales[Amount]),
    ALLSELECTED(Sales)
)
```

### 2. Matrix Configuration
```dax
// Hierarchical Display
Matrix_Display = 
VAR CurrentLevel = ISINSCOPE(Product[Category])
VAR SubLevel = ISINSCOPE(Product[Subcategory])
RETURN
    SWITCH(
        TRUE(),
        CurrentLevel, [Category_Total],
        SubLevel, [Subcategory_Total],
        [Detail_Amount]
    )
```

## 💡 Best Practices

### 1. Design Guidelines
```plaintext
Table Design Elements
├── Layout
│   ├── Column width
│   ├── Row height
│   └── Cell padding
│
├── Typography
│   ├── Font selection
│   ├── Text alignment
│   └── Number formats
│
└── Visual Hierarchy
    ├── Header styling
    ├── Alternating rows
    └── Border usage
```

### 2. Formatting Rules
```plaintext
Formatting Hierarchy
├── Cell Formatting
│   ├── Background colors
│   ├── Font properties
│   └── Borders
│
├── Conditional Rules
│   ├── Value-based
│   ├── Icon sets
│   └── Color scales
│
└── Totals Formatting
    ├── Subtotal styles
    ├── Grand total styles
    └── Level indicators
```

## ⚠️ Common Pitfalls
1. Information overload
2. Poor column sizing
3. Unclear hierarchy
4. Inconsistent formatting
5. Performance issues

## 📊 Advanced Features

### 1. Conditional Formatting
```dax
// Dynamic Formatting
Format_Rule = 
VAR CurrentValue = [Measure]
VAR Threshold = [Target]
RETURN
    SWITCH(
        TRUE(),
        CurrentValue > Threshold * 1.1, "Green",
        CurrentValue < Threshold * 0.9, "Red",
        "Yellow"
    )
```

### 2. Stepped Layout
```powerquery
// Hierarchical Indentation
let
    Source = Table.AddColumn(
        PreviousStep,
        "Indentation",
        each if [Level] = 1 then 0 else [Level] * 10
    )
in
    Source
```

## 🎨 Styling Guide

### 1. Color Schemes
```plaintext
Color Application
├── Headers
│   ├── Background
│   └── Text
├── Data Cells
│   ├── Normal state
│   └── Alternate rows
└── Totals
    ├── Subtotals
    └── Grand totals
```

### 2. Text Formatting
```plaintext
Text Properties
├── Alignment
│   ├── Headers
│   ├── Numbers
│   └── Text
├── Font Styles
│   ├── Family
│   ├── Size
│   └── Weight
└── Special Formats
    ├── Currency
    ├── Percentages
    └── Custom
```

## 🔄 Interactivity

### 1. Sorting Options
```dax
// Custom Sort Order
Sort_Column = 
SWITCH(
    [Category],
    "High", 1,
    "Medium", 2,
    "Low", 3,
    4
)
```

### 2. Filter Interactions
```plaintext
Filter Behavior
├── Cross Filtering
├── Cross Highlighting
└── Drill Through
```

## 📈 Performance Optimization

### 1. Data Load
```plaintext
Optimization Techniques
├── Column Selection
├── Row Reduction
├── Pre-aggregation
└── Caching
```

### 2. Visual Settings
```plaintext
Performance Settings
├── Pagination
│   ├── Page size
│   └── Load behavior
├── Scrolling
│   ├── Virtual scroll
│   └── Load on demand
└── Updates
    ├── Refresh timing
    └── Update triggers
```

## 📱 Responsive Design

### 1. Mobile Layout
```plaintext
Mobile Considerations
├── Column Priority
├── Text Wrapping
├── Touch Targets
└── Scroll Behavior
```

### 2. Cross-platform
```plaintext
Platform Support
├── Desktop
├── Web
├── Mobile
└── Embedded
```

## 🔍 Troubleshooting

### 1. Common Issues
```plaintext
Issue Resolution
├── Display Problems
├── Performance Issues
├── Formatting Errors
└── Interaction Bugs
```

### 2. Best Practices
```plaintext
Maintenance Guidelines
├── Regular Testing
├── Performance Monitoring
├── User Feedback
└── Documentation
```

## 📚 Related Topics
- Formatting
- Conditional Rules
- Visual Hierarchy
- Data Display
- Performance

## 🛡️ Governance
1. Table standards
2. Formatting rules
3. Naming conventions
4. Documentation
5. Testing protocols
