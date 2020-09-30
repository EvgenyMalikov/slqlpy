--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Debian 10.10-1.pgdg90+1)
-- Dumped by pg_dump version 10.10 (Debian 10.10-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: year; Type: DOMAIN; Schema: public; Owner: mev
--

CREATE DOMAIN public.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


ALTER DOMAIN public.year OWNER TO mev;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: album; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.album (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    release_year public.year
);


ALTER TABLE public.album OWNER TO mev;

--
-- Name: album_id_seq; Type: SEQUENCE; Schema: public; Owner: mev
--

CREATE SEQUENCE public.album_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.album_id_seq OWNER TO mev;

--
-- Name: album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mev
--

ALTER SEQUENCE public.album_id_seq OWNED BY public.album.id;


--
-- Name: artist; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.artist (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.artist OWNER TO mev;

--
-- Name: artist_album; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.artist_album (
    artist_id integer NOT NULL,
    album_id integer NOT NULL
);


ALTER TABLE public.artist_album OWNER TO mev;

--
-- Name: artist_genre; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.artist_genre (
    artist_id integer NOT NULL,
    genre_id character varying(20) NOT NULL
);


ALTER TABLE public.artist_genre OWNER TO mev;

--
-- Name: artist_id_seq; Type: SEQUENCE; Schema: public; Owner: mev
--

CREATE SEQUENCE public.artist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artist_id_seq OWNER TO mev;

--
-- Name: artist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mev
--

ALTER SEQUENCE public.artist_id_seq OWNED BY public.artist.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.collection (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    release_year public.year
);


ALTER TABLE public.collection OWNER TO mev;

--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: mev
--

CREATE SEQUENCE public.collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_id_seq OWNER TO mev;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mev
--

ALTER SEQUENCE public.collection_id_seq OWNED BY public.collection.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.genre (
    name character varying(20) NOT NULL
);


ALTER TABLE public.genre OWNER TO mev;

--
-- Name: song; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.song (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    duration double precision NOT NULL,
    album_id integer,
    CONSTRAINT song_duration_check CHECK ((duration > (0)::double precision))
);


ALTER TABLE public.song OWNER TO mev;

--
-- Name: song_collection; Type: TABLE; Schema: public; Owner: mev
--

CREATE TABLE public.song_collection (
    song_id integer NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.song_collection OWNER TO mev;

--
-- Name: song_id_seq; Type: SEQUENCE; Schema: public; Owner: mev
--

CREATE SEQUENCE public.song_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.song_id_seq OWNER TO mev;

--
-- Name: song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mev
--

ALTER SEQUENCE public.song_id_seq OWNED BY public.song.id;


--
-- Name: album id; Type: DEFAULT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.album ALTER COLUMN id SET DEFAULT nextval('public.album_id_seq'::regclass);


--
-- Name: artist id; Type: DEFAULT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist ALTER COLUMN id SET DEFAULT nextval('public.artist_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.collection ALTER COLUMN id SET DEFAULT nextval('public.collection_id_seq'::regclass);


--
-- Name: song id; Type: DEFAULT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song ALTER COLUMN id SET DEFAULT nextval('public.song_id_seq'::regclass);


--
-- Data for Name: album; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.album (id, name, release_year) FROM stdin;
1	Бензопилы любви	2018
2	Летняя жесть	2019
3	Слезы мясника	2016
4	Цепи наслаждения	2016
5	Небо в комнате	2016
6	Ракеты рока	2017
7	Космос, конечная	2018
8	Сборник законов	2016
\.


--
-- Data for Name: artist; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.artist (id, name) FROM stdin;
1	Снегурки без присмотра
2	Клоуны патологоанатомы
3	Кабзон,Лесной вой
4	Лесбиянки в законе
5	Геи со стажем
6	Смазаные бензопилы
7	Леди в белом
8	Зая
\.


--
-- Data for Name: artist_album; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.artist_album (artist_id, album_id) FROM stdin;
4	1
4	3
5	8
4	6
5	7
4	2
7	2
2	2
1	3
4	7
\.


--
-- Data for Name: artist_genre; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.artist_genre (artist_id, genre_id) FROM stdin;
2	рэп
8	классическая музыка
6	рэп
3	классическая музыка
8	говнари
6	метал
1	метал
1	говнари
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.collection (id, name, release_year) FROM stdin;
1	Какая то хрень	2019
2	Жесть	2016
3	Сборник прошлого	2020
4	Сборник эротических рассказов	2018
5	Сборник надежды	2015
6	Best of the best	2016
7	2000х	2017
8	X	2015
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.genre (name) FROM stdin;
попса
метал
рэп
говнари
классическая музыка
\.


--
-- Data for Name: song; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.song (id, name, duration, album_id) FROM stdin;
1	Скрежет романтики	3.29999999999999982	3
2	My erotica	3.29999999999999982	4
3	Mой морг	2.60000000000000009	1
4	Дождливое восхождение	3.70000000000000018	8
5	Ночное	2.29999999999999982	4
6	That's all	2.29999999999999982	1
7	Night	3	4
8	Speed	3.70000000000000018	5
9	Детские забавы	3.39999999999999991	5
10	Фантазия могил	3.29999999999999982	1
11	Глинтвейн	2.79999999999999982	1
12	Выстрел в печень	3.29999999999999982	1
13	Утрений свинг	3.20000000000000018	2
14	Ночное представление	3.29999999999999982	2
15	Голое воображение	3.60000000000000009	3
\.


--
-- Data for Name: song_collection; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.song_collection (song_id, collection_id) FROM stdin;
15	5
14	4
5	4
6	4
4	2
4	5
15	3
2	2
8	5
9	4
\.


--
-- Name: album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.album_id_seq', 8, true);


--
-- Name: artist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.artist_id_seq', 8, true);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.collection_id_seq', 8, true);


--
-- Name: song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.song_id_seq', 15, true);


--
-- Name: album album_pkey; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (id);


--
-- Name: artist artist_pkey; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (name);


--
-- Name: artist_album pk_artist_album; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_album
    ADD CONSTRAINT pk_artist_album PRIMARY KEY (artist_id, album_id);


--
-- Name: artist_genre pk_artist_genre; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_genre
    ADD CONSTRAINT pk_artist_genre PRIMARY KEY (artist_id, genre_id);


--
-- Name: song_collection pk_song_collection; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song_collection
    ADD CONSTRAINT pk_song_collection PRIMARY KEY (song_id, collection_id);


--
-- Name: song song_pkey; Type: CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT song_pkey PRIMARY KEY (id);


--
-- Name: artist_album artist_album_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_album
    ADD CONSTRAINT artist_album_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.album(id);


--
-- Name: artist_album artist_album_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_album
    ADD CONSTRAINT artist_album_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id);


--
-- Name: artist_genre artist_genre_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_genre
    ADD CONSTRAINT artist_genre_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artist(id);


--
-- Name: artist_genre artist_genre_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.artist_genre
    ADD CONSTRAINT artist_genre_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genre(name);


--
-- Name: song song_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT song_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.album(id);


--
-- Name: song_collection song_collection_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song_collection
    ADD CONSTRAINT song_collection_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collection(id);


--
-- Name: song_collection song_collection_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mev
--

ALTER TABLE ONLY public.song_collection
    ADD CONSTRAINT song_collection_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.song(id);


--
-- PostgreSQL database dump complete
--

