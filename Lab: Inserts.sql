-- Ajmal Esa
-- Question 1
drop table if exists CurrentEmployeeInfo;
CREATE TABLE CurrentEmployeeInfo
(
	emp_no INT(10) NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR(14) NOT NULL,
	last_name VARCHAR(16) NOT NULL,
	gender ENUM ('M', 'F') NOT NULL,
	hire_date DATE NOT NULL,
	dept_no CHAR(4) NOT NULL,
	salary int not null,
	title varchar(50)
);

insert ignore into employees.CurrentEmployeeInfo (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no, salary, title)
select  e.emp_no, e.birth_date, e.first_name, e.last_name, e.gender, e.hire_date, de.dept_no, s.salary, t.title
from employees e 
	join dept_emp de 
	on e.emp_no = de.emp_no
	join titles t
	on e.emp_no = t.emp_no
	join salaries s
	on e.emp_no = s.emp_no
where
	t.to_date = 
	(
		select max(t1.to_date) 
		from employees e1 
		join dept_emp de1 
		on e1.emp_no = de1.emp_no
		join titles t1
		on e1.emp_no = t1.emp_no
		join salaries s1
		on e1.emp_no = s1.emp_no
        where t1.to_date = '9999-01-01'
        and s1.to_date = '9999-01-01' 
	
	)
-- 	current_date() between s.from_date and s.to_date 
-- 	and s.to_date = '9999-01-01'
;

select * from CurrentEmployeeInfo;


-- Question 2
drop table if exists CurrentDeptManager;
CREATE TABLE CurrentDeptManager
(
	full_name VARCHAR(30) NOT NULL,
	dept_no CHAR(4) NOT NULL
);

insert into CurrentDeptManager (full_name, dept_no)
select concat(first_name, ' ', last_name), dept_no
from dept_manager dm 
join employees e 
on dm.emp_no = e.emp_no
where dm.to_date = 
(
	select max(to_date)
    from dept_manager dm2
);

select * from CurrentDeptManager;