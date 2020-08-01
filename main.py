from psycopg2 import connect

with connect('dbname=netology user=postgres host=localhost port=5432') as conn:
    with conn.cursor() as cur:
        cur.execute(
            """
            create table if not exists Genre(
                name varchar(20) primary key 
            )
            """
        )

        cur.execute(
            """
            create table if not exists Artist (
                id serial primary key,
                name varchar(50) not null,
                genre_name varchar(20) references Genre(name)
            )
            """
        )

        cur.execute(
            """
            create table if not exists Album(
                id serial primary key,
                name varchar(100) not null,
                release_date date not null ,
                artist_id integer references Artist(id)               
            )
            """
        )

        cur.execute(
            """
            create table if not exists Song(
                id serial primary key,
                name varchar(100) not null,
                duraction integer not null check ( duraction > 0 ),
                album_id integer references Album(id)
            )
            """
        )