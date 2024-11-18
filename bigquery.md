# Cracking Google Ads: Actionable Insights with Big Query & Power BI
*Because who doesn't love making sense of advertising data? Right?* 😉

## Table of Contents
## Table of Contents

1. [Project Conversion Starter](#project-conversion-starter)  
2. [Business Requirement Documentation](#business-requirement-documentation)  
3. [Data Collection](#data-collection)  
4. [Data Quality Assessment & Completeness](#data-quality-assessment--completeness)  
   4.1. [Record Count Analysis](#record-count-analysis)  
   4.2. [Missing Values](#missing-values)  
   4.3. [Data Metric Range](#data-metric-range)  
   4.4. [Outlier Detection](#outlier-detection)  
   4.5. [Relationship Integrity Between Tables](#relationship-integrity-between-tables)  
5. [Data Model Design: Facts & Dimension Tables](#data-model-design-facts--dimension-tables)  
6. [Data Processing & Cleaning](#data-processing--cleaning)  
7. [Data Enhancement: Metrics & KPI Development](#data-enhancement-metrics--kpi-development)  
8. [Analysis & Reporting](#analysis--reporting)  
9. [Power BI Dashboard](#power-bi-dashboard)  

<br>
<br>
<br>

## 1. Project Conversation Starter

<div align="left">

> **Boss:** (*probably after a coffee, because these requests always come after coffee*)  
> We need to figure out how our ads are doing and what’s working or not. I want insights that help us improve ROI and make better decisions.

<br>

**Me:** Got it! Let me confirm a few details to ensure I deliver exactly what you need. Are we focusing on specific campaigns, or do you want an overall analysis?

<br>

> **Boss:** Start with an overall analysis, then dive into the major campaigns driving the most traffic or spend.

<br>

**Me:** Understood. I'll analyze campaign performance metrics like clicks, impressions, conversions, and costs. For devices, I'll evaluate performance by type, including conversion rates and cost efficiency. I'll also assess landing page. Lastly, I'll segment the audience by demographics such as age and gender. Does this cover your requirements?

<br>

> **Boss:** Yes, sounds perfect. Can you make sure the insights are actionable and include recommendations?

<br>

**Me:** Absolutely! I’ll prepare a report with data visualizations and clear recommendations to optimize campaigns and improve ROI.

<br>

> **Boss:** Great. Let’s touch base by Friday to review the findings.

<br>
<br>
---
<br>

## 2. Business Requirement Documentation

#### Objective 
To analyze Google Ads campaign performance comprehensively by identifying key metrics, device-level insights, landing page effectiveness, and audience demographics, enabling data-driven optimization of marketing strategies.

#### KPI Goals

- ***Campaign Performance*** – Evaluates metrics like clicks, impressions, conversions, and costs.
- ***Device Work*** – Identifies which devices drive the best engagement and cost-efficiency.
- ***Landing Page Analysis*** – Ensures our landing pages are optimized for conversions with minimal bounce rates.
- ***Demographic Insights*** – Understands audience performance by age, gender, and engagement trends.
- ***Success Looks Like:*** Clear, data-driven recommendations to optimize ad spend, improve conversions, target the right audience, and refine landing pages for maximum ROI.

```mermaid
graph TD
    A[Google Ads Analysis] --> B[Campaign Performance] 
    A --> C[Device Work]
    A --> D[Landing Page Analysis]
    A --> E[Demographic Deep Dive]
    B --> B1[Clicks]
    B --> B2[Impressions]
    B --> B3[Conversions]
    B --> B4[Costs]
    C --> C1[Performance by Device]
    C --> C2[Conversion Rates by Device]
    C --> C3[Cost Efficiency by Device]
    D --> D1[Page Performance Metrics]
    D --> D2[Conversion Rates]
    D --> D3[Bounce Rates]
    E --> E1[Age Group Performance]
    E --> E2[Gender Insights]
    E --> E3[Engagement Patterns]
```
<br>
<br>
---
<br>

## 3. Data Collection

Before we dive into making those fancy charts, let's make sure our data isn't playing tricks on us. Think of this as a health check-up for our data - but don't worry, no needles involved!

Navigate to Bigquery--> GoogleAds Dataset and pick the required data tables by verifying schema. 

#### Tables I Picked
```
Our Tables:
📊 CampaignStats - The star of our show
📊 Demographics  - Who's who in our ad world
📊 LandingPages  - Where people end up
📊 AgesRange  - Which age range end up
```
<br>
<br>
---
<br>

## 4. Data Quality Assessment & Completeness


### 4.1. Record Count Analysis

```sql
-- Check daily record counts to identify missing dates or unusual patterns
WITH daily_counts AS (
    SELECT 
        segments_date,
        COUNT(*) as record_count,
        COUNT(DISTINCT campaign_id) as campaign_count,
        COUNT(DISTINCT customer_id) as customer_count
    FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
    WHERE segments_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
    GROUP BY segments_date
)
SELECT 
    segments_date,
    record_count,
    campaign_count,
    customer_count,
    LAG(record_count) OVER (ORDER BY segments_date) as prev_day_records,
    ROUND(ABS(record_count - LAG(record_count) OVER (ORDER BY segments_date)) / 
          LAG(record_count) OVER (ORDER BY segments_date) * 100, 2) as daily_change_percentage
FROM daily_counts
ORDER BY segments_date DESC;
```

| Date       | Records | Campaigns | Customers | Prev Day Records | Daily Change % |
|------------|---------|-----------|-----------|------------------|----------------|
| 2024-10-18 | 41      | 6         | 1         | 59              | 30.51         |
| 2024-10-17 | 59      | 6         | 1         | 59              | 0.00          |
| 2024-10-16 | 59      | 6         | 1         | 51              | 15.69         |

##### Key Insights:

- ***Campaign Expansion:*** There was a strategic increase in campaign count from 5 to 6 between Oct 15-16, though this didn't immediately translate to higher record counts. This suggests possible optimization period for new campaigns.
- ***Volume Volatility:*** Record counts show significant daily fluctuations, with the highest daily change being 30.51% drop (Oct 17-18). The average daily volume is around 55 records, making the Oct 18 count (41) notably below average, indicating a potential anomaly or campaign performance issue requiring investigation.

<br>
<br>

### 4.2. Missing Vaules 

```missing value analysis
-- Check null percentages for critical fields
WITH field_stats AS (
    SELECT 
        COUNT(*) as total_records,
        COUNTIF(campaign_id IS NULL) as null_campaign_ids,
        COUNTIF(metrics_clicks IS NULL) as null_clicks,
        COUNTIF(metrics_impressions IS NULL) as null_impressions,
        COUNTIF(metrics_conversions IS NULL) as null_conversions,
        COUNTIF(segments_device IS NULL) as null_devices
    FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
    WHERE segments_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
)
SELECT 
    ROUND(null_campaign_ids / total_records * 100, 2) as campaign_id_null_pct,
    ROUND(null_clicks / total_records * 100, 2) as clicks_null_pct,
    ROUND(null_impressions / total_records * 100, 2) as impressions_null_pct,
    ROUND(null_conversions / total_records * 100, 2) as conversions_null_pct,
    ROUND(null_devices / total_records * 100, 2) as devices_null_pct
FROM field_stats;
```
| Metric              | Null % |
|--------------------|--------|
| Campaign ID        | 0.0    |
| Clicks             | 0.0    |
| Impressions        | 0.0    |
| Conversions        | 0.0    |
| Devices            | 0.0    |

#### Key Insights:

- ***Perfect Data Quality:*** All key metrics (Campaign ID, Clicks, Impressions, Conversions, and Devices) show 0% null values, indicating excellent data completeness and reliable tracking implementation.
- ***Quality Assurance:*** The consistent 0% null values across all metrics suggests robust data collection processes and proper campaign setup, making this dataset highly reliable for performance analysis and decision-making.

  <br>
  <br>
  

### 4.3. Metric Range Analysis
```
-- Check for unusual metric values
WITH metric_stats AS (
    SELECT 
        segments_date,
        metrics_clicks,
        metrics_impressions,
        metrics_conversions,
        metrics_cost_micros/1000000 as cost,
        SAFE_DIVIDE(metrics_clicks, metrics_impressions) as ctr,
        SAFE_DIVIDE(metrics_conversions, metrics_clicks) as conversion_rate
    FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
    WHERE segments_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
)
SELECT 
    -- Basic Statistics
    MIN(metrics_clicks) as min_clicks,
    MAX(metrics_clicks) as max_clicks,
    AVG(metrics_clicks) as avg_clicks,
    STDDEV(metrics_clicks) as stddev_clicks,
    
    MIN(ctr) as min_ctr,
    MAX(ctr) as max_ctr,
    AVG(ctr) as avg_ctr,
    STDDEV(ctr) as stddev_ctr,
    
    MIN(conversion_rate) as min_conv_rate,
    MAX(conversion_rate) as max_conv_rate,
    AVG(conversion_rate) as avg_conv_rate,
    STDDEV(conversion_rate) as stddev_conv_rate
FROM metric_stats;
```

| Metric    | Min   | Max   | Average | Std Dev |
|-----------|-------|-------|---------|---------|
| Clicks    | 0     | 588   | 2.36    | 29.09   |
| CTR       | 0.0%  | 100%  | 2.44%   | 8.39%   |
| Conv Rate | 0.0%  | 0.0%  | 0.0%    | 0.0%    |

#### Key Insights:

- ***Click Performance Variance:*** Wide range in click performance (0-588 clicks). Low average clicks (2.36) with high standard deviation (29.09). Suggests a few high-performing campaigns/days driving most clicks
- ***CTR & Conversion Metrics:*** CTR ranges from 0-100% with 2.44% average. Zero conversions recorded (all conversion metrics at 0%). Indicates potential tracking issues or conversion funnel problems

<br>
<br>

### 4.4. Outlier Detection

```
-- Identify potential outliers using z-score method
WITH daily_metrics AS (
    SELECT 
        segments_date,
        campaign_id,
        metrics_clicks,
        metrics_impressions,
        metrics_conversions,
        metrics_cost_micros/1000000 as cost,
        SAFE_DIVIDE(metrics_clicks, metrics_impressions) as ctr
    FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
    WHERE segments_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 90 DAY)
),
metric_stats AS (
    SELECT 
        AVG(metrics_clicks) as avg_clicks,
        STDDEV(metrics_clicks) as stddev_clicks,
        AVG(ctr) as avg_ctr,
        STDDEV(ctr) as stddev_ctr,
        AVG(cost) as avg_cost,
        STDDEV(cost) as stddev_cost
    FROM daily_metrics
)
SELECT 
    dm.*,
    ABS(metrics_clicks - ms.avg_clicks) / NULLIF(ms.stddev_clicks, 0) as clicks_zscore,
    ABS(ctr - ms.avg_ctr) / NULLIF(ms.stddev_ctr, 0) as ctr_zscore,
    ABS(cost - ms.avg_cost) / NULLIF(ms.stddev_cost, 0) as cost_zscore
FROM daily_metrics dm
CROSS JOIN metric_stats ms
WHERE 
    ABS(metrics_clicks - ms.avg_clicks) / NULLIF(ms.stddev_clicks, 0) > 3
    OR ABS(ctr - ms.avg_ctr) / NULLIF(ms.stddev_ctr, 0) > 3
    OR ABS(cost - ms.avg_cost) / NULLIF(ms.stddev_cost, 0) > 3
ORDER BY segments_date DESC;
```

| Date       | Campaign ID  | Clicks | Imp.  | CTR    | Cost ($) | CTR Z-Score | Cost Z-Score |
|------------|-------------|--------|-------|---------|-----------|-------------|--------------|
| 2024-10-18 | 21583012749 | 1      | 3     | 33.33% | 3.37      | 3.68        | 0.19         |
| 2024-10-17 | 21605724628 | 588    | 32947 | 1.78%  | 125.46    | 0.08        | 15.77        |
| 2024-10-16 | 21605724628 | 148    | 6042  | 2.45%  | 43.43     | 0.00        | 5.30         |
| 2024-10-15 | 21622484389 | 2      | 3     | 66.67% | 12.65     | 7.66        | 1.37         |
| 2024-10-11 | 21583012749 | 5      | 42    | 11.90% | 28.14     | 1.13        | 3.35         |

#### Key Insights:

- ***Performance Outliers:*** Campaign 21605724628 shows exceptional volume (588 clicks, 32,947 impressions) but lower CTR (1.78%). Highest spend day ($125.46) has Z-score of 15.77, indicating significant deviation from average
- ***Cost-Efficiency Analysis:*** High-volume campaign has highest absolute cost but moderate efficiency (CTR Z-score 0.08). Some campaigns achieve high CTR Z-scores (7.66) with minimal spend ($12.65)


<br>
<br>

### 4.5. Relationship Integrity Between Tables

```
-- Check relationship integrity between tables
WITH campaign_stats_keys AS (
    SELECT 
        COUNT(DISTINCT campaign_id) as campaign_count,
        COUNT(DISTINCT customer_id) as customer_count
    FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
),
gender_keys AS (
    SELECT COUNT(DISTINCT campaign_id) as campaign_count
    FROM `ga4powerbi-2024.GoogleAds.p_ads_Gender_5917066896`
),
age_keys AS (
    SELECT COUNT(DISTINCT campaign_id) as campaign_count
    FROM `ga4powerbi-2024.GoogleAds.p_ads_AgeRange_5917066896`
),
landing_page_keys AS (
    SELECT COUNT(DISTINCT customer_id) as customer_count
    FROM `ga4powerbi-2024.GoogleAds.p_ads_LandingPageStats_5917066896`
)
SELECT 
    cs.campaign_count as stats_campaign_count,
    g.campaign_count as gender_campaign_count,
    a.campaign_count as age_campaign_count,
    cs.customer_count as stats_customer_count,
    l.customer_count as landing_page_customer_count,
    ROUND(g.campaign_count / cs.campaign_count * 100, 2) as gender_coverage_pct,
    ROUND(a.campaign_count / cs.campaign_count * 100, 2) as age_coverage_pct,
    ROUND(l.customer_count / cs.customer_count * 100, 2) as landing_page_coverage_pct
FROM campaign_stats_keys cs
CROSS JOIN gender_keys g
CROSS JOIN age_keys a
CROSS JOIN landing_page_keys l;
```
| Metric Type        | Campaign Count | Coverage % |
|-------------------|----------------|------------|
| Base Stats        | 6              | 100%       |
| Gender Data       | 45             | 750%       |
| Age Data          | 48             | 800%       |
| Landing Pages     | 1              | 100%       |


#### Key Insights:

- ***Demographic Data Richness:*** Base campaigns (6) have extensive demographic segmentation. Each campaign averages 7.5 gender segments and 8 age segments
- ***Coverage Analysis:*** 100% landing page coverage suggests consistent tracking. 750-800% demographic coverage shows detailed audience segmentation

<br>
<br>


## 5. Data Model Design: Facts & Dimension Tables

#### Table Relationships Diagram
```mermaid
graph TD
    F[CampaignStats<br>campaign_id, customer_id<br>metrics] --> D1[Gender<br>campaign_id<br>gender_type]
    F --> D2[AgeRange<br>campaign_id<br>age_range_type]
    F --> D3[LandingPage<br>customer_id<br>final_url]
    
    style F fill:#f9f,stroke:#333,stroke-width:4px
    style D1 fill:#bbf,stroke:#333
    style D2 fill:#bbf,stroke:#333
    style D3 fill:#bbf,stroke:#333
```
<br>
<br>

### Create Base Tables (Facts & Dimensions)

We create facts & dimension tables to make complex data dimple to understand, speeds up report generation, & to make ensure data consistency. 

***Facts Table:*** It stores the measurable, quantitative data for the business. It typically contains metrics (also called facts) that can be analyzed or aggregated. It’s the central point for quantitative analysis.

***Dimension Tables:*** It store descriptive or categorical data that provides context to the facts stored in the fact table. They contain information that answers the "who," "what," "where," "when," and "how" of a business event. It’s used for filtering, grouping, and slicing the data.

Combination of both tables enables efficient and flexible analysis and reporting.



```mermaid
graph TD;
    A[Campaign Stats] --> B[Daily performance metrics];
    A --> C[Click and impression data];
    A --> D[Cost information (Euros)];
    A --> E[Device breakdowns];

    F[Demographics] --> G[Gender insights];
    F --> H[Age range distributions];
    F --> I[Campaign targeting information];

    J[Landing Pages] --> K[URL tracking];
    J --> L[Domain analysis];
    J --> M[Path information];
```

<br>
<br>


#### Temporary Campaign Stats Fact Table

```sql
-- 1. Create temporary campaign stats table with Euro conversion
-- Note: metrics_cost_micros is in millionths of the account's currency (Euro for Ireland)
CREATE TEMP TABLE temp_fact_campaign_performance AS
SELECT
    campaign_id,
    customer_id,
    segments_date,
    segments_device,
    segments_click_type,
    metrics_clicks,
    metrics_impressions,
    metrics_conversions,
    metrics_cost_micros,
    -- Convert micros to Euros (divide by 1,000,000)
    ROUND(metrics_cost_micros/1000000, 2) as cost_eur
FROM `ga4powerbi-2024.GoogleAds.p_ads_CampaignStats_5917066896`
WHERE segments_date >= analysis_start_date;
```
<br>
<br>
<br>

#### Demographics Dimesion Table

```sql
-- 2. Create temporary demographics table (unchanged)
CREATE TEMP TABLE temp_dim_demographics AS
SELECT 
    d1.campaign_id,
    d1.ad_group_criterion_gender_type as gender,
    d2.ad_group_criterion_age_range_type as age_range,
    d2.campaign_bidding_strategy_type
FROM `ga4powerbi-2024.GoogleAds.p_ads_Gender_5917066896` d1
FULL OUTER JOIN `ga4powerbi-2024.GoogleAds.p_ads_AgeRange_5917066896` d2
    USING(campaign_id);
```
<br>
<br>
<br>


#### Landing Page Dimesion Table

```sql
-- 3. Create temporary landing pages table (unchanged)
CREATE TEMP TABLE temp_dim_landing_pages AS
SELECT 
    customer_id,
    landing_page_view_unexpanded_final_url,
    REGEXP_EXTRACT(landing_page_view_unexpanded_final_url, r'https?://([^/]+)') as domain,
    REGEXP_EXTRACT(landing_page_view_unexpanded_final_url, r'https?://[^/]+(.*)') as path
FROM `ga4powerbi-2024.GoogleAds.p_ads_LandingPageStats_5917066896`;
```

<br>
<br>
<br>

## 6. Data Processing & Cleaning
Ensure data integrity through validation by checking for completeness, verifying metric accuracy, and maintaining relationship integrity. Clean the data by standardizing formats, handling missing values, and fixing inconsistencies. Enhance the data by adding calculated fields, creating lookup tables, and optimizing for efficient reporting.

#### Create Optimized & Cleaned Tables


Yes, I understand! You want to combine the key processing steps and activities into a single point for each table (fact or dimension), summarizing the relevant steps. Here's how that can be structured:

1. Campaign Performance Table (Fact Table)
Key Processing Steps: Validate completeness and metric accuracy, ensure relationship integrity; Clean campaign metrics, handle missing values, and fix inconsistencies; Enhance by adding calculated fields, performance indicators, and optimizing for reporting (e.g., including time dimensions).
2. Demographics Lookup Table (Dimension Table)
Key Processing Steps: Validate completeness and accuracy of demographic data (age, gender, targeting info); Clean by standardizing formats and addressing missing values; Enhance by combining age and gender data, creating demographic segments, and adding targeting information.
3. Landing Page References Table (Dimension Table)
Key Processing Steps: Validate completeness and correctness of URL and domain data; Clean by handling missing or inconsistent data; Enhance by structuring URL information, categorizing domains, and tracking page performance for reporting purposes.

<br>
<br>

```sql
-- 4. Create temporary cleaned performance table with Euro metrics
CREATE TEMP TABLE temp_clean_campaign_performance AS
WITH validated_data AS (
    SELECT 
        campaign_id,
        customer_id,
        segments_date,
        segments_device,
        metrics_clicks,
        metrics_impressions,
        metrics_conversions,
        cost_eur,  -- Using Euro cost
        CASE 
            WHEN metrics_clicks > metrics_impressions THEN FALSE
            WHEN cost_eur < 0 THEN FALSE
            WHEN metrics_impressions = 0 THEN FALSE
            ELSE TRUE
        END as is_valid_record
    FROM temp_fact_campaign_performance
)
SELECT 
    campaign_id,
    customer_id,
    segments_date,
    segments_device,
    COALESCE(metrics_clicks, 0) as clicks,
    COALESCE(metrics_impressions, 0) as impressions,
    COALESCE(metrics_conversions, 0) as conversions,
    COALESCE(cost_eur, 0) as cost_eur,  -- Euro cost
    EXTRACT(YEAR FROM segments_date) as year,
    EXTRACT(MONTH FROM segments_date) as month,
    FORMAT_DATE('%A', segments_date) as day_of_week
FROM validated_data
WHERE is_valid_record = TRUE;
```
<br>
<br>

### 7. Data Enhancement: Metrics & KPI Development

Metrics play a crucial role in standardizing analysis, ensuring consistent reporting, and enabling trend analysis. They provide actionable insights that support informed decision-making and drive campaign optimization.
<br>
<br>



```mermaid
graph TD
    Metrics[Metrics]
    subgraph Framework
        A1[Performance Metrics]
        A2[Financial Metrics]
        A3[Engagement Metrics]
        A4[Audience Insights]
    end
    Metrics --> Framework

    subgraph Performance_Metrics
        A1a[CTR]
        A1b[Conversion Rate]
        A1c[Cost per Click]
        A1d[Cost per Conversion]
    end
    A1 --> Performance_Metrics

    subgraph Financial_Metrics
        A2a[Total Spend]
        A2b[ROAS]
        A2c[Cost Efficiency]
        A2d[Budget Utilization]
    end
    A2 --> Financial_Metrics

    subgraph Engagement_Metrics
        A3a[Device Performance]
        A3b[Demographic Response]
        A3c[Landing Page Effectiveness]
    end
    A3 --> Engagement_Metrics

    subgraph Audience_Insights
        A4a[Age Group Performance]
        A4b[Gender Response Rates]
        A4c[Device Preferences]
        A4d[Geographic Trends]
    end
    A4 --> Audience_Insights
```

<br>
<br>

```sql
-- 5. Final analysis query with Euro metrics
SELECT 
    -- Dimensions
    c.segments_date,
    c.campaign_id,
    c.customer_id,
    c.segments_device,
    COALESCE(d.gender, 'Unknown') as gender,
    COALESCE(d.age_range, 'Unknown') as age_range,
    COALESCE(l.domain, 'Direct') as landing_page_domain,
    
    -- Base Metrics
    SUM(c.clicks) as total_clicks,
    SUM(c.impressions) as total_impressions,
    SUM(c.conversions) as total_conversions,
    SUM(c.cost_eur) as total_cost_eur,  -- Total cost in Euros
    
    -- Calculated Metrics
    SAFE_DIVIDE(SUM(c.clicks), SUM(c.impressions)) * 100 as ctr,
    SAFE_DIVIDE(SUM(c.conversions), SUM(c.clicks)) * 100 as conversion_rate,
    -- Cost metrics in Euros
    ROUND(SAFE_DIVIDE(SUM(c.cost_eur), NULLIF(SUM(c.clicks), 0)), 2) as cost_per_click_eur,
    ROUND(SAFE_DIVIDE(SUM(c.cost_eur), NULLIF(SUM(c.conversions), 0)), 2) as cost_per_conversion_eur,
    
    -- Time dimensions
    c.year,
    c.month,
    c.day_of_week,
    
    -- Campaign attributes
    d.campaign_bidding_strategy_type
FROM temp_clean_campaign_performance c
LEFT JOIN temp_dim_demographics d
    ON c.campaign_id = d.campaign_id
LEFT JOIN temp_dim_landing_pages l
    ON c.customer_id = l.customer_id
GROUP BY 1,2,3,4,5,6,7,16,17,18,19;

END;
```

## 8. Analysis & Reporting


## 9. Power BI Dashboard
