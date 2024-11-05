# Power BI Custom Tooltips

## Overview
Custom tooltips in Power BI enable enhanced data visualization by providing contextual information, detailed insights, and even miniature visualizations when users hover over data points.


*   **Custom Tooltips Functionality**: Custom tooltips in Power BI allow users to display additional information when hovering over a data point in a visual, enhancing the interactivity and depth of insights available without cluttering the main visuals.
*   **Creating Tooltip Pages**: Custom tooltips are created by designing dedicated tooltip report pages. These pages can contain specific visuals and information relevant to the data point being hovered over.
*   **Size and Layout Control**: Users can control the size and layout of custom tooltips, allowing for more content to be displayed without affecting the overall report layout. Tooltips can be designed to fit the context of the data.
*   **Dynamic Content**: Custom tooltips can display dynamic content that changes based on the data point being hovered over, providing tailored insights and analysis relevant to that specific context.
*   **Interactivity Within Tooltips**: Custom tooltips can contain interactive elements such as charts, tables, and slicers, enabling users to engage with the data directly within the tooltip.
*   **Enhanced User Experience**: By using custom tooltips, report creators can enhance the user experience, allowing viewers to access deeper insights without navigating away from the main report.
*   **Visual Consistency**: Custom tooltips maintain visual consistency with the main report, ensuring that the additional information matches the design and branding of the overall Power BI report.
*   **Use Cases for Custom Tooltips**: Common use cases include displaying detailed metrics, additional context about a data point, historical trends, or comparisons when hovering over a data series.


## 🎯 Tooltip Types

### 1. Basic Custom Tooltips
```plaintext
Standard Elements
│
├── Text Elements
│   ├── Field values
│   ├── Calculations
│   └── Formatting
│
├── Value Display
│   ├── Measures
│   ├── Columns
│   └── Calculations
│
└── Formatting Options
    ├── Font settings
    ├── Colors
    └── Alignment
```

### 2. Report Page Tooltips
```plaintext
Advanced Features
│
├── Visual Elements
│   ├── Charts
│   ├── Tables
│   └── Cards
│
├── Interactivity
│   ├── Filters
│   ├── Highlights
│   └── Selection
│
└── Context
    ├── Data point
    ├── Related data
    └── Time period
```

## 🛠️ Implementation Guide

### 1. Basic Tooltip Setup
```dax
// Custom Tooltip Measure
Tooltip_Info = 
VAR CurrentValue = [Measure]
VAR PreviousValue = [Previous_Measure]
VAR PercentChange = 
    DIVIDE(
        CurrentValue - PreviousValue,
        PreviousValue,
        "No Previous Data"
    )
RETURN
    "Current: " & FORMAT(CurrentValue, "$#,##0") &
    UNICHAR(10) &
    "Previous: " & FORMAT(PreviousValue, "$#,##0") &
    UNICHAR(10) &
    "Change: " & FORMAT(PercentChange, "0.0%")
```

### 2. Report Page Tooltip
```dax
// Dynamic Tooltip Content
Tooltip_Context = 
SWITCH(
    TRUE(),
    ISFILTERED(Product[Category]), [Category_Detail],
    ISFILTERED(Date[Year]), [Year_Detail],
    [Default_Detail]
)
```

## 💡 Design Guidelines

### 1. Visual Elements
```plaintext
Design Components
├── Layout
│   ├── Size restrictions
│   ├── Spacing
│   └── Alignment
│
├── Content
│   ├── Primary info
│   ├── Secondary info
│   └── Visual elements
│
└── Styling
    ├── Colors
    ├── Typography
    └── Borders
```

### 2. User Experience
```plaintext
Interaction Design
├── Hover behavior
├── Timing
├── Position
└── Fade effects
```

## ⚠️ Common Pitfalls

### 1. Design Issues
```plaintext
Common Problems
├── Information overload
├── Poor contrast
├── Unclear hierarchy
├── Size issues
└── Performance impact
```

### 2. Technical Issues
```plaintext
Technical Challenges
├── Slow loading
├── Data context
├── Visual conflicts
├── Mobile display
└── Cross-filtering
```

## 📊 Implementation Examples

### 1. KPI Tooltip
```dax
// KPI Tooltip Information
KPI_Tooltip = 
VAR CurrentKPI = [KPI_Value]
VAR Target = [Target_Value]
VAR Status = 
    SWITCH(
        TRUE(),
        CurrentKPI >= Target * 1.1, "Exceeding",
        CurrentKPI >= Target, "Meeting",
        "Below"
    )
RETURN
    "Status: " & Status & UNICHAR(10) &
    "Current: " & FORMAT(CurrentKPI, "#,##0") & UNICHAR(10) &
    "Target: " & FORMAT(Target, "#,##0")
```

### 2. Trend Tooltip
```dax
// Trend Information
Trend_Tooltip = 
VAR CurrentPeriod = SELECTEDVALUE(Date[Period])
VAR TrendData = 
    CALCULATETABLE(
        SUMMARIZE(
            DATEADD(Date[Date], -3, MONTH),
            Date[Month],
            "Value", [Measure]
        ),
        ALL(Date)
    )
RETURN
    TrendData
```

## 🎨 Styling Guide

### 1. Color Usage
```plaintext
Color Application
├── Background
│   ├── Primary
│   ├── Secondary
│   └── Accent
│
├── Text
│   ├── Headers
│   ├── Values
│   └── Links
│
└── Indicators
    ├── Positive
    ├── Negative
    └── Neutral
```

### 2. Layout Options
```plaintext
Layout Elements
├── Header
├── Body
├── Footer
└── Visual area
```

## 🔄 Dynamic Content

### 1. Context-Aware Content
```dax
// Context-Based Information
Dynamic_Content = 
SWITCH(
    SELECTEDVALUE(Context[Type]),
    "Sales", [Sales_Detail],
    "Inventory", [Inventory_Detail],
    "Customer", [Customer_Detail],
    [Default_Content]
)
```

### 2. Conditional Display
```dax
// Conditional Tooltip
Conditional_Display = 
IF(
    [Value] > [Threshold],
    [Detailed_Info],
    [Basic_Info]
)
```

## 📱 Responsive Design

### 1. Device Support
```plaintext
Platform Optimization
├── Desktop
├── Web
├── Mobile
└── Tablet
```

### 2. Size Adaptation
```plaintext
Responsive Elements
├── Content scaling
├── Layout adjustment
├── Font sizing
└── Visual resize
```

## 🔍 Performance Optimization

### 1. Loading Strategy
```plaintext
Optimization Areas
├── Data volume
├── Visual complexity
├── Calculation speed
└── Refresh timing
```

### 2. Caching
```plaintext
Cache Strategy
├── Static content
├── Dynamic content
├── Visual elements
└── Data points
```

## 📚 Related Topics
- Report Page Design
- Visual Interactions
- Data Formatting
- User Experience
- Performance

## 🛡️ Best Practices
1. Clear information hierarchy
2. Consistent design
3. Performance optimization
4. Responsive behavior
5. Context preservation
