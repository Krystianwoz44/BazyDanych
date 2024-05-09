CREATE TRIGGER trg_UppercaseLastName
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE p
    SET LastName = UPPER(i.LastName)
    FROM Person.Person p
    JOIN inserted i ON p.BusinessEntityID = i.BusinessEntityID;
END;
-- Execute Use AdventureWorks2019; before TRIGGER
Use AdventureWorks2019;

UPDATE Person.Person
SET LastName = 'Smith'
WHERE BusinessEntityID = 1;
