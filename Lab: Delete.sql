DROP DATABASE IF EXISTS labDeletes;

create database labDeletes;

create table labDeletes.testingDeletes AS
(  
	SELECT o.*, od.orderLineNumber, od.priceEach, od.productCode,od.quantityOrdered  
    FROM    classicmodels.orders o    
    JOIN 
		classicmodels.orderdetails od      
		ON o.orderNumber = od.orderNumber);
        
-- Question 1
delete  
from labDeletes.testingDeletes
where 
	status not in ('Shipped', 'On Hold', 'Resolved', 'In Process');
    

-- Question 2
delete 
from testingDeletes
where
	customerNumber in 
    (
		select c.customerNumber
        from classicmodels.customers c
        where 
			instr(c.customerName, 'Co') > 0
    );
    

-- Question 3
delete
from l3abDeletes.testingDeletes
where 
	testingDeletes.productCode in 
	(
		select p.productCode
        from classicmodels.products p
        where
			p.buyPrice > (MSRP - 100.00)
    )
    ;
