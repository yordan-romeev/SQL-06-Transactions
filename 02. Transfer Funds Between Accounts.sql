USE Transactions_Triggers_Test
GO

-- Write a transaction to transfer $500 from Account A to Account B. Ensure the transaction is committed only if both updates are successful.

DECLARE @AccountA_ID INT
SET @AccountA_ID = 1

DECLARE @AccountB_ID INT
SET @AccountB_ID = 2

BEGIN TRANSACTION

UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = @AccountA_ID
UPDATE Accounts SET Balance = Balance + 500 WHERE AccountID = @AccountB_ID

IF @@ERROR <> 0
BEGIN
    ROLLBACK TRANSACTION
END
ELSE
BEGIN
    COMMIT TRANSACTION
END