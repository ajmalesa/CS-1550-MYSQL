drop database if exists medialibrary;
create database medialibrary;

use medialibrary;

drop table if exists artist;
create table artist
(
	artistid integer auto_increment not null primary key,
	artistname varchar(50)
);

drop table if exists album;
create table album
(
	albumid integer auto_increment not null primary key,
    albumtitle varchar(50),
    genre varchar(20),
    year integer, 
    label varchar(30),
    mediatype varchar(30),
    artistid integer
);

drop table if exists tracks;
create table tracks
(
	trackid integer auto_increment not null primary key,
    title varchar(50),
    number integer,
    albumid integer
);

drop table if exists tags;
create table tags
(
	tagid integer auto_increment not null primary key,
    tag varchar(30)
);

drop table if exists playlists;
create table playlists
(
	playlistid integer auto_increment not null primary key,
    playlist varchar(50)
);

drop table if exists artisttrack;
create table artisttrack
(
	artistid integer,
    trackid integer,
    isfeatured varchar(1)
);

drop table if exists tracktags;
create table tracktags
(
	trackid integer,
    tagid integer
);

drop table if exists trackplaylists;
create table trackplaylists 
(
	trackid integer,
    playlistsid integer
);