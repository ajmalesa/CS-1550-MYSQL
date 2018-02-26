-- Show a list of employees and what department they are insert
-- Colulmns: Employee Name, Department Name

select first_name, last_name, dept_name
from 
	departments d
    join dept_emp de
    on d.dept_no = de.dept_no
    join employees e
    on de.emp_no = e.emp_no;
    
-- Show employee name with all titles and all salaries
-- Columns: Employee Name, Title, Salary

select first_name, last_name, title, salary
from
	employees e 
    join titles t
    on e.emp_no = t.emp_no
    join salaries s
    on s.emp_no = e.emp_no;
    
-- Show who all the department managers were/are for each department
-- Columns: Manager's Employee Name, Department Name
select first_name, last_name, dept_name
from
	dept_manager dm
    join employees e
    on dm.emp_no = e.emp_no
    join departments d
    on dm.dept_no = d.dept_no;
    
-- Show the current salary for employees over 60
-- Columns: Employee Name, Salary
select first_name, last_name, concat('$', format(salary, 2)) as salary
from 
	employees e
    join salaries s
    on e.emp_no = s.emp_no
where
	timestampdiff(year, birth_date, curdate()) > 60
    and to_date=(select MAX(to_date) from salaries);

-- Show the employees who have a salary over 90k
-- Columns: Employee Name, Salary
select first_name, last_name, concat('$', format(salary, 2)) as salary
from 
	employees e 
    join salaries s
    on e.emp_no = s.emp_no
where 
	salary > 90000
    and to_date=(select MAX(to_date) from salaries);
    
-- Show the current salary, title, and department for Olivera Baek
-- Columns: Salary, Title, Department Name
select concat('$', format(salary, 2)) as salary, title, dept_name
from 
	employees e
    join salaries s 
    on e.emp_no = s.emp_no
    join titles t
    on e.emp_no = t.emp_no
    join dept_emp de
    on e.emp_no = de.emp_no
    join departments d
    on de.dept_no = d.dept_no
where
	first_name = 'Olivera' and 
    last_name = 'Baek' and
	s.to_date=(select MAX(to_date) from salaries)
    ;