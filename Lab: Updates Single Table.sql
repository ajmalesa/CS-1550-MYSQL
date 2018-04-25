DROP TABLE IF EXISTS EMPLOYEESCOPY;
DROP TABLE IF EXISTS DEPARTMENTCOPY;
DROP TABLE IF EXISTS CATEGORIESCOPY;
CREATE TABLE EMPLOYEESCOPY SELECT * FROM hr.employees;
CREATE TABLE LOCATIONSCOPY SELECT * FROM hr.locations;
CREATE TABLE DEPARTMENTCOPY SELECT * FROM hr.departments;
CREATE TABLE JOBSCOPY SELECT * FROM hr.jobs;
CREATE TABLE CUSTOMERSCOPY SELECT * FROM classicmodels.customers;
CREATE TABLE CATEGORIESCOPY SELECT * FROM northwind.Categories;

-- Question 1
UPDATE EMPLOYEESCOPY E
SET E.last_name = 'Barrett'
WHERE E.first_name = 'Diana' AND E.last_name = 'Lorentz';

select * 
from EMPLOYEESCOPY ;

-- Question 2
UPDATE LOCATIONSCOPY E1
SET 
	E1.STREET_ADDRESS = '3390 Grove Street',
    E1.POSTAL_CODE = '10011',
    E1.CITY = 'New York',
    E1.STATE_PROVINCE = 'NY',
    E1.COUNTRY_ID = 'US'
WHERE 
	E1.LOCATION_ID = 2700;
    
SELECT * FROM LOCATIONSCOPY;

-- Question 3
update DEPARTMENTCOPY D
SET D.MANAGER_ID = 
	(
		SELECT EMPLOYEE_ID 
        FROM hr.employees e
        where e.FIRST_NAME = 'Ki' and e.LAST_NAME = 'Gee'
	)
WHERE D.DEPARTMENT_NAME = 'Shipping';

SELECT * FROM DEPARTMENTCOPY;

-- Question 4
update jobs j
set j.MIN_SALARY = 300000, j.MAX_SALARY = 400000
where j.JOB_TITLE = 'President';

select * from jobs;

-- Question 5
update CUSTOMERSCOPY C
SET C.contactFirstName = 'AJ', C.contactLastName = 'Esa'
where C.customerName = 'Mini Wheels Co.';

select * from CUSTOMERSCOPY;

-- Question 6
update CATEGORIESCOPY CC
SET CC.Description = concat('Slurpees, ', CC.Description)
WHERE CC.CategoryName = 'Beverages';

select * from CATEGORIESCOPY;
