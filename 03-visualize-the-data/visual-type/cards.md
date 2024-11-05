# Power BI Cards

## Overview
Cards in Power BI are specialized visualizations designed to display single values, KPIs, and important metrics prominently. They are essential for dashboards and summary views.

## 🎯 Card Types

### 1. Basic Cards
```plaintext
Single Value Cards
│
├── Card
│   ├── Single metric
│   ├── Optional label
│   └── Basic formatting
│
├── Multi-row Card
│   ├── Multiple metrics
│   ├── Category labels
│   └── Vertical layout
│
└── Numeric Cards
    ├── Number formatting
    ├── Unit display
    └── Precision control
```

### 2. KPI Cards
```plaintext
KPI Components
│
├── Structure
│   ├── Current value
│   ├── Target value
│   └── Variance
│
├── Indicators
│   ├── Status icons
│   ├── Trend arrows
│   └── Color coding
│
└── Comparisons
    ├── Period over period
    ├── Target vs actual
    └── Trend indication
```

### 3. Custom Cards
```plaintext
Advanced Cards
│
├── Infographic Cards
│   ├── Icon display
│   ├── Custom layout
│   └── Rich formatting
│
├── Combination Cards
│   ├── Sparklines
│   ├── Small multiples
│   └── Micro charts
│
└── Dynamic Cards
    ├── Conditional display
    ├── Interactive elements
    └── Animated updates
```

## 🛠️ Implementation Guide

### 1. Basic Card Setup
```dax
// Simple Card Measure
Card_Value = 
CALCULATE(
    SUM(Sales[Amount]),
    LASTDATE(Calendar[Date])
)
```

### 2. KPI Configuration
```dax
// KPI Status Calculation
KPI_Status = 
VAR CurrentValue = [Current_Measure]
VAR Target = [Target_Measure]
VAR Variance = DIVIDE(CurrentValue - Target, Target)
RETURN
    SWITCH(
        TRUE(),
        Variance >= 0.1, "Exceeding",
        Variance >= 0, "Meeting",
        "Below"
    )
```

## 💡 Best Practices

### 1. Design Guidelines
```plaintext
Card Design Elements
├── Layout
│   ├── Size considerations
│   ├── Spacing rules
│   └── Alignment
│
├── Typography
│   ├── Font hierarchy
│   ├── Size hierarchy
│   └── Weight variations
│
└── Visual Elements
    ├── Icons
    ├── Colors
    └── Borders
```

### 2. Information Hierarchy
```plaintext
Content Structure
├── Primary Information
│   ├── Main metric
│   ├── Key indicator
│   └── Critical value
│
├── Secondary Information
│   ├── Comparison
│   ├── Context
│   └── Time period
│
└── Supporting Elements
    ├── Labels
    ├── Icons
    └── Descriptions
```

## ⚠️ Common Pitfalls
1. Information overload
2. Poor formatting choices
3. Unclear metrics
4. Inconsistent styling
5. Missing context

## 📊 Advanced Features

### 1. Conditional Formatting
```dax
// Dynamic Color Formatting
Card_Color = 
SWITCH(
    TRUE(),
    [Value] > [Target] * 1.1, "#2ECC71",  // Green
    [Value] < [Target] * 0.9, "#E74C3C",  // Red
    "#F1C40F"  // Yellow
)
```

### 2. Dynamic Text
```dax
// Dynamic Card Label
Card_Label = 
VAR MetricName = SELECTEDVALUE(Metrics[Name])
VAR TimePeriod = SELECTEDVALUE(Time[Period])
RETURN
    MetricName & " - " & TimePeriod
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
│   ├── Title
│   ├── Value
│   └── Label
│
└── Indicators
    ├── Positive
    ├── Negative
    └── Neutral
```

### 2. Layout Options
```plaintext
Card Layouts
├── Standard
│   ├── Center aligned
│   ├── Left aligned
│   └── Custom position
│
├── Compact
│   ├── Minimal padding
│   ├── Dense information
│   └── Small footprint
│
└── Extended
    ├── Additional context
    ├── Multiple elements
    └── Rich formatting
```

## 🔄 Interactivity

### 1. Card Actions
```dax
// Interactive Behavior
Card_Action = 
SWITCH(
    SELECTEDVALUE(Action[Type]),
    "Drill", [Drill_Measure],
    "Filter", [Filter_Measure],
    [Default_Measure]
)
```

### 2. Tooltip Configuration
```plaintext
Tooltip Elements
├── Basic Information
├── Trend Data
└── Comparison Values
```

## 📈 Performance

### 1. Optimization
```plaintext
Performance Areas
├── Calculation Speed
├── Refresh Rate
└── Memory Usage
```

### 2. Best Practices
```plaintext
Optimization Tips
├── Measure Simplification
├── Caching Strategy
└── Update Frequency
```

## 📱 Responsive Design

### 1. Mobile Layout
```plaintext
Mobile Considerations
├── Size Adaptation
├── Touch Targets
└── Content Priority
```

### 2. Cross-platform Support
```plaintext
Platform Optimization
├── Desktop View
├── Mobile View
├── Tablet View
└── Web View
```

## 🔍 Testing Framework

### 1. Validation Tests
```plaintext
Test Categories
├── Visual Display
├── Data Accuracy
├── Performance
└── Interactivity
```

### 2. Quality Checks
```plaintext
Quality Metrics
├── Readability
├── Consistency
├── Responsiveness
└── Accuracy
```

## 📚 Related Topics
- Visual Design
- Formatting
- KPI Design
- Dashboard Layout
- Performance

## 🛡️ Governance
1. Design standards
2. Color schemes
3. Naming conventions
4. Documentation
5. Testing protocols
