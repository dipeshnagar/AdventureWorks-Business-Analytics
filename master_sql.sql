USE AdventureWorks2025;

-- SAMPLE PREVIEW
SELECT TOP 5 * FROM Sales.SalesOrderHeader;
SELECT TOP 5 * FROM Sales.SalesOrderDetail;
SELECT TOP 5 * FROM Production.Product;
SELECT TOP 5 * FROM Production.ProductSubcategory;
SELECT TOP 5 * FROM Production.ProductCategory;
SELECT TOP 5 * FROM Sales.Customer;
SELECT TOP 5 * FROM Person.Person;
SELECT TOP 5 * FROM Sales.SalesTerritory;
SELECT TOP 5 * FROM Person.BusinessEntityAddress;
SELECT TOP 5 * FROM Person.Address;

-------------------------------------------------------------
-- DATA PIPELINE (STEP 1) : JOIN 10+ TABLES WITH CTE
-------------------------------------------------------------

WITH ctc AS (
    SELECT
        soh.SalesOrderID,
        soh.OrderDate,
        soh.ShipDate,
        soh.OnlineOrderFlag,
        soh.SubTotal,
        soh.TaxAmt,
        soh.Freight,
        soh.TotalDue,

        so.SalesOrderDetailID,
        so.OrderQty,
        so.ProductID,
        so.UnitPriceDiscount,
        so.UnitPrice,
        so.LineTotal,

        pp.Name AS Product_Name,
        psc.Name AS Subcategory_Name,
        pc.Name AS Category_Name,

        soh.CustomerID,
        p.FirstName + ' ' + p.LastName AS FullName,

        t.CountryRegionCode,
        t.[Group] AS Country_Group,
        pa.City,

        YEAR(soh.OrderDate) AS OrderYear,
        MONTH(soh.OrderDate) AS OrderMonth,
        DATENAME(month, soh.OrderDate) AS OrderMonthName,
        DATEDIFF(day, OrderDate, ShipDate) AS ShippingDays
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail so ON soh.SalesOrderID = so.SalesOrderID
    JOIN Production.Product pp ON so.ProductID = pp.ProductID
    LEFT JOIN Production.ProductSubcategory psc ON pp.ProductSubcategoryID = psc.ProductSubcategoryID
    LEFT JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
    JOIN Sales.Customer sc ON soh.CustomerID = sc.CustomerID
    LEFT JOIN Person.Person p ON sc.PersonID = p.BusinessEntityID
    LEFT JOIN Sales.SalesTerritory t ON sc.TerritoryID = t.TerritoryID
    LEFT JOIN Person.BusinessEntityAddress ba ON sc.CustomerID = ba.BusinessEntityID
    LEFT JOIN Person.Address pa ON ba.AddressID = pa.AddressID
)
SELECT * FROM ctc;

-------------------------------------------------------------
-- DATA CLEANING (STEP 2) : REMOVE DUPLICATES INTO FINAL TABLE
-------------------------------------------------------------

SELECT *
INTO Clen_Table
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY SalesOrderID, SalesOrderDetailID ORDER BY SalesOrderID) AS rn
    FROM ctc
) x
WHERE rn = 1;

-------------------------------------------------------------
-- NULL HANDLING
-------------------------------------------------------------

UPDATE Clen_Table
SET City = 'Unknown'
WHERE City IS NULL;

-------------------------------------------------------------
-- DATATYPE CORRECTION
-------------------------------------------------------------

ALTER TABLE Clen_Table ALTER COLUMN Product_Name NVARCHAR(200);
ALTER TABLE Clen_Table ALTER COLUMN Subcategory_Name NVARCHAR(200);
ALTER TABLE Clen_Table ALTER COLUMN Category_Name NVARCHAR(200);

-------------------------------------------------------------
-- CLEANUP UNUSED COLUMNS
-------------------------------------------------------------

ALTER TABLE Clen_Table DROP COLUMN rn;
ALTER TABLE Clen_Table DROP COLUMN ShipDate;

-------------------------------------------------------------
-- FINAL TABLE
-------------------------------------------------------------

SELECT COUNT(*) FROM Clen_Table;
SELECT * FROM Clen_Table;

-------------------------------------------------------------
-- EXPORT THIS TABLE TO EXCEL FOR DASHBOARD CREATION
-------------------------------------------------------------

SELECT @@SERVERNAME;
