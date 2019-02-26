/* declarations formation update party table 
*/
INSERT INTO public.party

SELECT 
  form_k_pessoas.id_party, 
  digitisations.upn, 
  form_k_pessoas.pessoa_app, 
  form_k_pessoas.pessoa_nom, 
  table_genero_pessoa.genero, 
  table_estado_civil.estado_civil, 
  form_k_pessoas.pessoa_prof,
  form_k_pessoas.pessoa_prof as prof_other, 
  form_k_pessoas.pessoa_nacion, 
  form_k_pessoas.pessoa_natural, 
  form_k_pessoas.nasc_y_n, 
  form_k_pessoas.pessoa_nasc, 
  form_k_pessoas.pessoa_ida, 
  table_doc_identificacao.documento, 
  form_k_pessoas.pessoa_id, 
  form_k_pessoas.doc_local, 
  form_k_pessoas.doc_emi, 
  form_k_pessoas.doc_val, 
  form_k_pessoas.doc_vital, 
  form_k_pessoas.pessoa_foto, 
  form_k_pessoas.pessoa_id_photo, 
  form_k_pessoas.pessoa_assin, 
  form_k_pessoas.contacto, 
  form_k_pessoas.id_party|| digitisations.upn as key
FROM 
  public.form_k_pessoas, 
  public.form_l_titulares, 
  public.form_l_registrar_parcela, 
  public.digitisations, 
  public.table_genero_pessoa, 
  public.table_doc_identificacao, 
  public.table_estado_civil
WHERE 
  form_k_pessoas.pessoa_gen = table_genero_pessoa.code AND
  form_k_pessoas.pessoa_doc = table_doc_identificacao.code AND
  form_k_pessoas.pessoa_civil = table_estado_civil.code AND
  form_l_titulares.found_party = form_k_pessoas.id_party AND
  form_l_titulares.parent_key = form_l_registrar_parcela.meta_inst_id AND
  digitisations.upn = form_l_registrar_parcela.upn_id AND
  form_k_pessoas.id_party|| digitisations.upn NOT IN (SELECT key FROM party);
  
  ALTER TABLE party SET WITH OIDS;
  
  -----------------------Tenure right attested through OCC----------------------------
  
/*  Update the OCC table with any changes to status */ 
  
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
				 
------------- produce the link for the testamunhas names 	
DROP TABLE public.testmunhas_name;
			 
CREATE TABLE public.testmunhas_name as (
SELECT 
  form_l_registrar_parcela.upn_id, 
   concat(form_k_pessoas.pessoa_nom,' ',form_k_pessoas.pessoa_app)
FROM 
  public.form_l_registrar_parcela, 
  public.form_l_testemunhas_v2, 
  public.form_k_pessoas
WHERE 
  form_l_registrar_parcela.key = form_l_testemunhas_v2.parent_uid AND
  form_l_testemunhas_v2.found_testem = form_k_pessoas.id_party
order by form_l_registrar_parcela.upn_id ASC);	

ALTER TABLE testmunhas_name SET WITH OIDS;		 
				 
----- Make the declorations ------------------------------------------

-- spatial			 
				 
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
SELECT ST_Transform(public.digitisations.geom,32737) AS geom, 
public.digitisations.upn as upn, 
public.geo_table_moz_provincias.label as province, 
public.geo_table_moz_distritos.distrito as district, 
public.geo_table_moz_postos.name_lower as posto_admin, 
public.table_associacao.short_label as assoc,
public.table_associacao.name as assoc_id, 
public.table_povoados_geom.nome as povoado,
public.table_povoados_geom.id as povoado_id,
public.form_l_registrar_parcela.party_type as party_type, 
public.digitisations.area_h as area, 
public.digitisations.x_min, 
public.digitisations.x_max, 
public.digitisations.y_min, 
public.digitisations.y_max
FROM ((((((public.digitisations 
INNER JOIN public.form_l_registrar_parcela ON public.digitisations.upn = public.form_l_registrar_parcela.upn_id) 
INNER JOIN public.table_associacao ON public.form_l_registrar_parcela.assocs_id = public.table_associacao.name) 
INNER JOIN public.geo_table_moz_provincias ON public.form_l_registrar_parcela.prov_id = public.geo_table_moz_provincias.name) 
INNER JOIN public.geo_table_moz_distritos ON public.form_l_registrar_parcela.dist_id = public.geo_table_moz_distritos.key) 
INNER JOIN public.geo_table_moz_postos ON public.form_l_registrar_parcela.posto_id = public.geo_table_moz_postos.name) 
INNER JOIN public.table_povoados_geom ON public.digitisations.code_povoa = public.table_povoados_geom.pov) 
INNER JOIN public.normalise_form_m_occ ON public.digitisations.upn = public.normalise_form_m_occ.parcel_id
WHERE (form_l_registrar_parcela.party_type = 'sing' OR 
  form_l_registrar_parcela.party_type = 'cotitular') AND 
  normalise_form_m_occ.desicion = 'certify';
  
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