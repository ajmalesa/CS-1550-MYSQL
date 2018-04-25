-- Ajmal Esa
-- Question 1
insert into medialibrary.album (albumtitle, genre, year, label, mediatype, artistid) 
values ("This is my Album Title", "Polka", "2000", "Only The Goods", "Vinyl", 1); 

-- Question 2
insert into medialibrary.album (albumtitle, genre, year, label, mediatype, artistid)
select 
	concat(a.albumtitle, '1'), 
    concat(a.genre, '1'),
    concat(a.year, '1'),
    concat(a.label, '1'),
    concat(a.mediatype, '1'),
    a.artistid + 1
from
	album a;
    
-- Question 3
update tracks t 
set t.number = 4
where t.title = 'Goofy';

-- Question 7 
select * 
from 
	album a
    join tracks t
    on a.albumid = t.albumid
    join artisttrack artra
    on artra.trackid = t.trackid
    join artist art 
    on artra.artistid = art.artistid
    join tracktags tt
    on t.trackid = tt.trackid
    join tags ta
    on tt.tagid = ta.tagid
    join trackplaylists tp
    on t.trackid = tp.trackid
    join playlists p 
    on tp.playlistid = p.playlistid
where a.albumid = 1;

-- Question 8 
select * 
from 
	album a
    join tracks t
    on a.albumid = t.albumid
    join artisttrack artra
    on artra.trackid = t.trackid
    join artist art 
    on artra.artistid = art.artistid
    join tracktags tt
    on t.trackid = tt.trackid
    join tags ta
    on tt.tagid = ta.tagid
    join trackplaylists tp
    on t.trackid = tp.trackid
    join playlists p 
    on tp.playlistid = p.playlistid
where art.artistid = 5;

-- Question 9 
select a.albumtitle
from 
	album a
    join tracks t
    on a.albumid = t.albumid
    join artisttrack artra
    on artra.trackid = t.trackid
    join artist art 
    on artra.artistid = art.artistid
    join tracktags tt
    on t.trackid = tt.trackid
    join tags ta
    on tt.tagid = ta.tagid
    join trackplaylists tp
    on t.trackid = tp.trackid
    join playlists p 
    on tp.playlistid = p.playlistid
where 
	ta.tagid = 10
group by a.albumtitle;

-- Question 10
select t.title
from 
	tracks t
	join trackplaylists tp 
    on t.trackid = tp.trackid
    join playlists p
    on tp.playlistid = p.playlistid
where 
	p.playlist = 'anotherlist';
    
-- (BONUS) Question 11
select a.artistname, count(t.trackid) 
from 
	tracks t
    join artisttrack artt
    on t.trackid = artt.trackid
    join artist a 
    on artt.artistid = a.artistid
group by a.artistname;

-- (BONUS) Question 12
select a.artistname, al.albumtitle, t.title, co.trackcount
from (select a.artistname, count(t.trackid) as trackcount
	from 
		tracks t
		join artisttrack artt
		on t.trackid = artt.trackid
		join artist a 
		on artt.artistid = a.artistid
		group by a.artistname
) as co 
join artist a 
on co.artistname = a.artistname
join album al 
on a.artistid = al.artistid
join tracks t 
on al.albumid = t.albumid;

