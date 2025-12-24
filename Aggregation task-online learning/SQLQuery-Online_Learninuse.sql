create database Online_Learninuse 


CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
)

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
)

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
)

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
)

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
)

---------------------------------------------------------
INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21')
select * from Instructors

INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business')
select * from Categories

INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01')
select * from Courses

INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10')
select * from Students

INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3)
select * from Enrollments

-----------------------------------------
use Online_Learning

-- Part 1: Warm-Up
--1. Display all courses with prices.
select 
Title, Price
from Courses

-- 2. Display all students with join dates.
select 
FullName, JoinDate
from Students

-- 3. Show all enrollments with completion percent and rating.
select * from Enrollments

-- 4. Count instructors who joined in 2023.
SELECT COUNT(*) AS Num_Instructors_2023
FROM Instructors
WHERE JoinDate BETWEEN '2023-01-01' AND '2023-12-31'

-- 5. Count students who joined in April 2023
select * from Students
SELECT COUNT(*) AS st_april_2023
FROM Students
WHERE JoinDate BETWEEN '2023-04-01' AND '2023-04-30'
----------------------------------------------------------------
-- Part 2: Beginner Aggregation 
--1. Count total number of students. 
select 
count (*) as total_students
from Students

-- 2. Count total number of enrollments.
select 
count (*) as total_enrollments
from Enrollments

-- 3. Find average rating per course. 
select * from Courses
select * from Enrollments

SELECT 
    CourseID ,
    AVG(E.Rating) AS AverageRating
FROM  Enrollments E
GROUP BY CourseID
-- 4. Count courses per instructor.
SELECT 
    InstructorID, 
    COUNT(CourseID) AS TotalCourses
FROM  Courses 
GROUP BY InstructorID

-- 5. Count courses per category. 
SELECT 
    CategoryID,
    COUNT(CourseID) AS TotalCourses
FROM Courses
GROUP BY CategoryID

-- 6. Count students enrolled in each course. 
select 
CourseID,
count (StudentID) as students_enrolled
from Enrollments
group by CourseID

-- 7. Find average course price per category. 
select
CategoryID,
avg (Price) as average_coursePrice
from Courses
group by CategoryID

-- 8. Find maximum course price. 
select 
max (Price) as max_price
from Courses

-- 9. Find min, max, and average rating per course. 
select 
min (Rating) as min_rate,
avg (Rating) as avg_rate,
max (Rating) as max_rate
from Enrollments

-- 10. Count how many students gave rating = 5. 
select 
Rating,
count (StudentID) as student_rate
from Enrollments
group by Rating
having Rating = 5
-----------------------------------------------
-- Part 3: Extended Beginner Practice 

-- 11. Count enrollments per month. 
select * from Enrollments
SELECT 
    MONTH(EnrollDate) AS MonthNumber,
    COUNT(*) AS TotalEnrollments
FROM Enrollments
GROUP BY MONTH(EnrollDate)

-- 12. Find average course price overall. 
SELECT
AVG(Price) AS AverageCoursePrice
FROM Courses

-- 13. Count students per join month. 
select * from Students
SELECT 
    MONTH(JoinDate) AS JoinMonth,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY MONTH(JoinDate)
ORDER BY JoinMonth

-- 14. Count ratings per value (1–5).
SELECT 
    Rating,
    COUNT(*) AS RatingCount
FROM Enrollments
GROUP BY Rating

-- 15. Find courses that never received rating = 5. 
SELECT 
    Title AS CourseTitle,
	CourseID
FROM Courses
WHERE CourseID NOT IN (
 SELECT CourseID
    FROM Enrollments
    WHERE Rating = 5)

-- 16. Count courses priced above 30. 
select
Price,
count (CourseID) as Course
FROM Courses
group by Price
having Price > 30
-- 17. Find average completion percentage. 
select
avg(CompletionPercent) as avgCP
from Enrollments

-- 18. Find course with lowest average rating. 

SELECT TOP 1
    CourseID,
    AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID
ORDER BY AvgRating ASC

------------------------------------
-- Answer briefly: 
-- • What was easiest? when asking about count 
-- • What was hardest? asking about  never (like Q15) and lowest  (like Q18)
-- • What does GROUP BY do in your own words? It groups rows with the same value in a column

-- Course Performance Snapshot  
-- • Course title 
-- • Total enrollments 
-- • Average rating 
-- • Average completion % 
SELECT
    C.Title AS CourseTitle,
    COUNT(E.EnrollmentID) AS TotalEnrollments,
    AVG(E.Rating) AS AverageRating,
    AVG(E.CompletionPercent) AS AverageCompletionPercent
FROM Courses C
 left JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
---------------------------------------------------------------
-- Part 4: JOIN + Aggregation 

-- 1. Course title + instructor name + enrollments. 
select
c.Title,
i.FullName,
count (e.EnrollmentID) as NoEnrollments
from Courses c
join Enrollments e
on c.CourseID = e.CourseID
join Instructors i
on i.InstructorID = c.InstructorID
GROUP BY C.Title, I.FullName

-- 2. Category name + total courses + average price. 
select 
c.CategoryName,
count (o.CourseID) as total_courses,
avg (o.Price) as average_price
from Courses o
join Categories c
on c.CategoryID = o.CategoryID
group by c.CategoryName

-- 3. Instructor name + average course rating. 
select
i.FullName,
avg (e.Rating) as average_rating
from Enrollments e
join Courses c
on  c.CourseID = e.CourseID
join Instructors i
on i.InstructorID = c.InstructorID
group by i.FullName

-- 4. Student name + total courses enrolled. 
select
s.FullName,
count (CourseID) as total_courses
from Enrollments e
join Students s
on s.StudentID = e.StudentID
group by s.FullName

-- 5. Category name + total enrollments.
select 
g.CategoryName,
count (e.EnrollmentID) as total_enrollments
from Categories g
join Courses c
on g.CategoryID = c.CategoryID
join Enrollments e
on c.CourseID = e.CourseID
group by g.CategoryName

-- 6. Instructor name + total revenue.
SELECT
    I.FullName AS InstructorName,
    SUM(C.Price) AS TotalRevenue
FROM Instructors I
JOIN Courses C
    ON I.InstructorID = C.InstructorID
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName

-- 7. Course title + % of students completed 100%.
SELECT
    C.Title AS CourseTitle,
    (COUNT(CASE WHEN E.CompletionPercent = 100 THEN 1 END) * 100.0
     / COUNT(E.EnrollmentID)) AS CompletionPercentage
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title

------------------------------------------------------------------------
--Part 5: HAVING Practice 

-- 1. Courses with more than 2 enrollments. 
select
c.Title,
i.FullName,
count (e.EnrollmentID) as NoEnrollments
from Courses c
join Enrollments e
on c.CourseID = e.CourseID
join Instructors i
on i.InstructorID = c.InstructorID
GROUP BY C.Title, I.FullName
having count (e.EnrollmentID) > 2

-- 2. Instructors with average rating above 4. 
select
i.FullName,
avg (e.Rating) as average_rating
from Enrollments e
join Courses c
on  c.CourseID = e.CourseID
join Instructors i
on i.InstructorID = c.InstructorID
group by i.FullName
having avg (e.Rating) > 4

-- 3. Courses with average completion below 60%. 
select
c.CourseID,
avg (e.CompletionPercent) as average_completion
from Courses c
join Enrollments e
on c.CourseID = e.CourseID
group by c.CourseID
having avg (e.CompletionPercent) <60

-- 4. Categories with more than 1 course. 
select *from Categories
select *from Courses

SELECT
    C.CategoryName,
    COUNT(CO.CourseID) AS TotalCourses
FROM Categories C
JOIN Courses CO
    ON C.CategoryID = CO.CategoryID
GROUP BY C.CategoryName
HAVING COUNT(CO.CourseID) > 1

-- 5. Students enrolled in at least 2 courses. 
select
s.FullName,
count (c.CourseID) as enrolled_courses
from Students s
join Enrollments e
on s.StudentID = e.StudentID
join Courses c
on c.CourseID = e.CourseID
group by s.FullName
having count (c.CourseID) >= 2
--------------------------------------------------------------

-- Part 6: Analytical Thinking 
--1. Best performing course. 
select top 1
c.Title, 
avg (e.Rating) as course_rate
from Courses c
join Enrollments e
on c.CourseID = e.CourseID
group by c.Title
order by avg (e.Rating) desc

-- 2. Instructor to promote. 
select * from Enrollments
select top 1
i.FullName,
avg (e.Rating) as Instructor_rate
from Instructors i
join Courses c
on i.InstructorID = c.InstructorID
join Enrollments e
on c.CourseID = e.CourseID
group by i.FullName
order by avg (e.Rating) desc

-- 3. Highest revenue category. 
SELECT top 1
    I.FullName AS InstructorName,
    SUM(C.Price) AS TotalRevenue
FROM Instructors I
JOIN Courses C
    ON I.InstructorID = C.InstructorID
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName
order by SUM(C.Price) desc

-- 4. Do expensive courses have better ratings? 
SELECT
    C.Title AS CourseTitle,
    C.Price,
    AVG(E.Rating) AS AverageRating
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title, C.Price
ORDER BY C.Price DESC
--This query shows the average rating for each course along with its price

-- 5. Do cheaper courses have higher completion? 
SELECT
    C.Title AS CourseTitle,
    C.Price,
    AVG(E.CompletionPercent) AS AvgCompletion
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title, C.Price
ORDER BY C.Price ASC  
--This query shows the average completion percentage for each course along with its price
-------------------------------------------------------------------------------------------
-- Final Challenge – Mini Analytics Report 
-- 1. Top 3 courses by revenue. 
SELECT TOP 3
    C.Title AS CourseTitle,
    SUM(C.Price) AS TotalRevenue
FROM Courses C
JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
ORDER BY SUM(C.Price) DESC

-- 2. Instructor with most enrollments.
select top 1
i.FullName,
count (e.EnrollmentID) as most_enrollments
from Instructors i
join Courses c
on i.InstructorID = c.InstructorID
join Enrollments e 
on e.CourseID = c.CourseID
group by i.FullName
order by count (e.EnrollmentID) desc

-- 3. Course with lowest completion rate. 
select top 1
c.Title as Course_title,
AVG(e.CompletionPercent) AS AvgCompletion
from Enrollments e
join Courses c
on e.CourseID = e.CourseID
group by c.Title
order by AVG(e.CompletionPercent) desc

-- 4. Category with highest average rating. 
SELECT TOP 1
    C.CategoryName,
    AVG(E.Rating) AS AvgRating
FROM Categories C
JOIN Courses CO
    ON C.CategoryID = CO.CategoryID
JOIN Enrollments E
    ON CO.CourseID = E.CourseID
GROUP BY C.CategoryName
ORDER BY AVG(E.Rating) DESC

-- 5. Student enrolled in most courses.
SELECT TOP 1
    S.FullName AS StudentName,
    COUNT(E.CourseID) AS TotalCourses
FROM Students S
JOIN Enrollments E
    ON S.StudentID = E.StudentID
GROUP BY S.FullName
ORDER BY COUNT(E.CourseID) DESC
