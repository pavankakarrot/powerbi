# Statistical Analysis in Power BI

## 📊 Basic Statistics

### 1. Central Tendency
```dax
// Average
Average Sales = AVERAGE(Sales[Amount])

// Median
Median Price = MEDIAN(Products[Price])

// Mode
Mode Category = 
CALCULATE(
    SELECTEDVALUE(Products[Category]),
    TOPN(1, VALUES(Products[Category]),
    COUNTROWS(Sales))
)
```

### 2. Dispersion Measures
```dax
// Standard Deviation
Sales StDev = STDEV.P(Sales[Amount])

// Variance
Sales Variance = VAR.P(Sales[Amount])

// Range
Sales Range = 
VAR MaxSales = MAX(Sales[Amount])
VAR MinSales = MIN(Sales[Amount])
RETURN MaxSales - MinSales
```

## 📈 Distribution Analysis

### 1. Percentiles
```dax
// 75th Percentile
75th Percentile = 
PERCENTILE.EXC(Sales[Amount], 0.75)

// Quartiles
Q1 = PERCENTILE.EXC(Sales[Amount], 0.25)
Q2 = PERCENTILE.EXC(Sales[Amount], 0.50)
Q3 = PERCENTILE.EXC(Sales[Amount], 0.75)
```

### 2. Frequency Distribution
```dax
// Bin Creation
Sales Bins = 
SWITCH(
    TRUE(),
    Sales[Amount] <= 100, "0-100",
    Sales[Amount] <= 500, "101-500",
    Sales[Amount] <= 1000, "501-1000",
    ">1000"
)
```

## 🎯 Correlation Analysis

### 1. Basic Correlation
```dax
// Correlation Coefficient
Correlation = 
CALCULATE(
    DIVIDE(
        SUMX(Sales, 
            ([Quantity] - AVERAGE(Sales[Quantity])) * 
            ([Price] - AVERAGE(Sales[Price]))
        ),
        SQRT(
            SUMX(Sales, ([Quantity] - AVERAGE(Sales[Quantity]))^2) *
            SUMX(Sales, ([Price] - AVERAGE(Sales[Price]))^2)
        )
    )
)
```

### 2. Regression Analysis
```dax
// Simple Linear Regression
Slope = 
VAR _avgX = AVERAGE(Sales[Quantity])
VAR _avgY = AVERAGE(Sales[Price])
VAR _numerator = 
    SUMX(
        Sales,
        (Sales[Quantity] - _avgX) * (Sales[Price] - _avgY)
    )
VAR _denominator = 
    SUMX(
        Sales,
        (Sales[Quantity] - _avgX)^2
    )
RETURN
DIVIDE(_numerator, _denominator)
```

## 📉 Statistical Tests

### 1. Z-Score
```dax
// Z-Score Calculation
Z Score = 
VAR _mean = AVERAGE(Sales[Amount])
VAR _stdDev = STDEV.P(Sales[Amount])
RETURN
DIVIDE(Sales[Amount] - _mean, _stdDev)
```

### 2. Confidence Intervals
```dax
// 95% Confidence Interval
Confidence Interval = 
VAR _mean = AVERAGE(Sales[Amount])
VAR _stdDev = STDEV.P(Sales[Amount])
VAR _n = COUNT(Sales[Amount])
VAR _marginError = 1.96 * _stdDev / SQRT(_n)
RETURN
_mean & " ± " & _marginError
```

## 🔍 Outlier Detection

### 1. IQR Method
```dax
// Outlier Flag
Outlier Flag = 
VAR Q1 = [Q1]
VAR Q3 = [Q3]
VAR IQR = Q3 - Q1
VAR LowerBound = Q1 - 1.5 * IQR
VAR UpperBound = Q3 + 1.5 * IQR
RETURN
IF(
    Sales[Amount] < LowerBound ||
    Sales[Amount] > UpperBound,
    "Outlier",
    "Normal"
)
```

## 📊 Visualization Techniques

### 1. Box Plot Elements
```
- Minimum
- Q1
- Median
- Q3
- Maximum
- Outliers
```

### 2. Statistical Charts
```
- Histogram
- Normal Distribution
- Scatter Plot with Trend
- Residual Analysis
```

## ⚠️ Common Issues & Solutions

### 1. Data Quality
```
- Missing Values
- Outliers
- Inconsistent Data
- Sample Size
```

### 2. Analysis Pitfalls
```
- Correlation vs Causation
- Selection Bias
- Inappropriate Methods
- Misinterpretation
```

## ✅ Best Practices

### 1. Data Preparation
- [ ] Check data quality
- [ ] Handle missing values
- [ ] Normalize if needed
- [ ] Document assumptions

### 2. Analysis Steps
- [ ] Start with descriptive stats
- [ ] Visualize distributions
- [ ] Check assumptions
- [ ] Validate results

### 3. Reporting
- [ ] Clear methodology
- [ ] Appropriate visualizations
- [ ] Statistical significance
- [ ] Confidence levels
