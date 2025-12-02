--
-- PostgreSQL database dump
--

\restrict Y4f4smyLeu7BJTnYDtDqk9Bd1DvGTWpPBBB86mDcGfc1mFp00Rj59CiDfQ38ZRU

-- Dumped from database version 18.0 (Debian 18.0-1.pgdg13+3)
-- Dumped by pg_dump version 18.0 (Debian 18.0-1.pgdg13+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.transaction DROP CONSTRAINT IF EXISTS transaction_account_iban_fkey;
ALTER TABLE IF EXISTS ONLY public.account DROP CONSTRAINT IF EXISTS account_client_id_fkey;
DROP INDEX IF EXISTS public.idx_transaction_iban;
ALTER TABLE IF EXISTS ONLY public.transaction DROP CONSTRAINT IF EXISTS transaction_pkey;
ALTER TABLE IF EXISTS ONLY public.client DROP CONSTRAINT IF EXISTS client_tax_code_key;
ALTER TABLE IF EXISTS ONLY public.client DROP CONSTRAINT IF EXISTS client_pkey;
ALTER TABLE IF EXISTS ONLY public.client DROP CONSTRAINT IF EXISTS client_email_key;
ALTER TABLE IF EXISTS ONLY public.account DROP CONSTRAINT IF EXISTS account_pkey;
ALTER TABLE IF EXISTS public.transaction ALTER COLUMN transaction_id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.transaction_transaction_id_seq;
DROP TABLE IF EXISTS public.transaction;
DROP TABLE IF EXISTS public.client;
DROP SEQUENCE IF EXISTS public.client_id_seq;
DROP TABLE IF EXISTS public.account;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: banklify_user
--

CREATE TABLE public.account (
    iban character varying(27) NOT NULL,
    client_id integer NOT NULL,
    ledger_balance numeric(15,2) DEFAULT 0.00 NOT NULL,
    available_balance numeric(15,2) DEFAULT 0.00 NOT NULL,
    status character varying(50) DEFAULT 'ACTIVE'::character varying NOT NULL,
    opening_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.account OWNER TO banklify_user;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: banklify_user
--

CREATE SEQUENCE public.client_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO banklify_user;

--
-- Name: client; Type: TABLE; Schema: public; Owner: banklify_user
--

CREATE TABLE public.client (
    client_id bigint DEFAULT nextval('public.client_id_seq'::regclass) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    tax_code character varying(16) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    address character varying,
    house_number character varying(20),
    city character varying(100),
    province character varying(2),
    zip_code character varying(5),
    phone_number character varying(20),
    birth_date date
);


ALTER TABLE public.client OWNER TO banklify_user;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: banklify_user
--

CREATE TABLE public.transaction (
    transaction_id bigint NOT NULL,
    account_iban character varying(27) NOT NULL,
    event_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    amount numeric(15,2) NOT NULL,
    transaction_type character varying(100) NOT NULL,
    description text,
    sender_iban character varying(27),
    sender_name character varying(255),
    receiver_iban character varying(27),
    receiver_name character varying(255)
);


ALTER TABLE public.transaction OWNER TO banklify_user;

--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: banklify_user
--

CREATE SEQUENCE public.transaction_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_transaction_id_seq OWNER TO banklify_user;

--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: banklify_user
--

ALTER SEQUENCE public.transaction_transaction_id_seq OWNED BY public.transaction.transaction_id;


--
-- Name: transaction transaction_id; Type: DEFAULT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.transaction ALTER COLUMN transaction_id SET DEFAULT nextval('public.transaction_transaction_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: banklify_user
--

INSERT INTO public.account VALUES ('IT601234500001000000000007', 7, 83.00, 83.00, 'ACTIVE', '2025-11-30 18:13:41.36308');
INSERT INTO public.account VALUES ('IT601234500001000000000006', 6, 2057.50, 2057.50, 'ACTIVE', '2025-11-30 18:38:18.413653');
INSERT INTO public.account VALUES ('IT601234500001000000000005', 5, 12863.25, 12863.25, 'ACTIVE', '2025-11-30 18:38:18.417452');
INSERT INTO public.account VALUES ('IT601234500001000000000008', 8, 0.00, 0.00, 'ACTIVE', '2025-11-30 21:45:38.490206');


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: banklify_user
--

INSERT INTO public.client VALUES (5, 'Mario', 'Rossi', 'MRORSS00X00X000X', 'mario.rossi@banklify.it', '$2a$10$CJS0Wk5g/TOEtl8QK8qWIudcmedNlq3RaTsE4Y/ouNRq7p3eZanmy', '2025-11-19 19:55:32.439072', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.client VALUES (6, 'Roberto', 'Rossi', 'RBTRSS00X00X000X', 'roberto.rossi@banklify.it', '$2a$10$dmjxKBHwGIV7q2UD.HgEt.CI79OUsbRRRf1au4uhCLui/nPdSRo6m', '2025-11-19 20:06:16.729794', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.client VALUES (7, 'Giovanni', 'Rossi', 'RSSGVN00X00X000X', 'giovanni.rossi@banklify.it', '$2a$10$H4wQi3pt7Cl1fpZS9ebUleJXiuLM.qdRGnwSlKy1Mknlfbzgch.N.', '2025-11-19 23:00:17.087409', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.client VALUES (8, 'Mario', 'Bianchi', 'BNCMRO94P15E556Q', 'mario.bianchi@banklify.it', '$2a$10$V6EmJeL5cma7CTgGTX9mT.WZn.4giblghnCQiYtjFWHtbjsVPzkgG', '2025-11-30 21:45:38.347143', 'Via Milano', '11', 'Milano', 'MI', '00199', '3391562169', '1992-06-18');


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: banklify_user
--

INSERT INTO public.transaction VALUES (29, 'IT601234500001000000000006', '2025-11-30 18:13:16.573861', -51.00, 'OUTGOING_INTERNAL', 'Bolletta gas', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');
INSERT INTO public.transaction VALUES (30, 'IT601234500001000000000007', '2025-11-30 18:13:16.573861', 51.00, 'INCOMING_INTERNAL', 'Bolletta gas', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');
INSERT INTO public.transaction VALUES (15, 'IT601234500001000000000005', '2025-11-29 15:43:20.398824', 150.75, 'INCOMING_EXTERNAL', 'Pagamento affitto gennaio', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (16, 'IT601234500001000000000006', '2025-11-29 15:44:27.482817', 150.75, 'INCOMING_EXTERNAL', 'Acquisto auto', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT', 'IT601234500001000000000006', 'Roberto Rossi');
INSERT INTO public.transaction VALUES (17, 'IT601234500001000000000006', '2025-11-29 15:44:50.51', 15000.75, 'INCOMING_EXTERNAL', 'Acquisto auto saldo', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT', 'IT601234500001000000000006', 'Roberto Rossi');
INSERT INTO public.transaction VALUES (31, 'IT601234500001000000000006', '2025-11-30 18:13:41.344913', -12.00, 'OUTGOING_INTERNAL', 'Bolletta intenet', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');
INSERT INTO public.transaction VALUES (18, 'IT601234500001000000000006', '2025-11-29 15:45:44.740931', -600.00, 'OUTGOING_EXTERNAL', 'Acquisto gomme auto', 'IT601234500001000000000006', 'Roberto Rossi', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT');
INSERT INTO public.transaction VALUES (32, 'IT601234500001000000000007', '2025-11-30 18:13:41.344913', 12.00, 'INCOMING_INTERNAL', 'Bolletta intenet', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');
INSERT INTO public.transaction VALUES (33, 'IT601234500001000000000006', '2025-11-30 18:38:18.394408', -11.00, 'OUTGOING_INTERNAL', 'Spesa', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Roberto Rossi');
INSERT INTO public.transaction VALUES (34, 'IT601234500001000000000005', '2025-11-30 18:38:18.394408', 11.00, 'INCOMING_INTERNAL', 'Spesa', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (19, 'IT601234500001000000000006', '2025-11-29 16:05:28.238416', -250.00, 'OUTGOING_INTERNAL', 'Regalo di natale', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (21, 'IT601234500001000000000006', '2025-11-29 16:09:13.867214', -10000.00, 'OUTGOING_INTERNAL', 'Regalo di laurea', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (23, 'IT601234500001000000000006', '2025-11-29 16:16:08.716805', -2000.00, 'OUTGOING_INTERNAL', 'Acquisto scooter', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (25, 'IT601234500001000000000006', '2025-11-29 16:25:04.285203', -150.00, 'OUTGOING_INTERNAL', 'Regalo compleanno', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (26, 'IT601234500001000000000005', '2025-11-29 16:25:04.285203', 150.00, 'INCOMING_INTERNAL', 'Regalo compleanno', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (13, 'IT601234500001000000000005', '2025-11-29 15:40:12.890323', 150.75, 'INCOMING_EXTERNAL', 'Pagamento affitto', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (14, 'IT601234500001000000000005', '2025-11-29 15:42:41.976174', 150.75, 'INCOMING_EXTERNAL', 'Pagamento affitto dicembre', 'IT60X0542811101000000123456', 'Tommaso Bianchi EXT', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (20, 'IT601234500001000000000005', '2025-11-29 16:05:28.238416', 250.00, 'INCOMING_INTERNAL', 'Regalo di natale', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (22, 'IT601234500001000000000005', '2025-11-29 16:09:13.867214', 10000.00, 'INCOMING_INTERNAL', 'Regalo di laurea', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (24, 'IT601234500001000000000005', '2025-11-29 16:16:08.716805', 2000.00, 'INCOMING_INTERNAL', 'Acquisto scooter', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000005', 'Mario Rossi');
INSERT INTO public.transaction VALUES (27, 'IT601234500001000000000006', '2025-11-30 18:12:04.010812', -20.00, 'OUTGOING_INTERNAL', 'Bolletta Luce', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');
INSERT INTO public.transaction VALUES (28, 'IT601234500001000000000007', '2025-11-30 18:12:04.010812', 20.00, 'INCOMING_INTERNAL', 'Bolletta Luce', 'IT601234500001000000000006', 'Roberto Rossi', 'IT601234500001000000000007', 'Giovanni Rossi');


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banklify_user
--

SELECT pg_catalog.setval('public.client_id_seq', 8, true);


--
-- Name: transaction_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: banklify_user
--

SELECT pg_catalog.setval('public.transaction_transaction_id_seq', 34, true);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (iban);


--
-- Name: client client_email_key; Type: CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_email_key UNIQUE (email);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (client_id);


--
-- Name: client client_tax_code_key; Type: CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_tax_code_key UNIQUE (tax_code);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (transaction_id);


--
-- Name: idx_transaction_iban; Type: INDEX; Schema: public; Owner: banklify_user
--

CREATE INDEX idx_transaction_iban ON public.transaction USING btree (account_iban);


--
-- Name: account account_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(client_id);


--
-- Name: transaction transaction_account_iban_fkey; Type: FK CONSTRAINT; Schema: public; Owner: banklify_user
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_account_iban_fkey FOREIGN KEY (account_iban) REFERENCES public.account(iban);


--
-- PostgreSQL database dump complete
--

\unrestrict Y4f4smyLeu7BJTnYDtDqk9Bd1DvGTWpPBBB86mDcGfc1mFp00Rj59CiDfQ38ZRU

