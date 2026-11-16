CREATE OR ALTER VIEW dbo.vw_FactSales AS
SELECT
    H.SalesOrderID,
    H.OrderDate,
    H.CustomerID,
    H.TerritoryID,
    D.SalesOrderDetailID,
    D.ProductID,
    D.OrderQty,
    D.UnitPrice,
    D.UnitPriceDiscount,
    D.LineTotal AS SalesAmount
FROM Sales.SalesOrderHeader AS H
INNER JOIN Sales.SalesOrderDetail AS D
    ON H.SalesOrderID = D.SalesOrderID;
GO

CREATE OR ALTER VIEW dbo.vw_DimProduct AS
SELECT
    P.ProductID,
    P.Name AS ProductName,
    PS.Name AS SubcategoryName,
    PC.Name AS CategoryName,
    P.ListPrice,
    P.StandardCost
FROM Production.Product AS P
LEFT JOIN Production.ProductSubcategory AS PS
    ON P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production.ProductCategory AS PC
    ON PS.ProductCategoryID = PC.ProductCategoryID;
GO

CREATE OR ALTER VIEW dbo.vw_DimCustomer AS
SELECT
    C.CustomerID,
    C.PersonID,
    C.StoreID,
    P.PersonType,
    P.FirstName,
    P.LastName,
    S.Name AS StoreName,

    CASE
        WHEN P.PersonType = 'IN'
            THEN CONCAT(P.FirstName, ' ', P.LastName)
        WHEN C.StoreID IS NOT NULL
            THEN S.Name
        ELSE 'Unknown'
    END AS CustomerName,

    CASE
        WHEN P.PersonType = 'IN'
            THEN 'Individual'
        WHEN C.StoreID IS NOT NULL
            THEN 'Store'
        ELSE 'Other'
    END AS CustomerType

FROM Sales.Customer AS C
LEFT JOIN Person.Person AS P
    ON C.PersonID = P.BusinessEntityID
LEFT JOIN Sales.Store AS S
    ON C.StoreID = S.BusinessEntityID;
GO

CREATE OR ALTER VIEW dbo.vw_DimTerritory AS
SELECT
    TerritoryID,
    Name AS TerritoryName,
    CountryRegionCode,
    [Group] AS TerritoryGroup
FROM Sales.SalesTerritory;
GO

SELECT TOP 10 *
FROM dbo.vw_FactSales;

SELECT TOP 30 *
FROM dbo.vw_DimProduct;

SELECT TOP 1000 *
FROM dbo.vw_DimCustomer;

SELECT TOP 10 *
FROM dbo.vw_DimTerritory;