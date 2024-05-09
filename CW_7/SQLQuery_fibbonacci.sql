CREATE PROCEDURE dbo.PrintFibonacciSequence
    @n INT
AS
BEGIN
    DECLARE @i INT = 1,
            @a INT = 0,
            @b INT = 1,
            @next INT;

    WHILE @i <= @n
    BEGIN
        PRINT @a;
        SET @next = @a + @b;
        SET @a = @b;
        SET @b = @next;
        SET @i = @i + 1;
    END
END;
GO
EXEC dbo.PrintFibonacciSequence @n = 20;