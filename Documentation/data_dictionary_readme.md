# 📊 Data Dictionary – Sales Performance & BI Dashboard

## 1. Overview

This document describes the reporting tables, relationships, key fields, and business measures used in the Power BI data model for the **Sales Performance & BI Dashboard** project.

* **Data Source:** `AdventureWorks2025` sample database.
* **Data Preparation:** Prepared via SQL Server views and loaded into Power BI.
* **Date Table:** The `DimDate` table is generated separately inside Power BI.

---

## 2. Data Model Overview

The data model follows a **Star Schema** structure consisting of **1 Fact table** and **4 Dimension tables**.

| Table | Type | Description |
| :--- | :--- | :--- |
| `vw_FactSales` | **Fact** | Stores sales order-line transactions and sales measures. |
| `vw_DimProduct` | **Dimension** | Provides product information and product classification. |
| `vw_DimCustomer` | **Dimension** | Provides customer information and customer classification. |
| `vw_DimTerritory` | **Dimension** | Provides sales territory and geographic attributes. |
| `DimDate` | **Dimension** | Provides calendar and fiscal-period attributes. |

### 🔗 Relationships

| Dimension Table | Key | Fact Table Key | Cardinality | Filter Direction |
| :--- | :--- | :--- | :---: | :---: |
| `vw_DimProduct` | `ProductID` | `ProductID` | `1:*` | Single (`Dimension` $\rightarrow$ `Fact`) |
| `vw_DimCustomer` | `CustomerID` | `CustomerID` | `1:*` | Single (`Dimension` $\rightarrow$ `Fact`) |
| `vw_DimTerritory` | `TerritoryID` | `TerritoryID` | `1:*` | Single (`Dimension` $\rightarrow$ `Fact`) |
| `DimDate` | `Date` | `OrderDate` | `1:*` | Single (`Dimension` $\rightarrow$ `Fact`) |

> **Note:** All relationships use single-direction cross-filtering from dimension tables to the fact table.

---

## 3. Fact Table

### `vw_FactSales`
* **Purpose:** Stores transactional sales data for revenue, order volume, quantity, and sales performance analysis.
* **Grain:** One row per sales order line (`SalesOrderDetailID`). A single sales order (`SalesOrderID`) can contain multiple order lines.

| Field | Description | Analytical Use |
| :--- | :--- | :--- |
| `SalesOrderID` | Sales order identifier. | Counting distinct orders. |
| `OrderDate` | Date of the sales order. | Time-based analysis. |
| `SalesOrderDetailID` | Sales order detail line identifier. | Identifying order-line records. |
| `ProductID` | Product identifier. | Linking to product dimension. |
| `CustomerID` | Customer identifier. | Linking to customer dimension. |
| `TerritoryID` | Sales territory identifier. | Linking to territory dimension. |
| `OrderQty` | Quantity of products in the order line. | Calculating total quantity sold. |
| `UnitPrice` | Unit selling price. | Transaction price analysis. |
| `UnitPriceDiscount` | Discount value recorded for the unit price. | Discount-related analysis. |
| `SalesAmount` | Sales line amount sourced from `SalesOrderDetail.LineTotal`. | Revenue and sales contribution analysis. |

#### 🧮 Calculation Notes
```dax
Total Sales = SUM(vw_FactSales[SalesAmount])
Total Orders = DISTINCTCOUNT(vw_FactSales[SalesOrderID])
Total Quantity Sold = SUM(vw_FactSales[OrderQty])
```
> ⚠️ **Important:** Because the fact table is at the order-line level, counting table rows (`COUNTROWS`) does **not** produce the actual number of orders.

---

## 4. Dimension Tables

### 4.1 `vw_DimProduct`
* **Purpose:** Provides descriptive product attributes for product and category performance analysis.
* **Analytical Use:** Product sales, category contribution, subcategory comparison, and top-performing products.

| Field | Description |
| :--- | :--- |
| `ProductID` | Unique product identifier used to link products to sales transactions. |
| `ProductName` | Product name. |
| `ProductNumber` | Product reference or code. |
| `Color` | Product color, where available. |
| `StandardCost` | Standard product cost. |
| `ListPrice` | Listed product price. |
| `Size` | Product size, where available. |
| `Weight` | Product weight, where available. |
| `SubcategoryName` | Product subcategory. |
| `CategoryName` | Product category. |

---

### 4.2 `vw_DimCustomer`
* **Purpose:** Provides customer attributes for customer segmentation and sales analysis.
* **Analytical Use:** Store vs. Individual sales comparison, customer revenue contribution, distinct transacting customers, and top customers by sales.

| Field | Description |
| :--- | :--- |
| `CustomerID` | Customer identifier used to link customers to sales transactions. |
| `CustomerName` | Customer display name used in reporting. |
| `CustomerType` | Customer classification, including `Store` and `Individual`. |

---

### 4.3 `vw_DimTerritory`
* **Purpose:** Provides sales territory and geographic attributes.
* **Analytical Use:** Sales by country/region, sales by territory, and sales contribution by territory group.

| Field | Description |
| :--- | :--- |
| `TerritoryID` | Sales territory identifier. |
| `TerritoryName` | Sales territory name. |
| `CountryRegionCode` | Country or region code. |
| `CountryRegionName` | Country or region name. |
| `Group` | Sales territory group. |

> 🗺️ **Geographic Limitation:**
> * Available data supports country/region and sales-territory analysis, but does not provide sufficient province- or city-level detail for this project.
> * Territory names such as `Northwest`, `Northeast`, `Central`, `Southwest`, and `Southeast` refer strictly to sales territories within the **United States**, not global geographic regions.

---

## 5. Date Dimension

### `DimDate`
* **Purpose:** Provides calendar and fiscal attributes for consistent time-based analysis. Created in Power BI and connected to `vw_FactSales[OrderDate]`.

| Field | Description |
| :--- | :--- |
| `Date` | Individual calendar date and relationship key. |
| `Year` | Calendar year. |
| `Month Name` | Month name for report labels. |
| `Month Number` | Numeric month used for chronological sorting. |
| `Quarter` | Calendar quarter. |
| `Year-Month` | Combined year and month label. |
| `YearMonthSort` | Sort key for chronological Year-Month ordering. |
| `Fiscal Year` | Fiscal-year label based on a July–June financial year. |
| `Fiscal Quarter` | Quarter within the fiscal year. |

### 📅 Fiscal Calendar Structure
The project uses a **July–June** fiscal year. Fiscal-year labels use the calendar year in which the fiscal year ends:

| Period | Fiscal Year |
| :--- | :---: |
| July 2022 – June 2023 | `FY2023` |
| July 2023 – June 2024 | `FY2024` |
| July 2024 – June 2025 | `FY2025` |

> ⚠️ **Coverage Note:** `FY2022` is a partial fiscal year covering **May–June 2022** only. Comparisons involving `FY2022` should be interpreted carefully.

---

## 6. Key Business Measures

The following DAX measures are calculated in Power BI and dynamically respond to active report filters and slicers:

| Measure | Definition |
| :--- | :--- |
| **Total Sales** | Sum of `SalesAmount`. |
| **Total Orders** | Distinct count of `SalesOrderID`. |
| **Total Quantity Sold** | Sum of `OrderQty`. |
| **Total Customers** | Distinct count of `CustomerID` with transactions in the current filter context. |
| **Average Order Value** | `Total Sales` divided by `Total Orders`. |
| **Average Selling Price** | `Total Sales` divided by `Total Quantity Sold`. |
| **Sales per Customer** | `Total Sales` divided by `Total Customers`. |

---

## 7. Data Limitations

* **Sample Dataset:** Uses the `AdventureWorks2025` sample database and does not represent a real company's actual operating performance.
* **Order-Line Granularity:** The fact table is stored at the sales order-line level, so order counts must always use distinct `SalesOrderID`.
* **Partial Fiscal Year:** `FY2022` is incomplete, covering May–June 2022 only.
* **June 2025 Category Gap:** No `Bikes` or `Components` transactions are recorded in June 2025; the available source data does not establish the underlying business cause.
* **Geographic Granularity:** Geographic analysis is restricted to the territory attributes available in the source views.

---

## 8. Related Project Files

* [`../SQL/`](../SQL/) – SQL scripts for data exploration, view creation, data-quality checks, view adjustments, and relationship validation.
* [`../Dashboard/`](../Dashboard/) – Power BI report (`.pbix`) and dashboard screenshots.
* [`../Analysis/`](../Analysis/) – Business insights and interpretation of the four report pages.