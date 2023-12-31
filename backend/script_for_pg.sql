--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    genre character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.genres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    title character varying(512),
    release_date date,
    runtime integer,
    mpaa_rating character varying(10),
    description text,
    image character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- Name: movies_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies_genres (
    id integer NOT NULL,
    movie_id integer,
    genre_id integer
);


ALTER TABLE public.movies_genres OWNER TO postgres;

--
-- Name: movies_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.movies_genres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movies_genres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: movies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.movies ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.movies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    password character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (14, 'Comedy', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (15, 'Sci-Fi', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (16, 'Horror', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (17, 'Romance', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (18, 'Action', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (19, 'Thriller', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (20, 'Drama', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (21, 'Mystery', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (22, 'Crime', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (23, 'Animation', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (24, 'Adventure', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (25, 'Fantasy', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.genres (id, genre, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (26, 'Superhero', '2022-09-23 00:00:00', '2022-09-23 00:00:00');


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (5, 'Raiders of the Lost Ark', '1981-06-12', 115, 'PG-13', 'Archaeology professor Indiana Jones ventures to seize a biblical artefact known as the Ark of the Covenant. While doing so, he puts up a fight against Renee and a troop of Nazis.', '/ceG9VzoRAVGwivFU403Wc3AHRys.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (6, 'The Godfather', '1972-03-24', 175, '18A', 'The aging patriarch of an organized crime dynasty in postwar New York City transfers control of his clandestine empire to his reluctant youngest son.', '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (7, 'mi pelicula', '2023-11-30', 12, 'PG', 'mi ejemplo 01', '', '2023-11-13 20:04:14.71421', '2023-11-13 20:04:14.71421');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (12, 'mi pelicula 3', '2008-08-20', 150, 'P-12', 'Nueva pelicula de prueba', 'asasa', '2023-11-24 18:51:38.744527', '2023-11-24 18:51:38.744527');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (13, 'mi pelicula', '2020-08-20', 100, '13', 'sasasasa', 'ssss', '2023-11-27 20:24:09.593163', '2023-11-27 20:24:09.593163');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (10, 'mi pelicula 222', '2020-08-20', 120, '13', 'Esta es una pelicula de prueba', 'aaaaaa', '2023-11-22 00:00:00', '2023-11-22 00:00:00');
INSERT INTO public.movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (4, 'Highlander 2222', '1986-03-07', 116, 'R', 'He fought his first battle on the Scottish Highlands in 1536. He will fight his greatest battle on the streets of New York City in 1986. His name is Connor MacLeod. He is immortal.', '/8Z8dptJEypuLoOQro1WugD855YE.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');


--
-- Data for Name: movies_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (10, 5, 18);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (11, 5, 24);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (12, 6, 22);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (13, 6, 20);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (14, 7, 20);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (15, 7, 14);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (18, 12, 14);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (19, 12, 15);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (20, 13, 14);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (21, 13, 15);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (22, 13, 16);
INSERT INTO public.movies_genres (id, movie_id, genre_id) OVERRIDING SYSTEM VALUE VALUES (23, 13, 17);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, first_name, last_name, email, password, created_at, updated_at) OVERRIDING SYSTEM VALUE VALUES (2, 'Admin', 'User', 'admin@example.com', '$2a$12$FZ18sUMJCP0yqR0HISoQreUUmveU./OubJwKxfz98DyeM7ElHhdLK', '2022-09-23 00:00:00', '2022-09-23 00:00:00');


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genres_id_seq', 26, true);


--
-- Name: movies_genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_genres_id_seq', 23, true);


--
-- Name: movies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_id_seq', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: movies_genres movies_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: movies_genres movies_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: movies_genres movies_genres_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies_genres
    ADD CONSTRAINT movies_genres_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

