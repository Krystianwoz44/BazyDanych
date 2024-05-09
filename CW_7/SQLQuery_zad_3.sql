CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    DECLARE @OldTaxRate DECIMAL(10, 2),
            @NewTaxRate DECIMAL(10, 2);

    SELECT @OldTaxRate = TaxRate FROM deleted;
    SELECT @NewTaxRate = TaxRate FROM inserted;

    IF ABS(@NewTaxRate - @OldTaxRate) / @OldTaxRate > 0.3
    BEGIN
        RAISERROR('Tax rate change exceeds limit.', 18, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
-- Execute Use AdventureWorks2019; before TRIGGER
Use AdventureWorks2019;

UPDATE Sales.SalesTaxRate
SET TaxRate = 20
WHERE SalesTaxRateID = 1;
