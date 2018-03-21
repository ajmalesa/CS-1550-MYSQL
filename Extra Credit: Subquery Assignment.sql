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
-- Results in no results because all branches have at least one paperback book
-- This can be tested by changing the end of line 83 to = 'Y'
select BRANCH_NAME
from BRANCH b
where b.BRANCH_NAME not in 
(
	select BRANCH_NAME
	from 
		BRANCH b1
		join INVENTORY i 
		on b1.BRANCH_NUM = i.BRANCH_NUM
		join BOOK bo 
		on i.BOOK_CODE = bo.BOOK_CODE
	where 
		bo.PAPERBACK = 'N'
);
 
-- Question 2 
select A2.AUTHOR_FIRST, A2.AUTHOR_LAST
from AUTHOR A2
	join WROTE W2
	on W2.AUTHOR_NUM = A2.AUTHOR_NUM
where W2.BOOK_CODE in 
(
	select B.BOOK_CODE
	from 
		INVENTORY I
		join BOOK B
		on I.BOOK_CODE = B.BOOK_CODE
		join WROTE W
		on B.BOOK_CODE = W.BOOK_CODE
		join AUTHOR A
		on W.AUTHOR_NUM = A.AUTHOR_NUM
	where 
		(AUTHOR_FIRST = 'TRUDDI' or AUTHOR_FIRST = 'SEAMUS')
	group by BOOK_CODE
	order by sum(ON_HAND)
)
limit 1;

-- Question 3
SELECT TITLE, CITY, COUNT(TITLE)
FROM 
	BOOK B
    JOIN PUBLISHER P
    ON B.PUBLISHER_CODE = P.PUBLISHER_CODE
    JOIN WROTE W
    ON B.BOOK_CODE = W.BOOK_CODE
WHERE 
	CITY != 'NEW YORK' 
GROUP BY TITLE, CITY
HAVING COUNT(TITLE) >= 2
;

-- Alexamara Marina
-- Question 1
SELECT O2.FIRST_NAME, O2.LAST_NAME
FROM OWNER O2
WHERE O2.OWNER_NUM IN 
(
	SELECT O.OWNER_NUM
	FROM
		OWNER O
		JOIN MARINA_SLIP MS
		ON O.OWNER_NUM = MS.OWNER_NUM
		JOIN SERVICE_REQUEST SR
		ON MS.SLIP_ID = SR.SLIP_ID
	WHERE 
		SR.STATUS = 'OPEN'
	GROUP BY FIRST_NAME, LAST_NAME
);

-- Question 2
SELECT BOAT_NAME 
FROM MARINA_SLIP MS2
WHERE MS2.BOAT_NAME IN
(
	SELECT BOAT_NAME 
	FROM 
		MARINA_SLIP MS
		JOIN SERVICE_REQUEST SR
		ON MS.SLIP_ID = SR.SLIP_ID
		JOIN SERVICE_CATEGORY SC
		ON SR.CATEGORY_NUM = SC.CATEGORY_NUM
	WHERE 
		SC.CATEGORY_DESCRIPTION = 'Engine repair'
);


-- Question 5
SELECT OWNER_NUM
FROM MARINA_SLIP MS
GROUP BY OWNER_NUM
ORDER BY SUM(RENTAL_FEE) DESC
LIMIT 1;

SELECT FIRST_NAME, LAST_NAME
FROM 
	OWNER O 
	JOIN MARINA_SLIP MS2
    ON O.OWNER_NUM = MS2.OWNER_NUM
WHERE MS2.OWNER_NUM IN 
(
	SELECT OWNER_NUM
	FROM MARINA_SLIP MS
	GROUP BY OWNER_NUM
	ORDER BY SUM(RENTAL_FEE) DESC
)
LIMIT 1;


