-- Create a trigger on the `Products` table to prevent inserting products with a negative price. If an attempt is made, raise an error.

CREATE TRIGGER Trg_Insted_Insert_Products
ON Products
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS ( SELECT * FROM inserted WHERE Price < 0)
    BEGIN
        RAISERROR ('Error: Cannot Insert product with a negative price.', 16, 1);
    END

    INSERT INTO Products
    SELECT *
    FROM inserted
    WHERE Price > 0
END;
GO

-- Sample Data Insertion

--should be inserted
INSERT INTO Products ([ProductID], [ProductName], [SupplierID], [CategoryID], [Unit], [Price])
VALUES (7, 'Test Product1', 1, 1, 'test units', 30)
GO

--should NOT be inserted
INSERT INTO Products ([ProductID], [ProductName], [SupplierID], [CategoryID], [Unit], [Price])
VALUES (8, 'Test Product1', 1, 1, 'test units', -20)
GO

--should insert just the first one
INSERT INTO Products ([ProductID], [ProductName], [SupplierID], [CategoryID], [Unit], [Price])
VALUES  (9, 'Test Product1', 1, 1, 'test units', 20),
        (10, 'Test Product2', 1, 1, 'test units', -20)
GO