CREATE TABLE public.update_form_a_rd_povoados
(
  key character varying NOT NULL,
  geom geometry(Point,0),
  sub_date timestamp without time zone,
  start timestamp without time zone,
  intronote character varying,
  tec_nome character varying,
  data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  com_id character varying,
  pov_id character varying,
  add_pov_id character varying,
  b_g1_chief_level character varying,
  b_g1_chief_app character varying,
  b_g1_chief_nome character varying,
  b_g1_chief_contact integer,
  conflict_yn character varying,
  conflict_cat character varying,
  conflict_origin character varying,
  sentido character varying,
  chief_foto character varying,
  latitude double precision,
  longitude double precision,
  altitude double precision,
  accuracy double precision,
  obs character varying,
  finish timestamp without time zone,
  meta_id character varying,
  meta_name character varying
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_a_rd_povoados OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_a_rd_povoados TO postgres;

COPY public.update_form_a_rd_povoados FROM '/var/lib/share/projects/legend/dbupdate/form_a_rd_povoados.csv'   USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_a_rd_povoados a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_a_rd_povoados b
                 WHERE  a.key = b.key);

DELETE from public.update_form_a_rd_povoados
WHERE EXISTS (SELECT 1 FROM public.form_a_rd_povoados
WHERE key = public.update_form_a_rd_povoados.key );

SELECT UpdateGeometrySRID('form_a_rd_povoados','geom',0);

INSERT INTO public.form_a_rd_povoados( key, geom, sub_date, start, intronote, tec_nome, data, prov_id, dist_id, posto_id, com_id, pov_id, add_pov_id, b_g1_chief_level,  b_g1_chief_app, b_g1_chief_nome, b_g1_chief_contact, conflict_yn, conflict_cat, conflict_origin, sentido, chief_foto, latitude, longitude, altitude, accuracy, obs, finish, meta_id, meta_name)
SELECT key, geom, sub_date, start, intronote, tec_nome, data, prov_id, dist_id, posto_id, com_id, pov_id, add_pov_id, b_g1_chief_level,  b_g1_chief_app, b_g1_chief_nome, b_g1_chief_contact, conflict_yn, conflict_cat, conflict_origin, sentido, chief_foto, latitude, longitude, altitude, accuracy, obs, finish, meta_id, meta_name
FROM update_form_a_rd_povoados;

SELECT UpdateGeometrySRID('form_a_rd_povoados','geom',4326);

DROP TABLE public.update_form_a_rd_povoados;











