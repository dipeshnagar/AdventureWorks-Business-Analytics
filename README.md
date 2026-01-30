# Business Performance Analytics Dashboard (SQL + Excel)

This project is a complete end-to-end Business Analytics Solution built using  
SQL Server + Excel Dashboarding, based on the AdventureWorks2025 dataset  
(1,21,000+ rows, 10+ tables joined).

It demonstrates real industry practices such as:
- Data modeling  
- SQL data cleaning  
- KPI creation  
- Dashboard design  
- Business insights generation  

# Project Overview

In this project, I built a complete Business Performance Dashboard to help the company understand:

- Sales performance  
- Product & category revenue  
- Customer purchase behavior  
- Geographic sales distribution  
- Online vs offline channel performance  
- Operational shipping efficiency  

The project covers data (extraction -> cleaning-> modeling -> dashboard -> insights).


# Tools & Technologies

- SQL Server (Window Functions,CTEs)
- Excel (Pivot Tables, Slicers, Dashboards)
- Data Cleaning Techniques
- Business Analytics Concepts



# Data Pipeline (End-to-End Process)

1. Extract Data from 10+ AdventureWorks Tables
- SalesOrderHeader  
- SalesOrderDetail  
- Product  
- ProductSubcategory  
- ProductCategory  
- Customer  
- Person  
- Address  
- BusinessEntityAddress  
- SalesTerritory  

2️. Build Master CTE (Joining All Tables) 
Performed multiple joins to create a unified analytical dataset.

3️. Data Cleaning
- Removed duplicates using `ROW_NUMBER()`
- Handled NULL values using `COALESCE`
- Standardized datatypes (names, nvarchar, dates)
- Removed unnecessary columns
- Verified row counts and consistency

4️. Exported Clean Data to Excel
Created 'clen_table.xlsx' with 121,317 clean rows

5️. Built Excel Dashboard
Using:
- Pivot tables
- Charts
- Slicers
- KPI cards
- Conditional formatting

---

# SQL Code (Master CTE + Cleaning)
You can find the full SQL script here:  
   (( master_sql.sql ))

----Contains joins, CTE, cleaning steps, deduplication, datatype fixes

# Excel Dashboard Features

KPIs Built
- Total Revenue  
- Top category
- Top subcategory
- Top Product
- Total Customers   
- average discount per unit 

Charts Created
- Monthly Revenue Trend
- yearly revenue
- Category-Wise Revenue constribution   
- top 10 products revenue 
- Country-Wise Revenue constribution 
- Online vs Offline Comparison  

Slicers
- Year/month 
- Category  
- Country_group


# Key Business Insights

1. Revenue Insights  
- Bikes(especially road bikes) contribute 86% of total revenue 
- Mountain bikes (especially Mountain-200 Black 38) are top sellers  
- Revenue peaks in June–July and drops in November

2. Geographic Insights  
- North America generates 60% of total revenue  
- US is the strongest territory

3. Product Insights  
- Touring bikes have highest discounts but lowest sales  

4. Operational Insights  
- 99.97% of orders ship within 7 days
- Very strong logistics and delivery consistency

5. Channel Insights  
- Online vs Offline orders are almost equal 
- Products like Road Frames and Mountain Frames are bought mostly offline




