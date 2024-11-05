# Cross-filtering & Cross-highlighting in Power BI

## Overview
Cross-filtering and cross-highlighting are interactive features in Power BI that enable users to see related data across multiple visualizations by selecting elements in one visual to filter or highlight data in other visuals.

## 🎯 Key Concepts

### Cross-filtering vs Cross-highlighting
```plaintext
Interaction Types
│
├── Cross-filtering
│   ├── Filters out unrelated data
│   ├── Shows only matching records
│   └── Affects visual totals
│
└── Cross-highlighting
    ├── Dims unrelated data
    ├── Keeps all data visible
    └── Maintains visual totals
```

*   **Cross-Filtering**: Cross-filtering occurs when selecting an item in one visual filters the data in other related visuals. This lets users narrow down data across multiple visuals by selecting specific criteria, like filtering all charts by selecting a specific region in a map.
*   **Cross-Highlighting**: Cross-highlighting allows you to select data in one visual and see the highlighted portion in related visuals, while still showing the non-selected data in a lighter shade. This is useful for comparing the selected subset to the whole, like highlighting sales for one product across a range of time in a line chart.
*   **Interactivity**: Cross-filter and cross-highlight add interactive capabilities to reports, enabling users to explore relationships between data across visuals without modifying the report.
*   **Visual Compatibility**: Not all visuals support both cross-filter and cross-highlight. Most common visuals, such as bar, line, and pie charts, support these features, while others may have limitations.
*   **Single vs. Multi-Selection**: Power BI allows single or multi-selection for cross-filtering and cross-highlighting, so users can filter or highlight by selecting one or multiple items in a visual.
*   **Bidirectional Cross-Filtering**: In some cases, Power BI supports bidirectional cross-filtering, where selections affect both directions in relationships, allowing for deeper analysis.
*   **Cross-Filter Behavior Settings**: Power BI lets users adjust cross-filter behavior in the visual settings to control how each visual interacts with others, enhancing customization and report usability.
*   **Data Context Maintenance**: Cross-filtering and cross-highlighting maintain the overall data context, so users can easily understand how selected data relates to the entire dataset.


## 🛠️ Implementation Guide

### 1. Basic Setup
```plaintext
Configuration Steps:
1. Select source visual
2. Format → Edit interactions
3. Choose interaction type for each target visual:
   - Filter
   - Highlight
   - None
```

### 2. DAX Support
```dax
// Measure to track selection state
Selected_Value = 
VAR CurrentSelection = SELECTEDVALUE(Table[Column])
RETURN
    IF(
        ISBLANK(CurrentSelection),
        SUM(Table[Value]),
        CALCULATE(
            SUM(Table[Value]),
            Table[Column] = CurrentSelection
        )
    )
```

## 💡 Best Practices

### 1. Visual Design
- Logical grouping of related visuals
- Clear visual hierarchy
- Consistent interaction patterns
- Intuitive user experience
- Performance optimization

### 2. Interaction Flow
```plaintext
Interaction Design
├── Primary Visuals (Filters)
│   ├── Slicers
│   ├── Tables
│   └── Key Charts
│
└── Detail Visuals (Filtered)
    ├── Detailed Charts
    ├── Cards
    └── Tables
```

## ⚠️ Common Pitfalls
1. Overcomplicated interactions
2. Conflicting filter logic
3. Poor performance
4. Unclear user feedback
5. Inconsistent behavior

## 📊 Implementation Scenarios

### 1. Basic Cross-filtering
```dax
// Measure for filtered values
Filtered_Sales = 
CALCULATE(
    SUM(Sales[Amount]),
    ALLSELECTED(Sales)
)
```

### 2. Advanced Scenarios
```dax
// Measure with multiple selection states
Dynamic_Selection = 
VAR SelectedCategory = SELECTEDVALUE(Product[Category])
VAR SelectedRegion = SELECTEDVALUE(Geography[Region])
RETURN
    CALCULATE(
        SUM(Sales[Amount]),
        FILTER(
            ALL(Product),
            ISBLANK(SelectedCategory) || 
            Product[Category] = SelectedCategory
        ),
        FILTER(
            ALL(Geography),
            ISBLANK(SelectedRegion) || 
            Geography[Region] = SelectedRegion
        )
    )
```

## 🔍 Performance Optimization

### 1. Best Practices
- Limit interaction chains
- Optimize visual count
- Use bookmarks for complex states
- Implement selective updates
- Monitor performance impact

### 2. Testing Scenarios
```plaintext
Test Cases
├── Single Selection
├── Multiple Selections
├── Clear Selections
├── Complex Interactions
└── Performance Monitoring
```

## 📈 Advanced Techniques

### 1. Custom Visual Interactions
```dax
// Custom interaction measure
Custom_Interaction = 
VAR SelectionState = SELECTEDVALUE(Control[State])
RETURN
    SWITCH(
        SelectionState,
        "Highlight", [Highlight_Measure],
        "Filter", [Filter_Measure],
        [Default_Measure]
    )
```

### 2. Bi-directional Filtering
```plaintext
Bi-directional Setup:
1. Model View
2. Select relationship
3. Enable bi-directional
4. Configure security
5. Test interactions
```

## 🎨 Design Patterns

### 1. Master-Detail
```plaintext
Layout Structure
├── Master View
│   ├── Summary Charts
│   └── Key Metrics
│
└── Detail View
    ├── Detailed Tables
    └── Specific Metrics
```

### 2. Hub and Spoke
```plaintext
Interaction Flow
├── Central Hub
│   └── Main KPIs
│
└── Surrounding Details
    ├── Supporting Metrics
    └── Detailed Analysis
```

## 🔄 Interaction States

### 1. State Management
```dax
// State tracking measure
Interaction_State = 
VAR CurrentState = SELECTEDVALUE(States[State])
RETURN
    SWITCH(
        CurrentState,
        "Default", [Base_Measure],
        "Filtered", [Filtered_Measure],
        "Highlighted", [Highlighted_Measure],
        [Base_Measure]
    )
```

### 2. Bookmarks
- Default states
- Custom views
- User selections
- Complex filters
- Shared states

## 📚 Related Topics
- Visual Interactions
- Filter Context
- Bookmarks
- Performance Optimization
- Report Design

## 🛡️ Governance Considerations
1. Interaction documentation
2. Performance guidelines
3. Design standards
4. Testing protocols
5. User training

## 📱 Cross-platform Behavior
1. Desktop interactions
2. Web browser support
3. Mobile experience
4. Embedded scenarios
5. Custom apps
