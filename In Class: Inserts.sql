drop table if exists InsertTest.OrderData;
-- Create the table structure
-- Non-null Columns cannot be skipped over in insert statement
create table OrderData 
(
	OrderDataID int AUTO_INCREMENT PRIMARY KEY,
	CustomerName Varchar(40),
    OrderID int,
    OrderDate date,
    ProductName Varchar(40)
);

-- Insert data into the table
insert into InsertTest.OrderData (CustomerName, OrderID, OrderDate, ProductName)
select c.CompanyName, o.OrderID, OrderDate, ProductName 
from
	northwind.Customers c
    join northwind.Orders o
    on c.CustomerID = o.CustomerID
    join northwind.OrderDetails od
    on o.OrderID = od.OrderID
    join northwind.Products p
    on od.ProductID = p.ProductID;
    
-- Show the data for testing    
select * from InsertTest.OrderData;