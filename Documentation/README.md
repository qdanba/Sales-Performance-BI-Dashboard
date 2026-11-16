# Documentation

This folder contains supporting technical documentation for the data model and project implementation.

## Suggested contents
- `Data-Model.png` – exported diagram of the Power BI relationship model.
- Notes describing the fact-table grain, dimension tables, relationship cardinality, and fiscal calendar.

## Data model overview
The Power BI model follows a star-schema-style structure:

- **Fact:** `vw_FactSales`
- **Dimensions:** `vw_DimProduct`, `vw_DimCustomer`, `vw_DimTerritory`, and `DimDate`
- **Relationships:** dimensions filter the fact table through their corresponding key/date columns.

The date dimension uses a July–June fiscal year. Fiscal-year labels use the ending year (for example, July 2022–June 2023 is FY2023).

## Modeling notes
- `vw_FactSales` is at sales order line level, not one row per order. Count orders using a distinct count of `SalesOrderID`.
- `Total Customers` represents distinct customers with transactions in the current filter context.
- FY2022 is partial (May–June 2022), so it is not directly comparable with complete fiscal years.
- Geographic analysis is constrained by the attributes available in the source data.

See `SQL/README.md` for the SQL preparation workflow and `Dashboard/README.md` for report details.
