--создание БД

CREATE DATABASE book_store
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--создание таблицы author

CREATE TABLE IF NOT EXISTS public.author
(
    author_id integer NOT NULL DEFAULT nextval('author_author_id_seq'::regclass),
    author_name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT author_pk PRIMARY KEY (author_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.author
    OWNER to postgres;

--заполнение

INSERT INTO author(author_name)
VALUES('Достоевский Ф.М.'),
	  ('Кинг С.'),
	  ('Роулинг Дж.'),
	  ('Грибоедов А.С.'),
	  ('Кристи А.'),
	  ('Лермонтов М.Ю.'),
	  ('Толстой Л.Н.'),
	  ('Крылов И.А.'),
	  ('Протеро С.'),
	  ('Мартин Р.'),
	  ('Маршак С.Я.'),
	  ('Атанасян Л.С.');

SELECT * FROM author;


--создание таблицы book

CREATE TABLE IF NOT EXISTS public.book
(
    book_id integer NOT NULL DEFAULT nextval('book_book_id_seq'::regclass),
    publisher_id smallint NOT NULL DEFAULT nextval('book_publisher_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    type character varying(20) COLLATE pg_catalog."default",
    stock integer,
    price numeric NOT NULL,
    language character varying(50) COLLATE pg_catalog."default" NOT NULL,
    age_rating integer NOT NULL,
    raiting integer NOT NULL,
    raiting_count integer NOT NULL,
    description character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT book_pk PRIMARY KEY (book_id),
    CONSTRAINT fk_publisher_id FOREIGN KEY (publisher_id)
        REFERENCES public.publisher (publisher_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.book
    OWNER to postgres;
	
--заполнение

INSERT INTO book(name, cover_type, stock, price, language, age_rating)
VALUES('Преступление и наказание', 'hardcover', 3, 314.50, 'русский', 'PG'),
	  ('Гарри Поттер и Орден Феникса', 'hardcover', 5, 788.99, 'русский', 'PG'),
	  ('Стихотворения и поэмы', 'paperback', 7, 276.00, 'русский', 'G'),
	  ('It', 'hardcover', 6, 917.99, 'english', 'R'),
	  ('Практический интеллект', 'hardcover', 2, 627.99, 'russian', 'PG-13');

SELECT * FROM book;

--создание таблицы book_author

CREATE TABLE IF NOT EXISTS public.book_author
(
    book_id integer NOT NULL DEFAULT nextval('book_author_book_id_seq'::regclass),
    author_id integer NOT NULL DEFAULT nextval('book_author_author_id_seq'::regclass),
    CONSTRAINT fk_author_id FOREIGN KEY (author_id)
        REFERENCES public.author (author_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_book_author FOREIGN KEY (book_id)
        REFERENCES public.book (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.book_author
    OWNER to postgres;
	

--создание таблицы book_genre

CREATE TABLE IF NOT EXISTS public.book_genre
(
    book_genre_id integer,
    book_id integer NOT NULL DEFAULT nextval('book_genre_book_id_seq'::regclass),
    genre_id integer NOT NULL DEFAULT nextval('book_genre_genre_id_seq'::regclass),
    CONSTRAINT fk_book_id FOREIGN KEY (book_id)
        REFERENCES public.book (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_genre_id FOREIGN KEY (genre_id)
        REFERENCES public.genre (genre_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.book_genre
    OWNER to postgres;


--создание таблицы book_review

CREATE TABLE IF NOT EXISTS public.book_review
(
    book_review_id integer NOT NULL DEFAULT nextval('book_review_book_review_id_seq'::regclass),
    review_id integer NOT NULL DEFAULT nextval('book_review_review_id_seq'::regclass),
    book_id integer NOT NULL DEFAULT nextval('book_review_book_id_seq'::regclass),
    CONSTRAINT book_review_id_pk PRIMARY KEY (book_review_id),
    CONSTRAINT fk_book_id FOREIGN KEY (book_id)
        REFERENCES public.book (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_review_id FOREIGN KEY (review_id)
        REFERENCES public.review (review_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.book_review
    OWNER to postgres;
	

--создание таблицы card

CREATE TABLE IF NOT EXISTS public.card
(
    card_id integer NOT NULL DEFAULT nextval('card_card_id_seq'::regclass),
    card_type character varying(50) COLLATE pg_catalog."default",
    card_number character varying(19) COLLATE pg_catalog."default",
    cardholder character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pk_card_id PRIMARY KEY (card_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.card
    OWNER to postgres;
	
--заполнение

INSERT INTO card(card_type, card_number, cardholder)
VALUES('Visa Classic', '4276 8000 5241 2821', 'PETR IVANOV'),
	  ('MasterCard Standard', '5484 9880 5777 9021', 'ALISA YAKOVENKO'),
	  ('Visa Gold', '4963 7501 6341 2998', 'TIMOFEI VOLKOV'),
	  ('MasterCard Gold', '5484 8592 1232 9155', 'IVAN FEDOROV'),
	  ('Мир', '2200 2000 6232 7913', 'MARIIA KOLCHENKO');

SELECT * FROM card;

--создание таблицы cart

CREATE TABLE IF NOT EXISTS public.cart
(
    cart_id integer NOT NULL DEFAULT nextval('cart_cart_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default",
    phone character varying(10) COLLATE pg_catalog."default",
    mail character varying(50) COLLATE pg_catalog."default",
    notes character varying(255) COLLATE pg_catalog."default",
    discount integer,
    bonus_points integer,
    cust_id integer NOT NULL DEFAULT nextval('cart_cust_id_seq'::regclass),
    CONSTRAINT pk_cart_id PRIMARY KEY (cart_id),
    CONSTRAINT fk_cust_id FOREIGN KEY (cust_id)
        REFERENCES public.customer_info (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;

--создание таблицы cart_info

CREATE TABLE IF NOT EXISTS public.cart_info
(
    cart_id integer NOT NULL DEFAULT nextval('cart_info_cart_id_seq'::regclass),
    book_id integer NOT NULL DEFAULT nextval('cart_info_book_id_seq'::regclass),
    amount integer,
    price numeric(10,2),
    CONSTRAINT fk_book_id FOREIGN KEY (book_id)
        REFERENCES public.book (book_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_cart_id FOREIGN KEY (cart_id)
        REFERENCES public.cart (cart_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart_info
    OWNER to postgres;

--создание таблицы customer_info

CREATE TABLE IF NOT EXISTS public.customer_info
(
    cust_id integer NOT NULL DEFAULT nextval('customer_info_cust_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(10) COLLATE pg_catalog."default",
    mail character varying(50) COLLATE pg_catalog."default",
    notes character varying(255) COLLATE pg_catalog."default",
    discount integer,
    bonus_points integer,
    CONSTRAINT pk_cust_id PRIMARY KEY (cust_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customer_info
    OWNER to postgres;
	
--заполнение

INSERT INTO customer_info (name, phone, email, discount, bonus_points)
VALUES('Иван', '+79214764128', 'qwerty@gmail.com', 10, 0),
	  ('Пётр', '+79114590893', 'petya228@gmail.com', 17, 78),
	  ('Мария', '+79817729441', 'mariak@gmail.com', 38, 115),
	  ('Алиса', '+79213948273', 'alice1998@gmail.com', 22, 152);

SELECT * FROM customers;

--создание таблицы genre

CREATE TABLE IF NOT EXISTS public.genre
(
    genre_id integer NOT NULL DEFAULT nextval('genre_genre_id_seq'::regclass),
    genre_name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_genre_id PRIMARY KEY (genre_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.genre
    OWNER to postgres;

--заполнение

INSERT INTO genre(genre_name)
VALUES('Роман'),
	  ('Детектив'),
	  ('Фэнтези'),
	  ('Драма'),
	  ('Поэзия'),
	  ('Триллер'),
	  ('Ужасы'),
	  ('Басня'),
	  ('Монография'),
	  ('Религиозная литература'),
	  ('Научная литература'),
	  ('Детская литература'),
	  ('Учебная литература');

SELECT * FROM genre;

--создание таблицы order_body

CREATE TABLE IF NOT EXISTS public.order_body
(
    order_id integer NOT NULL DEFAULT nextval('order_body_order_id_seq'::regclass),
    trans_id integer NOT NULL DEFAULT nextval('order_body_trans_id_seq'::regclass),
    delivery_id integer NOT NULL DEFAULT nextval('order_body_delivery_id_seq'::regclass),
    cust_id integer NOT NULL DEFAULT nextval('order_body_cust_id_seq'::regclass),
    order_status character varying(50) COLLATE pg_catalog."default",
    form_date timestamp without time zone,
    total_cost numeric(10,2),
    comment character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pk_order_id PRIMARY KEY (order_id),
    CONSTRAINT fk_cust_id FOREIGN KEY (cust_id)
        REFERENCES public.customer_info (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_delivery_id FOREIGN KEY (delivery_id)
        REFERENCES public.order_ship (delivery_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_trans_id FOREIGN KEY (trans_id)
        REFERENCES public.transakt (trans_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_body
    OWNER to postgres;
	
--заполнение

ALTER TABLE order_body 
ADD FOREIGN KEY (trans_id) REFERENCES transakt(trans_id);
ALTER TABLE order_body 
ADD FOREIGN KEY (delivery_id) REFERENCES order_ship(delivery_id);
ALTER TABLE order_body 
ADD FOREIGN KEY (cust_id) REFERENCES customer(cust_id);
INSERT INTO order_body(trans_id, delivery_id, cust_id, order_status, form_date, total_cost)
VALUES('Отправлен', 23.12.21, 347.00),
	  ('Доставлен', 10.11.21, 1236.00),
	  ('Отправлен', 05.12.21, 675.00),
	  ('Отправлен', 14.12.21, 1294.00),
	  ('Доставлен', 03.11.21, 475.00);

SELECT * FROM order_body;


--создание таблицы order_info

CREATE TABLE IF NOT EXISTS public.order_info
(
    order_id integer NOT NULL DEFAULT nextval('order_info_order_id_seq'::regclass),
    book_id integer NOT NULL DEFAULT nextval('order_info_book_id_seq'::regclass),
    amount integer,
    price numeric(10,2),
    CONSTRAINT fk_order_id FOREIGN KEY (order_id)
        REFERENCES public.order_body (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_info
    OWNER to postgres;

--создание таблицы order_ship
CREATE TABLE IF NOT EXISTS public.order_ship
(
    delivery_id integer NOT NULL DEFAULT nextval('order_ship_delivery_id_seq'::regclass),
    delivery_date timestamp without time zone NOT NULL,
    delivery_status character varying(50) COLLATE pg_catalog."default" NOT NULL,
    delivery_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    delivery_cost numeric(10,2),
    CONSTRAINT pk_delivery_id PRIMARY KEY (delivery_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_ship
    OWNER to postgres;

--создание таблицы publisher

CREATE TABLE IF NOT EXISTS public.publisher
(
    publisher_id integer NOT NULL DEFAULT nextval('publisher_publisher_id_seq'::regclass),
    publisher_name character varying(50) COLLATE pg_catalog."default",
    pub_year character varying(4) COLLATE pg_catalog."default",
    CONSTRAINT pk_publisher_id PRIMARY KEY (publisher_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.publisher
    OWNER to postgres;
	
--заполнение

INSERT INTO publisher(publisher_name, pub_year)
VALUES ('ABC Publishment', 1999),
       ('Наука', 1989);
	   
SELECT * FROM publisher;

--создание таблицы review

CREATE TABLE IF NOT EXISTS public.review
(
    review_id integer NOT NULL DEFAULT nextval('review_review_id_seq'::regclass),
    reviewer_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    reviewer_date timestamp without time zone NOT NULL,
    review character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT review_id_pk PRIMARY KEY (review_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.review
    OWNER to postgres;

--заполнение

INSERT INTO review(reviewer_name, review_date, review)
VALUES('Аноним', 11.11.21, "Интересная книга, но иногда автор не раскрывает тему до конца"),
	  ('Маша', 01.11.21, "Читается на одном дыхании")
WHERE book_review.book_id = 5;  --книга 'Практический интеллект'

SELECT * FROM review;

--создание таблицы transakt

CREATE TABLE IF NOT EXISTS public.transakt
(
    trans_id integer NOT NULL DEFAULT nextval('transakt_trans_id_seq'::regclass),
    card_id integer NOT NULL DEFAULT nextval('transakt_card_id_seq'::regclass),
    payment_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    payment_status character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_trans_id PRIMARY KEY (trans_id),
    CONSTRAINT fk_card_id FOREIGN KEY (card_id)
        REFERENCES public.card (card_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.transakt
    OWNER to postgres;

--заполнение
	
ALTER TABLE transakt 
ADD FOREIGN KEY (card_id) REFERENCES card(card_id);
INSERT INTO transakt(payment_type, payment_status)
VALUES('credit card', 'paid'),
	  ('credit card', 'paid'),
	  ('credit card', 'paid'),
	  ('credit card', 'paid'),
	  ('credit card', 'paid'),
	  ('credit card', 'unpaid');

SELECT * FROM transakt;


