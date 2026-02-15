-- Populating departments table 

ALTER SEQUENCE public.departments_department_id_seq RESTART WITH 101;
INSERT INTO departments (
	department_name ,
	department_email
)
VALUES
	('Human Resources' , 'hrdept@gmail.com'),
	('Finance' , 'financedept@gmail.com'),
	('IT & Support' , 'itdept@gmail.com'),
	('Sales & Marketing' , 'salesnmarketdept@gmail.com'),
	('Administrations' , 'admindept@gmail.com'),
	('Research & Development' , 'rnddept@gmail.com'),
	('Customer Service' , 'custservdept@gmail.com'),
	('Manufacturing & Production' , 'productiondept@gmail.com');


-- Populating jobs table

INSERT INTO jobs (job_title, min_salary , max_salary , department_id)
VALUES 
('HR Manager',60000,120000, 101),
('Recruiter',35000,60000, 101),
('Payroll Specialist',40000,75000, 101),
('Training Officer',38000,70000, 101),
('HR Assistant',30000,50000, 101),
('Finance Manager',80000,150000, 102),
('Accountant',45000,90000, 102),
('Auditor',50000,100000, 102),
('Financial Analyst',55000,110000, 102),
('Tax Consultant',50000,95000, 102),
('IT Manager',90000,180000, 103),
('Software Engineer',60000,120000, 103),
('System Admin',50000,90000, 103),
('Database Admin',55000,100000, 103),
('Technical Support',35000,65000, 103),
('Sales Executive',40000,90000, 104),
('Marketing Manager',70000,140000, 104),
('Business Analyst',55000,110000, 104),
('SEO Specialist',45000,85000, 104),
('Content Strategist',40000,80000, 104),
('Admin Manager',60000,110000, 105),
('Office Coordinator',35000,65000, 105),
('Receptionist',25000,45000, 105),
('Facilities Supervisor',40000,75000, 105),
('Document Controller',30000,60000, 105),
('R&D Manager',90000,160000, 106),
('Research Analyst',55000,105000, 106),
('Data Scientist',70000,140000, 106),
('Product Designer',60000,120000, 106),
('Innovation Strategist',65000,130000, 106),
('Customer Support Executive',30000,55000, 107),
('Call Center Agent',25000,45000, 107),
('Support Supervisor',40000,70000, 107),
('Client Relationship Manager',50000,90000, 107),
('Quality Analyst',45000,85000, 107),
('Production Manager',80000,150000, 108),
('Quality Engineer',50000,150000, 108),
('Safety Officer',45000,85000,108),
('Line Supervisor',40000,75000, 108),
('Machine Operator',30000,55000, 108);


-- For other tables import the respective .csv files

-- Load employees_table data
COPY employees(employee_id, first_name, last_name, gender, date_of_birth, email, phone_no, hire_date, department_id, job_id, salary, manager_id, status)
FROM '/path_to/employees.csv'
DELIMITER ','
CSV HEADER;

-- Load attendance_table data
COPY attendance(attendance_id, employee_id, month, total_days, present_days, absent_days, leave_days, late_days)
FROM '/path_to/attendance.csv'
DELIMITER ','
CSV HEADER;

-- Load payroll_table data
COPY payroll(payroll_id, employee_id, salary, bonus, net_salary, payment_date, payment_status)
FROM '/path_to/payroll.csv'
DELIMITER ','
CSV HEADER;

-- If error with copy command check you file path twice or use pgadmin's import feature to import all 5 tables with their corresponding csv files
-- remember to turn on header if import feature is used
-- Import order department > jobs > employees > attendance > payroll
