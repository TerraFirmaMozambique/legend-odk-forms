

CREATE TABLE public.update_form_a_encontros_sensibilizacao
(
  geom geometry(Point,0),
  subdate timestamp without time zone,
  begin timestamp without time zone,
  intronote character varying,
  tec_nome character varying,
  data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  com_id character varying,
  pov_id character varying,
  add_pov_id character varying,
  num_m integer,
  num_h integer,
  gov_p character varying,
  gov_n character varying,
  gov_o character varying,
  encont character varying,
  act_alt character varying,
  tema character varying,
  remind character varying,
  tema_alt character varying,
  part_h character varying,
  part_m character varying,
  part_j character varying,
  lid_apoio character varying,
  encont_foto character varying,
  latitude double precision,
  longitude double precision,
  altitude double precision,
  accuracy double precision,
  obs character varying,
  finish timestamp without time zone,
  meta_id character varying,
  meta_name character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_a_encontros_sensibilizacao
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_a_encontros_sensibilizacao TO postgres;

COPY public.update_form_a_encontros_sensibilizacao FROM '/var/lib/share/projects/legend/dbupdate/form_a_encontros_sensibilizacao.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_a_encontros_sensibilizacao a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_a_encontros_sensibilizacao b
                 WHERE  a.key = b.key);

DELETE from public.update_form_a_encontros_sensibilizacao
WHERE EXISTS (SELECT 1 FROM public.form_a_encontros_sensibilizacao
WHERE key = public.update_form_a_encontros_sensibilizacao.key );


SELECT UpdateGeometrySRID('form_a_encontros_sensibilizacao','geom',0);

INSERT INTO public.form_a_encontros_sensibilizacao(
            geom, subdate, begin, intronote, tec_nome, data, prov_id, dist_id, 
            posto_id, com_id, pov_id, add_pov_id, num_m, num_h, gov_p, gov_n, 
            gov_o, encont, act_alt, tema, remind, tema_alt, part_h, part_m, 
            part_j, lid_apoio, encont_foto, latitude, longitude, altitude, 
            accuracy, obs, finish, meta_id, meta_name, key)
SELECT geom, subdate, begin, intronote, tec_nome, data, prov_id, dist_id, 
       posto_id, com_id, pov_id, add_pov_id, num_m, num_h, gov_p, gov_n, 
       gov_o, encont, act_alt, tema, remind, tema_alt, part_h, part_m, 
       part_j, lid_apoio, encont_foto, latitude, longitude, altitude, 
       accuracy, obs, finish, meta_id, meta_name, key
 FROM public.update_form_a_encontros_sensibilizacao;


SELECT UpdateGeometrySRID('form_a_encontros_sensibilizacao','geom',4326);


DROP TABLE public.update_form_a_encontros_sensibilizacao;














