/**4.1. Product Dimension – loại sản phẩm không có CategoryName**/
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
    ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name IS NOT NULL;
GO

/**4.2. Territory Dimension – bổ sung tên quốc gia**/
GO
CREATE OR ALTER VIEW dbo.vw_DimTerritory AS
SELECT
    ST.TerritoryID,
    ST.Name AS TerritoryName,
    ST.CountryRegionCode,
    CR.Name AS CountryRegion,
    ST.[Group] AS TerritoryGroup
FROM Sales.SalesTerritory AS ST
LEFT JOIN Person.CountryRegion AS CR
    ON ST.CountryRegionCode = CR.CountryRegionCode;
GO

-- Kiểm tra kết quả, sắp xếp theo quốc gia và tên territory
SELECT *
FROM dbo.vw_DimTerritory
ORDER BY CountryRegion, TerritoryName;

/**4.3. Customer Dimension – truy vấn kiểm tra thông tin Individual/Store**/

SELECT TOP 20
    C.CustomerID,
    C.PersonID,
    C.StoreID,
    P.FirstName,
    P.LastName,
    S.Name AS StoreName,

    CASE
        WHEN C.PersonID IS NOT NULL
            THEN CONCAT(P.FirstName, ' ', P.LastName)
        WHEN C.StoreID IS NOT NULL
            THEN S.Name
        ELSE 'Unknown'
    END AS CustomerName,

    CASE
        WHEN C.PersonID IS NOT NULL THEN 'Individual'
        WHEN C.StoreID IS NOT NULL THEN 'Store'
        ELSE 'Unknown'
    END AS CustomerType

FROM Sales.Customer AS C
LEFT JOIN Person.Person AS P
    ON C.PersonID = P.BusinessEntityID
LEFT JOIN Sales.Store AS S
    ON C.StoreID = S.BusinessEntityID;

/**4.4. Kiểm tra trường hợp một Customer có cả PersonID và StoreID**/

SELECT
    C.CustomerID,
    C.PersonID,
    C.StoreID,
    P.PersonType,
    P.FirstName,
    P.LastName,
    S.Name AS StoreName
FROM Sales.Customer AS C
LEFT JOIN Person.Person AS P
    ON C.PersonID = P.BusinessEntityID
LEFT JOIN Sales.Store AS S
    ON C.StoreID = S.BusinessEntityID
WHERE C.PersonID IS NOT NULL
  AND C.StoreID IS NOT NULL;