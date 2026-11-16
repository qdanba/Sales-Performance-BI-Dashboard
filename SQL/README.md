# SQL Data Preparation – AdventureWorks2025

This folder documents the SQL workflow used to prepare data for the **Sales Performance & BI Dashboard** project.

## Environment
- **Database:** `AdventureWorks2025`
- **Platform:** Microsoft SQL Server
- **SQL client:** SQL Server Management Studio (SSMS)

Run these scripts in an environment where AdventureWorks2025 has been restored. The scripts create or alter views in the `dbo` schema.

## Script index
| File | Purpose |
|---|---|
| `01_Data_Exploration.sql` | Select the database and inspect source tables, date range, order headers, and order details. |
| `02_Create_Views.sql` | Create the fact and dimension views used by Power BI. |
| `03_Data_Quality_Checks.sql` | Check row counts, missing keys, revenue values, product attributes, customer categories, and territory records. |
| `04_View_Adjustments.sql` | Apply final view logic after reviewing initial data-quality findings. |
| `05_Relationship_Validation.sql` | Check whether fact-table keys have matching records in the related dimensions. |

## Workflow

### 1. Explore source data
The initial exploration focuses on `Sales.SalesOrderHeader` and `Sales.SalesOrderDetail`.

```sql
USE AdventureWorks2025;
GO

SELECT
    MIN(OrderDate) AS StartDate,
    MAX(OrderDate) AS EndDate,
    COUNT(*) AS TotalOrders
FROM Sales.SalesOrderHeader;

SELECT TOP 10
    OrderQty,
    UnitPrice,
    UnitPriceDiscount,
    LineTotal
FROM Sales.SalesOrderDetail;
```

`LineTotal` is used as the source for `SalesAmount`; revenue is not recalculated from `UnitPrice` when the goal is to preserve the source line total.

### 2. Create the fact view
`dbo.vw_FactSales` joins sales order headers with sales order details.

**Grain:** one row per sales order line (`SalesOrderDetailID`), not one row per order.

Key fields include order identifiers/date, customer and territory keys, product and order-line fields, and sales values. `SalesAmount` is sourced from `SalesOrderDetail.LineTotal`.

### 3. Create dimension views
- `dbo.vw_DimProduct` – product name, subcategory, category, list price, and standard cost.
- `dbo.vw_DimCustomer` – customer identifiers, person/store details, customer name, and customer type.
- `dbo.vw_DimTerritory` – territory name, country/region code and name, and territory group.

### 4. Check data quality
The checks cover:
- Fact-view row count.
- NULL values in important fact keys and order date.
- Negative, minimum, maximum, and average sales amounts.
- Missing product category/subcategory values.
- Customer type distribution and missing customer names.
- Territory count and missing territory identifiers.

A potential exception is an investigation signal, not automatic proof of a data error. Interpret it in the context of the source data and reporting requirements.

### 5. Apply view adjustments
Documented adjustments include:
- Excluding products without a category from the reporting product dimension after reviewing their relationship to sales.
- Enriching the territory view with country/region names by joining `Person.CountryRegion`.
- Reviewing person/store attributes to validate customer classification.

The final SQL files should contain the version intended for the Power BI model. Avoid leaving an earlier `CREATE OR ALTER VIEW` definition later in the execution order if it would overwrite the final definition.

### 6. Validate fact-to-dimension keys
`LEFT JOIN` checks identify fact keys without a matching dimension record for `ProductID`, `CustomerID`, and `TerritoryID`. If a query returns zero rows, no unmatched key was found by that specific check.

## Important analytical notes
- Because the fact view is at order-line level, use `COUNT(DISTINCT SalesOrderID)` to calculate order count.
- Use `SUM(SalesAmount)` for revenue based on the source `LineTotal` field.
- The committed data-preparation scripts do not contain the full set of monthly business-analysis queries used to investigate the late-FY2025 sales pattern. Do not label separately discussed queries as executed scripts unless they are added and tested.
- No Bikes or Components transactions are recorded in June 2025; the available data does not establish the underlying business cause.

## Execution order
1. `01_Data_Exploration.sql`
2. `02_Create_Views.sql`
3. `03_Data_Quality_Checks.sql`
4. `04_View_Adjustments.sql`
5. `05_Relationship_Validation.sql`

Some checks in step 3 should be rerun after view adjustments to validate the final outputs.

## Reproducibility
To reproduce the report on another machine, restore AdventureWorks2025, run the SQL scripts, and update the Power BI data-source connection to the local SQL Server instance.

See the root `README.md` for the project overview.
