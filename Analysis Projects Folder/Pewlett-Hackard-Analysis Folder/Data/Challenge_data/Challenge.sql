-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL
);

CREATE TABLE dept_employee (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

CREATE TABLE Titles (
  emp_no INT NOT NULL,
  title varchar NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--create all employee into & create table
SELECT emp.first_name, emp.last_name, emp.emp_no, sa.from_date, sa.salary, emp.birth_date, emp.hire_date
into employee_info
FROM employees as emp
inner join salaries as sa
on emp.emp_no = sa.emp_no

--combine info with title info & create table
SELECT ti.title, first_name, last_name, ei.emp_no, ei.from_date, salary, birth_date, hire_date, ti.to_date
into all_employee_info
FROM employee_info as ei
inner join titles as ti
on ei.emp_no = ti.emp_no

--partition off dup titles
SELECT emp_no, first_name, last_name, title, salary, from_date, to_date, birth_date, hire_date 
into all_employee_info_scrubbed
FROM
  (SELECT emp_no, first_name, last_name, title, salary, from_date, to_date, birth_date, hire_date,
     ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY to_date DESC) rn
   FROM all_employee_info
  ) tmp WHERE rn = 1;

--count the # of employees by title
select title, count(*)
into count_of_titles
from all_employee_info_scrubbed
group by title
ORDER BY count DESC

--refine the dataset to just 'silvers' & create table
SELECT emp.title, emp.first_name, emp.last_name, emp.emp_no, from_date, salary, birth_date, hire_date
into silver_titles
FROM all_employee_info_scrubbed as emp
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--count the # of SILVER employees by title
select title, count(*)
into count_of_silver_titles
from silver_titles
group by title
ORDER BY count DESC

--mentorship eligibility
select emp_no, first_name, last_name, from_date, to_date
into mentorship_eligibility
from all_employee_info_scrubbed
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')







