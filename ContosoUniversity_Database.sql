-- ==============================================================================
-- Project: Contoso University Database Schema & Seed Data
-- Tutorial: Get started with EF Core in an ASP.NET MVC web app (Tutorial 01)
-- Prepared for / Developed by: Eng.Alhassan Ali Bahbah
-- Compatible with: Microsoft SQL Server / LocalDB and MySQL Server
-- ==============================================================================

-- 1. Create Tables
CREATE TABLE IF NOT EXISTS Student (
    ID INT NOT NULL AUTO_INCREMENT,
    LastName VARCHAR(50) NOT NULL,
    FirstMidName VARCHAR(50) NOT NULL,
    EnrollmentDate DATETIME NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS Course (
    CourseID INT NOT NULL,
    Title VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    PRIMARY KEY (CourseID)
);

CREATE TABLE IF NOT EXISTS Enrollment (
    EnrollmentID INT NOT NULL AUTO_INCREMENT,
    CourseID INT NOT NULL,
    StudentID INT NOT NULL,
    Grade INT NULL, -- Enum: 0=A, 1=B, 2=C, 3=D, 4=F, NULL=No Grade
    PRIMARY KEY (EnrollmentID),
    CONSTRAINT FK_Enrollment_Course FOREIGN KEY (CourseID) REFERENCES Course (CourseID) ON DELETE CASCADE,
    CONSTRAINT FK_Enrollment_Student FOREIGN KEY (StudentID) REFERENCES Student (ID) ON DELETE CASCADE
);

-- 2. Seed Data: Students
INSERT INTO Student (ID, LastName, FirstMidName, EnrollmentDate) VALUES
(1, 'Alexander', 'Carson', '2005-09-01 00:00:00'),
(2, 'Alonso', 'Meredith', '2002-09-01 00:00:00'),
(3, 'Anand', 'Arturo', '2003-09-01 00:00:00'),
(4, 'Barzdukas', 'Gytis', '2002-09-01 00:00:00'),
(5, 'Li', 'Yan', '2002-09-01 00:00:00'),
(6, 'Justice', 'Peggy', '2001-09-01 00:00:00'),
(7, 'Norman', 'Laura', '2003-09-01 00:00:00'),
(8, 'Olivetto', 'Nino', '2005-09-01 00:00:00'),
(9, 'Bahbah', 'Eng.Alhassan', '2026-11-19 00:00:00');

-- 3. Seed Data: Courses
INSERT INTO Course (CourseID, Title, Credits) VALUES
(1050, 'Chemistry', 3),
(4022, 'Microeconomics', 3),
(4041, 'Macroeconomics', 3),
(1045, 'Calculus', 4),
(3141, 'Trigonometry', 4),
(2021, 'Composition', 3),
(2042, 'Literature', 4);

-- 4. Seed Data: Enrollments
-- Grade mapping: 0=A, 1=B, 2=C, 3=D, 4=F
INSERT INTO Enrollment (EnrollmentID, StudentID, CourseID, Grade) VALUES
(1, 1, 1050, 0), -- Carson Alexander: Chemistry, Grade A
(2, 1, 4022, 2), -- Carson Alexander: Microeconomics, Grade C
(3, 1, 4041, 1), -- Carson Alexander: Macroeconomics, Grade B
(4, 2, 1045, 1), -- Meredith Alonso: Calculus, Grade B
(5, 2, 3141, 4), -- Meredith Alonso: Trigonometry, Grade F
(6, 2, 2021, 4), -- Meredith Alonso: Composition, Grade F
(7, 3, 1050, NULL), -- Arturo Anand: Chemistry
(8, 4, 1050, NULL), -- Gytis Barzdukas: Chemistry
(9, 4, 4022, 4), -- Gytis Barzdukas: Microeconomics, Grade F
(10, 5, 4041, 2), -- Yan Li: Macroeconomics, Grade C
(11, 6, 1045, NULL), -- Peggy Justice: Calculus
(12, 7, 3141, 0), -- Laura Norman: Trigonometry, Grade A
(13, 9, 1045, 0), -- Eng.Alhassan Bahbah: Calculus, Grade A
(14, 9, 1050, 0); -- Eng.Alhassan Bahbah: Chemistry, Grade A
