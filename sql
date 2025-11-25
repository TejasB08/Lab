CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Department VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'IT');

INSERT INTO Employee VALUES
(101, 'Amit', 50000, 1),
(102, 'Ravi', 60000, 1),
(103, 'Priya', 55000, 1),
(104, 'Neha', 70000, 2),
(105, 'Karan', 72000, 2),
(106, 'Sanjay', 68000, 3);

SELECT 
    EmpName,
    Salary,
    DeptID,
    (Salary - (SELECT AVG(Salary) 
               FROM Employee e2 
               WHERE e2.DeptID = e1.DeptID)) AS Salary_Diff_From_Dept_Avg
FROM Employee e1;

SELECT 
    d.DeptID, 
    d.DeptName, 
    COUNT(e.EmpID) AS Total_Employees
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY d.DeptID, d.DeptName
HAVING COUNT(e.EmpID) > 2;

SELECT 
    d.DeptName,
    t.MaxSalary
FROM Department d
JOIN (
      SELECT DeptID, MAX(Salary) AS MaxSalary
      FROM Employee
      GROUP BY DeptID
     ) AS t
ON d.DeptID = t.DeptID;