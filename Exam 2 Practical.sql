-- Multiple Table Queries
select 
	customerName as 'Customer Name', concat(FirstName, ' ', LastName) as 'Full Name Of Sales Rep'
from
	offices o 
    join employees e 
    on o.officeCode = e.officeCode
    join customers c
    on e.employeeNumber = c.salesRepEmployeeNumber
where 
	o.territory = 'NA';
    
-- Group by
select 
	textDescription as 'Text Description',
    concat('$', format(sum(quantityOrdered * priceEach), 2)) as 'Item Total Average'
from
	orderdetails od
    join products p
    on od.productCode = p.productCode
    join productlines pl
    on p.productLine = pl.productLine
group by 
	p.ProductLine;
    
-- Having
select 
	customerName as 'Customer Name',
    count(orderNumber) as 'Number Of Orders'
from 
	customers c
    join orders o
    on c.customerNumber = o.customerNumber
group by
	customerName
having 
	count(orderNumber) >= 5
order by count(orderNumber) desc;

-- Sub Query
select 
	customerName as 'Customer Name'
from 
	customers c1
    join orders o 
    on c1.customerNumber = o.customerNumber
    join orderdetails od
    on o.orderNumber = od.orderNumber
    join products p 
    on od.productCode = p.productCode
where 
	p.productLine in 
    (
	select 
		productLine
	from 
		products p2 
	where 
		(MSRP - buyPrice) > 100
    )
group by 
	customerName
;
    


