-- use PREMIERE;
-- Question 1
drop procedure if exists PREMIERE.addNewCustomer;
delimiter \\
create procedure addNewCustomer (in cName char(35), in str char(15), in ct char(15), in sta char(2), in z char(5), in bal decimal(8,2), in cl decimal(8,2), in rfn char(15), in rln char(15))
begin
	declare newCustomerNumber char(3);
    declare rNumber char(2);
    -- declare ccName char(35); 
    -- set ccName = cName;
    
	# Check if customer does not exist
	if not exists 
		(
        select *
		from PREMIERE.CUSTOMER 
        WHERE CUSTOMER_NAME = cName
        )
	then
		set newCustomerNumber = (select max(CUSTOMER_NUM) + 1 from PREMIERE.CUSTOMER);
		set rNumber = (select REP_NUM from PREMIERE.REP WHERE FIRST_NAME = rfn and LAST_NAME = rln);
    
		insert into PREMIERE.CUSTOMER (CUSTOMER_NUM, CUSTOMER_NAME, STREET, CITY, STATE, ZIP, BALANCE, CREDIT_LIMIT, REP_NUM)
        values (newCustomerNumber, cName, str, ct, sta, z, bal, cl, rNumber);
			
	end if;

end\\

delimiter ;

-- Testing Question 1
call PREMIERE.addNewCustomer('AJ fft', 'Wall St.', 'Draper', 'UT', '84110', 212401.24, 54654.54, 'Valerie', 'Kaiser');
select * from PREMIERE.CUSTOMER;



-- Question 2
drop procedure if exists PREMIERE.RETRIEVE_ORDER_NUM;
delimiter \\
create procedure PREMIERE.RETRIEVE_ORDER_NUM(in part_desc char(15)) 
begin
	select ORDER_NUM
    from 
		ORDER_LINE OL
		join PART P 
        ON OL.PART_NUM = P.PART_NUM
	where P.DESCRIPTION = part_desc;
    
end\\

delimiter ;

call PREMIERE.RETRIEVE_ORDER_NUM('Iron');

