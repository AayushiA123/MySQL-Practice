CREATE DATABASE employee;


-- Create table employee, employee_hobby, hobby, employee_salary:

CREATE TABLE employee (
  id INT AUTO_INCREMENT, 
  first_name VARCHAR (30), 
  last_name VARCHAR (30), 
  age INT, 
  mobile_number VARCHAR (17), 
  address VARCHAR (100), 
  PRIMARY KEY (id)
);


CREATE TABLE employee_salary (
  id INT AUTO_INCREMENT, 
  fk_employee_id INT AUTO_INCREMENT, 
  salary INT, 
  date DATE, 
  PRIMARY KEY (fk_employee_id), 
  FOREIGN KEY (fk_employee_id) REFERENCES employee (id)
);


CREATE TABLE hobby (
  id INT AUTO_INCREMENT, 
  name VARCHAR (30), 
  PRIMARY KEY (id)
);


CREATE TABLE employee_hobby (
  id INT AUTO_INCREMENT, 
  fk_employee_id INT, 
  fk_hobby_id INT, 
  PRIMARY KEY (id), 
  FOREIGN KEY (fk_employee_id) REFERENCES employee (id), 
  FOREIGN KEY (fk_hobby_id) REFERENCES hobby (id)
);

-- Insert into employee, employee_hobby, hobby, employee_salary:


INSERT INTO employee (id, first_name, last_name, age, mobile_number, address)
VALUES (1, "Aayushi", "Agrawal", 21, 9300113777, "Ahmedabad");

INSERT INTO employee (id, first_name, last_name, age, mobile_number, address)
VALUES (2, "Srashti", "Agrawal", 25, 9345454377, "Bhopal");

INSERT INTO employee (id, first_name, last_name, age, mobile_number, address)
VALUES (3, "Shubham", "Gupta", 29, 9977447777, "Jabalpur");


INSERT INTO hobby (id, name)
VALUES (1, "Cricket");

INSERT INTO hobby (id, name)
VALUES (2, "Reading");

INSERT INTO hobby (id, name)
VALUES (3, "Reading");

INSERT INTO hobby (id, name)
VALUES (4, "Gardening");


INSERT INTO employee_hobby (id, fk_employee_id, fk_hobby_id)
VALUES (1, 1, 1);

INSERT INTO employee_hobby (id, fk_employee_id, fk_hobby_id)
VALUES (2, 2, 2);

INSERT INTO employee_hobby (id, fk_employee_id, fk_hobby_id)
VALUES (3, 3, 3);

INSERT INTO employee_hobby (id, fk_employee_id, fk_hobby_id)
VALUES (4, 4, 4);


INSERT INTO employee_salary (id, fk_employee_id, salary, date)
VALUES (1, 1, 2000, "2003-01-26");

INSERT INTO employee_salary (fk_employee_id, salary, date)
VALUES (2, 2006, "2009-05-23");

INSERT INTO employee_salary (fk_employee_id, salary, date)
VALUES (3, 2056, "2089-05-23");


-- Updating data of all tables: 

UPDATE employee
SET last_name = "Jain"
WHERE id = 2;


UPDATE employee_salary
SET salary = 500
WHERE fk_employee_id = 1;


UPDATE hobby
SET name = "Writting"
WHERE id = 2;


-- Deleting data of all tables: 

DELETE FROM employee
WHERE id = 5;

DELETE FROM employee
WHERE address = "Bhopal";


DELETE FROM employee_hobby
WHERE id = 3;

DELETE FROM employee_hobby
WHERE id = 4;


DELETE FROM employee_salary
WHERE id = 4;

DELETE FROM employee_salary
WHERE id = 3;


DELETE FROM employee_salary
WHERE id = 3;

DELETE FROM employee_salary
WHERE id = 3;



-- Trancating data of all tables: 

TRUNCATE TABLE employee_hobby;

TRUNCATE TABLE employee_salary;


-- Select queries for all table: 

SELECT *
FROM employee;

SELECT *
FROM employee_salary;

SELECT *
FROM hobby;

SELECT *
FROM employee_hobby;


-- Select queries to get employee name and hobby name: 

SELECT concat(first_name, ' ', last_name) 
AS employee_name
FROM employee
UNION
SELECT name
FROM hobby;

-- Select queries to get employee name and salary: 

SELECT concat(first_name, ' ', last_name) AS employee_name, salary
FROM employee e
INNER JOIN employee_salary es ON e.id = es.fk_employee_id;


-- Select queries to get employee name, hobby and salary: 

SELECT concat(first_name, ' ', last_name) AS employee_name, SUM(es.salary) AS total_salary,
(SELECT GROUP_CONCAT(h.NAME)
FROM hobby h
JOIN employee_hobby eh ON h.id = eh.fk_hobby_id
WHERE eh.fk_employee_id = e.id) AS hobby_names
FROM employee e
LEFT JOIN employee_salary es ON e.id = es.fk_employee_id
GROUP BY e.id;
