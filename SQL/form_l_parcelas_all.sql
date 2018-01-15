

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
  
  SELECT UpdateGeometrySRID('form_l_registrar_parcela','geom',4326);

  
  
  
  

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
  
DROP TABLE public.update_form_l_titulares;

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
part_name_key character varying,
key_test character varying,
confirmardo character varying,
parcel_id character varying

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
                 WHERE  a.key_test = b.key_test);
				 
DELETE from public.update_form_l_novas_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_l_novas_pessoas 
WHERE key_test = public.update_form_l_novas_pessoas.key_test);



INSERT INTO public.form_l_novas_pessoas(
            app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, id, localidade, emi, val, vital, foto, 
            idfoto, assin, contacto, parentuid, party_name, part_name_key, 
            key_test, confirmardo, parcel_id)
SELECT app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
       nascyn, nasc, aida, doc, id, localidade, emi, val, vital, foto, 
       idfoto, assin, contacto, parentuid, party_name, part_name_key, 
       key_test, confirmardo, parcel_id
  FROM public.update_form_l_novas_pessoas;		
  
DROP TABLE public.update_form_l_novas_pessoas;  
  
  CREATE TABLE public.update_form_k_novas_pessoas_l AS
SELECT 
  form_l_registrar_parcela.sub_date, 
  form_l_registrar_parcela.begin, 
  form_l_registrar_parcela.formname, 
  form_l_registrar_parcela.intronote, 
  form_l_registrar_parcela.tec_name, 
  form_l_registrar_parcela.registo_data, 
  form_l_registrar_parcela.prov_id, 
  form_l_registrar_parcela.dist_id, 
  form_l_registrar_parcela.posto_id, 
  form_l_registrar_parcela.assocs_id, 
  form_l_registrar_parcela.party_type, 
  form_l_registrar_parcela.entnome, 
  form_l_registrar_parcela.enttipo, 
  form_l_novas_pessoas.app, 
  form_l_novas_pessoas.nom, 
  form_l_novas_pessoas.role, 
  form_l_novas_pessoas.gen, 
  form_l_novas_pessoas.civil, 
  form_l_novas_pessoas.prof, 
  form_l_novas_pessoas.nacion, 
  form_l_novas_pessoas.naturalidade, 
  form_l_novas_pessoas.nascyn, 
  form_l_novas_pessoas.nasc, 
  form_l_novas_pessoas.aida, 
  form_l_novas_pessoas.doc, 
  form_l_novas_pessoas.id, 
  form_l_novas_pessoas.localidade, 
  form_l_novas_pessoas.emi, 
  form_l_novas_pessoas.val, 
  form_l_novas_pessoas.vital, 
  form_l_novas_pessoas.foto, 
  form_l_novas_pessoas.idfoto, 
  form_l_novas_pessoas.assin, 
  form_l_novas_pessoas.contacto, 
  form_l_registrar_parcela.finish, 
  form_l_registrar_parcela.meta_inst_id, 
  form_l_registrar_parcela.meta_inst_name, 
  form_l_registrar_parcela.key, 
  form_l_novas_pessoas.key_test
FROM 
  public.form_l_registrar_parcela, 
  public.form_l_novas_pessoas
WHERE 
  form_l_registrar_parcela.key = form_l_novas_pessoas.parentuid
ORDER BY
  form_l_registrar_parcela.upn_id ASC;
  
ALTER TABLE public.update_form_k_novas_pessoas_l ADD CONSTRAINT update_form_k_novas_pessoas_l_pkey PRIMARY KEY (key_test);

ALTER TABLE public.update_form_k_novas_pessoas_l  OWNER to postgres;
GRANT ALL ON TABLE public.update_form_k_novas_pessoas_l TO postgres;
GRANT ALL ON TABLE public.update_form_k_novas_pessoas_l TO public;




DELETE from public.update_form_k_novas_pessoas_l
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key_test = public.update_form_k_novas_pessoas_l.key_test);

INSERT INTO public.form_k_pessoas(
            sub_date, start, form_name, intronote, tec_name, 
            registo_data, prov_id, dist_id, posto_id, assoc_id, party_tipo, 
            ent_name, ent_tipo, pessoa_app, pessoa_nom, pessoa_role, 
            pessoa_gen, pessoa_civil, pessoa_prof, pessoa_nacion, 
            pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, pessoa_doc, 
            pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, 
            pessoa_id_photo, pessoa_assin, contacto, finish, meta_id, meta_name, 
            key, key_test)
SELECT sub_date, begin, formname, intronote, tec_name, registo_data, 
       prov_id, dist_id, posto_id, assocs_id, party_type, entnome, enttipo, 
       app, nom, role, gen, civil, prof, nacion, naturalidade, nascyn, 
       nasc, aida, doc, id, localidade, emi, val, vital, foto, idfoto, 
       assin, contacto, finish, meta_inst_id, meta_inst_name, key, key_test
  FROM public.update_form_k_novas_pessoas_l;
  
UPDATE public.form_k_pessoas SET id_party = 'party'; 
 
UPDATE public.form_k_pessoas SET id_party = id_party||id;

COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040001' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040001.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040002' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040002.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040003' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040003.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040004' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040004.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040005' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040005.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040006' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040006.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040007' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040007.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040008' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040008.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040009' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040009.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040010' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040010.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040011' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040011.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040012' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040012.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040013' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040013.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040014' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040014.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040015' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040015.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040016' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040016.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040017' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040017.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040018' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040018.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040019' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040019.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040020' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040020.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040021' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040021.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040022' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040022.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040023' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040023.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040001' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040001.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040002' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040002.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040003' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040003.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040004' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040004.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040005' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040005.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040006' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040006.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040007' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040007.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040008' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040008.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040009' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040009.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040010' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040010.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040011' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040011.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040012' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040012.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040013' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040013.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040014' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040014.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040015' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040015.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040016' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040016.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040017' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040017.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040018' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040018.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040019' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040019.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040020' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040020.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040021' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040021.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040022' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040022.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040023' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040023.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
  
  

DROP TABLE public.update_form_k_novas_pessoas_l;

CREATE TABLE public.update_form_l_registrar_pontos
(
    geom geometry(Point, 0),
    latitude double precision,
    longitude double precision,
    altitude double precision,
    accuracy double precision,
    upngpslimit character varying COLLATE pg_catalog."default",
    parentuid character varying COLLATE pg_catalog."default" NOT NULL,
    key character varying COLLATE pg_catalog."default"
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_registrar_pontos
  OWNER TO postgres;

GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO public;

	COPY public.update_form_l_registrar_pontos FROM '/var/lib/share/projects/legend/dbupdate/form_l_pontos.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_registrar_pontos a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_registrar_pontos b
                 WHERE  a.key = b.key);
	
	DELETE FROM public.update_form_l_registrar_pontos
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_pontos 
WHERE key = public.update_form_l_registrar_pontos.key );

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
            key)
SELECT geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
       key
  FROM public.update_form_l_registrar_pontos;


SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);

DROP TABLE public.update_form_l_registrar_pontos;

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