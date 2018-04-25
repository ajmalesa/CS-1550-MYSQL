drop table if exists ORDERSCOPY;
CREATE TABLE ORDERSCOPY SELECT * FROM northwind.Orders;

SELECT * from ORDERSCOPY;

-- Delete Order 10540
delete 
FROM ORDERSCOPY
WHERE OrderID = 10540;

select * from ORDERSCOPY
WHERE OrderID = 10540;