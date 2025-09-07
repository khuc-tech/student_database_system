-- 1. List all students along with their admission program and batch.
SELECT 
    s.Student_Id, 
    s.First_Name, 
    s.Last_Name, 
    a.Enrolled_Program_Code, 
    a.Batch
FROM student s
JOIN admission a 
    ON s.Student_Id = a.Student_Id;


-- 2. Find students who stay in hostel accommodation.
SELECT 
    s.Student_Id, 
    s.First_Name, 
    s.Last_Name, 
    a.Hostel_Accommodation
FROM student s
JOIN admission a 
    ON s.Student_Id = a.Student_Id
WHERE a.Hostel_Accommodation = 'Y';


-- 3. Show each student’s achievements (technical, non-technical, and skills).
SELECT 
    s.Student_Id, 
    s.First_Name, 
    a.Tech_Events_Participated, 
    a.Non_Tech_Events_Participated, 
    a.Extra_Skills
FROM student s
JOIN achievements a 
    ON s.Student_Id = a.Student_Id;


-- 4. Get all subjects taught by a particular faculty member.
SELECT 
    f.First_Name, 
    f.Last_Name, 
    sub.Subject_Name, 
    sub.Semester, 
    sub.Batch, 
    sub.Program_Code
FROM faculty f
JOIN subject sub 
    ON f.Faculty_Code = sub.Faculty_Code
WHERE f.Faculty_Code = 'APS';


-- 5. Find the fee status of each student (total vs. paid).
SELECT 
    s.Student_Id, 
    s.First_Name, 
    f.Semester, 
    f.Total_Fees, 
    f.Fees_Paid,
    (f.Total_Fees - f.Fees_Paid) AS Pending_Amount
FROM student s
JOIN fees f 
    ON s.Student_Id = f.Student_Id;


-- 6. List students who have transport facilities.
SELECT 
    s.Student_Id, 
    s.First_Name, 
    s.Last_Name, 
    a.Transport_Facility
FROM student s
JOIN admission a 
    ON s.Student_Id = a.Student_Id
WHERE a.Transport_Facility = 'Y';


-- 7. Get the average SGPA of each program in a batch.
SELECT 
    r.Batch, 
    r.Program_Code, 
    AVG(r.SGPA) AS Avg_SGPA
FROM result r
GROUP BY 
    r.Batch, 
    r.Program_Code;


-- 8. Show program details along with coordinator faculty.
SELECT 
    p.Program_Code, 
    p.Program_Name, 
    p.Batch, 
    f.First_Name, 
    f.Last_Name
FROM program p
JOIN faculty f 
    ON p.Program_Coordinator_Code = f.Faculty_Code;


-- 9. Number of students enrolled in a particular batch and program.
SELECT COUNT(a.Student_Id) AS Total_Students
FROM admission a
WHERE 
    a.Batch = 2021 
    AND a.Enrolled_Program_Code = 'CE';


-- 10. Find the average SGPA of each student for Semester 3 along with their program and batch details.
SELECT 
    s.Student_Id, 
    s.First_Name, 
    s.Last_Name, 
    r.Semester, 
    avg(r.SGPA) as SGPA, 
    p.Program_Name, 
    p.Batch 
FROM student s 
JOIN result r 
    ON s.Student_Id = r.Student_Id 
JOIN program p 
    ON r.Program_Code = p.Program_Code 
    AND r.Batch = p.Batch 
WHERE r.Semester = 3 
GROUP BY r.Student_Id;