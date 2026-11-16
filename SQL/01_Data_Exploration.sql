USE AdventureWorks2025;
GO

SELECT
    MIN(OrderDate) AS StartDate,
    MAX(OrderDate) AS EndDate,
    COUNT(*) AS TotalOrders
FROM Sales.SalesOrderHeader;

SELECT TOP 10
    *
FROM Sales.SalesOrderDetail;

SELECT TOP 10
    OrderQty,
    UnitPrice,
    UnitPriceDiscount,
    LineTotal
FROM Sales.SalesOrderDetail;

