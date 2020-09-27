import psycopg2


def select_artist_id(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute('SELECT id FROM artist;')
        return [artist_id[0] for artist_id in cur.fetchall()]


def select_album_id(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute('SELECT id FROM album;')
        return [album_id[0] for album_id in cur.fetchall()]


def select_song_id(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute('SELECT id FROM song;')
        return [song_id[0] for song_id in cur.fetchall()]


def select_collection_id(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute('SELECT id FROM collection;')
        return [collection_id[0] for collection_id in cur.fetchall()]


def select_date_albums(con: str, year: int) -> None:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT name, release_year FROM album
            WHERE release_year = %s;
            """, (year,))
        return cur.fetchall()


def order_by_duration_song(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """ 
            SELECT name, duration FROM song
            ORDER BY duration DESC
            """
        )
        song_list = cur.fetchall()
    max_duration = max(song_list, key=lambda duration: duration[1])[1]
    return [song for song in song_list if song[1] == max_duration]


def get_song_name(con: str, duration: float) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """ 
            SELECT name FROM song
            WHERE duration >= %s;
            """, (duration,))
        return cur.fetchall()


def select_collection_by_year(con: str, begin_year: int, end_year: int) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """ 
            SELECT name FROM collection
            WHERE release_year BETWEEN %(begin_year)s AND %(end_year)s;
            """, {'begin_year': begin_year, 'end_year': end_year})
        return cur.fetchall()


def select_artist_by_name_one_word(con: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """ 
            SELECT name FROM artist;
            
            """)
        artist_list = cur.fetchall()
        return [artist[0] for artist in artist_list if len(artist[0].split(' ')) == 1]


def find_text(con: str, text: str) -> list:
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """ 
            SELECT name FROM song
            WHERE name LIKE %s ESCAPE '';
            """, (text,))
        return cur.fetchall()



