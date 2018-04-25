drop procedure if exists InsertTest.parseList;
delimiter \\
create procedure InsertTest.parseList(IN listy varchar(100))
begin
    declare counter int;
    declare lastValue varchar(100);
    declare priorValue varchar(100);
    set counter = 1;
    
    set priorValue = '';
    set lastValue = trim(substring_index(listy, ',', -1));
    
    drop table if exists InsertTest.tempListValues;
    create table InsertTest.tempListValues(listValues varchar(100));
    
	while lastValue != priorValue
    do 
		# Trime to remove random whitespaces and substring the inside to get up to the counter 
        # and use -1 on the outside substring to only grab the last value
		set priorValue = trim(substring_index(substring_index(listy, ',', counter), ',', -1));
    --  
        insert into InsertTest.tempListValues ( listValues)
        values(priorValue);
        
        set counter = counter + 1;
    end while;
	
    
    select * from InsertTest.tempListValues;

end\\
delimiter ;
call InsertTest.parseList('Soda, Coffee, Hot Chocolate, Hi-C, Beer, Alcohol, Vodka');

