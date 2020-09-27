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
1	Бензопилы любви	2016
2	летняя жесть	2016
3	слезы мясника	2019
4	Снег зеленый	2016
5	Небо в печени	2020
6	Ракеты наслождения	2017
7	Космос, конечная	2018
8	Сборник законов	2017
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
\.


--
-- Data for Name: artist_album; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.artist_album (artist_id, album_id) FROM stdin;
7	4
3	8
7	1
3	4
2	7
4	3
6	1
7	3
6	7
1	6
7	5
6	3
4	1
\.


--
-- Data for Name: artist_genre; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.artist_genre (artist_id, genre_id) FROM stdin;
7	классическая музыка
6	рэп
3	классическая музыка
3	говнари
4	классическая музыка
3	метал
1	попса
5	метал
5	классическая музыка
4	рэп
4	метал
7	рэп
4	говнари
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.collection (id, name, release_year) FROM stdin;
1	Какая то хрень	2017
2	Жесть	2019
3	Сборник прошлого	2019
4	Cупер сборник	2018
5	Сборник сборников	2015
6	Сборник сборных сборников	2018
7	2000х	2020
8	X	2019
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
1	Скрежет романтики	3.89999999999999991	8
2	My bad	3.39999999999999991	6
3	Mой рокен-ролл	2.60000000000000009	2
4	Дождливое восхождение	3.89999999999999991	5
5	Ночное	2.39999999999999991	1
6	That's all	2.20000000000000018	1
7	Night	2.79999999999999982	1
8	Speed	2.79999999999999982	5
9	Детские забавы	2.89999999999999991	5
10	Фантазия могил	2.70000000000000018	3
11	Сарай	3.29999999999999982	5
12	Выстрел в печень	3	4
13	Утрений свинг	3.10000000000000009	5
14	Ночное представление	3.70000000000000018	3
15	Голое воображение	2.89999999999999991	6
\.


--
-- Data for Name: song_collection; Type: TABLE DATA; Schema: public; Owner: mev
--

COPY public.song_collection (song_id, collection_id) FROM stdin;
4	3
3	1
14	1
14	7
5	1
5	7
9	5
10	6
9	8
11	5
8	6
10	3
1	3
15	2
2	8
13	8
15	5
7	4
7	1
7	7
6	5
6	8
12	3
4	2
14	6
4	5
12	6
3	3
5	6
14	3
3	6
5	3
8	2
9	1
9	7
8	5
9	4
10	5
2	1
2	7
13	1
15	4
15	1
15	7
1	8
7	3
12	2
12	5
3	2
12	8
3	5
5	2
14	5
4	4
3	8
5	5
14	8
8	1
8	7
10	4
10	7
2	3
1	7
2	6
7	2
6	6
\.


--
-- Name: album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.album_id_seq', 8, true);


--
-- Name: artist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mev
--

SELECT pg_catalog.setval('public.artist_id_seq', 7, true);


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

