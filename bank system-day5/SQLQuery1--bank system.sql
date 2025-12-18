create database bank
use bank

CREATE TABLE Customer (
    customer_ID INT PRIMARY KEY identity (1,1),
    C_name VARCHAR(100),
    C_phone VARCHAR(15),
    date_of_birth DATE,
    address VARCHAR(55)
)

CREATE TABLE Branch (
    branch_ID INT PRIMARY KEY identity (1,1),
    address VARCHAR(55),
    B_phone VARCHAR(15)
)

CREATE TABLE Employee (
    employee_ID INT PRIMARY KEY identity (1,1),
    employee_name VARCHAR(100),
    employee_position VARCHAR(55),
    Branch_work_ID INT,
	branch_ID INT,
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
)

CREATE TABLE Loans (
    loans_ID INT PRIMARY KEY identity (1,1),
    loans_type VARCHAR(50),
    issue_date DATE,
    employee_ID INT,
    customer_ID INT,
    FOREIGN KEY (employee_ID) REFERENCES Employee(employee_ID),
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
)

CREATE TABLE Account (
    account_ID INT PRIMARY KEY,
    account_balance DECIMAL(10, 2),
    date_of_creation DATE,
    savings DECIMAL(15, 2),
    checking DECIMAL(15, 2),
    customer_ID INT,
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
)

CREATE TABLE Transactions (
    transaction_ID INT PRIMARY KEY identity (1,1),
	transaction_date date,
    balance DECIMAL(10, 2),
    withdrawals DECIMAL(10, 2),
    deposits DECIMAL(10, 2),
    transfers DECIMAL(10, 2),
    account_ID INT,
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID)
)
CREATE TABLE Customer_Employee (
    customer_ID INT,                             
    employee_ID INT,                             
    accounts_opened INT DEFAULT 0,              
    loans_processed INT DEFAULT 0,                
    PRIMARY KEY (customer_ID, employee_ID),     
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID), 
    FOREIGN KEY (employee_ID) REFERENCES Employee(employee_ID)   
)
--------------------------------------------------------------------
INSERT INTO Customer (C_name, C_phone, date_of_birth, address)
VALUES 
('Laila Al-Hinai', '96890123456', '1992-03-14', 'Muscat, Oman'),
('Omar Al-Khalili', '96891234567', '1988-08-21', 'Salalah, Oman'),
('Mariam Al-Salmi', '96892345678', '1995-12-09', 'Sohar, Oman'),
('Youssef Al-Amri', '96893456789', '2001-06-30', 'Nizwa, Oman'),
('Sara Al-Fahdi', '96894567890', '1999-11-05', 'Sur, Oman');
select * from Customer

INSERT INTO Branch (address, B_phone)
VALUES
('Muscat, Al Khuwair', '96890111222'),
('Salalah, Al Haffa', '96890222333'),
('Nizwa, Al Jami', '96890333444'),
('Sohar, Industrial Area', '96890444555'),
('Sur, Al Shuaiba', '96890555666');

select * from Branch

INSERT INTO Employee (employee_name, employee_position, Branch_work_ID, branch_ID)
VALUES
('Ali Al-Harthy', 'Manager', 101, 1),
('Fatma Al-Farsi', 'Cashier', 102, 1),
('Sultan Al-Maawali', 'Security', 103, 2),
('Noor Al-Balushi', 'Receptionist', 104, 3),
('Hussein Al-Riyami', 'Technician', 105, 4),
('Mariam Al-Khalili', 'Supervisor', 106, 5);
select * from Employee

INSERT INTO Loans (loans_type, issue_date, employee_ID, customer_ID)
VALUES
('Personal Loan', '2025-01-10', 1, 1),
('Home Loan', '2025-02-15', 2, 2),
('Car Loan', '2025-03-20', 3, 3),
('Education Loan', '2025-04-05', 4, 4),
('Business Loan', '2025-05-12', 5, 5),
('Personal Loan', '2025-06-18', 6, 1);
select * from Loans

INSERT INTO Account (account_ID, account_balance, date_of_creation, savings, checking, customer_ID)
VALUES
(1001, 5000.00, '2025-01-10', 3000.00, 2000.00, 1),
(1002, 15000.50, '2025-02-15', 10000.00, 5000.50, 2),
(1003, 8000.75, '2025-03-20', 5000.00, 3000.75, 3),
(1004, 12000.00, '2025-04-05', 7000.00, 5000.00, 4),
(1005, 25000.25, '2025-05-12', 15000.00, 10000.25, 5),
(1006, 4000.00, '2025-06-18', 2000.00, 2000.00, 1);
select * from Account

INSERT INTO Transactions (transaction_date, balance, withdrawals, deposits, transfers, account_ID)
VALUES
('2025-01-15', 5000.00, 0.00, 1000.00, 0.00, 1001),
('2025-02-20', 6000.00, 500.00, 0.00, 0.00, 1001),
('2025-03-10', 15000.50, 0.00, 5000.50, 0.00, 1002),
('2025-04-12', 12000.00, 2000.00, 0.00, 0.00, 1004),
('2025-05-18', 25000.25, 0.00, 10000.25, 0.00, 1005),
('2025-06-22', 4000.00, 1000.00, 0.00, 0.00, 1006);
select * from Transactions

INSERT INTO Customer_Employee (customer_ID, employee_ID, accounts_opened, loans_processed)
VALUES
(1, 1, 1, 2),
(2, 2, 1, 1),
(3, 3, 1, 1),
(4, 4, 1, 1),
(5, 5, 1, 1),
(1, 6, 0, 1);
select * from Customer_Employee
---------------------------------------------------------------------------------------
-- DQL 
-- 1. Display all customer records. 
select * from Customer

-- 2. Display customer full name, phone, and membership start date.
select 
C_name, C_phone
from Customer

-- 3. Display each loan ID, amount, and type.
alter table Loans
add  Loans_amount decimal (10,3)

UPDATE Loans
SET Loans_amount = 5000.000
WHERE loans_ID = 1;

UPDATE Loans
SET Loans_amount = 25000.500
WHERE loans_ID = 2;

UPDATE Loans
SET Loans_amount = 12000.750
WHERE loans_ID = 3;

UPDATE Loans
SET Loans_amount = 8000.000
WHERE loans_ID = 4;

UPDATE Loans
SET Loans_amount = 30000.250
WHERE loans_ID = 5;

UPDATE Loans
SET Loans_amount = 4000.000
WHERE loans_ID = 6;

select * from Loans

select 
loans_ID, loans_type, Loans_amount
 from Loans

 -- 4. Display account number and annual interest (5% of balance) as AnnualInterest. 
 SELECT 
    account_ID,
    account_balance * 0.05 AS AnnualInterest
FROM Account;

-- 5. List customers with loan amounts greater than 100000 LE. 
select * from Loans
where Loans_amount > 10000

-- 6. List accounts with balances above 20000. 
select * from Account
where   account_balance > 20000

-- 7. Display accounts opened in 2023. 
SELECT * FROM Account
WHERE YEAR(date_of_creation) = 2023;

-- 8. Display accounts ordered by balance descending. 
SELECT * FROM Account
order by account_balance desc

-- 9. Display the maximum, minimum, and average account balance. 
SELECT
max (account_balance) as maxbalance,
min (account_balance) as minbalance,
avg (account_balance) as avgbalance
FROM Account

-- 10. Display total number of customers. 
select count (*) as totalNo_customers
from Customer

-- 11. Display customers with NULL phone numbers. 
SELECT * FROM Customer
WHERE C_phone IS NULL;

-- DML 
-- 13. Insert yourself as a new customer and open an account with balance 10000.
INSERT INTO Customer (C_name, C_phone, date_of_birth, address)
VALUES ('Manar Mohd', '96890000000', '2000-01-01', 'Muscat, Oman');

INSERT INTO Account (account_ID, account_balance, date_of_creation, savings, checking, customer_ID)
VALUES (1007, 10000.00, GETDATE(), 10000.00, 0.00, 6);

SELECT * FROM Account

-- 14. Insert another customer with NULL phone and address. 
INSERT INTO Customer (C_name, C_phone, date_of_birth, address)
VALUES ('anoud', 'NULL', '2000-07-01', 'NULL');
SELECT * FROM Customer

-- 15. Increase your account balance by 20%.
UPDATE Account
SET account_balance = account_balance * 1.20
WHERE customer_ID = 6;
SELECT * FROM Account

-- 16. Increase balance by 5% for accounts with balance less than 5000. 
UPDATE Account
SET account_balance = account_balance * 1.05
WHERE account_balance < 5000;
SELECT * FROM Account

-- 17. Update phone number to 'Not Provided' where phone is NULL. 
UPDATE Customer
SET C_phone = 'Not Provided'
WHERE C_phone = 'NULL';
SELECT * FROM Customer

-- 