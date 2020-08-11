from psycopg2 import connect

def create_music_db():
    with connect('dbname=netology user=postgres host=localhost port=5432') as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Genre(
                    name VARCHAR(20) PRIMARY KEY
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Artist (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(50) NOT NULL
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS ArtistGenre(
                    artist_id INTEGER REFERENCES Artist(id),
                    genre_id VARCHAR(20) REFERENCES Genre(name),
                    CONSTRAINT pk_artist_genre PRIMARY KEY (artist_id, genre_id)
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Album(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    release_date DATE
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS ArtistAlbum(
                    artist_id INTEGER REFERENCES Artist(id),
                    album_id INTEGER REFERENCES Album(id),
                    CONSTRAINT pk_artist_album PRIMARY KEY (artist_id, album_id)
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Song(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    duraction INTEGER NOT NULL CHECK ( duraction > 0 ),
                    album_id INTEGER REFERENCES Album(id)
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Collection(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    release_date DATE
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS SongCollection(
                    song_id INTEGER REFERENCES Song(id),
                    collection_id INTEGER REFERENCES Collection(id),
                    CONSTRAINT pk_song_collection PRIMARY KEY (song_id, collection_id)
                )
                """
            )

def creat_employee_db():
    with connect('dbname=netologydb user=postgres host=localhost port=5432') as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Department(
                    name VARCHAR(20) PRIMARY KEY 
                )
                """
            )

            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Employee(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(50),
                    boss_id INTEGER REFERENCES Employee(id),
                    department_name VARCHAR(20) REFERENCES Department(name)
                    
                )
                """
            )


if __name__ == '__main__':
    # create_music_db()
    creat_employee_db()