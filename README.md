#  Customer Churn Analysis Using SQL

This project focuses on analyzing customer churn using SQL queries. It helps identify **which types of customers are most likely to leave**, based on their services, demographics, payment preferences, and support interaction history.

#  Database Structure

The analysis is based on a database called **`churn_analysis`**, with one main table:

#  Table: `Customer_churn_data`

It contains fields like:

- **Demographics**: `gender`, `SeniorCitizen`, `Partner`, `Dependents`
- **Service Subscriptions**: `PhoneService`, `MultipleLines`, `InternetService`, `OnlineSecurity`, etc.
- **Financial Data**: `MonthlyCharges`, `TotalCharges`
- **Support Interaction**: `numAdminTickets`, `numTechTickets`
- **Churn Indicator**: `Churn` (Yes/No)

#  Business Questions Answered with SQL

# 1. Customer Overview
- **Q**: How many customers are there?
- **Q**: How many customers have churned?
```sql
SELECT COUNT(*) FROM Customer_churn_data;
SELECT COUNT(*) FROM Customer_churn_data WHERE Churn = 'Yes';
```

# 2. Revenue Insights
- **Q**: What is the total revenue generated?
- **Q**: What is the total and average revenue from churned customers?
```sql
SELECT ROUND(SUM(TotalCharges), 2) FROM Customer_churn_data;
SELECT ROUND(SUM(TotalCharges), 2), ROUND(AVG(TotalCharges), 2)
FROM Customer_churn_data
WHERE Churn = 'Yes';
```

# 3. Service-wise Churn Rate
- **Q**: What % of churned customers used PhoneService, StreamingTV, or DeviceProtection?
```sql
SELECT PhoneService, COUNT(*) 
FROM Customer_churn_data 
WHERE Churn = 'Yes'
GROUP BY PhoneService;
```
- **Q**: Does having more services impact churn?
```sql
SELECT 
  service_count,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_percentage
FROM (
  SELECT customerID,
    (OnlineSecurity = 'Yes') +
    (OnlineBackup = 'Yes') +
    (DeviceProtection = 'Yes') +
    (TechSupport = 'Yes') +
    (StreamingTV = 'Yes') +
    (StreamingMovies = 'Yes') AS service_count,
    Churn
  FROM Customer_churn_data
) AS service_count_table
GROUP BY service_count;
```

# 4. Demographics & Churn
- **Q**: How does churn vary by gender, senior citizen status, or having dependents?
```sql
SELECT gender, COUNT(*) 
FROM Customer_churn_data 
WHERE Churn = 'Yes' 
GROUP BY gender;
```

# 5. Payment & Contract Preferences
- **Q**: Which contract types have the most churn?
- **Q**: Do autopay users churn less?
```sql
SELECT Contract, COUNT(*) 
FROM Customer_churn_data 
WHERE Churn = 'Yes' 
GROUP BY Contract;

SELECT 
  CASE WHEN PaymentMethod LIKE '%auto%' THEN 'Autopay' ELSE 'Manual' END AS Pay_Type,
  COUNT(*) 
FROM Customer_churn_data
WHERE Churn = 'Yes'
GROUP BY Pay_Type;
```

# 6. Churn by Tenure
- **Q**: What’s the churn rate by tenure range?
- **Q**: What’s the average tenure of churned vs. non-churned customers?
```sql
SELECT 
  CASE 
    WHEN tenure <= 12 THEN '<1 year'
    WHEN tenure <= 24 THEN '<2 years'
    WHEN tenure <= 36 THEN '<3 years'
    WHEN tenure <= 48 THEN '<4 years'
    WHEN tenure <= 60 THEN '<5 years'
    ELSE '>5 years'
  END AS tenure_range,
  COUNT(*),
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM Customer_churn_data
GROUP BY tenure_range;
```

# 7. Churn Based on Support Tickets
- **Q**: Are customers with more tickets more likely to churn?
```sql
WITH ticket_cte AS (
  SELECT customerID,
    NTILE(4) OVER (ORDER BY (numAdminTickets + numTechTickets) DESC) AS ticket_group,
    Churn
  FROM Customer_churn_data
)
SELECT ticket_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM ticket_cte
GROUP BY ticket_group;
```

# 8. Bundled Service Usage and Churn
- **Q**: How do InternetService and StreamingTV combinations affect churn?
```sql
SELECT InternetService, StreamingTV, COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM Customer_churn_data
GROUP BY InternetService, StreamingTV;
```

 Technologies Used
 MySQL
 Compatible for use with Power BI/Tableau for dashboards

# Author  
Ranganath S 
[LinkedIn](https://www.linkedin.com/in/ranganath-s-b44808156) | [GitHub](https://github.com/)
