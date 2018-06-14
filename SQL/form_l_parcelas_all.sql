CREATE TABLE public.update_form_l_registrar_parcela
(
  geom geometry(Point,0),
  sub_date timestamp without time zone,
  begin timestamp without time zone,
  formname character varying,
  intronote character varying,
  tec_name character varying,
  registo_data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  assocs_id character varying,
  upn_id bigint,
  upn_check bigint,
  ocup character varying,
  ocup_outro character varying,
  z_excl character varying,
  part_excl character varying,
  tipo_excl character varying,
  conf character varying,
  tipo_conf character varying,
  desc_conf character varying,
  use_cat character varying,
  use_tipo character varying,
  use_prin character varying,
  use_outro character varying,
  demarcator character varying,
  nomedemarcator character varying,
  party_type character varying,
  add_party_number integer,
  party_menor character varying,
  titulares_count integer,
  set_of_titulares character varying,
  searchtext1 character varying,
  foundrepmenor character varying,
  searchtext2 character varying,
  foundrepent character varying,
  entnome character varying,
  enttipo character varying,
  reg_party_yn character varying,
  reg_newparty_number integer,
  novas_pessoas_count integer,
  set_of_novas_pessoas character varying,
  testem_num integer,
  testemunhas_count integer,
  set_of_testemunhas character varying,
  regparty1yn character varying,
  regnewparty1number integer,
  novaspessoas1count integer,
  novaspessoas1 character varying,
  latitude double precision,
  longitude double precision,
  altitude double precision,
  accuracy double precision,
  limites_yn character varying,
  set_of_pontos character varying,
  endnote character varying,
  recibo_image character varying,
  finish timestamp without time zone,
  meta_inst_id character varying,
  meta_inst_name character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_registrar_parcela
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_parcela TO postgres;


COPY public.update_form_l_registrar_parcela FROM '/var/lib/share/projects/legend/dbupdate/form_l_registrar_parcela.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_registrar_parcela a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_registrar_parcela b
                 WHERE  a.key = b.key);
				 
DELETE from public.update_form_l_registrar_parcela
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_parcela 
WHERE key = public.update_form_l_registrar_parcela.key);

UPDATE public.update_form_l_registrar_parcela 
SET recibo_image = '<img src="'||recibo_image||'" style="width:256px;height:256px;">';

SELECT UpdateGeometrySRID('form_l_registrar_parcela','geom',0);


INSERT INTO public.form_l_registrar_parcela(
            geom, sub_date, begin, formname, intronote, tec_name, registo_data, 
            prov_id, dist_id, posto_id, assocs_id, upn_id, upn_check, ocup, 
            ocup_outro, z_excl, part_excl, tipo_excl, conf, tipo_conf, desc_conf, 
            use_cat, use_tipo, use_prin, use_outro, demarcator, nomedemarcator, 
            party_type, add_party_number, party_menor, titulares_count, set_of_titulares, 
            searchtext1, foundrepmenor, searchtext2, foundrepent, entnome, 
            enttipo, reg_party_yn, reg_newparty_number, novas_pessoas_count, 
            set_of_novas_pessoas, testem_num, testemunhas_count, set_of_testemunhas, 
            regparty1yn, regnewparty1number, novaspessoas1count, novaspessoas1, 
            latitude, longitude, altitude, accuracy, limites_yn, set_of_pontos, 
            endnote, recibo_image, finish, meta_inst_id, meta_inst_name, key)
			
			
SELECT geom, sub_date, begin, formname, intronote, tec_name, registo_data, 
       prov_id, dist_id, posto_id, assocs_id, upn_id, upn_check, ocup, 
       ocup_outro, z_excl, part_excl, tipo_excl, conf, tipo_conf, desc_conf, 
       use_cat, use_tipo, use_prin, use_outro, demarcator, nomedemarcator, 
       party_type, add_party_number, party_menor, titulares_count, set_of_titulares, 
       searchtext1, foundrepmenor, searchtext2, foundrepent, entnome, 
       enttipo, reg_party_yn, reg_newparty_number, novas_pessoas_count, 
       set_of_novas_pessoas, testem_num, testemunhas_count, set_of_testemunhas, 
       regparty1yn, regnewparty1number, novaspessoas1count, novaspessoas1, 
       latitude, longitude, altitude, accuracy, limites_yn, set_of_pontos, 
       endnote, recibo_image, finish, meta_inst_id, meta_inst_name, 
       key
  FROM public.update_form_l_registrar_parcela;
  
  DROP TABLE public.update_form_l_registrar_parcela;
  
  -----------------------------------
  
  CREATE TABLE public.update_form_l_titulares
(
  searchtext character varying,
  found_party character varying,
  parent_key character varying,
  key_test character varying
  
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_titulares   OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_titulares TO postgres;

COPY public.update_form_l_titulares FROM '/var/lib/share/projects/legend/dbupdate/form_l_titulares.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_titulares
WHERE found_party = '1';

DELETE FROM public.update_form_l_titulares a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_titulares b
                 WHERE  a.key_test = b.key_test);
				 
DELETE from public.update_form_l_titulares
WHERE EXISTS (SELECT 1 FROM public.form_l_titulares 
WHERE key_test = public.update_form_l_titulares.key_test);


INSERT INTO public.form_l_titulares(
            searchtext, found_party, parent_key, key_test)
SELECT searchtext, found_party, parent_key, key_test
  FROM public.update_form_l_titulares;
  
  --------------------------------------------------
  
  CREATE TABLE public.update_form_l_novas_pessoas
(
app character varying,
nom character varying,
role character varying,
gen character varying,
civil character varying,
prof character varying,
prof_o character varying,
nacion character varying,
naturalidade character varying,
nascyn character varying,
nasc date,
aida character varying,
doc character varying,
id character varying,
localidade character varying,
emi date,
val date,
vital character varying,
foto character varying,
idfoto character varying,
assin character varying,
contacto character varying,
parentuid character varying,
party_name character varying,
party_name_key character varying,
key_test character varying,
confirmardo character varying,
parcel_id integer

)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE public.update_form_l_novas_pessoas  OWNER to postgres;
GRANT ALL ON TABLE public.update_form_l_novas_pessoas TO postgres;


COPY public.update_form_l_novas_pessoas FROM '/var/lib/share/projects/legend/dbupdate/form_l_novas_pessoas.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_novas_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_novas_pessoas b
                 WHERE  a.party_name_key = b.party_name_key);
				 
DELETE from public.update_form_l_novas_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_l_novas_pessoas 
WHERE party_name_key = public.update_form_l_novas_pessoas.party_name_key);

UPDATE update_form_l_novas_pessoas
SET foto = '<img src="'||foto||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_l_novas_pessoas
SET idfoto = '<img src="'||idfoto||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_l_novas_pessoas
SET assin = '<img src="'||assin||'" style="width:1024px;height:1024px;" />';


INSERT INTO public.form_l_novas_pessoas(
            app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, foto, 
            idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, confirmardo, parcel_id)
SELECT app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
       nascyn, nasc, aida, doc, id, localidade, emi, val, vital, foto, 
       idfoto, assin, contacto, parentuid, party_name, party_name_key, 
       key_test, confirmardo, parcel_id
  FROM public.update_form_l_novas_pessoas;		
  
DROP TABLE public.update_form_l_novas_pessoas;  

-------------------------------------------------------
/*CREATE TABLE public.update_form_l_registrar_pontos
(
    geom geometry(Point, 0),
    latitude double precision,
    longitude double precision,
    altitude double precision,
    accuracy double precision,
    upngpslimit character varying COLLATE pg_catalog."default",
    parentuid character varying COLLATE pg_catalog."default" NOT NULL,
    key character varying COLLATE pg_catalog."default",
    assocsid character varying
	)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_registrar_pontos
  OWNER TO postgres;

GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO public;

	COPY public.update_form_l_registrar_pontos FROM '/var/lib/share/projects/legend/dbupdate/form_l_pontos.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

UPDATE update_form_l_registrar_pontos SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);


INSERT INTO public.form_l_registrar_pontos(
            geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, key, assocsid)
SELECT geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, key, assocsid
  FROM public.update_form_l_registrar_pontos
  WHERE key NOT IN (Select key from form_l_registrar_pontos ORDER BY key ASC );

DROP TABLE public.update_form_l_registrar_pontos;
*/
----------------------------------------------

CREATE TABLE public.update_form_l_testemunhas
(
  ng4_testem_nome character varying,
  ng4_testem_type character varying,
  testem_assin character varying,
  parent_key character varying,
  key character varying NOT NULL
  
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_testemunhas OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_testemunhas TO postgres;


COPY public.update_form_l_testemunhas FROM '/var/lib/share/projects/legend/dbupdate/form_l_testemunhas.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_testemunhas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_testemunhas b
                 WHERE  a.key = b.key);
	
	DELETE FROM public.update_form_l_testemunhas
WHERE EXISTS (SELECT 1 FROM public.form_l_testemunhas 
WHERE key = public.update_form_l_testemunhas.key );

INSERT INTO public.form_l_testemunhas
(ng4_testem_nome, ng4_testem_type, testem_assin,parent_key, key)
SELECT ng4_testem_nome, ng4_testem_type, testem_assin,parent_key, key
FROM public.update_form_l_testemunhas;

DROP TABLE public.update_form_l_testemunhas;


CREATE TABLE public.update_form_l_testemunhas_v2
(
  search_text character varying,
  found_testem character varying,
  testem_type character varying,
  parent_uid character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_testemunhas_v2 OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_testemunhas_v2 TO postgres;

COPY public.update_form_l_testemunhas_v2 FROM '/var/lib/share/projects/legend/dbupdate/form_l_testemunhas_v2.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_testemunhas_v2
WHERE found_testem = '1';

DELETE FROM public.update_form_l_testemunhas_v2 a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_testemunhas_v2 b
                 WHERE  a.key = b.key);
				 
DELETE from public.update_form_l_testemunhas_v2
WHERE EXISTS (SELECT 1 FROM public.form_l_testemunhas_v2 
WHERE key = public.update_form_l_testemunhas_v2.key);

INSERT INTO public.form_l_testemunhas_v2(search_text, found_testem, testem_type, parent_uid, key)
SELECT search_text, found_testem, testem_type, parent_uid, key
FROM public.update_form_l_testemunhas_v2;

DROP TABLE public.update_form_l_testemunhas_v2;

  
DROP TABLE public.update_form_l_titulares;
  
  SELECT UpdateGeometrySRID('form_l_registrar_parcela','geom',4326);
  
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

INSERT INTO public.party
SELECT party_id, parcel_id, app, nom, genero, estado_civil, prof, prof_o, nacion, naturalidade, nascyn, nasc, aida, documento, doc_id, localidade, emi, val, vital,foto, idfoto, assin, contacto, key FROM 
(SELECT form_l_novas_pessoas.oid as party_id,form_l_novas_pessoas.parcel_id, form_l_novas_pessoas.app, form_l_novas_pessoas.nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_l_novas_pessoas.prof, form_l_novas_pessoas.prof_o, form_l_novas_pessoas.nacion, form_l_novas_pessoas.naturalidade, form_l_novas_pessoas.nascyn, form_l_novas_pessoas.nasc, form_l_novas_pessoas.aida, table_doc_identificacao.documento, form_l_novas_pessoas.doc_id, form_l_novas_pessoas.localidade, form_l_novas_pessoas.emi, form_l_novas_pessoas.val, form_l_novas_pessoas.vital, form_l_novas_pessoas.foto, form_l_novas_pessoas.idfoto, form_l_novas_pessoas.assin, form_l_novas_pessoas.contacto, form_l_novas_pessoas.oid::text||form_l_novas_pessoas.parcel_id::text as key FROM  public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_estado_civil AS table_estado_civil RIGHT OUTER JOIN public.form_l_novas_pessoas AS form_l_novas_pessoas ON table_estado_civil.code = form_l_novas_pessoas.civil ON table_doc_identificacao.code = form_l_novas_pessoas.doc ON table_genero_pessoa.code = form_l_novas_pessoas.gen) AS a
WHERE a.key NOT IN (SELECT key FROM party);

INSERT INTO public.party
SELECT id_party, upn, pessoa_app, pessoa_nom, genero, estado_civil, pessoa_prof, prof_other, pessoa_nacion, pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, documento, pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, pessoa_id_photo, pessoa_assin, contacto, key FROM
(SELECT form_k_pessoas.id_party::text, digitisations.upn, form_k_pessoas.pessoa_app, form_k_pessoas.pessoa_nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_k_pessoas.pessoa_prof, form_k_pessoas.pessoa_prof as prof_other, form_k_pessoas.pessoa_nacion, form_k_pessoas.pessoa_natural, form_k_pessoas.nasc_y_n, form_k_pessoas.pessoa_nasc, form_k_pessoas.pessoa_ida, table_doc_identificacao.documento, form_k_pessoas.pessoa_id, form_k_pessoas.doc_local, form_k_pessoas.doc_emi, form_k_pessoas.doc_val, form_k_pessoas.doc_vital, form_k_pessoas.pessoa_foto, form_k_pessoas.pessoa_id_photo, form_k_pessoas.pessoa_assin, form_k_pessoas.contacto::text,  form_k_pessoas.id_party|| digitisations.upn as key FROM  public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.form_k_pessoas AS form_k_pessoas RIGHT OUTER JOIN public.form_l_titulares AS form_l_titulares ON form_k_pessoas.id_party = form_l_titulares.found_party ON table_genero_pessoa.code = form_k_pessoas.pessoa_gen ON table_doc_identificacao.code = form_k_pessoas.pessoa_doc, public.form_l_registrar_parcela AS form_l_registrar_parcela LEFT OUTER JOIN public.digitisations AS digitisations ON form_l_registrar_parcela.upn_id = digitisations.upn , public.table_estado_civil AS table_estado_civil WHERE form_l_registrar_parcela.key = form_l_titulares.parent_key AND table_estado_civil.code = form_k_pessoas.pessoa_civil) AS a
WHERE a.key NOT IN (SELECT key FROM party);

DELETE FROM public.party a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.party b
                 WHERE  a.key = b.key);

alter table party add primary key (key);