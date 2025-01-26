USE Transactions_Triggers_Test
GO

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    SupplierID INT NOT NULL,
    CategoryID INT NOT NULL,
    Unit NVARCHAR(255),
    Price DECIMAL(10, 2) NOT NULL
);
GO

INSERT INTO Products
    (ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES
    (1, 'Chais', 1, 1, '10 boxes x 20 bags', 18),
    (2, 'Chang', 1, 1, '24 - 12 oz bottles', 19),
    (3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10),
    (4, 'Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22),
    (5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35)

GO

-- Create a transaction that updates the stock of a `Products` table. If any error occurs during the update, rollback the transaction and print an error message.

BEGIN TRANSACTION
BEGIN TRY
        INSERT INTO Products
VALUES
    (5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35)
    END TRY
    BEGIN CATCH
        IF @@ERROR <> 0
        BEGIN
            PRINT 'Error Message: ' + ERROR_MESSAGE()
            ROLLBACK TRANSACTION
        END
        ELSE
        BEGIN
        COMMIT TRANSACTION
        END
    END CATCH