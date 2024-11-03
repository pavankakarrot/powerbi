# Data Analysis in Power BI

## 🎯 Learning Objectives
- Understanding statistical analysis
- Mastering time intelligence
- Implementing advanced analytics
- Creating AI-driven insights

## 📊 Statistical Analysis

### Basic Statistics
1. Central Tendency
   ```dax
   Average Sales = AVERAGE(Sales[Amount])
   Median Price = MEDIAN(Products[Price])
   Mode Category = CALCULATE(
       SELECTEDVALUE(Products[Category]),
       TOPN(1, VALUES(Products[Category]),
       COUNTROWS(Sales))
   )
   ```

2. Variance Measures
   ```dax
   Sales StdDev = STDEV.P(Sales[Amount])
   Price Variance = VAR(Products[Price])
   ```

3. Distribution Analysis
   - Histograms
   - Box plots
   - Scatter plots

## ⏰ Time Intelligence

### Basic Time Calculations
1. Year-to-Date (YTD)
   ```dax
   YTD Sales = 
   CALCULATE(
       SUM(Sales[Amount]),
       DATESYTD(Calendar[Date])
   )
   ```

2. Previous Period Comparison
   ```dax
   Sales vs PY = 
   VAR CurrentSales = [Total Sales]
   VAR PreviousSales = 
       CALCULATE(
           [Total Sales],
           SAMEPERIODLASTYEAR(Calendar[Date])
       )
   RETURN
   CurrentSales - PreviousSales
   ```

3. Moving Averages
   ```dax
   3M Moving Avg = 
   AVERAGEX(
       DATESINPERIOD(
           Calendar[Date],
           LASTDATE(Calendar[Date]),
           -3,
           MONTH
       ),
       [Total Sales]
   )
   ```

## 🤖 Advanced Analytics

### Forecasting
1. Built-in Forecasting
   - Time series forecasting
   - Confidence intervals
   - Seasonality adjustment

2. Custom Forecasting
   - Using R scripts
   - Python integration
   - Advanced models

### Clustering
1. Customer Segmentation
   - RFM analysis
   - Behavioral clustering
   - Value segmentation

2. Product Analysis
   - Category clustering
   - Performance grouping
   - Inventory optimization

## 📈 Key Performance Indicators (KPIs)

### Financial KPIs
1. Profitability
   ```dax
   Gross Margin % = 
   DIVIDE(
       SUM(Sales[Revenue]) - SUM(Sales[Cost]),
       SUM(Sales[Revenue])
   )
   ```

2. Growth Metrics
   ```dax
   YoY Growth % = 
   DIVIDE(
       [Sales vs PY],
       [Previous Year Sales],
       0
   )
   ```

### Operational KPIs
1. Inventory Metrics
   - Stock turnover
   - Days of inventory
   - Reorder points

2. Sales Metrics
   - Conversion rates
   - Average order value
   - Customer acquisition cost

## 👩‍💻 Practice Exercises

### Basic Analysis
1. Create time intelligence measures
   - YTD calculations
   - Previous period comparisons
   - Growth calculations

### Advanced Analysis
1. Implement forecasting
   - Built-in forecasting
   - Custom calculations
   - Seasonal adjustments

### AI Integration
1. Key Influencers visual
2. Decomposition tree
3. Smart narrative

## ⚠️ Common Challenges

### Time Intelligence Issues
- Problem: Incorrect date relationships
- Solution: Proper date table setup
- Prevention: Use CALENDAR function

### Performance Issues
- Problem: Slow calculations
- Solution: Optimize measures
- Prevention: Use variables and proper filtering

## 🔍 Analysis Checklist
- [ ] Set up date table
- [ ] Create basic time measures
- [ ] Implement KPIs
- [ ] Add forecasting
- [ ] Test performance
- [ ] Document calculations

## 📚 Additional Resources
- DAX Patterns website
- Power BI community forums
- Microsoft documentation
- Sample reports
- Video tutorials

## 📝 Analysis Notes
Document your insights and learnings here!
