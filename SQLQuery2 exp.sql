create database exp2;
use exp2;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL  
);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),        
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

Select E1.EmpName as EmployeeName,E1.Department as EmployeeDept,E2.EmpName as ManagerName,E2.Department as ManagerDept
from Employee as E1
Left join Employee as E2 on 
E1.ManagerID = E2.EmpID


-------------------------------hard Level-------------------------------------------------
CREATE TABLE Year_tbl (
      ID INT,
      YEAR INT,
      NPV INT
  );
   CREATE TABLE Queries (
      ID INT,
      YEAR INT
  );
   INSERT INTO Year_tbl (ID, YEAR, NPV)
  VALUES
  (1, 2018, 100),
  (7, 2020, 30),
  (13, 2019, 40),
  (1, 2019, 113),
  (2, 2008, 121),
  (3, 2009, 12),
  (11, 2020, 99),
  (7, 2019, 0);

  INSERT INTO Queries (ID, YEAR)
  VALUES
  (1, 2019),
  (2, 2008),
  (3, 2009),
  (7, 2018),
  (7, 2019),
  (7, 2020),
  (13, 2019);

  Select Q.ID as ID,Q.YEAR as year,Y.NPV as NPV
  from Queries as Q
  Left join year_tbl as Y
  on Q.ID = y.ID and Q.YEAR = Y.YEAR ORDER BY Q.ID,Q.year;