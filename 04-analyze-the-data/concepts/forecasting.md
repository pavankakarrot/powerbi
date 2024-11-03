# Forecasting in Power BI

## 📈 Time Series Analysis

### 1. Moving Averages
```dax
// Simple Moving Average
3M Moving Average = 
AVERAGEX(
    DATESINPERIOD(
        Calendar[Date],
        LASTDATE(Calendar[Date]),
        -3,
        MONTH
    ),
    [Sales]
)

// Weighted Moving Average
Weighted MA = 
VAR Period1 = CALCULATE([Sales], DATEADD(Calendar[Date], -1, MONTH)) * 0.5
VAR Period2 = CALCULATE([Sales], DATEADD(Calendar[Date], -2, MONTH)) * 0.3
VAR Period3 = CALCULATE([Sales], DATEADD(Calendar[Date], -3, MONTH)) * 0.2
RETURN Period1 + Period2 + Period3
```

### 2. Exponential Smoothing
```dax
// Simple Exponential Smoothing
Smoothed Value = 
VAR Alpha = 0.3
VAR CurrentValue = [Sales]
VAR PreviousSmoothed = [Previous Smoothed Value]
RETURN
Alpha * CurrentValue + (1 - Alpha) * PreviousSmoothed
```

## 🎯 Trend Analysis

### 1. Linear Trend
```dax
// Linear Trend Calculation
Linear Trend = 
VAR _avgX = AVERAGE(Calendar[DateIndex])
VAR _avgY = AVERAGE(Sales[Amount])
VAR _slope = [Slope]
RETURN
_avgY + _slope * (Calendar[DateIndex] - _avgX)
```

### 2. Seasonal Patterns
```dax
// Seasonal Index
Seasonal Index = 
DIVIDE(
    [Sales],
    CALCULATE(
        AVERAGE(Sales[Amount]),
        ALL(Calendar[Month])
    )
)
```

## 🤖 Built-in Forecasting

### 1. Configuration
```
Parameters:
- Forecast Length
- Confidence Interval
- Seasonality
- Ignore Last
```

### 2. Algorithm Options
```
Methods:
- ETS (Error, Trend, Seasonal)
- ARIMA
- Neural Network
```

## 📊 Custom Forecasting Models

### 1. Multiple Regression
```dax
// Multiple Regression Forecast
Forecast = 
VAR Intercept = [Regression Intercept]
VAR Coefficient1 = [Coefficient 1]
VAR Coefficient2 = [Coefficient 2]
RETURN
Intercept + 
Coefficient1 * [Variable1] +
Coefficient2 * [Variable2]
```

### 2. Growth Models
```dax
// Exponential Growth
Growth Forecast = 
[Initial Value] * 
POWER(1 + [Growth Rate], [Time Period])
```

## 🎯 Accuracy Metrics

### 1. Error Measurements
```dax
// Mean Absolute Error (MAE)
MAE = 
AVERAGEX(
    Forecasts,
    ABS([Actual] - [Forecast])
)

// Mean Absolute Percentage Error (MAPE)
MAPE = 
AVERAGEX(
    Forecasts,
    ABS(([Actual] - [Forecast]) / [Actual])
)
```

### 2. Forecast Validation
```dax
// R-Squared
R Squared = 
VAR _SST = [Total Sum of Squares]
VAR _SSR = [Regression Sum of Squares]
RETURN
DIVIDE(_SSR, _SST)
```

## 📉 Scenario Analysis

### 1. What-If Parameters
```
Parameters:
- Growth Rate
- Seasonality Factor
- External Factors
```

### 2. Multiple Scenarios
```
Types:
- Optimistic
- Pessimistic
- Most Likely
```

## ⚠️ Common Challenges

### 1. Data Issues
```
- Insufficient History
- Missing Values
- Outliers
- Structural Changes
```

### 2. Model Selection
```
- Complexity vs Accuracy
- Seasonality Handling
- Trend Components
- External Factors
```

## ✅ Best Practices

### 1. Preparation
- [ ] Data quality check
- [ ] Sufficient history
- [ ] Seasonal patterns
- [ ] Trend analysis

### 2. Model Building
- [ ] Start simple
- [ ] Test assumptions
- [ ] Validate results
- [ ] Document process

### 3. Monitoring
- [ ] Track accuracy
- [ ] Update models
- [ ] Review assumptions
- [ ] Adjust parameters
