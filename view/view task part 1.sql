create database emp
use emp

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Phone NVARCHAR(20),
    JobTitle NVARCHAR(50),
    Status NVARCHAR(10)  
)

INSERT INTO Employees VALUES
(101, 'John', 'Doe', '111-111-1111', 'Software Engineer', 'Active'),
(102, 'Jane', 'Smith', '222-222-2222', 'HR Manager', 'Active'),
(103, 'Alice', 'Brown', '333-333-3333', 'Intern', 'Inactive')

select * from Employees
-- Create a view to show only active employees
CREATE VIEW ActiveEmployees AS
SELECT EmployeeID, FirstName, LastName, Phone, JobTitle
FROM Employees
WHERE Status = 'Active'
-- Update phone number for an employee using the view
UPDATE ActiveEmployees
SET Phone = '123-456-7890'
WHERE EmployeeID = 101

select * from Employees

