--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: observation; Type: TABLE; Schema: v1; Owner: postgres
--

CREATE TABLE v1.observation (
    id bigint NOT NULL,
    data jsonb,
    stream_id bigint,
    featureofinterest_id bigint
);


ALTER TABLE v1.observation OWNER TO postgres;

--
-- Name: observation_id_seq; Type: SEQUENCE; Schema: v1; Owner: postgres
--

CREATE SEQUENCE v1.observation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE v1.observation_id_seq OWNER TO postgres;

--
-- Name: observation_id_seq; Type: SEQUENCE OWNED BY; Schema: v1; Owner: postgres
--

ALTER SEQUENCE v1.observation_id_seq OWNED BY v1.observation.id;


--
-- Name: observation id; Type: DEFAULT; Schema: v1; Owner: postgres
--

ALTER TABLE ONLY v1.observation ALTER COLUMN id SET DEFAULT nextval('v1.observation_id_seq'::regclass);


--
-- Name: fki_featureofinterest; Type: INDEX; Schema: v1; Owner: postgres
--

CREATE INDEX fki_featureofinterest ON v1.observation USING btree (featureofinterest_id);


--
-- Name: i_dsid_id; Type: INDEX; Schema: v1; Owner: postgres
--

CREATE INDEX i_dsid_id ON v1.observation USING btree (stream_id, id);


--
-- Name: i_id; Type: INDEX; Schema: v1; Owner: postgres
--

CREATE INDEX i_id ON v1.observation USING btree (id);


--
-- Name: observation fk_datastream; Type: FK CONSTRAINT; Schema: v1; Owner: postgres
--

ALTER TABLE ONLY v1.observation
    ADD CONSTRAINT fk_datastream FOREIGN KEY (stream_id) REFERENCES v1.datastream(id) ON DELETE CASCADE;


--
-- Name: observation fk_featureofinterest; Type: FK CONSTRAINT; Schema: v1; Owner: postgres
--

ALTER TABLE ONLY v1.observation
    ADD CONSTRAINT fk_featureofinterest FOREIGN KEY (featureofinterest_id) REFERENCES v1.featureofinterest(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

