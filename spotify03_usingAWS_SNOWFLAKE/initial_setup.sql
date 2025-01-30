create or replace database spotify;
create or replace schema spotify;

create or replace table tblalbumalbum(
    album_id string,
    album_name string,
    release_date date,
    total_tracks int,
    album_url string
);

create or replace table tblartist(
    artist_id string,
    artist_name string,
    artist_url string
);

create or replace table tblsong(
    song_id string,
    song_name string,
    song_duration_ms int,
    song_url string,
    popularity int,
    added_date date,
    album_id string,
    artist_id string
);



