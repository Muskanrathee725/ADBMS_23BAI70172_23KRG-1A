-- Easy Level: Author-Book Relationship

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS author;

CREATE TABLE author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(MAX),
    experience INT,
    country VARCHAR(50)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(MAX),
    author_id INT FOREIGN KEY(author_id) REFERENCES author(author_id)
);

INSERT INTO author VALUES (1, 'Aman', 10, 'India');
INSERT INTO author VALUES (2, 'Naman', 20, 'UK');
INSERT INTO author VALUES (3, 'Mantu', 5, 'USA');
INSERT INTO author VALUES (4, 'Andrew', 7, 'Canada');
INSERT INTO author VALUES (5, 'Nandu', 3, 'India');

INSERT INTO books VALUES (101, 'Learn SQL', 1);
INSERT INTO books VALUES (102, 'Data Science 101', 2);
INSERT INTO books VALUES (103, 'Advanced Python', 3);
INSERT INTO books VALUES (104, 'Database Basics', 1);
INSERT INTO books VALUES (105, 'Machine Learning', 4);

SELECT b.book_name AS [BOOK TITLE], a.author_name AS [AUTHOR NAME], a.country AS [AUTHOR COUNTRY]
FROM books AS b
INNER JOIN author AS a ON b.author_id = a.author_id;

SELECT b.book_name AS [BOOK TITLE], a.author_name AS [AUTHOR NAME], a.country AS [AUTHOR COUNTRY]
FROM books AS b
LEFT JOIN author AS a ON b.author_id = a.author_id;

SELECT b.book_name AS [BOOK TITLE], a.author_name AS [AUTHOR NAME], a.country AS [AUTHOR COUNTRY]
FROM books AS b
RIGHT JOIN author AS a ON b.author_id = a.author_id;

-- Medium Level: Department-Course Subquery and DCL

DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS department;

CREATE TABLE department (
    deptid INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE course (
    courseid INT PRIMARY KEY,
    coursename VARCHAR(100) NOT NULL,
    deptid INT,
    FOREIGN KEY(deptid) REFERENCES department(deptid)
);

INSERT INTO department VALUES (1, 'Computer Science');
INSERT INTO department VALUES (2, 'Mathematics');
INSERT INTO department VALUES (3, 'Physics');
INSERT INTO department VALUES (4, 'English');
INSERT INTO department VALUES (5, 'Chemistry');

INSERT INTO course VALUES (101, 'Algorithms', 1);
INSERT INTO course VALUES (102, 'Data Structures', 1);
INSERT INTO course VALUES (103, 'Operating Systems', 1);
INSERT INTO course VALUES (104, 'Calculus', 2);
INSERT INTO course VALUES (105, 'Linear Algebra', 2);
INSERT INTO course VALUES (106, 'Quantum Mechanics', 3);
INSERT INTO course VALUES (107, 'Classical Mechanics', 3);
INSERT INTO course VALUES (108, 'Electrodynamics', 3);
INSERT INTO course VALUES (109, 'English Literature', 4);
INSERT INTO course VALUES (110, 'Organic Chemistry', 5);

SELECT d.deptid, d.dept_name, COUNT(*) AS count
FROM course c
JOIN department d ON c.deptid = d.deptid
GROUP BY d.deptid, d.dept_name
HAVING COUNT(*) > 2;

-- DCL: User Creation and Permission Test

CREATE LOGIN Muskan WITH PASSWORD = '@1Muskan@1';
CREATE USER Muskan FOR LOGIN Muskan;
GRANT SELECT, INSERT, UPDATE, DELETE ON course TO Muskan;
INSERT INTO course VALUES (111, 'exempler Chemistry', 5);
REVOKE INSERT ON course FROM Muskan;
EXECUTE AS USER = 'Muskan';
INSERT INTO course VALUES (113, 'Modern abc', 4);
REVERT;
