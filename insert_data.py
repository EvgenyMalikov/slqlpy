import psycopg2
from random import randint, uniform

from select_query import select_album_id


def insert_genre(con: str, *args):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for genre in args:
            cur.execute("INSERT INTO genre (name) VALUES (%s);", (genre,))


def insert_artist(con: str, *args):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for artist in args:
            cur.execute("INSERT INTO artist (name) VALUES (%s);", (artist,))


def insert_artist_genre(con: str, couple: set):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for item in couple:
            cur.execute('INSERT INTO artist_genre (artist_id, genre_id) VALUES (%s, %s);', (item[0], item[1]))


def insert_albums(con: str, album_list: list):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for album in album_list:
            cur.execute('INSERT INTO album (name, release_year) VALUES (%s, %s);',
                        (album, randint(2015, 2020)))


def insert_artist_album(con: str, couple: set):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for item in couple:
            cur.execute('INSERT INTO artist_album (artist_id, album_id) VALUES (%s, %s);', (item[0], item[1]))


def insert_song(con: str, list_song: list,):
    len_album_list = len(select_album_id(con))
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for song in list_song:
            cur.execute('INSERT INTO song (name, duration, album_id) VALUES (%(name)s, %(duration)s, %(album_id)s)',
                        {'name': song, 'duration': round(uniform(2, 4), 1), 'album_id': randint(1, len_album_list)})


def insert_collection(con: str, collection_list: list):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for collection in collection_list:
            cur.execute('INSERT INTO collection (name, release_year) VALUES (%s, %s);',
                        (collection, randint(2015, 2020)))


def insert_song_collection(con: str, couple: set):
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        for item in couple:
            cur.execute('INSERT INTO song_collection (song_id, collection_id) VALUES (%s, %s);', (item[0], item[1]))

