-- Database Setup

USE master;
GO

CREATE DATABASE Transactions_Triggers_Test;
GO

USE Transactions_Triggers_Test
GO

CREATE TABLE Accounts
(
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    AccountName NVARCHAR(50),
    Balance DECIMAL(10, 2)
);
GO

-- Task 1. Create a transaction to insert a new record into an `Accounts` table. If the balance is less than zero, rollback the transaction.

BEGIN TRANSACTION

DECLARE @Balance DECIMAL(10, 2)
SET @Balance = -50

DECLARE @AccountName NVARCHAR(50)
SET @AccountName = 'Sample Account 3'

INSERT INTO Accounts
    (AccountName, Balance)
VALUES
    (@AccountName, @Balance)

IF (SELECT Balance
FROM Accounts
WHERE AccountName = @AccountName) < 0
BEGIN
    ROLLBACK TRANSACTION
END
    ELSE
    BEGIN
    COMMIT TRANSACTION
END

GO

-- If a negative account amount is inserted the table should be empty

SELECT *
FROM Accounts

GO