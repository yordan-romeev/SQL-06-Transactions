USE Transactions_Triggers_Test
GO

-- DB Preparation 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2)
);

CREATE TABLE HighValueOrders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
    RecordedDate DATETIME DEFAULT GETDATE()
);
GO

-- Write an `AFTER INSERT` trigger for an `Orders` table. If the order value exceeds $1000, insert the record into a `HighValueOrders` table.

CREATE TRIGGER Trg_After_Insert_Orders
ON Orders
AFTER INSERT
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE TotalAmount > 1000)
BEGIN
    INSERT INTO HighValueOrders 
    SELECT OrderID, CustomerID, TotalAmount, GETDATE() 
    FROM inserted 
    WHERE TotalAmount > 1000
END
END;
GO


--Sample Insertions

--should not be in HighValueOrders
INSERT INTO Orders 
--should not be in HighValueOrders
VALUES  (1, 1, 500),
--should be in HighValueOrders
        (2, 2, 1500),
--should not be in HighValueOrders
        (3, 3, 750),
--should be in HighValueOrders
        (4, 4, 2000)
GO

SELECT * FROM Orders
SELECT * FROM HighValueOrders        