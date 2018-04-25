-- AddArtist Procedure
drop procedure if exists medialibrary.addartist;
delimiter \\
create procedure medialibrary.addartist (aname varchar(50))
begin
	declare newartistid int;
    
    if not exists
    (
		select * 
        from artist
        where artistname = aname
    )
    then
		set newartistid = (select max(artistid) + 1 from medialibrary.artist);
		insert into medialibrary.artist (artistid, artistname) 
        values (newartistid, aname);
        
    end if;
	
end \\
delimiter ;

call medialibrary.addartist('Avicici');
select * from artist;

-- AddAlbum Procedure
drop procedure if exists medialibrary.addalbum; 
delimiter \\
create procedure medialibrary.addalbum (altitle varchar(50), algenre varchar(20), alyear int(11), allabel varchar(30), almediatype varchar(30), aname varchar(50))
begin 
    declare newartistid int;
    
    -- Add the artist if they do not already exist in the artist table
    if not exists 
    (
		select * from artist where artistname = aname 
    )
    then 
		call medialibrary.addartist(aname);
	end if;

	-- Set the newartist id to the one equal tot
	set newartistid = 
	(
		select art.artistid 
		from artist art
		where art.artistname = aname
	);
    
    -- Check if the album does not exist using the album and artist. If the album already exists, we update the album 
    -- If it does not exist, add the album.
    if not exists
    (
		select * 
		from 
			medialibrary.album al
            join artist a 
            on al.artistid = a.artistid
		where 
			al.albumtitle = altitle and
			a.artistname = aname
	)
    then 
		insert into medialibrary.album (albumtitle, genre, year, label, mediatype, artistid)
        values (altitle, algenre, alyear, allabel, almediatype, newartistid);
	else
		update album, artist
        set genre = algenre, year = alyear, label = allabel, mediatype = almediatype
        where album.albumtitle = altitle and artist.artistname = aname;
	end if;
		
        
end \\
delimiter ;

call medialibrary.addalbum('Bars', 'pink Rock', 2017, 'Undergrond Music', 'Vinyl', 'sean');
call medialibrary.addalbum('Baps', 'pink Rock', 2017, 'Undergrond Music', 'CD', 'rhett');
select * from album;

-- addtrack procedure
drop procedure if exists medialibrary.addtrack; 
delimiter \\
create procedure medialibrary.addtrack (ttracktitle varchar(50), ttracknumber int(11), talbumtitle varchar(50), tprimaryartist varchar(50), tfeaturedartist varchar(50))
begin 
	declare newalbumid int;
    declare newartistid int;
    declare newtrackid int;
    declare newfeaturedartistid int;
    
    set newalbumid = (select albumid from album a where a.albumtitle = talbumtitle limit 1);
    
	-- If a featured artist is passed, add them to the artist table if they have not already been added
	if (tfeaturedartist != '')
    then 
		call medialibrary.addartist(tfeaturedartist);
    end if;
    
    -- Add the primary artist to the artist table if they are not already in there
    if not exists ( select * from artist where tprimaryartist = artist.artistname)
    then 
		call medialibrary.addartist(tprimaryartist);
	end if;
    
    -- Check if a track exists. If it does not, add it to the table. Don't add it again if it already exists
    if not exists ( select * from tracks t join album a on t.albumid = a.albumid where t.title = ttracktitle and t.number = ttracknumber and a.albumtitle = talbumtitle)
    then
		insert into medialibrary.tracks (title, number, albumid)
        values (ttracktitle, ttracknumber, newalbumid);
    end if;
    
    -- Check if the track has a relationship to the primary artist int he artisttrack table. If there does not exist one, add it. If it does, do nothing.
    -- These two variables just help us save space on the select statement in the if condition
	set newartistid = (select artistid from artist a where a.artistname = tprimaryartist);
    set newtrackid = (select trackid from tracks t where t.title = ttracktitle);
    if not exists (select * from artisttrack at where at.trackid = newtrackid and at.artistid = newartistid)
		then
		insert into artisttrack 
        values (newartistid, newtrackid, 'y');
	end if;
    
    -- Check if the track has a relationship to the featured artist int he artisttrack table. If there does not exist one, add it. If it does, do nothing.
	set newfeaturedartistid = (select artistid from artist a where a.artistname = tfeaturedartist);
    if not exists (select * from artisttrack at where at.trackid = newtrackid and at.artistid = newartistid)
		then
		insert into artisttrack 
        values (newartistid, newtrackid, 'n');
	end if;
end \\
delimiter ;

call medialibrary.addtrack ('My Own Song', 1, 'emotions', 'AJ', 'CJ');

select * from tracks;
select * from artist;
select * from artisttrack;

-- addplaylist procedure
drop procedure if exists addplaylist;
delimiter \\
create procedure medialibrary.addplaylist (ptrack varchar(50), pplaylist varchar(50))
begin 
	

end \\
delimiter ;

