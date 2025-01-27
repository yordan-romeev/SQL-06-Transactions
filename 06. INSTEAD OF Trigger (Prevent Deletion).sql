USE Transactions_Triggers_Test
GO

-- DB Preparation

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Position NVARCHAR(50)
);

CREATE TABLE DeletedEmployees
(
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Position NVARCHAR(50),
    DeletedDate DATETIME DEFAULT GETDATE()
);
GO

-- Write an `INSTEAD OF DELETE` trigger to prevent deletions from an `Employees` table. Instead of deleting, insert the record into a `DeletedEmployees` table.

CREATE TRIGGER trg_PreventDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO DeletedEmployees
        (EmployeeID, Name, Position)
    SELECT EmployeeID, Name, [Position]
    FROM deleted
END;
GO

-- Sample Data

INSERT INTO Employees
    (EmployeeID, Name, Position)
VALUES
    (1, 'Test Employee 1', 'Test Position 1'),
    (2, 'Test Employee 2', 'Test Position 2')

-- Test Delete

DELETE FROM Employees WHERE EmployeeID = 1

-- Employee should be in DeletedEmployees table, instead of being deleted

SELECT * FROM Employees
SELECT * FROM DeletedEmployees