# Sales Performance & BI Dashboard — AdventureWorks2025

An end-to-end Business Intelligence portfolio project using SQL Server and Power BI to analyze sales performance across products, customers, time, and territories.

## Project overview

This project transforms AdventureWorks2025 sales data into an interactive four-page Power BI report. SQL Server is used for data inspection, analytical views, and validation; Power BI is used for data modeling, DAX measures, and dashboard development.

### Business questions

- How is sales performance changing over time?
- Which product categories and products contribute most to revenue?
- Which customer segments and accounts generate the most value?
- Which territories and countries contribute most to sales?

## Tools

- SQL Server / SSMS — data exploration, SQL views, and validation
- Power BI Desktop — data modeling, DAX, and visualization
- DAX — sales KPIs, time intelligence, and contribution measures
- GitHub — project documentation and version control

## Dashboard pages

| Page | Focus | Main analytical question |
|---|---|---|
| Sales Overview | Sales trends, KPIs, category and territory contribution | What drives sales and how is performance changing? |
| Product Performance | Category mix, product trends, top products | Which products and categories drive revenue? |
| Customer Analysis | Store vs. Individual, top customers, customer KPIs | Which customer segments generate the most value? |
| Territory Analysis | Country, territory group, territory contribution | Where is revenue geographically concentrated? |

## Key findings

### 1. Sales Overview
- Total sales: **$109.85M**; orders: **31,465**; customers: **19,119**; AOV: approximately **$3,491**.
- Sales increased across complete fiscal years: approximately $27M in FY2023, $35M in FY2024, and $45M in FY2025.
- FY2022 is a partial fiscal year (May–June 2022), so it should not be compared directly with complete fiscal years.
- June 2025 recorded only **$47,491.55** in sales. SQL validation found no recorded Bikes or Components transactions in that month. Bikes sales had already fallen by approximately 59.2% from April to May 2025; Components had no recorded transactions in May or June.
- This is described as a recorded sales-activity disruption; the available data does not establish its underlying cause.

### 2. Product Performance
- Bikes contributed **$94.65M (86.17%)** of total sales.
- Components contributed **$11.80M (10.74%)**, Clothing **$2.12M (1.93%)**, and Accessories **$1.27M (1.16%)**.
- The sales mix is highly concentrated in Bikes. Mountain-200 variants are prominent among the top-selling products.

### 3. Customer Analysis
- Store customers generated **$80.49M (73.27%)** of sales; Individual customers generated **$29.36M (26.73%)**.
- The leading customers by sales are predominantly Stores, highlighting the importance of key-account retention and development.
- Average sales per customer are approximately **$5.75K**.

### 4. Territory Analysis
- North America is the largest territory group at approximately **$79M**; Europe contributed approximately **$19.84M (18.06%)** and Pacific approximately **$10.65M**.
- Southwest is the leading territory at approximately **$24.18M (22.02%)**; Northwest contributed approximately **$16.08M (14.64%)**.
- Revenue is geographically concentrated in North America.

## Repository structure

```text
sales-performance-bi-dashboard/
├── README.md
├── dashboard/
│   ├── Sales_Performance_Dashboard.pbix
│   └── screenshots/
├── analysis/
│   ├── Sales_Performance_Insight_Analysis_Bilingual.docx
│   └── Sales_Performance_Insight_Analysis_Bilingual.pdf
├── sql/
│   ├── 01-create-views.sql
│   ├── 02-data-quality-checks.sql
│   └── 03-sales-analysis.sql
└── documentation/
    └── data-model.png
```

## Data and interpretation notes

- Dataset: AdventureWorks2025 sample database.
- FY2022 covers May–June 2022 only. FY2023 and FY2024 are complete fiscal years. FY2025 is a complete fiscal year (July 2024–June 2025), as confirmed during source-data validation.
- The absence of recorded transactions does not, by itself, prove a decline in market demand, a stockout, or a strategic decision.
- All financial values are presented in the dataset's reporting currency; values in visuals may be rounded.

## How to explore

1. Open the screenshots in `dashboard/screenshots/` for a quick preview.
2. Open the `.pbix` file in Power BI Desktop to interact with slicers and visuals.
3. Read the bilingual insight report in `analysis/` for the business interpretation.
4. Review the SQL scripts in `sql/` to understand the data checks and analytical queries.

## Project positioning

An independent portfolio project demonstrating SQL-based data exploration and validation, Power BI data modeling, DAX measures, dashboard design, and business-oriented insight communication using a sample dataset.
