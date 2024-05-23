Use AdventureWorksLT2019
GO

WITH CategorySalesCTE AS (
    SELECT
        pc.Name AS Category,
        SUM(sd.LineTotal) AS SalesValue
    FROM 
        SalesLT.SalesOrderDetail sd
        JOIN SalesLT.Product p ON sd.ProductID = p.ProductID
        JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    GROUP BY
        pc.Name
)
-- Pobranie wyników CTE
SELECT Category, SalesValue
FROM CategorySalesCTE
ORDER BY SalesValue DESC;
