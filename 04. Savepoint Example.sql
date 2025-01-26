USE Transactions_Triggers_Test
GO

-- Create a transaction that:
-- - Updates the quantity of multiple products.
-- - Creates a savepoint after the first product update.
-- - Rolls back to the savepoint if the second product update fails.

BEGIN TRANSACTION

UPDATE Products SET ProductID = 6 WHERE ProductID = 1

SAVE TRANSACTION SavePoint1

UPDATE Products SET ProductID = 6 WHERE ProductID = 2
IF @@ERROR <> 0
BEGIN
    ROLLBACK TRANSACTION SavePoint1
END

COMMIT TRANSACTION
