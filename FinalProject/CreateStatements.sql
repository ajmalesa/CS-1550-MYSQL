drop database if exists FinalProject;
create database if not exists FinalProject;
use FinalProject;

create table FinalProject.Artist 
(
	ArtistID int primary key not null auto_increment,
    Artist varchar(45)
);

create table FinalProject.TrackArtist
(
	TrackID int not null,
    ArtistSequence int,
    ArtistID int 
);

create table FinalProject.Track
(
	TrackID int primary key not null auto_increment,
    TrackTitle varchar(45),
    TrackNumber int,
    AlbumID varchar(45)
);

create table FinalProject.Playlist
(
	PlaylistID int primary key not null auto_increment,
    Playlists varchar(45)
);

create table FinalProject.PlaylistTrack
(
	PlaylistID int not null,
    TrackID int not null
);

create table FinalProject.TrackTag 
(
	TrackID int not null,
    TagID int not null
);

create table FinalProject.Tag
(
	TagID int primary key not null auto_increment,
    TrackTag varchar(45)
);

create table FinalProject.Album
(
	AlbumID int primary key not null auto_increment,
    AlbumTitle varchar(45),
    MediaType varchar(45),
    AlbumGenre varchar(45),
    AlbumYear year,
    ProductionID int
);

create table FinalProject.Production
(
	ProductionID int primary key not null auto_increment,
    ProductionLabel varchar(45)
);