create database exp3;
use exp3;
--------------------EXPERIMENT 03: (MEDIUM LEVEL)
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

Select * from department;
Select * from employee;

Select D.dept_name,e.name,e.salary,D.id
from employee as e
INNER JOIN
Department as d
on e.department_id = D.id
where e.salary IN(
Select max(E2.salary)
from employee as E2
where E2.department_id = E.department_id
)
order by D.dept_name;

--where e.salary in (
--select max(E2.salary)
--from employee as E2
--group by E2.department_id;



-----hard level-----
create table A(
    empId int,
    E_name varchar(20),
    salary int
);

insert into A values(1, 'AA', 1000);
insert into A values(2, 'BB', 300);

create table B(
    empId int,
    E_name varchar(20), 
    salary int
);

insert into B values(1, 'BB', 400);
insert into B values(2, 'CC', 100);

Select * from A;
Select * from B;

SELECT E_name, MIN(salary) AS Salary
FROM (
    SELECT empId, E_name, salary FROM A
    UNION
    SELECT empId, E_name, salary FROM B
) AS inter_result
GROUP BY E_name;

