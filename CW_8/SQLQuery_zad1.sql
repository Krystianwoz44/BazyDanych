Use AdventureWorks2019
GO
-- Wyra¿enie CTE do pobrania danych pracowników
WITH EmployeeCTE AS (
    SELECT
        e.BusinessEntityID AS EmployeeID,
        p.FirstName,
        p.LastName,
        e.JobTitle,
        r.Rate
    FROM 
        HumanResources.Employee e
        JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
        JOIN HumanResources.EmployeePayHistory r ON e.BusinessEntityID = r.BusinessEntityID
)
-- Wstawienie wyników CTE do tabeli tymczasowej
SELECT EmployeeID, FirstName, LastName, JobTitle, Rate INTO dbo.TempEmployeeInfo
FROM EmployeeCTE;

-- Sprawdzenie wyników
SELECT * FROM TempEmployeeInfo ORDER BY EmployeeID ASC;

