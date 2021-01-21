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
