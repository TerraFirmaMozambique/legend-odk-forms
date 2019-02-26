/* LEGEND certification build

DROP TABLE public.certification;

CREATE TABLE public.certification
(
  geom geometry(MultiPolygon,32737),
  upn integer NOT NULL,
  province character varying,
  district character varying,
  posto_admin text,
  assoc character varying,
  assoc_id character varying,
  povoado character varying,
  povoado_id character varying,
  party_type character varying,
  area double precision,
  x_min double precision,
  x_max double precision,
  y_min double precision,
  y_max double precision,
  produced date,
  CONSTRAINT pk_certification1 PRIMARY KEY (upn)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.certification
  OWNER TO postgres;
GRANT ALL ON TABLE public.certification TO public;
GRANT ALL ON TABLE public.certification TO postgres;*/ 


/* LEGEND */ 


DROP TABLE public.normalise_form_m_occ;

CREATE TABLE public.normalise_form_m_occ
(

  parcel_id integer,
  outcome character varying,
  party_id character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.normalise_form_m_occ
  OWNER TO postgres;
GRANT ALL ON TABLE public.normalise_form_m_occ TO public;
GRANT ALL ON TABLE public.normalise_form_m_occ TO postgres;

INSERT INTO public.normalise_form_m_occ( parcel_id, outcome, party_id, key)
SELECT parcelid, outcome, partyid, key
  FROM public.form_m_occ;

ALTER TABLE normalise_form_m_occ ADD COLUMN id_outcome character varying;

UPDATE normalise_form_m_occ set id_outcome = parcel_id ||'-'|| outcome;

ALTER TABLE normalise_form_m_occ ADD COLUMN id_count integer;

UPDATE normalise_form_m_occ set id_count = count From (Select parcel_id, count FROM (SELECT normalise_form_m_occ.parcel_id, count(parcel_id) OVER (PARTITION BY parcel_id) FROM normalise_form_m_occ) AS a) AS b
where normalise_form_m_occ.parcel_id = b.parcel_id;

ALTER TABLE normalise_form_m_occ ADD COLUMN id_outcome_count integer;

UPDATE normalise_form_m_occ set id_outcome_count = count From (Select id_outcome, count FROM (SELECT normalise_form_m_occ.id_outcome, count(id_outcome) OVER (PARTITION BY id_outcome) FROM normalise_form_m_occ) AS a) AS b
where normalise_form_m_occ.id_outcome = b.id_outcome;

ALTER TABLE normalise_form_m_occ ADD COLUMN desicion character varying;

UPDATE normalise_form_m_occ set desicion = b.desicion 
FROM (SELECT desicion, key FROM (SELECT id_outcome_count, id_count, outcome, key,
  CASE
    WHEN "id_outcome_count" = "id_count" THEN outcome 
    ELSE 'PROBLEM'
  END 
  AS desicion
FROM normalise_form_m_occ)AS a) AS b
WHERE normalise_form_m_occ.key = b.key;


DELETE FROM public.normalise_form_m_occ a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.normalise_form_m_occ b
                 WHERE  a.key = b.key);
--------------------------------------------------------------

UPDATE form_l_novas_pessoas
SET parcel_id = upn_id FROM 
(SELECT 
  form_l_registrar_parcela.upn_id, 
  form_l_registrar_parcela.key
FROM 
  public.form_l_registrar_parcela) AS a
WHERE form_l_novas_pessoas.parentuid = a.key;

-------------------------------------------------------------------
DROP TABLE public.party;

CREATE TABLE public.party
(
  id character varying,
  parcel_id integer,
  app character varying,
  nome character varying,
  gen character varying,
  civil character varying,
  prof character varying,
  prof_other character varying,
  nacion character varying,
  naturalidade character varying,
  nascyn character varying,
  nasc date,
  ida character varying,
  doc character varying,
  doc_id character varying,
  doc_local character varying,
  doc_emi date,
  doc_val date,
  doc_vital character varying,
  foto character varying,
  doc_foto character varying,
  assin character varying,
  contacto character varying,
  key character varying NOT NULL
  
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.party
  OWNER TO postgres;
GRANT ALL ON TABLE public.party TO public;
GRANT ALL ON TABLE public.party TO postgres;

----

/*
INSERT INTO public.party
SELECT party_id, parcel_id, app, nom, genero, estado_civil, prof, prof_o, nacion, naturalidade, nascyn, nasc, aida, documento, id, localidade, emi, val, vital,foto, idfoto, assin, contacto, key FROM 
(SELECT form_l_novas_pessoas.oid as party_id,form_l_novas_pessoas.parcel_id, form_l_novas_pessoas.app, form_l_novas_pessoas.nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_l_novas_pessoas.prof, form_l_novas_pessoas.prof_o, form_l_novas_pessoas.nacion, form_l_novas_pessoas.naturalidade, form_l_novas_pessoas.nascyn, form_l_novas_pessoas.nasc, form_l_novas_pessoas.aida, table_doc_identificacao.documento, form_l_novas_pessoas.id, form_l_novas_pessoas.localidade, form_l_novas_pessoas.emi, form_l_novas_pessoas.val, form_l_novas_pessoas.vital, form_l_novas_pessoas.foto, form_l_novas_pessoas.idfoto, form_l_novas_pessoas.assin, form_l_novas_pessoas.contacto, form_l_novas_pessoas.oid::text||form_l_novas_pessoas.parcel_id::text as key FROM  public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_estado_civil AS table_estado_civil RIGHT OUTER JOIN public.form_l_novas_pessoas AS form_l_novas_pessoas ON table_estado_civil.code = form_l_novas_pessoas.civil ON table_doc_identificacao.code = form_l_novas_pessoas.doc ON table_genero_pessoa.code = form_l_novas_pessoas.gen) AS a
WHERE a.key NOT IN (SELECT key FROM party);
*/

INSERT INTO public.party
SELECT id_party, upn, pessoa_app, pessoa_nom, genero, estado_civil, pessoa_prof, prof_other, pessoa_nacion, pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, documento, pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, pessoa_id_photo, pessoa_assin, contacto, key FROM
(SELECT form_k_pessoas.id_party::text, digitisations.upn, form_k_pessoas.pessoa_app, form_k_pessoas.pessoa_nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_k_pessoas.pessoa_prof, form_k_pessoas.pessoa_prof as prof_other, form_k_pessoas.pessoa_nacion, form_k_pessoas.pessoa_natural, form_k_pessoas.nasc_y_n, form_k_pessoas.pessoa_nasc, form_k_pessoas.pessoa_ida, table_doc_identificacao.documento, form_k_pessoas.pessoa_id, form_k_pessoas.doc_local, form_k_pessoas.doc_emi, form_k_pessoas.doc_val, form_k_pessoas.doc_vital, form_k_pessoas.pessoa_foto, form_k_pessoas.pessoa_id_photo, form_k_pessoas.pessoa_assin, form_k_pessoas.contacto::text,  form_k_pessoas.id_party|| digitisations.upn as key FROM  public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.form_k_pessoas AS form_k_pessoas RIGHT OUTER JOIN public.form_l_titulares AS form_l_titulares ON form_k_pessoas.id_party = form_l_titulares.found_party ON table_genero_pessoa.code = form_k_pessoas.pessoa_gen ON table_doc_identificacao.code = form_k_pessoas.pessoa_doc, public.form_l_registrar_parcela AS form_l_registrar_parcela LEFT OUTER JOIN public.digitisations AS digitisations ON form_l_registrar_parcela.upn_id = digitisations.upn , public.table_estado_civil AS table_estado_civil WHERE form_l_registrar_parcela.key = form_l_titulares.parent_key AND table_estado_civil.code = form_k_pessoas.pessoa_civil) AS a
WHERE a.key NOT IN (SELECT key FROM party);

DELETE FROM public.party a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.party b
                 WHERE  a.key = b.key);

alter table party add primary key (key);



---------------------------------------------------------------

CREATE TABLE public.udcertification
(
  geom geometry(MultiPolygon,32737),
  upn integer NOT NULL,
  province character varying,
  district character varying,
  posto_admin character varying,
  assoc character varying,
  assoc_id character varying,
  povoado character varying,
  povoado_id character varying,
  party_type character varying,
  area double precision,
  x_min double precision,
  x_max double precision,
  y_min double precision,
  y_max double precision
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.udcertification
  OWNER TO postgres;
GRANT ALL ON TABLE public.udcertification TO public;
GRANT ALL ON TABLE public.udcertification TO postgres;

INSERT INTO public.udcertification(
            geom, upn, province, district, posto_admin, assoc, assoc_id, povoado, povoado_id, party_type, area, x_min, x_max, y_min, y_max)
SELECT geom, upn, province, district, posto_admin, assoc, assoc_id, initcap(povoado) AS povoado, povoado_id, party_type, area, x_min, x_max, y_min, y_max FROM (SELECT 
  ST_Transform(digitisations.geom,32737) AS geom,
  digitisations.upn, 
  geo_table_moz_provincias.label AS province,
  geo_table_moz_distritos.distrito AS district, 
  geo_table_moz_postos.name_lower AS posto_admin, 
  table_associacao.short_label AS assoc,
  table_associacao.name AS assoc_id,
  digitisations.code_povoa AS povoado,  
  table_povoados_geom.id AS povoado_id,
  form_l_registrar_parcela.party_type, 
  digitisations.area_h AS area,
  digitisations.x_min, 
  digitisations.x_max, 
  digitisations.y_min, 
  digitisations.y_max
FROM 
  public.digitisations, 
  public.form_l_registrar_parcela, 
  public.geo_table_moz_provincias, 
  public.geo_table_moz_postos, 
  public.geo_table_moz_distritos, 
  public.normalise_form_m_occ, 
  public.table_associacao, 
  public.table_povoados_geom
WHERE 
  digitisations.upn = form_l_registrar_parcela.upn_id AND
  digitisations.upn = normalise_form_m_occ.parcel_id AND
  digitisations.code_povoa = table_povoados_geom.pov AND
  form_l_registrar_parcela.dist_id = geo_table_moz_distritos.key AND
  form_l_registrar_parcela.posto_id = geo_table_moz_postos.name AND
  form_l_registrar_parcela.prov_id = geo_table_moz_provincias.name AND
  form_l_registrar_parcela.assocs_id = table_associacao.name AND
  (form_l_registrar_parcela.party_type = 'sing' OR 
  form_l_registrar_parcela.party_type = 'cotitular') AND 
  normalise_form_m_occ.desicion = 'certify'
ORDER BY
  table_associacao.name ASC, 
  digitisations.upn ASC) AS a;

DELETE FROM public.udcertification a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.udcertification b
                 WHERE  a.upn = b.upn);

DELETE from public.udcertification
WHERE EXISTS (SELECT 1 FROM public.certification 
WHERE upn = public.udcertification.upn);  

ALTER TABLE udcertification ADD COLUMN produced date;
UPDATE udcertification SET produced = 'now';

INSERT INTO public.certification(
            geom, upn, province, district, posto_admin, assoc, assoc_id, povoado, povoado_id, party_type, 
            area, x_min, x_max, y_min, y_max, produced)
SELECT geom, upn, province, district, posto_admin, assoc, assoc_id, povoado, povoado_id, party_type, 
       area, x_min, x_max, y_min, y_max, produced
FROM public.udcertification;

DROP TABLE public.udcertification;

UPDATE certification
set area =  ST_Area FROM (SELECT ST_Area(geom), upn  FROM certification) AS a
WHERE certification.upn = a.upn;

UPDATE certification
set x_min = ST_XMin FROM (SELECT ST_XMin(geom), upn from certification)as a
where certification.upn = a.upn;

UPDATE certification
set x_max = ST_XMax FROM (SELECT ST_XMax(geom), upn from certification)as a
where certification.upn = a.upn;

UPDATE certification
set y_min = ST_YMin FROM (SELECT ST_YMin(geom), upn from certification)as a
where certification.upn = a.upn;

UPDATE certification
set y_max = ST_YMax FROM (SELECT ST_YMax(geom), upn from certification)as a
where certification.upn = a.upn;
	




