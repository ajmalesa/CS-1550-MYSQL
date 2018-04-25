create table ownercopy select * from ALEXAMARA.OWNER;
create table marina_slipcopy select * from MARINA_SLIP;


update 
	ownercopy o
    join marina_slipcopy ms
    on o.OWNER_NUM = ms.OWNER_NUM
set 
	o.STATE = 'UT',
    RENTAL_FEE = RENTAL_FEE * 1.5
WHERE
	left(LAST_NAME, 1) < 'M';

select * from ownercopy;



