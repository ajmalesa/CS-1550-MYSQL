select *
from
(
select emp_no
from 
	employees.employees
where 
	first_name = 'Leon'
    and extract(month from hire_date)= '1'
    ) a
    join employees.dept_manager dm
    on a.emp_no = dm.emp_no
;


-- Get the average salary using subquery in the select clause
select e.*,
	(
	select 
		avg(salary)
	from 
		employees.salaries
	where 
		emp_no = e.emp_no
    group by emp_no
    ) as AverageSalary
from 
	employees.employees e;
    
    
-- Get the average salary using subquery in the select clause
select *
from 
	employees.employees e
    join 
    (
	select 
		emp_no,
		avg(salary)
	from 
		employees.salaries
    group by emp_no
    ) as AverageSalary
	on AverageSalary.emp_no = e.emp_no
    ;