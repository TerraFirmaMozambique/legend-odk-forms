

CREATE TABLE public.update_form_c_reg_encontros_assoc
(
  geom geometry(Point,0),
  submissiondate timestamp without time zone,
  start timestamp without time zone,
  my_form_name character varying,
  intronote character varying,
  tec_nome character varying,
  add_nome character varying,
  data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  pov_num integer,
  pov_ids character varying,
  add_pov character varying,
  num_m integer,
  num_h integer,
  gov_p character varying,
  gov_n character varying,
  gov_o character varying,
  encont character varying,
  act_alt character varying,
  tema character varying,
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
ALTER TABLE public.update_form_c_reg_encontros_assoc
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_c_reg_encontros_assoc TO postgres;

COPY public.update_form_c_reg_encontros_assoc FROM '/var/lib/share/projects/legend/dbupdate/form_c_reg_encontros_assoc.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_c_reg_encontros_assoc a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_c_reg_encontros_assoc b
                 WHERE  a.key = b.key);

DELETE from public.update_form_c_reg_encontros_assoc
WHERE EXISTS (SELECT 1 FROM public.form_c_reg_encontros_assoc
WHERE key = public.update_form_c_reg_encontros_assoc.key );



SELECT UpdateGeometrySRID('form_c_reg_encontros_assoc','geom',0);

INSERT INTO public.form_c_reg_encontros_assoc(
            geom, submissiondate, start, my_form_name, intronote, tec_nome, 
            add_nome, data, prov_id, dist_id, posto_id, pov_num, pov_ids, 
            add_pov, num_m, num_h, gov_p, gov_n, gov_o, encont, act_alt, 
            tema, tema_alt, part_h, part_m, part_j, lid_apoio, encont_foto, 
            latitude, longitude, altitude, accuracy, obs, finish, meta_id, 
            meta_name, key)
SELECT geom, submissiondate, start, my_form_name, intronote, tec_nome, 
       add_nome, data, prov_id, dist_id, posto_id, pov_num, pov_ids, 
       add_pov, num_m, num_h, gov_p, gov_n, gov_o, encont, act_alt, 
       tema, tema_alt, part_h, part_m, part_j, lid_apoio, encont_foto, 
       latitude, longitude, altitude, accuracy, obs, finish, meta_id, 
       meta_name, key
  FROM public.update_form_c_reg_encontros_assoc;


SELECT UpdateGeometrySRID('form_c_reg_encontros_assoc','geom',4326);

DROP TABLE public.update_form_c_reg_encontros_assoc;



