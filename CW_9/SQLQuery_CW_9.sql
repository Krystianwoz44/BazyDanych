Use AdventureWorks2019
GO

--1.
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice * 1.10
WHERE ProductID = 680;
COMMIT TRANSACTION;



--2.
BEGIN TRANSACTION;
DELETE FROM Production.Product
    WHERE ProductID = 707;
ROLLBACK TRANSACTION;
PRINT 'Transakcja wycofana'




--3.
BEGIN TRANSACTION;
INSERT INTO Production.Product (Name, ProductNumber, MakeFlag ,FinishedGoodsFlag ,SafetyStockLevel, ReorderPoint ,StandardCost,ListPrice,DaysToManufacture, SellStartDate, rowguid ,ModifiedDate )
VALUES ('Nowy Produkt', 'NP-001', 100.00, 150.00, 1, 1000, 750, 1600, 67, GETDATE(),NEWID(), GETDATE());
COMMIT TRANSACTION;



--4.
BEGIN TRANSACTION;
-- Aktualizacja StandardCost o 10%
    UPDATE Production.Product
    SET StandardCost = StandardCost * 1.10;
 
    -- Sprawdzenie, czy suma StandardCost po aktualizacji nie przekracza 50000
    DECLARE @TotalStandardCost MONEY;
    SELECT @TotalStandardCost = SUM(StandardCost) FROM Production.Product;
 
    IF @TotalStandardCost <= 50000
    BEGIN
        -- Jeœli suma nie przekracza 50000, zatwierdŸ transakcjê
        COMMIT;
        PRINT 'Transakcja zatwierdzona. Suma StandardCost wynosi: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
    END
    ELSE
    BEGIN
        -- Jeœli suma przekracza 50000, wycofaj transakcjê
        ROLLBACK;
        PRINT 'Transakcja wycofana. Suma StandardCost przekracza 50000. Aktualna suma: ' + CAST(@TotalStandardCost AS NVARCHAR(50));
    END


--5.
BEGIN TRANSACTION;

IF NOT EXISTS (SELECT 1 FROM Production.Product WHERE ProductNumber = 'NP-003')
BEGIN
    INSERT INTO Production.Product (Name, ProductNumber, MakeFlag ,FinishedGoodsFlag ,SafetyStockLevel, ReorderPoint ,StandardCost,ListPrice,DaysToManufacture, SellStartDate, rowguid ,ModifiedDate )
    VALUES ('Nowy Produkt3', 'NP-003', 100.00, 150.00, 1, 1000, 750, 1600, 67, GETDATE(),NEWID(), GETDATE());
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
	PRINT 'Transakcja wycofana'
END



--6.
BEGIN TRANSACTION;

UPDATE Sales.SalesOrderDetail
SET OrderQty = OrderQty -2;

IF EXISTS (SELECT 1 FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
    ROLLBACK TRANSACTION;
	PRINT 'Transakcja wycofana'
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END



--7.
BEGIN TRANSACTION;

DECLARE @AverageCost DECIMAL(18, 2);
DECLARE @CountToDelete INT;

SELECT @AverageCost = AVG(StandardCost) FROM Production.Product;

DELETE FROM Production.Product
WHERE StandardCost > @AverageCost;
SET @CountToDelete = @@ROWCOUNT;

IF @CountToDelete <= 10
BEGIN
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
	PRINT 'Transakcja wycofana'
END
