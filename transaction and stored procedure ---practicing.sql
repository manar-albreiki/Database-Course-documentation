select * from Account
select * from Customer

BEGIN TRANSACTION;

UPDATE Account
SET Balance = Balance - 200
WHERE AccountID = 1;

UPDATE Account
SET Balance = Balance + 200
WHERE AccountID = 2;

COMMIT;

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Account
    SET Balance = Balance - 100
    WHERE AccountID = 1;

    UPDATE Account
    SET Balance = Balance + 100
    WHERE AccountID = 2;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction failed and was rolled back';
END CATCH;
----------------

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Account
    SET Balance = Balance - 500
    WHERE AccountID = 1;

    UPDATE Account
    SET Balance = Balance + 500
    WHERE AccountID = 2;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction failed and was rolled back';
END CATCH;

--------------------
BEGIN TRY
    BEGIN TRANSACTION;

    -- Check if balance is sufficient
    IF (SELECT Balance FROM Account WHERE AccountID = 1) < 500
    BEGIN
        THROW 50001, 'Insufficient balance. Transaction cancelled.', 1;
    END;

    UPDATE Account
    SET Balance = Balance - 500
    WHERE AccountID = 1;

    UPDATE Account
    SET Balance = Balance + 500
    WHERE AccountID = 2;

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Transaction failed and was rolled back';
END CATCH;
-----
BEGIN TRANSACTION;

DECLARE @FromBalance DECIMAL(10,2);
SELECT @FromBalance = Balance FROM Account WHERE AccountID = 1;

IF @FromBalance >= 500
BEGIN
    -- Deduct from source account
    UPDATE Account
    SET Balance = Balance - 500
    WHERE AccountID = 1;

    -- Add to destination account
    UPDATE Account
    SET Balance = Balance + 500
    WHERE AccountID = 2;

    COMMIT TRANSACTION;
    PRINT 'Transaction completed successfully!';
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: Not enough balance.';
END

-------

BEGIN TRANSACTION;
BEGIN TRY
    UPDATE Account SET Balance = Balance - 500 WHERE AccountID = 2;
    UPDATE Account SET Balance = Balance + 500 WHERE AccountID = 1;

    COMMIT TRANSACTION;
    PRINT 'Transaction successful!';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: ' + ERROR_MESSAGE();
END CATCH

----------------------------------------------------------------------------------------
-- Stored Procedures
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName NVARCHAR(50),
    Age INT
)

INSERT INTO Students (StudentID, StudentName, Age)
VALUES (2, 'Ahmed Ali', 21),
 (3, 'Fatima Saeed', 22);

 CREATE PROCEDURE GetStudentByID
    @ID INT
AS
BEGIN
    SELECT * FROM Students
    WHERE StudentID = @ID;
END;

EXEC GetStudentByID @ID =3;
-------

CREATE PROCEDURE AddStudent
    @Name NVARCHAR(50),
    @Age INT
AS
BEGIN
    INSERT INTO Students (StudentName, Age)
    VALUES (@Name, @Age);
END;

EXEC AddStudent @Name = 'Manar', @Age = 23;


CREATE PROCEDURE TransferMoneyy
    @FromAccount INT,
    @ToAccount INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE Account SET Balance = Balance - @Amount WHERE AccountID = @FromAccount;
        UPDATE Account SET Balance = Balance + @Amount WHERE AccountID = @ToAccount;

        COMMIT TRANSACTION;
        PRINT 'Transaction successful!';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Transaction failed: ' + ERROR_MESSAGE();
    END CATCH
END;

EXEC TransferMoneyy @FromAccount = 1, @ToAccount = 2, @Amount = 300.00;
