from select_query import (select_date_albums,
                          order_by_duration_song,
                          get_song_name,
                          select_collection_by_year,
                          select_artist_by_name_one_word,
                          find_text)


CONNECT = 'dbname=homework user=mev password=admin host=0.0.0.0 port=5432'


if __name__ == '__main__':
    print(select_date_albums(CONNECT, 2018))
    print(order_by_duration_song(CONNECT))
    print(get_song_name(CONNECT, 3.5))
    print(select_collection_by_year(CONNECT, 2018, 2020))
    print(select_artist_by_name_one_word(CONNECT))
    print(find_text(CONNECT, '%%My%%'))
