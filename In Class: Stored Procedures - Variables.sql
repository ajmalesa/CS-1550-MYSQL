delimiter \\
create procedure InsertTest.addEmployee (in bDay date, in fName varchar(14), in lName varchar(14), in gen enum('M', 'F'), in hDay DATE)
begin
	declare newEmpNo int;

	# Check if the Employee Exists Already
    # If Exists - Do Nothing or the update record
    
    if exists (select * from employees.employees where birth_date = 'bDay' and first_name = 'fName' and last_name = 'lName')
	then
        update employees.employees
        set 
			gender = @gen,   	-- @ Symbol not 100% necessary but helps to be more specific that it is a local stored procedure variable
            hire_date = @hDay	-- It would be required if you had the same variable name as the column name
		where
			birth_date = @bDay and
            first_name = @fName and
            last_name = @lName;
			
    # If Not Exists - 
    else
    
		set @newEmpNo = (select max(emp_no) + 1 from employees.employees);
    
		insert into employees.employees (emp_no, birth_date, firest_name, last_name, gender, hire_date)
        values(@newEmpNo, @bDay, @fName, @lName, @gender, @hDay);
        
    end if;
    
end \\
delimiter ;
call inserttest.getEmployee(100001);

DELIMITER $$
CREATE PROCEDURE "getEmployee" ( EmployeeNumber int)
begin
	select * from employees.employees where emp_no = 100001;
end$$

delimiter;