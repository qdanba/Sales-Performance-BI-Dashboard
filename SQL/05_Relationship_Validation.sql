/**5.1. Kiểm tra ProductID**/

SELECT DISTINCT F.ProductID
FROM dbo.vw_FactSales AS F
LEFT JOIN dbo.vw_DimProduct AS P
    ON F.ProductID = P.ProductID
WHERE P.ProductID IS NULL;

/**5.2. Kiểm tra CustomerID**/

SELECT DISTINCT F.CustomerID
FROM dbo.vw_FactSales AS F
LEFT JOIN dbo.vw_DimCustomer AS C
    ON F.CustomerID = C.CustomerID
WHERE C.CustomerID IS NULL;

/**5.3. Kiểm tra TerritoryID**/

SELECT DISTINCT F.TerritoryID
FROM dbo.vw_FactSales AS F
LEFT JOIN dbo.vw_DimTerritory AS T
    ON F.TerritoryID = T.TerritoryID
WHERE T.TerritoryID IS NULL;