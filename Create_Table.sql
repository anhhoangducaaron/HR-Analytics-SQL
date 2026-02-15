-- Creating a new Table for Departments

CREATE TABLE departments(
	department_id SERIAL PRIMARY KEY,
	department_name VARCHAR(50) UNIQUE NOT NULL,
	department_email VARCHAR(70) UNIQUE NOT NULL
);


-- Creating a new Table for Jobs

CREATE TABLE jobs(
	job_id SERIAL PRIMARY KEY,
	job_title VARCHAR(50) UNIQUE NOT NULL,
	min_salary INT NOT NULL CHECK(min_salary > 0 AND min_salary < max_salary),
	max_salary INT NOT NULL CHECK(max_salary > min_salary),
	department_id INT REFERENCES departments (department_id)
);


-- Creating a New Table for Employees

CREATE TABLE employees (
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender CHAR(1) CHECK(gender IN ('M' , 'F' , 'O')) NOT NULL,
	date_of_birth DATE NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	phone_no VARCHAR(15) UNIQUE NOT NULL,
	hire_date DATE CHECK (hire_date > date_of_birth) NOT NULL,
	department_id SMALLINT REFERENCES departments (department_id),
	job_id SMALLINT REFERENCES jobs (job_id),
	salary INT NOT NULL,
	manager_id SMALLINT ,
	status VARCHAR(10) CHECK(status IN ( 'active' , 'on leave' , 'retired' )) NOT NULL
);


-- Creating a new Table for Attendance

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    employee_id SMALLINT REFERENCES employees(employee_id),
    month VARCHAR(10) NOT NULL,
    total_days SMALLINT NOT NULL,
    present_days SMALLINT NOT NULL,
    absent_days SMALLINT NOT NULL,
    leave_days SMALLINT NOT NULL,
    late_days SMALLINT NOT NULL
);


-- Creating a new Table for Payroll

CREATE TABLE payroll (
	payroll_id SERIAL PRIMARY KEY,
	employee_id SMALLINT REFERENCES employees (employee_id),
	salary INT NOT NULL,
	bonus INT CHECK ( bonus >= 0 ),
	net_salary INT ,
	payment_date DATE NOT NULL,
	payment_status VARCHAR(10) CHECK( payment_status IN ( 'Paid' , 'Pending' )) NOT NULL
)