-- Creation of tables
CREATE TABLE genres (
                        id INTEGER PRIMARY KEY,
                        genre TEXT,
                        created_at TEXT,
                        updated_at TEXT
);

CREATE TABLE movies (
                        id INTEGER PRIMARY KEY,
                        title TEXT,
                        release_date TEXT,
                        runtime INTEGER,
                        mpaa_rating TEXT,
                        description TEXT,
                        image TEXT,
                        created_at TEXT,
                        updated_at TEXT
);

CREATE TABLE movies_genres (
                               id INTEGER PRIMARY KEY,
                               movie_id INTEGER,
                               genre_id INTEGER,
                               FOREIGN KEY(movie_id) REFERENCES movies(id),
                               FOREIGN KEY(genre_id) REFERENCES genres(id)
);

CREATE TABLE users (
                       id INTEGER PRIMARY KEY,
                       first_name TEXT,
                       last_name TEXT,
                       email TEXT,
                       password TEXT,
                       created_at TEXT,
                       updated_at TEXT
);

--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO genres (id, genre, created_at, updated_at) VALUES (14, 'Comedy', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (15, 'Sci-Fi', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (16, 'Horror', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (17, 'Romance', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (18, 'Action', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (19, 'Thriller', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (20, 'Drama', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (21, 'Mystery', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (22, 'Crime', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (23, 'Animation', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (24, 'Adventure', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (25, 'Fantasy', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO genres (id, genre, created_at, updated_at) VALUES (26, 'Superhero', '2022-09-23 00:00:00', '2022-09-23 00:00:00');


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (5, 'Raiders of the Lost Ark', '1981-06-12', 115, 'PG-13', 'Archaeology professor Indiana Jones ventures to seize a biblical artefact known as the Ark of the Covenant. While doing so, he puts up a fight against Renee and a troop of Nazis.', '/ceG9VzoRAVGwivFU403Wc3AHRys.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (6, 'The Godfather', '1972-03-24', 175, '18A', 'The aging patriarch of an organized crime dynasty in postwar New York City transfers control of his clandestine empire to his reluctant youngest son.', '/3bhkrj58Vtu7enYsRolD1fZdja1.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (7, 'mi pelicula', '2023-11-30', 12, 'PG', 'mi ejemplo 01', '', '2023-11-13 20:04:14.71421', '2023-11-13 20:04:14.71421');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (12, 'mi pelicula 3', '2008-08-20', 150, 'P-12', 'Nueva pelicula de prueba', 'asasa', '2023-11-24 18:51:38.744527', '2023-11-24 18:51:38.744527');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (13, 'mi pelicula', '2020-08-20', 100, '13', 'sasasasa', 'ssss', '2023-11-27 20:24:09.593163', '2023-11-27 20:24:09.593163');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (10, 'mi pelicula 222', '2020-08-20', 120, '13', 'Esta es una pelicula de prueba', 'aaaaaa', '2023-11-22 00:00:00', '2023-11-22 00:00:00');
INSERT INTO movies (id, title, release_date, runtime, mpaa_rating, description, image, created_at, updated_at) VALUES (4, 'Highlander 2222', '1986-03-07', 116, 'R', 'He fought his first battle on the Scottish Highlands in 1536. He will fight his greatest battle on the streets of New York City in 1986. His name is Connor MacLeod. He is immortal.', '/8Z8dptJEypuLoOQro1WugD855YE.jpg', '2022-09-23 00:00:00', '2022-09-23 00:00:00');


--
-- Data for Name: movies_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (10, 5, 18);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (11, 5, 24);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (12, 6, 22);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (13, 6, 20);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (14, 7, 20);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (15, 7, 14);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (18, 12, 14);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (19, 12, 15);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (20, 13, 14);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (21, 13, 15);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (22, 13, 16);
INSERT INTO movies_genres (id, movie_id, genre_id) VALUES (23, 13, 17);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO users (id, first_name, last_name, email, password, created_at, updated_at) VALUES (2, 'Admin', 'User', 'admin@example.com', '$2a$12$FZ18sUMJCP0yqR0HISoQreUUmveU./OubJwKxfz98DyeM7ElHhdLK', '2022-09-23 00:00:00', '2022-09-23 00:00:00');
