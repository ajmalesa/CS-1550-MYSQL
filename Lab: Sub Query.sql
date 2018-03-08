-- Question 1
select emp_no, birth_date, first_name, last_name, gender, hire_date
from employees e
where emp_no in 
	(
	select emp_no
    from dept_emp de
    group by emp_no
    having count(de.dept_no) >= 2
    );
    
-- Question 2
select e.first_name, e.last_name
from employees.employees e
	join employees.dept_emp de
    on e.emp_no = de.emp_no
where 
	de.dept_no in 
    (
    select dm.dept_no
    from employees.employees e2
    join employees.dept_manager dm
    on e2.emp_no = dm.emp_no
    where e2.first_name = 'Leon' 
	and e2.last_name = 'DasSarma' 
    and dm.to_date = '9999-01-01'
    );
    
-- Question 3 