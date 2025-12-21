use collage
select * from student
select * from Dept
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
select * from Subjects
select
