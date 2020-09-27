from psycopg2 import connect


def create_music_db(connect_):
    with connect(connect_) as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                
                CREATE TABLE IF NOT EXISTS Genre(
                    name VARCHAR(20) PRIMARY KEY);
                    
                CREATE TABLE IF NOT EXISTS Artist (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(50) NOT NULL);
                
                CREATE TABLE IF NOT EXISTS artist_genre(
                    artist_id INTEGER REFERENCES Artist(id),
                    genre_id VARCHAR(20) REFERENCES Genre(name),
                    CONSTRAINT pk_artist_genre PRIMARY KEY (artist_id, genre_id));
                    
                CREATE TABLE IF NOT EXISTS album(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    release_year YEAR);
                    
                CREATE TABLE IF NOT EXISTS artist_album(
                    artist_id INTEGER REFERENCES Artist(id),
                    album_id INTEGER REFERENCES Album(id),
                    CONSTRAINT pk_artist_album PRIMARY KEY (artist_id, album_id));
                    
                CREATE TABLE IF NOT EXISTS Song(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    duration FLOAT NOT NULL CHECK ( duration > 0 ),
                    album_id INTEGER REFERENCES Album(id));
                    
                CREATE TABLE IF NOT EXISTS Collection(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    release_year YEAR);
                    
                CREATE TABLE IF NOT EXISTS song_collection(
                    song_id INTEGER REFERENCES Song(id),
                    collection_id INTEGER REFERENCES Collection(id),
                    CONSTRAINT pk_song_collection PRIMARY KEY (song_id, collection_id));    
                """
            )


def creat_employee_db(connect_):
    with connect(connect_) as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS Department(
                    name VARCHAR(20) PRIMARY KEY);

                CREATE TABLE IF NOT EXISTS Employee(
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(50),
                    boss_id INTEGER REFERENCES Employee(id),
                    department_name VARCHAR(20) REFERENCES Department(name));
                """
            )

