--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1

-- Started on 2023-12-25 09:09:27 UTC

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
-- TOC entry 6 (class 2615 OID 16478)
-- Name: app; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA app;


--
-- TOC entry 237 (class 1255 OID 16479)
-- Name: add_user(); Type: FUNCTION; Schema: app; Owner: -
--

CREATE FUNCTION app.add_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
user_role_id INTEGER = 1;
default_event_category_id INTEGER = 1;

date1 Date = NOW() + INTERVAL '1 day';
date2 Date = NOW() + INTERVAL '2 day';
date3 Date = NOW() + INTERVAL '3 day';

BEGIN
-- INSERT INTO app.activity (uuid, activated, user_id) VALUES (gen_random_uuid(), 0, NEW.id);

-- Задаем роль пользователю
INSERT INTO app.user_role (user_id, role_id) VALUES (NEW.id, user_role_id);

-- Создаем событие пользователя
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Новое событие', date1, default_event_category_id, NEW.id);
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Тренировка', date2, 2, NEW.id);
INSERT INTO app.event (title, event_date, event_category_id, user_id) VALUES ('Тур по барам', date3, 3, NEW.id);
-- INSERT INTO app.event (title, user_id) VALUES ('Тренажерный зал', NEW.id) RETURNING id into categoryId2;


RETURN NEW;
END$$;


SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 16480)
-- Name: event_category; Type: TABLE; Schema: app; Owner: -
--

CREATE TABLE app.event_category (
    id bigint NOT NULL,
    name text NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16485)
-- Name: category_id_seq; Type: SEQUENCE; Schema: app; Owner: -
--

ALTER TABLE app.event_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16486)
-- Name: event; Type: TABLE; Schema: app; Owner: -
--

CREATE TABLE app.event (
    id bigint NOT NULL,
    event_date timestamp without time zone,
    event_category_id bigint DEFAULT 1 NOT NULL,
    user_id bigint NOT NULL,
    title text NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16492)
-- Name: event_id_seq; Type: SEQUENCE; Schema: app; Owner: -
--

ALTER TABLE app.event ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16493)
-- Name: role; Type: TABLE; Schema: app; Owner: -
--

CREATE TABLE app.role (
    id bigint NOT NULL,
    name text DEFAULT USER NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16499)
-- Name: role_id_seq; Type: SEQUENCE; Schema: app; Owner: -
--

ALTER TABLE app.role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16500)
-- Name: user_data; Type: TABLE; Schema: app; Owner: -
--

CREATE TABLE app.user_data (
    id bigint NOT NULL,
    email text NOT NULL,
    username text NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16505)
-- Name: user_data_id_seq; Type: SEQUENCE; Schema: app; Owner: -
--

ALTER TABLE app.user_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.user_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16506)
-- Name: user_role; Type: TABLE; Schema: app; Owner: -
--

CREATE TABLE app.user_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16509)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: app; Owner: -
--

ALTER TABLE app.user_role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3390 (class 0 OID 16486)
-- Dependencies: 218
-- Data for Name: event; Type: TABLE DATA; Schema: app; Owner: -
--

COPY app.event (id, event_date, event_category_id, user_id, title) FROM stdin;
7	2023-12-25 00:00:00	1	14	Новое событие
8	2023-12-26 00:00:00	2	14	Тренировка
9	2023-12-27 00:00:00	3	14	Тур по барам
10	2023-12-25 00:00:00	1	15	Новое событие
11	2023-12-26 00:00:00	2	15	Тренировка
12	2023-12-27 00:00:00	3	15	Тур по барам
\.


--
-- TOC entry 3388 (class 0 OID 16480)
-- Dependencies: 216
-- Data for Name: event_category; Type: TABLE DATA; Schema: app; Owner: -
--

COPY app.event_category (id, name) FROM stdin;
1	Без категории
3	Вечеринка
2	Спорт
\.


--
-- TOC entry 3392 (class 0 OID 16493)
-- Dependencies: 220
-- Data for Name: role; Type: TABLE DATA; Schema: app; Owner: -
--

COPY app.role (id, name) FROM stdin;
1	ADMIN
2	USER
\.


--
-- TOC entry 3394 (class 0 OID 16500)
-- Dependencies: 222
-- Data for Name: user_data; Type: TABLE DATA; Schema: app; Owner: -
--

COPY app.user_data (id, email, username) FROM stdin;
14	test	test
15	test@mail.ru	sasha
\.


--
-- TOC entry 3396 (class 0 OID 16506)
-- Dependencies: 224
-- Data for Name: user_role; Type: TABLE DATA; Schema: app; Owner: -
--

COPY app.user_role (id, user_id, role_id) FROM stdin;
6	14	1
7	15	1
\.


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 217
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.category_id_seq', 3, true);


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 219
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.event_id_seq', 12, true);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 221
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.role_id_seq', 2, true);


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 223
-- Name: user_data_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.user_data_id_seq', 15, true);


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: app; Owner: -
--

SELECT pg_catalog.setval('app.user_role_id_seq', 7, true);


--
-- TOC entry 3228 (class 2606 OID 16511)
-- Name: event_category category_name_key; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.event_category
    ADD CONSTRAINT category_name_key UNIQUE (name);


--
-- TOC entry 3230 (class 2606 OID 16513)
-- Name: event_category category_pkey; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.event_category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16515)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 16517)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 3236 (class 2606 OID 16519)
-- Name: user_data user_data_email_key; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.user_data
    ADD CONSTRAINT user_data_email_key UNIQUE (email);


--
-- TOC entry 3238 (class 2606 OID 16521)
-- Name: user_data user_data_pkey; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16523)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2620 OID 16524)
-- Name: user_data add_user_trigger; Type: TRIGGER; Schema: app; Owner: -
--

CREATE TRIGGER add_user_trigger AFTER INSERT ON app.user_data FOR EACH ROW EXECUTE FUNCTION app.add_user();


--
-- TOC entry 3241 (class 2606 OID 16525)
-- Name: event event_user_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.event
    ADD CONSTRAINT event_user_id_fkey FOREIGN KEY (user_id) REFERENCES app.user_data(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3242 (class 2606 OID 16530)
-- Name: user_role user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES app.role(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3243 (class 2606 OID 16535)
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: app; Owner: -
--

ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES app.user_data(id) ON DELETE CASCADE NOT VALID;


-- Completed on 2023-12-25 09:09:27 UTC

--
-- PostgreSQL database dump complete
--

