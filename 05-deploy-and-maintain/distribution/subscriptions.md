# Power BI Subscriptions

## Overview
Power BI subscriptions enable automated report distribution to stakeholders through email, allowing users to receive regular snapshots of reports or dashboards without logging into Power BI.

Note: A subscription emails you a snapshot of the Power BI report/dashboard according to the defined schedules. It does not check the individual data points. You can set an alert only on Gauges, KPIs, and Card visuals. If you pin a line chart report visual as a tile to the dashboard, you will not see any option.

## 🎯 Key Concepts
1. **Automation and Timeliness:** Subscriptions automate report sharing, ensuring users get timely updates without manually accessing the Power BI service.
2. **Reduced Manual Reporting:** By automating regular updates, subscriptions reduce the need for manual reporting, freeing up time for analysis.
3. **Data Refresh Dependency:** Subscriptions depend on report data refresh schedules; if data isn't refreshed, the subscription may send outdated information.
4. **User-Specific Access Control:** Subscriptions respect Power BI’s role-based access, so users receive data they’re authorized to view, supporting data governance.
5.** Mobile Compatibility:** Subscription emails are designed to be mobile-friendly, so users can view reports on various devices.
6. **Snapshot vs. Live Data:** Subscriptions can send a static snapshot (image) or a link to live data, giving users the choice between fixed insights or real-time access.
7. **Error and Notification Handling:** Power BI notifies users if a subscription fails (e.g., due to access issues or refresh errors), helping maintain data reliability.
8. **Security Compliance:** Subscriptions integrate with data sensitivity and security settings in Power BI, ensuring compliance with organizational policies when sharing data.



## 📋 Types of Subscriptions

### 1. Standard Subscriptions
- Report page subscriptions
- Dashboard tile subscriptions
- Full dashboard subscriptions
- Paginated report subscriptions

### 2. Subscription Parameters
- Frequency options
- Time-based delivery
- Parameter-based snapshots
- Attachment formats

## 🛠️ Implementation Guide

### Setting Up Subscriptions

#### Basic Subscription Setup
1. Navigate to the report
2. Click "Subscribe"
3. Configure basic settings:
   ```plaintext
   - Subject line
   - Recipient list
   - Frequency
   - Start time
   - Time zone
   ```

#### Advanced Configuration
```plaintext
Subscription Settings:
│
├── Preview Image
│   ├── Include report page
│   └── Preview in email
│
├── Attachment Options
│   ├── PowerPoint
│   ├── PDF
│   ├── Excel
│   └── CSV
│
└── Parameter Settings
    ├── Default values
    └── Custom parameters
```

## 💡 Best Practices

### 1. Subscription Management
- Use descriptive subject lines
- Group similar subscriptions
- Document subscription purpose
- Regular subscription audit
- Test before mass distribution

### 2. Performance Considerations
- Stagger delivery times
- Monitor data refresh timing
- Consider attachment sizes
- Optimize report performance
- Cache usage planning

### 3. Security Guidelines
- Review recipient access
- Validate email domains
- Monitor subscription changes
- Regular security audits
- Data protection compliance

## ⚠️ Common Pitfalls
1. Misaligned refresh schedules
2. Overlooked time zones
3. Incorrect parameter settings
4. Missing data validations
5. Excessive subscription volume

## 📊 Implementation Matrix

| Feature | Standard | Premium | Remarks |
|---------|----------|----------|----------|
| Email | ✓ | ✓ | Basic functionality |
| Attachments | Limited | Full | Premium allows all formats |
| Parameters | ✓ | ✓ | Custom values |
| Frequency | Hourly+ | Minutes+ | Premium allows higher frequency |

## 🔍 Monitoring & Maintenance

### 1. Subscription Health
```powerquery
let
    Source = PowerBI.Subscriptions("workspace"),
    #"Filtered Active" = Table.SelectRows(
        Source,
        each [Status] = "Active"
    )
in
    #"Filtered Active"
```

### 2. Audit Requirements
- Subscription logs
- Delivery status
- Error tracking
- Usage metrics
- Performance monitoring

## 📈 Analytics & Optimization
1. Subscription usage patterns
2. Delivery success rates
3. User engagement metrics
4. Performance impact
5. Resource utilization

## 🔄 Integration Scenarios

### 1. Enterprise Integration
```plaintext
Power BI Service
│
├── Azure Active Directory
│   └── User Management
│
├── SharePoint
│   └── File Storage
│
└── Teams
    └── Notifications
```

### 2. Custom Solutions
- API integration
- Custom scheduling
- Advanced formatting
- Dynamic distribution
- Conditional delivery

## 📚 Related Topics
- Report Sharing
- Data Refresh
- Access Management
- Alert Configuration
- Data Gateway

## 🎓 Advanced Features
1. Paginated Report Subscriptions
2. Custom Parameter Values
3. Dynamic Row-Level Security
4. Multi-Format Delivery
5. Conditional Subscriptions

## 🛡️ Governance & Compliance
1. Data residency requirements
2. Audit trail maintenance
3. Access reviews
4. Security protocols
5. Compliance documentation
