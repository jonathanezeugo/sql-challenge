-- Dropping to reset tables
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;


-- DATA ENGINEERING

-- Creating departments table
CREATE TABLE departments
(
	dept_no VARCHAR(30) NOT NULL UNIQUE,
	dept_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (dept_no)
);
-- Displaying the departments table
SELECT * FROM departments;


-- Creating titles table
CREATE TABLE titles
(
	title_id VARCHAR(10) NOT NULL UNIQUE,
	PRIMARY KEY (title_id),
	title VARCHAR(50) NOT NULL
);
-- Displaying the titles table
SELECT * FROM titles;

-- Creating employees table
CREATE TABLE employees
(
	emp_no INT NOT NULL UNIQUE,
	PRIMARY KEY (emp_no),
	emp_title_id VARCHAR(50) NOT NULL,
	birth_date date DEFAULT ('now'::text)::date NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date date DEFAULT ('now'::text)::date NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Displaying the employees table
SELECT * FROM employees;


-- Creating salaries table
CREATE TABLE salaries
(
	emp_no INT NOT NULL UNIQUE,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);
-- Displaying the salaries table
SELECT * FROM salaries;


-- Creating dept_emp table
CREATE TABLE dept_emp
(
	emp_no INT NOT NULL,
	dept_no VARCHAR(20) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
-- Displaying the department employees table
SELECT * FROM dept_emp;


-- Creating dept_manager table
CREATE TABLE dept_manager
(
	dept_no VARCHAR(20) NOT NULL,
	emp_no INT NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
-- Displaying the department managers table
SELECT * FROM dept_manager;

-- PERFORMING DATA ANALYSIS

--(1) Listing employee number, last name, first name, sex and salary
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e, salaries AS s
WHERE e.emp_no=s.emp_no;

--(2) Listing first name, last name and hire dates for employees who were hired in 1986
SELECT e.first_name, e.last_name, e.hire_date  -- selecting the first_name, last_name and hire_date columns from employees table
FROM employees AS e
WHERE EXTRACT(YEAR FROM e.hire_date) = '1986';


--(3) Listing the manager of each department by dept number, dept name, employee no, last name and first name
SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name  
FROM employees AS e, departments AS d, dept_manager AS dm
WHERE dm.emp_no =e.emp_no AND dm.dept_no = d.dept_no;


--(4)  Lising departments of each employee by employee number, last name, first name and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name  
FROM employees AS e, departments AS d, dept_emp AS de
WHERE de.emp_no = e.emp_no AND de.dept_no = d.dept_no;


--(5) Listing first names, last names and sex for employees whose first name is "Hercules" and last name begins with "B"
SELECT e.first_name, e.last_name, e.sex  
FROM employees AS e 
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';


--(6) Listing all employees in the Sales departments by employee number, last name, first name and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name  
FROM employees e 
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_no = 'd007'; 


--(7) Listing all employees in the Sales and Development departments by employee number, last name, first name and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name  
FROM employees e 
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no)
WHERE d.dept_no IN ('d007', 'd005'); 


--(8) Listing all the frequency count of employee sharing same last names.
SELECT e.last_name, COUNT(e.last_name) AS "Employees With Unique Last Names Count" 
FROM employees e 
GROUP BY e.last_name 
ORDER BY "Employees With Unique Last Names Count" DESC;
