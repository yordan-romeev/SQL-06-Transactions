USE Transactions_Triggers_Test
GO

-- DB Preparation

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

CREATE TABLE Employees2 (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    DepartmentID INT,
    DepartmentName NVARCHAR(50)
);
GO

-- Write an `AFTER UPDATE` trigger on a `Departments` table. When a department’s name is updated, automatically update the `DepartmentName` in the `Employees` table.

CREATE TRIGGER Trg_After_Update_Departments
ON Departments
AFTER UPDATE
AS
BEGIN
    UPDATE e
    SET e.DepartmentName = i.DepartmentName
    FROM Employees2 e
    INNER JOIN INSERTED i
        ON e.DepartmentID = i.DepartmentID
    WHERE EXISTS (SELECT 1
        FROM DELETED d
        WHERE d.DepartmentID = i.DepartmentID
          AND d.DepartmentName <> i.DepartmentName)
END;
GO

--Sample Data Insertion 

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'Finance'), 
        (2, 'Marketing'),
        (3, 'R&D')
GO

INSERT INTO Employees2 (EmployeeID, Name, DepartmentID, DepartmentName)
VALUES  (1, 'Name 1', 1, 'Finance'),
        (2, 'Name 2', 1, 'Finance'),
        (3, 'Name 3', 2, 'Marketing'),
        (4, 'Name 4', 2, 'Marketing'),
        (5, 'Name 5', 3, 'R&D'),
        (6, 'Name 61', 3, 'R&D')

GO

-- Sample Update

-- Department name should be 'R&D'
SELECT * FROM Employees2
GO 

UPDATE Departments SET DepartmentName = 'Development' WHERE DepartmentName = 'R&D'
GO

-- Department name should be 'Development' 
SELECT * FROM Employees2