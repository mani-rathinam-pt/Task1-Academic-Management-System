show databases;
use academic_management_system;
-- Drop tables if they exist (in reverse order due to foreign key dependencies)
DROP TABLE IF EXISTS EnrollmentInfo;
DROP TABLE IF EXISTS CoursesInfo;
DROP TABLE IF EXISTS StudentInfo;

-- Create StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100) NOT NULL,
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

-- Create CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100) NOT NULL,
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- Create EnrollmentInfo table with foreign key constraints
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);
-- Insert sample data into StudentInfo table
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
(1, 'Manirathnam', '2002-05-15', '9876543210', 'manirathnam@email.com', '123 Main St, Chennai'),
(2, 'Edison', '2001-08-22', '9876543211', 'edison@email.com', '456 Park Ave, Bangalore'),
(3, 'Jayashree', '2003-01-10', '9876543212', 'jayashree@email.com', '789 Lake Rd, Hyderabad'),
(4, 'Dimpal', '2002-11-30', '9876543213', 'dimpal@email.com', '321 Hill St, Chennai'),
(5, 'Vidya', '2001-07-18', '9876543214', 'vidya@email.com', '654 River Ln, Pune');

-- Insert sample data into CoursesInfo table
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
(101, 'Database Management Systems', 'Dr. Sharma'),
(102, 'Data Structures and Algorithms', 'Prof. Kumar'),
(103, 'Web Development', 'Dr. Patel'),
(104, 'Machine Learning', 'Prof. Reddy'),
(105, 'Operating Systems', 'Dr. Singh');

-- Insert sample data into EnrollmentInfo table
INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Enrolled'),
(3, 2, 101, 'Enrolled'),
(4, 2, 103, 'Not Enrolled'),
(5, 3, 102, 'Enrolled'),
(6, 3, 104, 'Enrolled'),
(7, 4, 103, 'Enrolled'),
(8, 4, 105, 'Enrolled'),
(9, 5, 101, 'Enrolled'),
(10, 5, 104, 'Not Enrolled');
 -- Select all records from StudentInfo table
SELECT * FROM StudentInfo;
-- Select all records from CoursesInfo table
SELECT * FROM CoursesInfo;
-- Select all records from EnrollmentInfo table
SELECT * FROM EnrollmentInfo;

-- 3. RETRIEVE STUDENT INFORMATION QUERIES
-- ========================================

-- a) Retrieve student details with contact information and enrollment status
SELECT 
    s.STU_ID,
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    s.ADDRESS,
    e.ENROLL_STATUS,
    c.COURSE_NAME
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
ORDER BY s.STU_ID;

-- b) Retrieve list of courses for a specific student (Example: Manirathnam, STU_ID = 1)
SELECT 
    s.STU_NAME,
    c.COURSE_ID,
    c.COURSE_NAME,
    c.COURSE_INSTRUCTOR_NAME,
    e.ENROLL_STATUS
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE s.STU_ID = 1;

-- c) Retrieve course information including course name and instructor information
SELECT 
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
ORDER BY COURSE_ID;

-- d) Retrieve course information for a specific course
SELECT 
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID = 101;
-- e) Retrieve course information for multiple courses
SELECT 
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM CoursesInfo
WHERE COURSE_ID IN (101, 102, 103)
ORDER BY COURSE_ID;

-- f) Test queries - Verification queries with expected output

-- Test 1: Count total students
SELECT 'Total Students' AS Test, COUNT(*) AS Count FROM StudentInfo;
-- Expected: 5 students

-- Test 2: Count total courses
SELECT 'Total Courses' AS Test, COUNT(*) AS Count FROM CoursesInfo;
-- Expected: 5 courses

-- Test 3: Count total enrollments
SELECT 'Total Enrollments' AS Test, COUNT(*) AS Count FROM EnrollmentInfo;
-- Expected: 10 enrollments

-- Test 4: Count students with 'Enrolled' status
SELECT 'Enrolled Status Count' AS Test, COUNT(*) AS Count 
FROM EnrollmentInfo 
WHERE ENROLL_STATUS = 'Enrolled';
-- Expected: 8 enrolled

-- Test 5: Verify specific student enrollments (Manirathnam should have 2 courses)
SELECT 
    s.STU_NAME,
    COUNT(e.ENROLLMENT_ID) AS Total_Courses
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE s.STU_ID = 1
GROUP BY s.STU_NAME;
-- Expected: Manirathnam, 2 courses
-- Test 6: Verify course with most enrollments
SELECT 
    c.COURSE_NAME,
    COUNT(e.ENROLLMENT_ID) AS Total_Enrollments
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY c.COURSE_NAME
ORDER BY Total_Enrollments DESC;
-- Expected: Database Management Systems should have 3 enrollments

-- ========================================
-- 4. REPORTING AND ANALYTICS (Using Joining Queries)
-- ========================================

-- a) Retrieve the number of students enrolled in each course
SELECT 
    c.COURSE_NAME,
    COUNT(*) AS Number_of_Students
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

-- b) Retrieve the list of students enrolled in a specific course (Example: COURSE_ID = 101)
SELECT 
    s.STU_NAME,
    s.EMAIL_ID,
    c.COURSE_NAME
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE c.COURSE_ID = 101 AND e.ENROLL_STATUS = 'Enrolled';

-- c) Retrieve the count of enrolled students for each instructor
SELECT 
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(*) AS Number_of_Students
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

-- d) Retrieve the list of students who are enrolled in multiple courses
SELECT 
    s.STU_NAME,
    COUNT(*) AS Total_Courses
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_NAME
HAVING COUNT(*) > 1;

-- e) Retrieve the courses that have the highest number of enrolled students (arranging from highest to lowest)
SELECT 
    c.COURSE_NAME,
    COUNT(*) AS Number_of_Students
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY Number_of_Students DESC;