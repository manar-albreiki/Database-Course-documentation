create database banking
use banking

CREATE TABLE Customer ( 
CustomerID INT PRIMARY KEY, 
FullName NVARCHAR(100), 
Email NVARCHAR(100), 
Phone NVARCHAR(15), 
SSN CHAR(9) 
)

CREATE TABLE Account ( 
    AccountID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    Balance DECIMAL(10, 2), 
    AccountType VARCHAR(50), 
    Status VARCHAR(20) 
)

CREATE TABLE Transactions ( 
    TransactionID INT PRIMARY KEY, 
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID), 
    Amount DECIMAL(10, 2), 
    Type VARCHAR(10), -- Deposit, Withdraw 
    TransactionDate DATETIME 
)

CREATE TABLE Loan ( 
    LoanID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    LoanAmount DECIMAL(12, 2), 
    LoanType VARCHAR(50), 
    Status VARCHAR(20) 
)
INSERT INTO Customer (CustomerID, FullName, Email, Phone, SSN) VALUES
(101, 'John Doe', 'john.doe@email.com', '111-111-1111', '123456789'),
(102, 'Jane Smith', 'jane.smith@email.com', '222-222-2222', '987654321'),
(103, 'Alice Brown', 'alice.brown@email.com', '333-333-3333', '456789123')
select * from Customer

INSERT INTO Account (AccountID, CustomerID, Balance, AccountType, Status) VALUES
(201, 101, 5000.00, 'Savings', 'Active'),
(202, 101, 1500.00, 'Checking', 'Active'),
(203, 102, 3000.00, 'Savings', 'Active'),
(204, 103, 1000.00, 'Checking', 'Inactive')
select * from Account

INSERT INTO Transactions (TransactionID, AccountID, Amount, Type, TransactionDate) VALUES
(301, 201, 1000.00, 'Deposit', '2025-12-01 10:00:00'),
(302, 201, 200.00, 'Withdraw', '2025-12-05 12:30:00'),
(303, 202, 500.00, 'Deposit', '2025-12-03 14:00:00'),
(304, 203, 300.00, 'Deposit', '2025-12-02 09:00:00')
select * from Transactions

INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, Status) VALUES
(401, 101, 10000.00, 'Personal', 'Active'),
(402, 102, 50000.00, 'Home', 'Active'),
(403, 103, 2000.00, 'Auto', 'Closed')
select * from Loan

-- Create Customer Service View
CREATE VIEW CustomerServiceView AS
SELECT 
    C.FullName,
    C.Phone,
    A.Status AS AccountStatus
FROM Customer C
JOIN Account A ON C.CustomerID = A.CustomerID
SELECT * FROM CustomerServiceView

-- Create Finance Department View
CREATE VIEW FinanceDeptView AS
SELECT 
    AccountID,
    Balance,
    AccountType
FROM Account
SELECT * FROM FinanceDeptView

-- Create Loan Officer View
CREATE VIEW LoanOfficerView AS
SELECT 
    LoanID,
    CustomerID,
    LoanAmount,
    LoanType,
    Status AS LoanStatus
FROM Loan
SELECT * FROM LoanOfficerView

-- Create Transaction Summary View (last 30 days)
CREATE VIEW TransactionSummaryView AS
SELECT 
    AccountID,
    Amount,
    TransactionDate,
    Type AS TransactionType
FROM Transactions
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE())
SELECT * FROM TransactionSummaryView
