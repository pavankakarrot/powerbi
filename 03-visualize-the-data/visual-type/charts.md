# Power BI Charts

## Overview
Power BI offers a wide range of chart types to effectively visualize data. Choosing the right chart type is crucial for clear data communication and insights delivery.

## 🎯 Chart Categories

### 1. Comparison Charts
```plaintext
Comparison Visualizations
│
├── Bar Charts
│   ├── Clustered Bar
│   ├── Stacked Bar
│   └── 100% Stacked Bar
│
├── Column Charts
│   ├── Clustered Column
│   ├── Stacked Column
│   └── 100% Stacked Column
│
└── Line Charts
    ├── Basic Line
    ├── Smoothed Line
    └── Area Charts
```

### 2. Part-to-Whole Charts
```plaintext
Distribution Visualizations
│
├── Pie Charts
│   ├── Basic Pie
│   └── Doughnut
│
├── Treemaps
│   ├── Single level
│   └── Hierarchical
│
└── Waterfall Charts
    ├── Basic Waterfall
    └── Breakdown
```

### 3. Trend Charts
```plaintext
Time Series Visualizations
│
├── Time Series
│   ├── Line
│   ├── Area
│   └── Column
│
├── Combinations
│   ├── Line and Column
│   ├── Line and Stacked Column
│   └── Area and Line
│
└── Specialized
    ├── Candlestick
    └── Stock Charts
```

## 🛠️ Chart Selection Guide

### 1. Selection Matrix
```plaintext
Data Type → Chart Type
│
├── Categorical Comparison
│   ├── Few Categories → Bar Chart
│   ├── Many Categories → Tree Map
│   └── Time-based → Line Chart
│
├── Distribution Analysis
│   ├── Single Variable → Histogram
│   ├── Two Variables → Scatter Plot
│   └── Multiple Variables → Bubble Chart
│
└── Relationship Analysis
    ├── Correlation → Scatter Plot
    ├── Composition → Stacked Chart
    └── Trends → Line Chart
```

### 2. DAX Support
```dax
// Dynamic Chart Selection Measure
Chart_Data = 
SWITCH(
    SELECTEDVALUE(ChartType[Type]),
    "Bar", [Bar_Measure],
    "Line", [Line_Measure],
    "Pie", [Pie_Measure],
    [Default_Measure]
)
```

## 💡 Best Practices

### 1. Design Guidelines
```plaintext
Visual Design Principles
├── Clarity
│   ├── Clear labels
│   ├── Appropriate scaling
│   └── Meaningful colors
│
├── Simplicity
│   ├── Avoid clutter
│   ├── Focus on data
│   └── Remove decoration
│
└── Consistency
    ├── Color schemes
    ├── Font styles
    └── Layout patterns
```

### 2. Color Usage
```plaintext
Color Guidelines
├── Primary Colors
│   ├── Main metrics
│   └── Key comparisons
│
├── Secondary Colors
│   ├── Supporting data
│   └── Background elements
│
└── Accent Colors
    ├── Highlights
    └── Alerts
```

## ⚠️ Common Pitfalls
1. Wrong chart selection
2. Data overload
3. Misleading scales
4. Poor color choices
5. Inadequate labeling

## 📊 Implementation Examples

### 1. Comparison Charts
```dax
// Dynamic Comparison Measure
Comparison_Value = 
VAR CurrentPeriod = SUM(Sales[Amount])
VAR PreviousPeriod = CALCULATE(
    SUM(Sales[Amount]),
    DATEADD(Sales[Date], -1, YEAR)
)
RETURN
    DIVIDE(
        CurrentPeriod - PreviousPeriod,
        PreviousPeriod
    )
```

### 2. Time Series
```dax
// Time Series Formatting
Time_Format = 
SWITCH(
    SELECTEDVALUE(TimeGranularity[Level]),
    "Year", FORMAT([Date], "yyyy"),
    "Quarter", FORMAT([Date], "yyyy-Q"),
    "Month", FORMAT([Date], "mmm yyyy")
)
```

## 🎨 Formatting Guidelines

### 1. Basic Formatting
```plaintext
Format Elements
├── Title
├── Axis Labels
├── Data Labels
├── Legend
└── Grid Lines
```

### 2. Advanced Settings
```plaintext
Advanced Options
├── Conditional Formatting
├── Dynamic Titles
├── Custom Tooltips
└── Visual Headers
```

## 📈 Advanced Techniques

### 1. Custom Visuals
```plaintext
Custom Development
├── Visual Selection
├── Configuration
├── Performance
└── Maintenance
```

### 2. Dynamic Formatting
```dax
// Dynamic Title
Chart_Title = 
VAR SelectedMetric = SELECTEDVALUE(Metrics[Name])
VAR SelectedPeriod = SELECTEDVALUE(Time[Period])
RETURN
    SelectedMetric & " Analysis - " & SelectedPeriod
```

## 🔍 Performance Considerations

### 1. Optimization Tips
```plaintext
Performance Areas
├── Data Volume
├── Visual Complexity
├── Interaction Speed
└── Refresh Rate
```

### 2. Monitoring
```plaintext
Monitoring Metrics
├── Load Time
├── Interaction Time
├── Memory Usage
└── Data Points
```

## 📱 Cross-platform Compatibility

### 1. Responsive Design
```plaintext
Platform Optimization
├── Desktop
├── Web
├── Mobile
└── Tablet
```

### 2. Mobile Considerations
- Touch interactions
- Screen size
- Performance
- Orientation

## 📚 Related Topics
- Visual Interactions
- Formatting
- Data Labels
- Tooltips
- Analytics

## 🛡️ Governance
1. Chart standards
2. Color schemes
3. Naming conventions
4. Documentation
5. Testing protocols
