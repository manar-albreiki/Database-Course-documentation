create database hostel
use database hostel

CREATE TABLE Branch (
    branch_ID INT IDENTITY(1,1) PRIMARY KEY,
    Branch_name VARCHAR(50) NOT NULL,
    Branch_location VARCHAR(100) NOT NULL
)

CREATE TABLE Customer (
    customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    customer_phone VARCHAR(20),
    customer_email VARCHAR(100)
)

CREATE TABLE Staff (
    staff_ID INT IDENTITY(1,1) PRIMARY KEY,
    staff_name VARCHAR(50) NOT NULL,
    staff_job_title VARCHAR(50),
    staff_salary DECIMAL(10,2),
    branch_ID INT,
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
)

CREATE TABLE Room (
    room_number INT IDENTITY(1,1) PRIMARY KEY,
    room_type VARCHAR(30) NOT NULL,
    nightly_rate DECIMAL(10,2) NOT NULL,
    branch_ID INT,
    FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
)

CREATE TABLE Booking (
    booking_ID INT IDENTITY(1,1) PRIMARY KEY,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    customer_ID INT,
    FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
)
CREATE TABLE Room_Booking (
    room_number INT,
    booking_ID INT,
    PRIMARY KEY (room_number, booking_ID),
    FOREIGN KEY (room_number) REFERENCES Room(room_number),
    FOREIGN KEY (booking_ID) REFERENCES Booking(booking_ID)
)

CREATE TABLE Staff_Booking (
    staff_ID INT,
    booking_ID INT,
    PRIMARY KEY (staff_ID, booking_ID),
    FOREIGN KEY (staff_ID) REFERENCES Staff(staff_ID),
    FOREIGN KEY (booking_ID) REFERENCES Booking(booking_ID)
)
------------------------------------------------------------------
INSERT INTO Branch (Branch_name, Branch_location)
VALUES 
('Muscat Branch', 'Muscat'),
('Salalah Branch', 'Salalah')
select * from Branch

INSERT INTO Customer (customer_name, customer_phone, customer_email)
VALUES
('Ahmed Al Said', '91234567', 'ahmed@gmail.com'),
('Fatma Al Harthy', '92345678', 'fatma@gmail.com')
select * from Customer

INSERT INTO Staff (staff_name, staff_job_title, staff_salary, branch_ID)
VALUES
('Ali Hassan', 'Receptionist', 450.00, 1),
('Sara Mohammed', 'Manager', 800.00, 1),
('Khalid Salem', 'Receptionist', 400.00, 2)
select * from Staff

INSERT INTO Room (room_type, nightly_rate, branch_ID)
VALUES
('Single', 25.00, 1),
('Double', 40.00, 1),
('Suite', 70.00, 2)
select * from Room

INSERT INTO Booking (check_in, check_out, customer_ID)
VALUES
('2025-01-10', '2025-01-15', 1),
('2025-02-01', '2025-02-05', 2)
select * from Booking

INSERT INTO Room_Booking (room_number, booking_ID)
VALUES
(1, 1),
(2, 1),
(3, 2)
select * from Room_Booking

INSERT INTO Staff_Booking (staff_ID, booking_ID)
VALUES
(1, 1),
(2, 1),
(3, 2)
select * from Staff_Booking

-----------------------------------------------
--DQL
--1. Display all guest records.
SELECT * FROM Customer

-- 2. Display each guest’s name, contact number, and proof ID type.
SELECT 
customer_name, 
customer_phone, 
customer_email AS Proof_ID 
FROM Customer

-- 3. Display all bookings with booking date, status, and total cost.
select * from Booking
SELECT B.booking_ID, B.check_in, B.check_out, 
       SUM(R.nightly_rate * DATEDIFF(DAY, B.check_in, B.check_out)) AS Total_Cost
FROM Booking B
JOIN Room_Booking RB ON B.booking_ID = RB.booking_ID
JOIN Room R ON RB.room_number = R.room_number
GROUP BY B.booking_ID, B.check_in, B.check_out

--4. Display each room number and its price per night as NightlyRate. 
SELECT 
room_number,
nightly_rate AS NightlyRate 
FROM Room

--5. List rooms priced above 1000 per night.
SELECT * FROM Room
WHERE nightly_rate > 30 -- do not have 1000

--6. Display staff members working as 'Receptionist'.
SELECT * FROM Staff
WHERE staff_job_title = 'Receptionist'

--7. Display bookings made in 2024.
SELECT * FROM Booking
WHERE YEAR(check_in) = 2025 -- do not have 2024

-- 8. Display bookings ordered by total cost descending.

-- 9. Display the maximum, minimum, and average room price.
SELECT MAX(nightly_rate) AS MaxPrice, 
       MIN(nightly_rate) AS MinPrice, 
       AVG(nightly_rate) AS AvgPrice
FROM Room

-- 10. Display total number of rooms.
SELECT 
COUNT(*) AS TotalRooms 
FROM Room

-- 11. Display guests whose names start with 'M'.
SELECT * FROM Customer
WHERE customer_name LIKE 'F%' -- DOES nit have M

-- 12. Display rooms priced between 800 and 1500.
SELECT * FROM Room
WHERE nightly_rate BETWEEN 20 AND 40

-- DML
--13. Insert yourself as a guest (Guest ID = 9011).
SET IDENTITY_INSERT Customer ON;

INSERT INTO Customer (customer_ID, customer_name, customer_phone, customer_email)
VALUES (9011, 'Manar Mohd', '98765432', 'manar@example.com')

SET IDENTITY_INSERT Customer OFF
select * from Customer

--14. Create a booking for room 205.
INSERT INTO Booking (check_in, check_out, customer_ID)
VALUES ('2025-12-25', '2025-12-30', 9011)
select * from Booking

-- 15. Insert another guest with NULL contact and proof details.
INSERT INTO Customer (customer_name, customer_phone, customer_email)
VALUES ('Noor', NULL, NULL)
select * from Customer

--16. Update your booking status to 'Confirmed'.
ALTER TABLE Booking 
ADD status VARCHAR(20)

UPDATE Booking
SET status = 'Confirmed'
WHERE customer_ID = 9011

select * from Booking

-- 17. Increase room prices by 10% for luxury rooms.

select * from Room
UPDATE Room
SET nightly_rate = nightly_rate * 1.10
WHERE room_type = 'Suite'

-- 18. Update booking status to 'Completed' where checkout date is before today.
UPDATE Booking
SET status = 'Completed'
WHERE check_out < GETDATE()

select * from Booking

-- 19. Delete bookings with status 'Cancelled'.
DELETE FROM Booking
WHERE status = 'Cancelled';

-----------------------------------------------
--JOIN
-- 1. Display hotel ID, name, and the name of its manager. 
select * from Staff
SELECT 
    B.branch_ID AS Hotel_ID,
    B.Branch_name AS Hotel_Name,
    S.staff_name AS Manager_Name
FROM Branch B
JOIN Staff S
    ON B.branch_ID = S.branch_ID
WHERE S.staff_job_title = 'Manager'

-- 2. Display hotel names and the rooms available under them. 
SELECT 
    B.Branch_name AS Hotel_Name,
    R.room_number AS Room_Number,
    R.room_type AS Room_Type
FROM Branch B
JOIN Room R
    ON B.branch_ID = R.branch_ID

	-- 3. Display guest data along with the bookings they made. 
	SELECT 
    C.*,
    B.booking_ID,
    B.check_in,
    B.check_out
FROM Customer C
LEFT JOIN Booking B
    ON C.customer_ID = B.customer_ID

-- 4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'. 
select * from Branch
SELECT 
    Bk.booking_ID,
    Bk.check_in,
    Bk.check_out,
    Br.Branch_name AS Hotel_Name,
    Br.Branch_location
FROM Branch Br
JOIN Room R
    ON Br.branch_ID = R.branch_ID
JOIN Room_Booking RB
    ON R.room_number = RB.room_number
JOIN Booking Bk
    ON RB.booking_ID = Bk.booking_ID
WHERE Br.Branch_location IN ('Muscat', 'Salalah')

-- 5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 
SELECT *
FROM Room
WHERE room_type LIKE 'S%'

-- 6. List guests who booked rooms priced between 1500 and 2500 LE.
SELECT 
    C.customer_name,
	R.nightly_rate
FROM Customer C
JOIN Booking B
    ON C.customer_ID = B.customer_ID
JOIN Room_Booking RB
    ON B.booking_ID = RB.booking_ID
JOIN Room R
    ON RB.room_number = R.room_number
WHERE R.nightly_rate BETWEEN 15 AND 50

-- 7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown". 
select * from Booking
select * from Branch
SELECT 
    C.customer_name,
	Br.Branch_name,
	B.status
FROM Customer C
JOIN Booking B
    ON C.customer_ID = B.customer_ID
JOIN Room_Booking RB
    ON B.booking_ID = RB.booking_ID
JOIN Room R
    ON RB.room_number = R.room_number
JOIN Branch Br
    ON R.branch_ID = Br.branch_ID
WHERE B.status = 'Completed'
  AND Br.Branch_name = 'Muscat Branch'

  -- 8. Find guests whose bookings were handled by staff member "Mona Ali". 
    select * from Staff
	SELECT 
    C.customer_name,
	s.staff_name
FROM Staff S
JOIN Staff_Booking SB
    ON S.staff_ID = SB.staff_ID
JOIN Booking B
    ON SB.booking_ID = B.booking_ID
JOIN Customer C
    ON B.customer_ID = C.customer_ID
WHERE S.staff_name = 'Khalid Salem'

-- 9. Display each guest’s name and the rooms they booked, ordered by room type. 
SELECT 
    C.customer_name,
    R.room_number,
    R.room_type
FROM Customer C
JOIN Booking B
    ON C.customer_ID = B.customer_ID
JOIN Room_Booking RB
    ON B.booking_ID = RB.booking_ID
JOIN Room R
    ON RB.room_number = R.room_number
ORDER BY R.room_type

-- 10. For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 
SELECT 
    Br.branch_ID AS Hotel_ID,
    Br.Branch_name AS Hotel_Name,
    S.staff_name AS Manager_Name,
    S.staff_job_title,
    S.staff_salary
FROM Branch Br
JOIN Staff S
    ON Br.branch_ID = S.branch_ID
WHERE Br.Branch_location = 'Muscat'
  AND S.staff_job_title = 'Manager'

  -- 11. Display all staff members who hold 'Manager' positions. 
  SELECT *
FROM Staff
WHERE staff_job_title = 'Manager'

-- 12. Display all guests and their reviews, even if some guests haven't submitted any reviews. 