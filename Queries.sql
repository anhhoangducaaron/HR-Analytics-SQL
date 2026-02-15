-- 1. Retrieve all employee's details.

SELECT * FROM employees



-- 2. Get all job titles and their corresponding job IDs.

SELECT job_title , job_id FROM jobs



-- 3. Show the total number of employees.

SELECT COUNT(employee_id) FROM employees



--  4. List all unique department names.

SELECT DISTINCT department_name FROM departments



-- 5. Retrieve employees hired after 2020-01-01.

SELECT employee_id , first_name , last_name , hire_date FROM employees
WHERE hire_date > '2020-01-01' ORDER BY hire_date



-- 6. List employees from the IT & Support (Department ID not mentioned).

SELECT employee_id , first_name , last_name , departments.department_id
FROM employees LEFT OUTER JOIN departments
ON employees.department_id = departments.department_id
WHERE department_name = 'IT & Support'



-- 7. Show top 5 highest-paid employees.

SELECT employee_id , first_name , last_name , salary 
FROM employees ORDER BY salary DESC
LIMIT 5



-- 8. Retrieve employees whose name starts with 'A'.

SELECT employee_id , first_name , last_name FROM employees
WHERE first_name LIKE 'A%'



-- 9. List all employees hired in 2019.

SELECT employee_id , first_name , last_name , hire_date FROM employees 
WHERE EXTRACT(YEAR FROM hire_date) = 2019;



-- 10. Find employees with a salary between 50,000 and 100,000.
SELECT employee_id , first_name , last_name , salary FROM employees
WHERE salary BETWEEN 50000 AND 100000



-- 11. Find the average salary of all employees per month over the year (variations in salaries due to bonus).

SELECT employee_id , salary,  ROUND(AVG (net_salary), 2) 
AS average FROM payroll
GROUP BY employee_id , salary



-- 12. Count how many employees belong to each department.

SELECT department_id , COUNT(employee_id) 
AS employee_count FROM employees
GROUP BY department_id



-- 13. Get the highest and lowest salary in the company.

SELECT 
	MAX(salary) AS highest_salary,
	MIN(salary) AS lowest_salary
FROM employees



-- 14. Count the number of employees per job title.

SELECT job_title , COUNT(employee_id) FROM jobs
FULL OUTER JOIN employees ON employees.job_id = jobs.job_id
GROUP BY job_title



-- 15. Find the total salary expense for the company.

SELECT SUM(net_salary) AS total_salary_expense_2024
FROM payroll



-- 16. Retrieve employee names along with their department names.

SELECT employee_id , first_name , last_name , department_name
FROM employees INNER JOIN departments
ON employees.department_id = departments.department_id



-- 17. Show employees along with their job title and salary.

SELECT first_name , last_name , job_title , salary
FROM employees LEFT OUTER JOIN jobs
ON employees.job_id = jobs.job_id



-- 18. Find employees who haven't received a bonus throughout the year.

--SELECT employees.employee_id , first_name , last_name , SUM(bonus) 
--FROM employees INNER JOIN payroll
--ON employees.employee_id = payroll.employee_id
--GROUP BY employees.employee_id , first_name , last_name
--HAVING SUM(bonus) = 0


-- In my table all the 99 employees are getting bonus atleast once in a month

SELECT COUNT (DISTINCT (employee_id)) FROM payroll
WHERE bonus != 0 



-- 19. Show the month-wise count of employees hired.

SELECT DISTINCT (EXTRACT(MONTH FROM hire_date)) AS month_number , COUNT(employee_id) AS no_of_emloyees_hired
FROM employees GROUP BY month_number
ORDER BY (EXTRACT(MONTH FROM hire_date))



-- 20. Find the average number of absent days per employee.

SELECT employees.employee_id , first_name , last_name , ROUND (AVG(absent_days),0) AS averge_absent_days
FROM employees INNER JOIN attendance
ON employees.employee_id = attendance.employee_id
GROUP BY employees.employee_id , first_name , last_name



-- 21. Find departments with an average salary above 80,000.

SELECT departments.department_id , department_name , ROUND(AVG(salary),2) AS average_salary
FROM departments INNER JOIN employees
ON departments.department_id = employees.department_id
GROUP BY departments.department_id , department_name
HAVING AVG(salary) > 80000



-- 22. Find the top 3 departments with the highest total salary expense.

SELECT employees.department_id , department_name , SUM (net_salary) AS salary_expenses
FROM departments 
INNER JOIN employees ON departments.department_id = employees.department_id
INNER JOIN payroll ON employees.employee_id = payroll.employee_id
GROUP BY employees.department_id , department_name 
ORDER BY salary_expenses DESC LIMIT 3



-- 23. Retrieve the employee with the highest salary in each department .

SELECT e.employee_id, e.first_name, e.last_name, e.department_id, e.salary
FROM employees e
WHERE salary = 
(
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
)




-- 24. Find employees who earned more than 1,000,000 in total salary (including bonus) in the last year.

SELECT employees.employee_id , first_name , last_name , SUM(net_salary) AS annual_income
FROM employees INNER JOIN payroll
ON employees.employee_id = payroll.employee_id
GROUP BY  employees.employee_id , first_name , last_name
HAVING SUM (net_salary) > 1000000 



-- 25. Find the department with the most employees

SELECT departments.department_id , department_name , COUNT(employee_id) AS no_of_employees
FROM departments INNER JOIN employees
ON departments.department_id = employees.department_id
GROUP BY departments.department_id , department_name
ORDER BY COUNT (employee_id) DESC LIMIT 1



-- 26. Calculate the attendance percentage for each employee for each month.

SELECT attendance.employee_id, employees.first_name, employees.last_name, 
       attendance.month, 
       (attendance.present_days * 100.0 / attendance.total_days) AS attendance_percentage
FROM attendance
JOIN employees ON attendance.employee_id = employees.employee_id
ORDER BY attendance.employee_id, attendance.month;



-- 27. Get employees who have been working the longest.

SELECT employees.employee_id, employees.first_name, employees.last_name, 
       employees.department_id, employees.hire_date
FROM employees
WHERE employees.hire_date = (SELECT MIN(employees.hire_date) FROM employees);



-- 28. List departments that have more than 5 employees earning a net salary greater than 80,000.
-- In my table every department satisfies this contition

SELECT departments.department_name, COUNT(employees.employee_id) AS high_earning_employees
FROM employees
JOIN payroll ON employees.employee_id = payroll.employee_id
JOIN departments ON employees.department_id = departments.department_id
WHERE payroll.net_salary > 80000
GROUP BY departments.department_name
HAVING COUNT(employees.employee_id) > 5;



-- 29. Retrieve the employee with the highest total absence days in the attendance table.

SELECT employees.employee_id, employees.first_name, employees.last_name, SUM(attendance.absent_days) AS total_absences
FROM employees
JOIN attendance ON employees.employee_id = attendance.employee_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name
ORDER BY total_absences DESC LIMIT 1




-- 30. List employees who haven't had a salary change for 3+ months consecutively.

SELECT payroll.employee_id, employees.first_name, employees.last_name, COUNT(*) 
AS consecutive_months, payroll.net_salary FROM payroll
JOIN employees ON payroll.employee_id = employees.employee_id
GROUP BY payroll.employee_id, employees.first_name, employees.last_name, payroll.net_salary
HAVING COUNT(*) > 3 ORDER BY employee_id
