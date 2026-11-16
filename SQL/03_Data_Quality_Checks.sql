/**3.1. Fact Sales – cấu trúc và số dòng**/

-- Kiểm tra cấu trúc
SELECT TOP 10 *
FROM dbo.vw_FactSales;

-- Tổng số dòng trong Fact View
SELECT COUNT(*) AS TotalRows
FROM dbo.vw_FactSales;

/**3.2. Fact Sales – kiểm tra NULL ở các khóa và ngày**/

SELECT
    SUM(CASE WHEN SalesOrderID IS NULL THEN 1 ELSE 0 END) AS NullSalesOrderID,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,
    SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS NullProductID,
    SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END) AS NullOrderDate
FROM dbo.vw_FactSales;

/**3.3. Fact Sales – kiểm tra giá trị doanh thu**/

-- Tìm dòng có SalesAmount âm
SELECT *
FROM dbo.vw_FactSales
WHERE SalesAmount < 0;

-- Thống kê giá trị doanh thu
SELECT
    MIN(SalesAmount) AS MinRevenue,
    MAX(SalesAmount) AS MaxRevenue,
    AVG(SalesAmount) AS AvgRevenue
FROM dbo.vw_FactSales;

/**3.4. Product Dimension – số lượng sản phẩm và NULL**/

-- Tổng số sản phẩm
SELECT COUNT(*) AS TotalProducts
FROM dbo.vw_DimProduct;

-- Kiểm tra CategoryName và SubcategoryName bị NULL
SELECT
    COUNT(*) AS TotalProducts,
    SUM(CASE WHEN CategoryName IS NULL THEN 1 ELSE 0 END) AS NullCategory,
    SUM(CASE WHEN SubcategoryName IS NULL THEN 1 ELSE 0 END) AS NullSubcategory
FROM dbo.vw_DimProduct;

/**3.5. Product Dimension – kiểm tra sản phẩm không có Category**/

SELECT
    P.ProductID,
    P.ProductName,
    P.CategoryName,
    COUNT(F.ProductID) AS NumberOfSales
FROM dbo.vw_DimProduct AS P
LEFT JOIN dbo.vw_FactSales AS F
    ON P.ProductID = F.ProductID
WHERE P.CategoryName IS NULL
GROUP BY
    P.ProductID,
    P.ProductName,
    P.CategoryName
ORDER BY NumberOfSales DESC;

/**3.6. Customer Dimension – kiểm tra loại khách hàng và tên NULL**/

-- Đếm số khách hàng theo nhóm
SELECT
    CustomerType,
    COUNT(*) AS TotalCustomers
FROM dbo.vw_DimCustomer
GROUP BY CustomerType;

-- Kiểm tra CustomerName bị NULL
SELECT *
FROM dbo.vw_DimCustomer
WHERE CustomerName IS NULL;

/**3.7. Territory Dimension – kiểm tra dữ liệu**/

-- Xem dữ liệu territory
SELECT *
FROM dbo.vw_DimTerritory;

-- Tổng số territory
SELECT COUNT(*) AS TotalTerritories
FROM dbo.vw_DimTerritory;

-- Kiểm tra TerritoryID bị NULL
SELECT *
FROM dbo.vw_DimTerritory
WHERE TerritoryID IS NULL;