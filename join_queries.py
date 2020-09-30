import psycopg2


def count_artist_in_genre(con: str) -> list:
    """
    :param con: строка с параметрами подключения
    :return: список кортежей с результатами запроса
    количество исполнителей в каждом жанре;
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT genre_id, COUNT(artist_id) FROM artist_genre
            GROUP BY genre_id;
            """
        )
        return cur.fetchall()


def count_song_in_album(con: str, start_year: int, end_year: int) -> list:
    """
    :param con: строка с параметрами подключения
    :param start_year: целое число, начальный год
    :param end_year: целое число, конечный год
    :return: список кортежей с результатами запроса
    количество треков, вошедших в альбомы 2019-2020 годов
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT COUNT(s.name), al.name, al.release_year FROM song s
            JOIN album al on al.id = s.album_id
            WHERE release_year BETWEEN %(begin_year)s AND %(end_year)s
            GROUP BY  al.release_year, al.name;
            """, {'begin_year': start_year, 'end_year': end_year}
        )
        return cur.fetchall()


def count_average_song_in_album(con: str) -> list:
    """
    :param con: строка с параметрами подключения
    :return: список кортежей с результатами запроса
    средняя продолжительность треков по каждому альбому
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT al.name, AVG(s.duration) FROM song s
            JOIN album al on al.id = s.album_id
            GROUP BY  al.name
            """
        )
        return cur.fetchall()


def find_artist_who_dont_release_album(con: str, year: int) -> list:
    """
    :param con: строка с параметрами подключения
    :param year: целое число, год в котором не выпускали альбомы
    :return: список кортежей с результатами запроса
    все исполнители, которые не выпустили альбомы в 2020 году
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT ar.name FROM artist ar
            JOIN artist_album aa on ar.id = aa.artist_id
            JOIN album al on al.id = aa.album_id
            WHERE release_year != %s
            GROUP BY ar.name;
            """, (year,)
        )
        return cur.fetchall()


def find_collection_by_artist(con: str, name_artist: str) -> list:
    """
    :param con: строка с параметрами подключения
    :param name_artist: строка, имя артиста
    :return: список кортежей с результатами запроса
    названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT c.name FROM collection c
            JOIN song_collection sc on c.id = sc.collection_id
            JOIN song s on sc.song_id = s.id
            JOIN album a on a.id = s.album_id
            JOIN artist_album aa on a.id = aa.album_id
            JOIN artist a2 on a2.id = aa.artist_id
            WHERE a2.name = %s
            GROUP BY c.name; 
            """, (name_artist,)
        )
        return cur.fetchall()


def find_album_with_artist_multi_genre(con: str, count_genre: int) -> list:
    """
    :param con: строка с параметрами подключения
    :param count_genre: количество жанров, целое число
    :return: список кортежей с результатами запроса
    название альбомов, в которых присутствуют исполнители более 1 жанра
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT a.name  FROM artist_genre ag
            JOIN artist_album aa ON ag.artist_id = aa.artist_id
            JOIN album a ON a.id = aa.album_id
            GROUP BY ag.artist_id, a.name
            HAVING COUNT(ag.genre_id) > %s;
            """, (count_genre,)
        )
        return cur.fetchall()


def find_song_not_included_in_collection(con: str) -> list:
    """
    :param con: строка с параметрами подключения
    :return: список кортежей с результатами запроса
    наименование треков, которые не входят в сборники
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT s.name FROM song s
            LEFT JOIN song_collection sc ON s.id=sc.song_id
            WHERE sc.collection_id IS NULL;
            """
        )
        return cur.fetchall()


def find_artist_who_wrote_shortest_song(con: str) -> list:
    """
    :param con:  строка с параметрами подключения
    :return: список кортежей с результатами запроса
    исполнителя(-ей), написавшего самый короткий по продолжительности трек
    (теоретически таких треков может быть несколько)
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT a.name FROM artist a
            JOIN artist_album aa ON aa.artist_id = a.id
            JOIN song s ON s.album_id = aa.album_id
            WHERE duration = (SELECT MIN(duration) FROM song);
            """
        )
        return cur.fetchall()


def find_album_with_highest_number_songs(con: str) -> list:
    """
    :param con:  строка с параметрами подключения
    :return: список кортежей с результатами запроса
    название альбомов, содержащих наименьшее количество треков.
    """
    with psycopg2.connect(con) as conn, conn.cursor() as cur:
        cur.execute(
            """
            SELECT a.name  FROM album a 
            JOIN song s on a.id = s.album_id
            GROUP BY a.name
            HAVING COUNT(s.album_id) = (SELECT MIN(album_id) FROM song)
            """
        )
        return cur.fetchall()
