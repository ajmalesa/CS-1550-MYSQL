-- Ajmal Esa
-- Premiere Products
-- Question 1
select CUSTOMER_NAME 
from CUSTOMER C
where 
	C.CUSTOMER_NUM in 
    (	
		select 
			C2.CUSTOMER_NUM
        from 
			CUSTOMER C2
            join ORDERS O 
            on C2.CUSTOMER_NUM = O.CUSTOMER_NUM
            join ORDER_LINE OD 
            on O.ORDER_NUM = OD.ORDER_NUM
			join PART P 
            on OD.PART_NUM = P.PART_NUM
		where 
			P.DESCRIPTION = 'Treadmill' or
			P.DESCRIPTION = 'Cordless Drill'
	);
    
-- Question 2
select CUSTOMER_NAME
from 
	CUSTOMER C 
    join 
    (
		Select C2.CUSTOMER_NUM, MAX(P.PRICE - OD.QUOTED_PRICE)
		from 
			CUSTOMER C2
			join ORDERS O 
			on C2.CUSTOMER_NUM = O.CUSTOMER_NUM
			join ORDER_LINE OD 
			on O.ORDER_NUM = OD.ORDER_NUM
			join PART P 
			on OD.PART_NUM = P.PART_NUM
		group by C2.CUSTOMER_NUM
        order by MAX(P.PRICE - OD.QUOTED_PRICE) DESC
        limit 1
    ) as AllCustomers
    on C.CUSTOMER_NUM = AllCustomers.CUSTOMER_NUM
group by CUSTOMER_NAME
;

-- Question 3  
select FIRST_NAME, LAST_NAME 
from 
	REP
where REP_NUM in 
(
	select REP_NUM
	from 
		CUSTOMER C 
		join ORDERS O 
		on C.CUSTOMER_NUM = O.CUSTOMER_NUM
		join ORDER_LINE OL
		on O.ORDER_NUM = OL.ORDER_NUM
		join PART P 
		on OL.PART_NUM = P.PART_NUM
	where P.CLASS = 'HW'
	group by REP_NUM
	order by MIN(CREDIT_LIMIT - BALANCE)
);

-- Henry Books
-- Question 1
 