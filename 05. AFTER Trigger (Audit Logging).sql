USE Transactions_Triggers_Test
GO

-- DB Definition

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    LogDate DATETIME DEFAULT GETDATE()
);

GO
-- Create an `AFTER INSERT` trigger for an `Orders` table to log new orders into an `OrderLog` table.

CREATE TRIGGER Trg_After_Insert_Orders
ON Orders
AFTER INSERT
AS
BEGIN
    INSERT INTO OrderLog (OrderID)
    SELECT OrderID FROM inserted;
END

GO

-- Sample Data

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES (1, 2, GETDATE())
GO


INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES (2, 1, GETDATE())
GO

SELECT * FROM Orders
SELECT * FROM OrderLog