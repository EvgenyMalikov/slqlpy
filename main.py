from pprint import pprint
from os.path import join

from create_database import create_music_db
from insert_data import (
insert_genre,
insert_artist,
insert_artist_genre,
insert_albums,
insert_artist_album,
insert_song,
insert_collection,
insert_song_collection
)
from tools import generate_couple_set
from select_query import (
select_artist_id,
select_album_id,
select_song_id,
select_collection_id
)
from join_queries import (
count_artist_in_genre,
count_song_in_album,
count_average_song_in_album,
find_artist_who_dont_release_album,
find_collection_by_artist,
find_album_with_artist_multi_genre,
find_song_not_included_in_collection,
find_album_with_highest_number_songs
)


CONNECT = 'dbname=homework user=mev password=admin host=0.0.0.0 port=5432'

def create_db():
    create_music_db(CONNECT)
    with open(join('data_files', 'genres.txt')) as genres_f:
        insert_genre(CONNECT, *genres_f.read().split('\n'))
    with open(join('data_files', 'artists.txt')) as artists_f:
        insert_artist(CONNECT, *artists_f.read().split('\n'))
    with open(join('data_files', 'genres.txt')) as genres_f:
        insert_artist_genre(CONNECT, generate_couple_set(select_artist_id(CONNECT), genres_f.read().split('\n'), 10))
    with open(join('data_files', 'albums.txt')) as albums_f:
        insert_albums(CONNECT, albums_f.read().split('\n'))
    insert_artist_album(CONNECT, generate_couple_set(select_artist_id(CONNECT), select_album_id(CONNECT), 10))
    with open(join('data_files', 'songs.txt')) as songs_f:
        insert_song(CONNECT, songs_f.read().split('\n'))
    with open(join('data_files', 'collections.txt')) as collection_f:
        insert_collection(CONNECT, collection_f.read().split('\n'))
    insert_song_collection(CONNECT, generate_couple_set(select_song_id(CONNECT), select_collection_id(CONNECT), 10))


if __name__ == '__main__':
    # pprint(count_artist_in_genre(CONNECT))
    # pprint(count_song_in_album(CONNECT, 2019, 2020))
    # pprint(count_average_song_in_album(CONNECT))
    # pprint(find_artist_who_dont_release_album(CONNECT, 2020))
    # pprint(find_collection_by_artist(CONNECT, 'Лесбиянки в законе'))
    # pprint(find_album_with_artist_multi_genre(CONNECT, 1))
    # pprint(find_song_not_included_in_collection(CONNECT))
    pprint(find_album_with_highest_number_songs(CONNECT))