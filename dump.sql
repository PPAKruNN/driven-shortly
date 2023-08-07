--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

-- Started on 2023-08-07 04:00:51 -03

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
-- TOC entry 213 (class 1259 OID 16583)
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    userid integer NOT NULL,
    token character varying(72)
);


--
-- TOC entry 212 (class 1259 OID 16567)
-- Name: shorturls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shorturls (
    id integer NOT NULL,
    userid integer NOT NULL,
    visitcount integer DEFAULT 0 NOT NULL,
    shorturl character varying(21) NOT NULL,
    url text NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 16566)
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
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 211
-- Name: shorturls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shorturls_id_seq OWNED BY public.shorturls.id;


--
-- TOC entry 210 (class 1259 OID 16546)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    email character varying(256) NOT NULL,
    passwordhash character varying(72) NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 16545)
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
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 209
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3219 (class 2604 OID 16570)
-- Name: shorturls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls ALTER COLUMN id SET DEFAULT nextval('public.shorturls_id_seq'::regclass);


--
-- TOC entry 3218 (class 2604 OID 16549)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3230 (class 2606 OID 16587)
-- Name: sessions sessions_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_token_key UNIQUE (token);


--
-- TOC entry 3226 (class 2606 OID 16575)
-- Name: shorturls shorturls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_pkey PRIMARY KEY (id);


--
-- TOC entry 3228 (class 2606 OID 16577)
-- Name: shorturls shorturls_shorturl_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_shorturl_key UNIQUE (shorturl);


--
-- TOC entry 3222 (class 2606 OID 16555)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3224 (class 2606 OID 16553)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16588)
-- Name: sessions sessions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


--
-- TOC entry 3231 (class 2606 OID 16578)
-- Name: shorturls shorturls_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shorturls
    ADD CONSTRAINT shorturls_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(id);


-- Completed on 2023-08-07 04:00:51 -03

--
-- PostgreSQL database dump complete
--

