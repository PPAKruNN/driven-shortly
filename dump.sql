--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

-- Started on 2023-08-07 04:22:59 -03

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
-- TOC entry 211 (class 1259 OID 16605)
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    userid integer NOT NULL,
    token character varying(72),
    createdat timestamp without time zone DEFAULT now()
);


--
-- TOC entry 213 (class 1259 OID 16617)
-- Name: shorturls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shorturls (
    id integer NOT NULL,
    userid integer NOT NULL,
    visitcount integer DEFAULT 0 NOT NULL,
    shorturl character varying(21) NOT NULL,
    url text NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);


--
-- TOC entry 212 (class 1259 OID 16616)
-- Name: shorturls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shorturls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 212
-- Name: shorturls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shorturls_id_seq OWNED BY public.shorturls.id;


--
-- TOC entry 210 (class 1259 OID 16594)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    email character varying(256) NOT NULL,
    passwordhash character varying(72) NOT NULL,
    createdat timestamp without time zone DEFAULT now()
);


--
-- TOC entry 209 (class 1259 OID 16593)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3221 (class 2604 OID 16620)
-- Name: shorturls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls ALTER COLUMN id SET DEFAULT nextval('public.shorturls_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 16597)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3229 (class 2606 OID 16610)
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- TOC entry 3231 (class 2606 OID 16626)
-- Name: shorturls shorturls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_pkey PRIMARY KEY (id);


--
-- TOC entry 3233 (class 2606 OID 16628)
-- Name: shorturls shorturls_shorturl_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_shorturl_key UNIQUE (shorturl);


--
-- TOC entry 3225 (class 2606 OID 16604)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3227 (class 2606 OID 16602)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3234 (class 2606 OID 16611)
-- Name: sessions sessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- TOC entry 3235 (class 2606 OID 16629)
-- Name: shorturls shorturls_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


-- Completed on 2023-08-07 04:22:59 -03

--
-- PostgreSQL database dump complete
--

