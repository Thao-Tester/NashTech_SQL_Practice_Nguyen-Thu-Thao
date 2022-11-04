---Exercise 1---
select department_id from employees where last_name ='Zlotkey'

select last_name,hire_date, department_id from employees
where department_id = 80
and last_name <> 'Zlotkey'
--DB
select last_name, hire_date from employees
where department_id in (select department_id from employees where last_name ='Zlotkey')
and last_name <> 'Zlotkey'

---Exercise 2---

select employee_id, last_name, salary from employees where salary > (select  AVG (salary) from employees) order by salary ASC

---Exercise 3---

select employee_id, last_name from employees
where department_id in (select department_id from employees where last_name like'%u%')

---Exercise 4---
---Cách 1---
select last_name, department_id, job_id from employees
where department_id in (select department_id from departments where location_id = 1700)

---Cách 2---
select e.last_name, e.department_id, e.job_id from employees e INNER JOIN departments d on e.department_id = d.department_id
where d.location_id = 1700

---Exercise 5---
---Cách 1---
select last_name, salary from employees where manager_id in 
(select employee_id from employees where last_name = 'King')

---Cách 2---
select e.last_name, e.salary from employees e 
inner join employees manager on e.manager_id = manager.employee_id
where manager.last_name = 'King'

---Exercise 6---
SELECT d.department_id AS 'Department No', e.last_name AS 'Last Name', j.job_id AS 'Job ID'
FROM departments d
	LEFT JOIN employees e ON d.manager_id = e.manager_id
	LEFT JOIN jobs j ON e.job_id = j.job_id
WHERE d.department_name = 'Executive'

---Exercise 7 (Đề bài không rõ ràng?)---
--Nếu ý đề là những nhân viên có lương cao hơn trung bình và những nhân viên làm ở đơn vị có nhân viên có chữ cái 'u' trong họ--
SELECT e.employee_id AS 'Employee No', e.last_name AS 'Last Name', e.salary AS 'Salary'
FROM employees e
	LEFT JOIN departments d ON e.department_id = d.department_id
WHERE (d.department_id IN (SELECT department_id FROM employees WHERE last_name like'%u%')) OR (e.salary > (SELECT  AVG(salary) FROM employees))
ORDER BY e.employee_id

--Nếu ý đề là những nhân viên có lương cao hơn trung bình và làm ở đơn vị có nhân viên có chữ cái 'u' trong họ--
SELECT e.employee_id AS 'Employee No', e.last_name AS 'Last Name', e.salary AS 'Salary'
FROM employees e
	LEFT JOIN departments d ON e.department_id = d.department_id
WHERE (d.department_id IN (SELECT department_id FROM employees WHERE last_name like'%u%')) AND (e.salary > (SELECT  AVG(salary) FROM employees))
ORDER BY e.employee_id


---Exercise 8---
SELECT CAST(ROUND(MAX(e.salary), 0) AS DECIMAL) AS 'Maximum',  CAST(ROUND(MIN(e.salary), 0) AS DECIMAL) AS 'Minimum', CAST(ROUND(SUM(e.salary), 0) AS DECIMAL) AS 'Sum', CAST(ROUND(AVG(e.salary), 0) AS DECIMAL) AS 'Average'
FROM employees e


---Exercise 9---
SELECT UPPER(LEFT(e.last_name, 1)) + LOWER(RIGHT(e.last_name, LEN(e.last_name) - 1)) AS 'Last Name', LEN(e.last_name) AS 'Length'
FROM employees e
WHERE LEFT(e.first_name, 1) IN ('J', 'A', 'M')


---Excercise 10---
SELECT e.employee_id AS 'Employee No', e.last_name AS 'Last Name', e.salary AS 'Current Salary', CAST(ROUND(e.salary*1.155, 0) AS DECIMAL) AS 'New Salary'
FROM employees e


---Excercise 11---
SELECT e.last_name AS 'Last Name', e.department_id AS 'Department ID'
FROM employees e

SELECT d.department_id AS 'Department ID', d.department_name AS 'Department Name'
FROM departments d
UNION
SELECT e.department_id, d.department_name
FROM employees e
	LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL

---Exercise 12 (Đề bài không rõ?)---
--Nếu ý đề là những nhân viên làm sau quản lý và những nhân viên làm ở Toronto--
SELECT DISTINCT e.employee_id AS 'Employee ID'--, e.hire_date, e.manager_id, m.hire_date, l.city
FROM employees e
	LEFT JOIN employees m ON e.manager_id = m.employee_id
	LEFT JOIN departments d ON e.department_id = d.department_id
	LEFT JOIN locations l ON d.location_id = l.location_id
WHERE (e.hire_date > m.hire_date) OR (l.city = 'Toronto')
ORDER BY e.employee_id


--Nếu ý đề là những nhân viên làm sau quản lý và làm ở Toronto--
SELECT DISTINCT e.employee_id AS 'Employee ID'--, e.hire_date, e.manager_id, m.hire_date, l.city
FROM employees e
	LEFT JOIN employees m ON e.manager_id = m.employee_id
	LEFT JOIN departments d ON e.department_id = d.department_id
	LEFT JOIN locations l ON d.location_id = l.location_id
WHERE (e.hire_date > m.hire_date) AND (l.city = 'Toronto')
ORDER BY e.employee_id
