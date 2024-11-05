# Power BI Dynamic Elements

## Overview
Dynamic elements in Power BI are interactive components that change based on user input, data conditions, or context, providing enhanced user experience and data insights.

## 🎯 Types of Dynamic Elements

### 1. Dynamic Visuals
```plaintext
Visual Elements
│
├── Dynamic Titles
│   ├── Context-based text
│   ├── Data-driven values
│   └── Conditional display
│
├── Dynamic Colors
│   ├── Conditional formatting
│   ├── Color scales
│   └── Status indicators
│
└── Dynamic Sizes
    ├── Responsive sizing
    ├── Data-driven size
    └── Conditional display
```

### 2. Dynamic Data
```plaintext
Data Elements
│
├── Measures
│   ├── Context-aware
│   ├── Time intelligence
│   └── Conditional logic
│
├── Calculated Columns
│   ├── Dynamic categories
│   ├── Status flags
│   └── Grouping logic
│
└── Parameters
    ├── User inputs
    ├── Time selections
    └── Scenario analysis
```

## 🛠️ Implementation Guide

### 1. Dynamic Titles
```dax
// Dynamic Title Based on Selection
Dynamic_Title = 
VAR SelectedCategory = SELECTEDVALUE(Product[Category], "All Categories")
VAR SelectedYear = SELECTEDVALUE(Date[Year], YEAR(TODAY()))
RETURN
    "Sales Analysis for " & SelectedCategory & 
    " in " & SelectedYear
```

### 2. Dynamic Formatting
```dax
// Dynamic Color Based on Performance
Color_Logic = 
VAR CurrentValue = [Measure]
VAR Target = [Target]
RETURN
    SWITCH(
        TRUE(),
        CurrentValue >= Target * 1.1, "#2ECC71",  // Green
        CurrentValue >= Target, "#F1C40F",        // Yellow
        "#E74C3C"                                 // Red
    )
```

## 💡 Best Practices

### 1. Design Guidelines
```plaintext
Design Elements
├── Visual Hierarchy
│   ├── Primary elements
│   ├── Secondary elements
│   └── Supporting info
│
├── Interaction Design
│   ├── User feedback
│   ├── State changes
│   └── Transitions
│
└── Performance
    ├── Calculation efficiency
    ├── Visual response
    └── Memory usage
```

### 2. Implementation Rules
```dax
// Efficient Dynamic Measure
Optimized_Measure = 
VAR CurrentContext = SELECTEDVALUE(Dimension[Field])
VAR CachedResult = 
    CALCULATE(
        [Base_Measure],
        KEEPFILTERS(Dimension[Field] = CurrentContext)
    )
RETURN
    CachedResult
```

## ⚠️ Common Pitfalls

### 1. Performance Issues
```plaintext
Common Problems
├── Complex calculations
├── Too many dynamics
├── Poor optimization
├── Memory pressure
└── Slow response
```

### 2. Design Issues
```plaintext
Design Challenges
├── Unclear feedback
├── Inconsistent behavior
├── Poor visibility
├── Complex interaction
└── Confusing states
```

## 📊 Implementation Examples

### 1. Dynamic Visuals
```dax
// Dynamic Visual Selection
Visual_State = 
SWITCH(
    SELECTEDVALUE(Display[Type]),
    "Chart", "ShowChart",
    "Table", "ShowTable",
    "Card", "ShowCard",
    "ShowDefault"
)
```

### 2. Dynamic Fields
```dax
// Dynamic Field Selection
Selected_Field = 
VAR FieldChoice = SELECTEDVALUE(Fields[Name])
RETURN
    SWITCH(
        FieldChoice,
        "Sales", [Sales_Amount],
        "Profit", [Profit_Amount],
        "Units", [Units_Sold],
        [Default_Measure]
    )
```

## 🎨 Dynamic Properties

### 1. Visual Properties
```dax
// Dynamic Properties
Property_Value = 
SWITCH(
    TRUE(),
    [Value] > [High_Threshold], "Large",
    [Value] > [Med_Threshold], "Medium",
    "Small"
)
```

### 2. Formatting Rules
```dax
// Dynamic Formatting
Format_Rule = 
VAR CurrentValue = [Measure]
VAR BaseFormat = "0.0"
RETURN
    IF(
        ABS(CurrentValue) >= 1000000,
        "0.0,,\"M\"",
        IF(
            ABS(CurrentValue) >= 1000,
            "0.0,\"K\"",
            BaseFormat
        )
    )
```

## 🔄 State Management

### 1. Selection States
```dax
// Selection State Tracking
State_Tracker = 
VAR CurrentState = SELECTEDVALUE(States[State])
VAR DefaultState = "Initial"
RETURN
    COALESCE(CurrentState, DefaultState)
```

### 2. Context Preservation
```dax
// Context Management
Context_Keeper = 
CALCULATETABLE(
    VALUES(Dimension[Field]),
    ALLSELECTED()
)
```

## 📱 Responsive Behavior

### 1. Size Adaptation
```dax
// Responsive Sizing
Size_Calculator = 
VAR ScreenSize = SELECTEDVALUE(Screen[Size])
RETURN
    SWITCH(
        ScreenSize,
        "Large", 48,
        "Medium", 32,
        "Small", 24,
        16
    )
```

### 2. Layout Changes
```plaintext
Responsive Layout
├── Desktop
│   ├── Full layout
│   └── All elements
├── Tablet
│   ├── Modified layout
│   └── Priority elements
└── Mobile
    ├── Minimal layout
    └── Essential elements
```

## 🔍 Performance Optimization

### 1. Calculation Optimization
```dax
// Optimized Dynamic Calculation
Optimized_Dynamic = 
VAR StoredResult = 
    CALCULATE(
        [Complex_Measure],
        KEEPFILTERS(ALL(Dimension))
    )
RETURN
    StoredResult
```

### 2. Cache Strategy
```plaintext
Caching Approach
├── Static elements
├── Common calculations
├── Lookup values
└── Intermediate results
```

## 📚 Related Topics
- Conditional Formatting
- Interactive Features
- Visual Design
- Performance
- User Experience

## 🛡️ Best Practices
1. Performance first
2. Clear feedback
3. Consistent behavior
4. Error handling
5. User guidance
