-- Ajmal Esa
-- Question 1
select dept_name, avg(s.salary)
from 
	departments d
    join dept_emp de
    on d.dept_no = de.dept_no
    join employees e 
    on de.emp_no = e.emp_no
    join (
		select
			salary, emp_no
		from 
			salaries s
		where 
			to_date=(select MAX(to_date) from salaries)
	)  as s
    on e.emp_no = s.emp_no
group by dept_name
order by dept_name;

-- Question 2
select d.dept_name 
from 
	departments d
    join 
    (
		select d2.dept_name, d2.dept_no
		from 
			departments d2
            join dept_emp de
            on d2.dept_no = de.dept_no
            join employees e
            on de.emp_no = e.emp_no
		where e.first_name = 'Rosita'
		and e.last_name = 'Merle'
	) as a
    on d.dept_no = a.dept_no;


-- Question 3 (Challenge Attempt)
select e.first_name, e.last_name, 
	(
		select hire_date h1
	)CurrentDepartmentStartDate,
    (
		select from_date f
        where CurrentDepartmentStartDate > t.to_date 
	)PriorDepartmentStartDate,
    (
		select timestampdiff(DAY, PriorDepartmentStartDate, CurrentDepartmentStartDate)
	) TimeInPriorDepartment
from employees e
join titles t
on e.emp_no = t.emp_no;