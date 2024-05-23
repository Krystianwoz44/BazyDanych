Use AdventureWorksLT2019
GO

WITH SalesCTE AS (
    SELECT
        c.CompanyName,
        CONCAT(c.FirstName, ' ', c.LastName) AS ContactName,
        SUM(s.SubTotal) AS Revenue
    FROM 
        SalesLT.Customer c
        JOIN SalesLT.SalesOrderHeader s ON c.CustomerID = s.CustomerID
        JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
        JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
    GROUP BY
        c.CompanyName,
        c.FirstName,
        c.LastName
)
-- Pobranie wyników CTE
SELECT 
    CompanyName + ' (' + ContactName + ')' AS CompanyContact,
    Revenue
FROM SalesCTE
ORDER BY Revenue DESC;

