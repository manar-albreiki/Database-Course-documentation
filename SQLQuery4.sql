CREATE DATABASE BankingDB3
use BankingDB3

-- Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(15)
)

-- Account table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    Balance DECIMAL(10,2),
    AccountType NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
)

-- Insert customers
INSERT INTO Customer (FullName, Email, Phone) VALUES
('Alice Johnson', 'alice@example.com', '1234567890'),
('Bob Smith', 'bob@example.com', '0987654321')

-- Insert accounts
INSERT INTO Account (CustomerID, Balance, AccountType) VALUES
(1, 1000.00, 'Checking'),
(2, 500.00, 'Savings')

CREATE PROCEDURE TransferMoney
    @FromAccount INT,
    @ToAccount INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;  -- Start transaction
    BEGIN TRY
        -- Check if FromAccount has enough balance
        DECLARE @FromBalance DECIMAL(10,2);
        SELECT @FromBalance = Balance FROM Account WHERE AccountID = @FromAccount;

        IF @FromBalance < @Amount
        BEGIN
            PRINT 'Insufficient balance.';
            ROLLBACK;
            RETURN;
        END

        -- Deduct from sender
        UPDATE Account
        SET Balance = Balance - @Amount
        WHERE AccountID = @FromAccount;

        -- Add to receiver
        UPDATE Account
        SET Balance = Balance + @Amount
        WHERE AccountID = @ToAccount;

        COMMIT;  -- Commit transaction
        PRINT 'Transfer successful.';
    END TRY
    BEGIN CATCH
        ROLLBACK;  -- Rollback if error occurs
        PRINT 'Error occurred during transfer.';
    END CATCH
END;

-- Check balances before transfer
SELECT * FROM Account

-- Transfer $200 from Alice's account (ID 1) to Bob's account (ID 2)
EXEC TransferMoney @FromAccount = 1, @ToAccount = 2, @Amount = 200

SELECT * FROM Account