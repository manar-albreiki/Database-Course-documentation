use collage
select * from student
select * from Subjects
--------
-- join task 
-- 1. Display the department ID, name, and the full name of the faculty managing it. 
select
d.Dept_ID,
d.Dept_name,
f. Faculty_name
from Dept d
join Faculty f
on d.Dept_ID = f.Dept_ID

-- 2. Display each program's name and the name of the department offering it. 
select 
d.Dept_name,
c.course_name
from Dept d
join course c
on d.Dept_ID = c.Dept_ID

-- 3. Display the full student data and the full name of their faculty advisor. 
select
s.S_ID,s.Fname, s.Lname, s.Phone_no,s.DOB, f.advisor
from student s
full join student f
on s.S_ID = f.S_ID

-- 4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'. 

-- 5. Display full data about courses whose titles start with "I" (e.g., "Introduction to..."). 
select * from course
where course_name like 'T%' -- i didnot have I


-- 6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 
select * from student
select
s.Fname+ ' ' +s.Lname as fullname, s.GPA, c.course_ID --use course because i do not have program
from student s
join Student_Course c
on s.S_ID = c.S_ID
where c.course_ID = 3
and s.GPA between 2.5 and 3.5

-- 7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 

-- 8. Find names of students who are advised by "Dr. Ahmed Hassan". 
select
s.Fname+ ' ' +s.Lname as fullname, s.advisor
from  student s
join  student c
on s.S_ID = c.S_ID
where s.advisor = 'ahmed'

-- 9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.  
SELECT
s.Fname, s.Lname, c.course_name
FROM student s
JOIN Student_Course sc 
ON s.S_ID = sc.S_ID
JOIN course c
ON sc.course_ID = c.course_ID
ORDER BY c.course_name;

-- 10. For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 
select -- we do not have any class table or column
c.course_name,
d.Dept_name,
f.Faculty_name
from Dept d
join Faculty f on d.Dept_ID = f.Dept_ID
join course c on d.Dept_ID = c.Dept_ID

-- 11. Display all faculty members who manage any department. 

SELECT 
f.Faculty_name, d.Dept_name
FROM Faculty f
 JOIN Dept d
ON f.Dept_ID = d.Dept_ID;

-- 12. Display all students and their advisors' names, even if some students don’t have advisors yet. 
select 
s.Fname, d.advisor
from student s
left join student d
on s.S_ID = d.S_ID
