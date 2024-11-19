# E-Commerce Retail Analysis: Data-Driven Insights
*Transforming raw retail data into actionable business insights* 📊

## Table of Contents
1. [Project Overview](#project-overview)
2. [Environment Setup](#environment-setup)
3. [Data Exploration & Cleaning](#data-exploration--cleaning)
4. [Data Quality Assessment](#data-quality-assessment)
5. [Feature Engineering & Analysis](#feature-engineering--analysis)

## Project Overview
This analysis explores an e-commerce retail dataset to uncover customer behavior patterns, optimize inventory management, and enhance business operations. Using Python and various data analysis libraries, we'll dive deep into transactional data to extract meaningful insights.

## Environment Setup

```python
# Import required libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
import plotly.graph_objs as go
import plotly.subplots as sp
import warnings
import os

# Configure environment
warnings.filterwarnings('ignore')
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', 100)
%matplotlib inline

# Environment Information
print(f"Python version: {sys.version}")
print(f"Pandas version: {pd.__version__}")
print(f"NumPy version: {np.__version__}")
```

## Data Exploration & Cleaning

### Initial Data Assessment

The dataset contains 49,782 records with 17 columns, covering various aspects of retail operations including:
- Transaction details (InvoiceNo, StockCode, Quantity)
- Product information (Description, UnitPrice, Category)
- Customer data (CustomerID, Country)
- Operational metrics (ShippingCost, PaymentMethod, OrderPriority)

#### Data Structure Overview
```python
df = pd.read_csv('/Users/pavankakarrot/Documents/DataAnalysisProjects/online_retail_dataset.csv')
```

Key Dataset Characteristics:
- 17 columns with mixed data types (4 float64, 2 int64, 11 object)
- Primary metrics include quantity, unit price, and shipping costs
- Contains categorical data like country, payment method, and order priority

### Data Quality Assessment

#### Missing Values Analysis
- CustomerID: 4,978 missing values (10% of dataset)
- ShippingCost: 2,489 missing values (5% of dataset)
- WarehouseLocation: 3,485 missing values (7% of dataset)

#### Data Type Optimization
```python
# Convert date and ID columns to appropriate types
df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'])
df['CustomerID'] = df['CustomerID'].astype('object')
df['InvoiceNo'] = df['InvoiceNo'].astype('object')
```

#### Statistical Summary
| Metric | Quantity | UnitPrice | Discount | ShippingCost |
|--------|----------|-----------|----------|--------------|
| Count | 49,782 | 49,782 | 49,782 | 47,293 |
| Mean | 22.37 | 47.54 | 0.28 | 17.49 |
| Min | -50.0 | -99.98 | 0.0 | 5.0 |
| Max | 49.0 | 100.0 | 2.0 | 30.0 |
| Std | 17.92 | 33.48 | 0.23 | 7.22 |

### Data Cleaning Steps

1. **Handling Negative Values**
```python
# Remove negative unit prices
print("Initial negative prices:", (df['UnitPrice']<0).sum())  # 1,493 records
df = df[df['UnitPrice']>=0]
print("After cleaning:", (df['UnitPrice']<0).sum())  # 0 records
```

2. **Cardinality Analysis**
```python
def check_cardinality(df):
    cardinality = pd.DataFrame({
        'Unique_Values': df.nunique(),
        'Total_Values': len(df),
        'Cardinality_Percentage': (df.nunique() / len(df) * 100).round(2)
    })
    return cardinality.sort_values('Unique_Values', ascending=False)
```

#### Cardinality Results
- High Cardinality (>20%): InvoiceDate (100%), InvoiceNo (97.51%), CustomerID (73.29%), UnitPrice (20.33%)
- Medium Cardinality (1-20%): ShippingCost (5.18%), StockCode (2.07%)
- Low Cardinality (<1%): Country, PaymentMethod, Category, etc.

### Feature Categorization

```python
def analyze_columns(df, cardinality_threshold=20):
    num_col = []
    cat_col = []
    high_card_col = []
    
    for column in df.columns:
        if df[column].dtype in ['int64', 'float64']:
            num_col.append(column)
        else:
            unique_values = df[column].nunique()
            if unique_values > cardinality_threshold:
                high_card_col.append(column)
            else:
                cat_col.append(column)
    return num_col, cat_col, high_card_col
```

#### Column Classification Results:
1. **Numeric Columns**: 
   - Quantity, UnitPrice, Discount, ShippingCost
2. **Categorical Columns**:
   - Description, Country, PaymentMethod, Category
   - SalesChannel, ReturnStatus, ShipmentProvider
   - WarehouseLocation, OrderPriority
3. **High Cardinality Columns**:
   - InvoiceNo, StockCode, InvoiceDate, CustomerID

### Key Insights from Initial Analysis
1. The dataset shows a healthy mix of numerical and categorical features, providing rich ground for analysis
2. Negative values in UnitPrice (1,493 records) were identified and removed to ensure data quality
3. The cardinality analysis reveals natural groupings of features, helping inform our analysis strategy
4. Missing values are concentrated in specific columns, suggesting focused cleaning strategies will be needed

## Distribution Analysis & Statistical Insights

### Numerical Variables Analysis

#### Code Implementation
```python
def analyze_num_col(df, num_col):
    # Statistical Summary
    print(df[num_col].describe().T)
    
    # Distribution Plots
    plt.figure(figsize=(15,5))
    for i, col in enumerate(num_col, 1):
        plt.subplot(1, 4, i)
        sns.histplot(df[col], kde=True)
        plt.title(f'{col} Distribution')
    plt.show()
    
    # Box Plot
    plt.figure(figsize=(15,5))
    sns.barplot(data=df[num_col])
    plt.title("Box Plot of Numerical Variables")
    plt.show()
    
    # Correlation Matrix
    plt.figure(figsize=(10, 8))
    sns.heatmap(df[num_col].corr(), annot=True, cmap='coolwarm')
    plt.title("Correlation between Numerical Variables")
    plt.show()

# Execute analysis
analyze_num_col(df, num_col)
```

#### Distribution Visualizations
[Image 1: Distribution plots showing histograms with KDE for Quantity, UnitPrice, Discount, and ShippingCost]

Key Distribution Patterns:
- Quantity shows a bell-shaped distribution with concentration around 24 units
- UnitPrice displays uniform distribution across the range
- Discount follows a tight distribution between 13-38%
- ShippingCost shows normal distribution around €17.50

#### Box Plot Analysis
[Image 2: Box plot comparing distributions of numerical variables]

Distribution Insights:
- Quantity: Median at 24 units with moderate outliers
- UnitPrice: Wide range with €50.45 median
- Discount: Tight distribution around 25%
- ShippingCost: Consistent range between €11.22-23.72

#### Correlation Matrix
[Image 3: Heatmap showing correlations between numerical variables]

Correlation Insights:
- Minimal correlation between variables (all near 0)
- Slight negative correlation between UnitPrice and Quantity (-0.0027)
- Independent behavior of shipping costs

### Categorical Variables Analysis

#### Code Implementation
```python
def analyze_categorical_columns(df, cat_cols):
    for col in cat_cols:
        # Value counts and percentage
        print(f"\nValue Counts for {col}:")
        count_df = df[col].value_counts().reset_index()
        count_df.columns = [col, 'Count']
        count_df['Percentage'] = (count_df['Count']/len(df))*100
        print(count_df)
        
        # Bar plot
        plt.figure(figsize=(10, 5))
        sns.countplot(data=df, x=col)
        plt.title(f'Distribution of {col}')
        plt.xticks(rotation=45)
        plt.show()

# Execute analysis
analyze_categorical_columns(df, cat_col)
```

#### Product Description Distribution
[Image 4: Bar plot showing distribution of product descriptions]

Distribution Highlights:
- Wall Clock leads with 9.22%
- Even distribution across product types (~9% each)
- Balanced inventory across categories

# Data Quality Assessment & Preprocessing

## Missing Value Analysis

### Initial Assessment
```python
def analyze_missing_values(df):
    missing = df.isnull().sum()
    missing_perc = (missing/len(df))*100
    
    missing_df = pd.DataFrame({
        'Missing Values': missing,
        'Missing Percentage': missing_perc
    }).sort_values('Missing Values', ascending=False)
    print("Missing Value Analysis:")
    print(missing_df[missing_df['Missing Values'] > 0])
```

#### Missing Values Summary
| Column | Missing Count | Percentage |
|--------|--------------|------------|
| CustomerID | 3,485 | 7.22% |
| WarehouseLocation | 1,992 | 4.13% |
| ShippingCost | 996 | 2.06% |

### Shipping Cost Analysis
```python
def shipping_analysis(df):
    ship_cost = df['ShippingCost'].mean()
    ship_cost_country = df.groupby('Country')['ShippingCost'].mean()
    # ... [rest of the function code]
```

#### Key Findings:
1. **Overall Metrics**
   - Mean Shipping Cost: €17.49
   - Median Shipping Cost: €17.50
   - Skewness: 0.00
   - No outliers detected in shipping costs

2. **Country-wise Analysis**
   - Spain: Highest average (€17.81)
   - Germany: Lowest average (€17.30)
   - Very consistent pricing across countries
   - Maximum variation: €0.52 between countries

3. **Distribution Analysis**
   - Perfect normal distribution (skewness: 0.00)
   - No significant outliers
   - Mean and median virtually identical (diff: €0.01)

## Data Cleaning Strategy

### 1. Missing Value Treatment
```python
def handle_missing_values(df):
    df_clean = df.copy()
    
    # Fill WarehouseLocation with mode
    df_clean['WarehouseLocation'] = df_clean['WarehouseLocation'].fillna(
        df_clean['WarehouseLocation'].mode()[0]
    )
    
    # Fill ShippingCost with country-wise median
    df_clean['ShippingCost'] = df_clean.groupby('Country')['ShippingCost'].transform(
        lambda x: x.fillna(x.median())
    )
    
    # Replace CustomerID missing values
    df_clean["CustomerID"] = df_clean["CustomerID"].fillna("Guest Customer")
    
    return df_clean
```

#### Imputation Strategy:
1. **CustomerID (7.22% missing)**
   - Filled with "Guest Customer"
   - Rationale: Likely guest purchases
   - Maintains analytical integrity

2. **WarehouseLocation (4.13% missing)**
   - Filled with mode
   - Preserves existing distribution
   - Logical for operational analysis

3. **ShippingCost (2.06% missing)**
   - Country-wise median imputation
   - Accounts for regional variations
   - Maintains pricing structure

### 2. Outlier Detection & Treatment
```python
def handle_outliers(df_clean, num_col):
    df_cleaned_outliers = df_clean.copy()
    for col in num_col:
        Q1 = df_cleaned_outliers[col].quantile(0.25)
        Q3 = df_cleaned_outliers[col].quantile(0.75)
        IQR = Q3 - Q1
        # ... [rest of the function code]
```

#### Outlier Analysis Results:
1. **Quantity**
   - Outliers: 518 records (1.07%)
   - Bounds: [-25.50, 74.50]
   - Treatment: Capped at boundaries
   - Impact: Minimal change in distribution

2. **UnitPrice**
   - No outliers detected
   - Natural range: [€1.00, €100.00]
   - No treatment needed

3. **Discount**
   - No outliers detected
   - Consistent range: [0, 0.5]
   - Well-controlled discount policy

4. **ShippingCost**
   - No outliers detected
   - Range: [€5.00, €30.00]
   - Standardized shipping tiers

### Impact of Data Cleaning

#### Before vs After Metrics
```python
# Quantity Statistics Comparison
Before:
- Mean: 23.85
- Std: 15.87
- Range: [-50, 49]

After:
- Mean: 23.98
- Std: 15.40
- Range: [-25.5, 49]
```

#### Key Improvements:
1. **Data Completeness**
   - 100% complete dataset
   - Maintained data integrity
   - Preserved business logic

2. **Data Quality**
   - Removed extreme outliers
   - Preserved natural variations
   - Improved statistical reliability

3. **Statistical Stability**
   - Reduced standard deviation
   - Maintained central tendencies
   - Enhanced analytical reliability

### Recommendations for Future Data Collection

1. **CustomerID Tracking**
   - Implement guest ID system
   - Improve customer tracking
   - Reduce missing IDs

2. **Warehouse Management**
   - Strengthen location tracking
   - Implement validation rules
   - Improve data entry process

3. **Shipping Cost Documentation**
   - Standardize cost recording
   - Implement automated calculation
   - Enhance country-specific tracking
# Advanced Sales Analytics & Feature Engineering

## Feature Engineering Implementation

### Code Overview
```python
def feature_engineering(df_final):
    df_feat = df_final.copy()
    
    # 1. Time-based Features
    df_feat['InvoiceDate'] = pd.to_datetime(df_feat['InvoiceDate'])
    df_feat['Year'] = df_feat['InvoiceDate'].dt.year
    df_feat['Month'] = df_feat['InvoiceDate'].dt.month
    df_feat['Day'] = df_feat['InvoiceDate'].dt.day
    df_feat['DayOfWeek'] = df_feat['InvoiceDate'].dt.dayofweek
    df_feat['IsWeekend'] = df_feat['DayOfWeek'].isin([5,6]).astype(int)
    
    # 2. Sales Features
    df_feat['TotalAmount'] = df_feat['Quantity'] * df_feat['UnitPrice']
    df_feat['DiscountAmount'] = df_feat['TotalAmount'] * df_feat['Discount']
    df_feat['FinalAmount'] = df_feat['TotalAmount'] - df_feat['DiscountAmount']
    
    return df_feat
```

### Features Created
1. **Time-based Features**
   - Year: Extraction of year from invoice date
   - Month: Month number (1-12)
   - Day: Day of month
   - DayOfWeek: Day of week (0=Monday, 6=Sunday)
   - IsWeekend: Binary indicator (0=Weekday, 1=Weekend)

2. **Sales Metrics**
   - TotalAmount: Base revenue (Quantity × UnitPrice)
   - DiscountAmount: Discount value applied
   - FinalAmount: Net revenue after discounts

## Sales Analysis Visualization

### Implementation
```python
def visualize_sales_analysis(df_featured):
    plt.style.use('default')
    colors = sns.color_palette("husl", 10)
    
    # 1. Sales Distribution by Country
    plt.figure(figsize=(12, 6))
    country_sales = df_featured.groupby('Country')['FinalAmount'].sum().sort_values(ascending=False)
    sns.barplot(x=country_sales.index, y=country_sales.values, palette='viridis')
    plt.title('Sales Distribution by Country')
    plt.xticks(rotation=45)
    plt.show()
    
    # [Additional visualization code...]
```

### Key Visualizations & Insights

#### 1. Geographic Distribution
[Image 1: Bar chart showing sales distribution by country]

**Key Findings:**
- Belgium leads with €3.77M in sales
- UK and US follow closely (€3.74M each)
- Netherlands has lowest but still significant sales (€3.52M)
- Remarkably balanced distribution across countries

#### 2. Payment Methods
[Image 2: Pie chart of sales by payment method]

**Distribution:**
- Bank Transfer: 33.9%
- Credit Card: 33.1%
- PayPal: 33.0%

**Insights:**
- Nearly equal distribution across payment methods
- Suggests robust payment infrastructure
- No clear customer preference in payment method

#### 3. Seasonal Trends
[Image 3: Line plot showing sales trends over years]

**Pattern Analysis:**
- Consistent sales patterns across years
- Slight seasonal variations
- Strong performance in late Q3/early Q4
- Notable dip in early Q1 across years

#### 4. Product Performance
[Image 4: Bar chart of top 10 products by sales]

**Top Performers:**
1. SKU_1995: $72,330
2. SKU_1741: $68,376
3. SKU_1185: $68,324

**Analysis:**
- Top 10 products show consistent performance
- Small variance between top performers ($7,044 range)
- Suggests stable product portfolio

## Statistical Analysis Results

### Overall Sales Metrics
```python
def analyze_sales(df_featured):
    # Sales analysis implementation
    print("\nSales Analysis:")
    print(df_featured['FinalAmount'].describe())
```

#### Key Statistics
| Metric | Value |
|--------|--------|
| Mean | €909.05 |
| Median | €668.83 |
| Std Dev | €879.83 |
| Min | -€2,387.57 |
| Max | €4,847.12 |

### Temporal Analysis

#### Day of Week Performance
| Day | Average Sales |
|-----|---------------|
| Monday | €919.39 |
| Tuesday | €897.71 |
| Wednesday | €917.07 |
| Thursday | €908.09 |
| Friday | €883.96 |
| Saturday | €919.91 |
| Sunday | €916.95 |

#### Weekend vs Weekday
- Weekday Average: €905.29
- Weekend Average: €918.43
- Weekend Premium: +1.45%

### Category Performance
| Category | Total Sales |
|----------|-------------|
| Furniture | €8.90M |
| Accessories | €8.80M |
| Apparel | €8.74M |
| Electronics | €8.73M |
| Stationery | €8.73M |

## Business Insights & Recommendations

### 1. Market Strategy
- **Geographic Focus**: Maintain balanced international presence
- **Growth Potential**: Netherlands shows room for growth
- **Market Stability**: Consistent performance across regions

### 2. Payment Strategy
- **Infrastructure**: Maintain robust multi-payment support
- **Cost Optimization**: Negotiate better rates with providers
- **Customer Choice**: Continue offering all payment methods

### 3. Product Strategy
- **Portfolio Balance**: Maintain diverse product mix
- **Top Performers**: Focus on SKU_1995 success factors
- **Category Management**: Continue balanced category approach

### 4. Operational Recommendations
1. **Timing Optimization**
   - Leverage weekend sales boost
   - Plan promotions around peak days
   - Optimize staffing for weekend demand

2. **Category Management**
   - Maintain balanced inventory across categories
   - Focus on furniture category success factors
   - Consider cross-category promotions

3. **Payment Processing**
   - Monitor processing costs across methods
   - Consider loyalty programs for preferred methods
   - Maintain payment method flexibility

4. **International Operations**
   - Standardize operations across markets
   - Consider local market optimizations
   - Maintain balanced resource allocation

### Future Analysis Recommendations
1. **Deep Dive Analysis**
   - Product-level profitability
   - Customer segment performance
   - Regional preference patterns

2. **Advanced Analytics**
   - Predictive sales modeling
   - Customer behavior clustering
   - Seasonal trend forecasting


  # Advanced Sales Analysis & Business Recommendations

## Order Value Analysis

### Distribution Pattern
```python
plt.figure(figsize=(12, 6))
sns.histplot(data=df_featured, x='FinalAmount', bins=50, kde=True)
plt.axvline(df_featured['FinalAmount'].mean(), color='red', 
            linestyle='--', label=f'Mean: ${df_featured["FinalAmount"].mean():,.2f}')
plt.axvline(df_featured['FinalAmount'].median(), color='green', 
            linestyle='--', label=f'Median: ${df_featured["FinalAmount"].median():,.2f}')
plt.title('Distribution of Order Values')
plt.legend()
plt.show()
```

[Image 1: Histogram showing order value distribution]

**Key Insights:**
- Mean Order Value: $909.05
- Median Order Value: $668.83
- Right-skewed distribution
- Most orders concentrated between $200-$1,500
- Long tail extending to $4,000+

## Sales Channel Analysis

### Channel Distribution
[Image 2: Pie chart of sales distribution by channel]

**Channel Performance:**
- Online: 50.1% ($21.98M)
- In-store: 49.9% ($21.91M)

**Key Metrics:**
| Channel | Count | Average Order |
|---------|--------|---------------|
| Online | 24,281 | $905.41 |
| In-store | 24,008 | $912.73 |

## Return Rate Analysis
[Image 3: Pie chart showing return status]

**Return Statistics:**
- Not Returned: 90.2%
- Returned: 9.8%

**Business Impact:**
- Healthy return rate below industry average
- Potential for $4.3M in retained revenue
- Strong product satisfaction indicators

## Category Performance
[Image 4: Bar chart of average order value by category]

**Category Rankings:**
1. Accessories: $912.16
2. Apparel: $911.70
3. Furniture: $911.10
4. Electronics: $905.62
5. Stationery: $904.66

**Analysis:**
- Minimal variance across categories ($7.50 range)
- Consistent pricing strategy
- Balanced category performance

## Shipping Analysis
[Image 5: Box plot of shipping costs by country]

**Distribution Characteristics:**
- Median Range: €17.20 - €18.02
- Consistent spread across countries
- Few outliers in shipping costs
- Standardized shipping policy evident

## Comprehensive Business Analysis

### 1. Sales Performance
```python
def generate_summary(df_featured):
    print("Key Business Insights:")
    print(f"Total Revenue: ${df_featured['FinalAmount'].sum():,.2f}")
    print(f"Average Order Value: ${df_featured['FinalAmount'].mean():,.2f}")
    # ... [rest of the code]
```

#### Key Metrics:
- Total Revenue: $43,897,082.88
- Average Order Value: $909.05
- Unique Customers: 35,390
- Orders per Customer: 1.36

### 2. Channel Effectiveness
```python
channel_conversion = df_featured.groupby('SalesChannel')['FinalAmount'].agg(['count', 'sum', 'mean'])
```

#### Channel Metrics:
| Channel | Transactions | Total Revenue | Avg. Order |
|---------|--------------|---------------|------------|
| Online | 24,281 | $21.98M | $905.41 |
| In-store | 24,008 | $21.91M | $912.73 |

### 3. Business Recommendations

```python
def business_recommendations(df_featured):
    print("Business Recommendations:")
    top_months = df_featured.groupby('Month')['FinalAmount'].sum().nlargest(3)
    # ... [rest of the code]
```

#### Strategic Initiatives:

1. **Sales Optimization**
   - Focus marketing in months 1, 8, and 3
   - Leverage seasonal trends
   - Optimize promotional timing

2. **Customer Engagement**
   - Implement loyalty program
   - Target 1.36 orders per customer
   - Personalize marketing efforts

3. **Product Strategy**
   - Maintain category balance
   - Review pricing consistency
   - Optimize inventory mix

4. **Operational Excellence**
   - Standardize shipping costs
   - Balance channel operations
   - Minimize returns

## Final Report Summary

```python
def generate_final_report(df_featured):
    print("SALES ANALYSIS REPORT")
    print("=" * 50)
    # ... [rest of the code]
```

### Analysis Period
- Start Date: 2020-01-01
- End Date: 2025-09-05
- Total Transactions: 48,289

### Key Performance Indicators
1. **Revenue Metrics**
   - Total Revenue: $43.90M
   - Average Transaction: $909.05
   - Channel Balance: 50.1% Online

2. **Customer Metrics**
   - Active Customers: 35,390
   - Customer Frequency: 1.36 orders
   - Return Rate: 9.8%

3. **Product Performance**
   - Product Range: 1,000 SKUs
   - Category Spread: $7.50 variance
   - Top Category: Accessories ($912.16)

### Strategic Recommendations

1. **Revenue Growth**
   - Implement seasonal marketing
   - Optimize channel mix
   - Enhance product categories

2. **Customer Development**
   - Launch loyalty program
   - Increase purchase frequency
   - Reduce return rate

3. **Operational Enhancement**
   - Standardize shipping
   - Balance inventory
   - Optimize pricing

4. **Market Expansion**
   - Focus on high-potential regions
   - Enhance channel integration
   - Develop category strengths

### Implementation Priorities
1. Immediate Focus
   - Loyalty program launch
   - Seasonal marketing planning
   - Shipping optimization

2. Medium Term
   - Channel integration
   - Product range expansion
   - Customer retention

3. Long Term
   - Market expansion
   - Category development
   - Operational excellence

This comprehensive analysis provides a clear roadmap for business optimization and growth strategies.
