PGDMP      %                {            test    16.1 (Debian 16.1-1.pgdg120+1)    16.1 %    H           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            I           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            J           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            K           1262    16384    test    DATABASE     o   CREATE DATABASE test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE test;
                test    false                        2615    16389    app    SCHEMA        CREATE SCHEMA app;
    DROP SCHEMA app;
                test    false            �            1255    16468 
   add_user()    FUNCTION     D  CREATE FUNCTION app.add_user() RETURNS trigger
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
    DROP FUNCTION app.add_user();
       app          test    false    6            �            1259    16411    event_category    TABLE     T   CREATE TABLE app.event_category (
    id bigint NOT NULL,
    name text NOT NULL
);
    DROP TABLE app.event_category;
       app         heap    test    false    6            �            1259    16410    category_id_seq    SEQUENCE     �   ALTER TABLE app.event_category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            app          test    false    221    6            �            1259    16391    event    TABLE     �   CREATE TABLE app.event (
    id bigint NOT NULL,
    event_date timestamp without time zone,
    event_category_id bigint DEFAULT 1 NOT NULL,
    user_id bigint NOT NULL,
    title text NOT NULL
);
    DROP TABLE app.event;
       app         heap    test    false    6            �            1259    16390    event_id_seq    SEQUENCE     �   ALTER TABLE app.event ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            app          test    false    6    217            �            1259    16420    role    TABLE     W   CREATE TABLE app.role (
    id bigint NOT NULL,
    name text DEFAULT USER NOT NULL
);
    DROP TABLE app.role;
       app         heap    test    false    6            �            1259    16426    role_id_seq    SEQUENCE     �   ALTER TABLE app.role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            app          test    false    6    222            �            1259    16397 	   user_data    TABLE     l   CREATE TABLE app.user_data (
    id bigint NOT NULL,
    email text NOT NULL,
    username text NOT NULL
);
    DROP TABLE app.user_data;
       app         heap    test    false    6            �            1259    16396    user_data_id_seq    SEQUENCE     �   ALTER TABLE app.user_data ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.user_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            app          test    false    6    219            �            1259    16423 	   user_role    TABLE     q   CREATE TABLE app.user_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);
    DROP TABLE app.user_role;
       app         heap    test    false    6            �            1259    16435    user_role_id_seq    SEQUENCE     �   ALTER TABLE app.user_role ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME app.user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            app          test    false    223    6            =          0    16391    event 
   TABLE DATA           O   COPY app.event (id, event_date, event_category_id, user_id, title) FROM stdin;
    app          test    false    217   9*       A          0    16411    event_category 
   TABLE DATA           /   COPY app.event_category (id, name) FROM stdin;
    app          test    false    221   V*       B          0    16420    role 
   TABLE DATA           %   COPY app.role (id, name) FROM stdin;
    app          test    false    222   �*       ?          0    16397 	   user_data 
   TABLE DATA           5   COPY app.user_data (id, email, username) FROM stdin;
    app          test    false    219   �*       C          0    16423 	   user_role 
   TABLE DATA           6   COPY app.user_role (id, user_id, role_id) FROM stdin;
    app          test    false    223   �*       L           0    0    category_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('app.category_id_seq', 3, true);
          app          test    false    220            M           0    0    event_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('app.event_id_seq', 6, true);
          app          test    false    216            N           0    0    role_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('app.role_id_seq', 2, true);
          app          test    false    224            O           0    0    user_data_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('app.user_data_id_seq', 13, true);
          app          test    false    218            P           0    0    user_role_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('app.user_role_id_seq', 5, true);
          app          test    false    225            �           2606    16419     event_category category_name_key 
   CONSTRAINT     X   ALTER TABLE ONLY app.event_category
    ADD CONSTRAINT category_name_key UNIQUE (name);
 G   ALTER TABLE ONLY app.event_category DROP CONSTRAINT category_name_key;
       app            test    false    221            �           2606    16415    event_category category_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY app.event_category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY app.event_category DROP CONSTRAINT category_pkey;
       app            test    false    221            �           2606    16395    event event_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY app.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);
 7   ALTER TABLE ONLY app.event DROP CONSTRAINT event_pkey;
       app            test    false    217            �           2606    16434    role role_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY app.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);
 5   ALTER TABLE ONLY app.role DROP CONSTRAINT role_pkey;
       app            test    false    222            �           2606    16409    user_data user_data_email_key 
   CONSTRAINT     V   ALTER TABLE ONLY app.user_data
    ADD CONSTRAINT user_data_email_key UNIQUE (email);
 D   ALTER TABLE ONLY app.user_data DROP CONSTRAINT user_data_email_key;
       app            test    false    219            �           2606    16403    user_data user_data_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY app.user_data
    ADD CONSTRAINT user_data_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY app.user_data DROP CONSTRAINT user_data_pkey;
       app            test    false    219            �           2606    16440    user_role user_role_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY app.user_role DROP CONSTRAINT user_role_pkey;
       app            test    false    223            �           2620    16469    user_data add_user_trigger    TRIGGER     l   CREATE TRIGGER add_user_trigger AFTER INSERT ON app.user_data FOR EACH ROW EXECUTE FUNCTION app.add_user();
 0   DROP TRIGGER add_user_trigger ON app.user_data;
       app          test    false    219    237            �           2606    16472    event event_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.event
    ADD CONSTRAINT event_user_id_fkey FOREIGN KEY (user_id) REFERENCES app.user_data(id) ON DELETE CASCADE NOT VALID;
 ?   ALTER TABLE ONLY app.event DROP CONSTRAINT event_user_id_fkey;
       app          test    false    219    217    3232            �           2606    16446     user_role user_role_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES app.role(id) ON DELETE CASCADE NOT VALID;
 G   ALTER TABLE ONLY app.user_role DROP CONSTRAINT user_role_role_id_fkey;
       app          test    false    3238    222    223            �           2606    16441     user_role user_role_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY app.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES app.user_data(id) ON DELETE CASCADE NOT VALID;
 G   ALTER TABLE ONLY app.user_role DROP CONSTRAINT user_role_user_id_fkey;
       app          test    false    223    219    3232            =      x������ � �      A   F   x�3�0����.캰�b���¾�v\��e�ya҅�ہ$���ˈ����Aj.6q��qqq ��'�      B      x�3�tt����2�v����� +��      ?      x������ � �      C      x������ � �     