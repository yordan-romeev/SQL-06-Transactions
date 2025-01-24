
# Transactions – Exercises

## Table of Contents
1. [Basic Transaction (INSERT and ROLLBACK)](#basic-transaction-insert-and-rollback)
2. [Transfer Funds Between Accounts](#transfer-funds-between-accounts)
3. [Transaction with Error Handling](#transaction-with-error-handling)
4. [Savepoint Example](#savepoint-example)
5. [AFTER Trigger (Audit Logging)](#after-trigger-audit-logging)
6. [INSTEAD OF Trigger (Prevent Deletion)](#instead-of-trigger-prevent-deletion)
7. [Trigger for Data Validation](#trigger-for-data-validation)
8. [Cascade Update with Trigger](#cascade-update-with-trigger)
9. [Conditional Trigger](#conditional-trigger)

---

## 1. Basic Transaction (INSERT and ROLLBACK)

Create a transaction to insert a new record into an `Accounts` table. If the balance is less than zero, rollback the transaction.

```sql
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountName NVARCHAR(50),
    Balance DECIMAL(10, 2)
);
```

---

## 2. Transfer Funds Between Accounts

Write a transaction to transfer $500 from Account A to Account B. Ensure the transaction is committed only if both updates are successful.

---

## 3. Transaction with Error Handling

Create a transaction that updates the stock of a `Products` table. If any error occurs during the update, rollback the transaction and print an error message.

---

## 4. Savepoint Example

Create a transaction that:
- Updates the quantity of multiple products.
- Creates a savepoint after the first product update.
- Rolls back to the savepoint if the second product update fails.

---

## 5. AFTER Trigger (Audit Logging)

Create an `AFTER INSERT` trigger for an `Orders` table to log new orders into an `OrderLog` table.

```sql
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
```

---

## 6. INSTEAD OF Trigger (Prevent Deletion)

Write an `INSTEAD OF DELETE` trigger to prevent deletions from an `Employees` table. Instead of deleting, insert the record into a `DeletedEmployees` table.

```sql
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Position NVARCHAR(50)
);

CREATE TABLE DeletedEmployees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Position NVARCHAR(50),
    DeletedDate DATETIME DEFAULT GETDATE()
);
```

---

## 7. Trigger for Data Validation

Create a trigger on the `Products` table to prevent inserting products with a negative price. If an attempt is made, raise an error.

---

## 8. Cascade Update with Trigger

Write an `AFTER UPDATE` trigger on a `Departments` table. When a department’s name is updated, automatically update the `DepartmentName` in the `Employees` table.

```sql
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    DepartmentID INT,
    DepartmentName NVARCHAR(50)
);
```

---

## 9. Conditional Trigger

Write an `AFTER INSERT` trigger for an `Orders` table. If the order value exceeds $1000, insert the record into a `HighValueOrders` table.

```sql
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
```
