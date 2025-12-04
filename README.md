# Task1-Academic-Management-System
Design and develop an Academic Management System using SQL. The projects should involve three tables 
1.StudentInfo 
2. CoursesInfo 
3.EnrollmentInfo.

The Aim is to create a system that allows for managing student information and course enrollment.

**Academic Management System (SQL Project)**

**Author: Manirathinam P T**

**Project Overview**

The Academic Management System is an SQL-based project designed to manage student information, courses, and enrollments.
It demonstrates database creation, relational modeling, data insertion, retrieval operations, and analytical reporting using SQL.

This project simulates a real-world academic environment where administrators can maintain and analyze academic records.

**Project Structure**

**StudentInfo**

Stores personal and academic details of students.
Columns: STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS

**CoursesInfo**

Stores course-level details.
Columns: COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR

**EnrollmentInfo**

Tracks enrollments of students in different courses.
Columns: ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS
Includes FOREIGN KEY constraints referencing StudentInfo and CoursesInfo.

**Key Features & Tasks Completed**

**1. Database Creation**

Designed schema for all three tables

Added primary keys and foreign key constraints

**2. Data Insertion**

Inserted sample data into StudentInfo, CoursesInfo, and EnrollmentInfo

**3. Information Retrieval Queries**

Retrieve complete student details and enrollment status

Retrieve courses for a specific student

Retrieve course and instructor details

Fetch info for multiple courses

Tested and validated all queries

**4. Reporting & Analytics**

Includes SQL queries to:

Count students enrolled per course

List students enrolled in a specific course

Count enrolled students per instructor

Identify students enrolled in multiple courses

Rank courses by enrollment volume

**How to Use This Project**

Open the SQL file in mySQL

Execute tasks sequentially to recreate the system

View query outputs using the provided screenshots

