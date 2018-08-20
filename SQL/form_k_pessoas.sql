

CREATE TABLE public.update_form_k_pessoas
(
  sub_date timestamp without time zone,
  start timestamp without time zone,
  form_name character varying,
  intronote character varying,
  tec_name character varying,
  registo_data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  assoc_id character varying,
  party_tipo character varying,
  ent_name character varying,
  ent_tipo character varying,
  ent_rep character varying,
  pessoa_app character varying,
  pessoa_nom character varying,
  pessoa_role character varying,
  pessoa_gen character varying,
  pessoa_civil character varying,
  pessoa_prof character varying,
  pessoa_prof_outra character varying,
  pessoa_nacion character varying,
  nota_nacion character varying,
  pessoa_natural character varying,
  nasc_y_n character varying,
  pessoa_nasc date,
  pessoa_ida character varying,
  pessoa_doc character varying,
  pessoa_id character varying,
  doc_local character varying,
  doc_emi date,
  doc_val date,
  doc_vital character varying,
  pessoa_foto character varying,
  pessoa_id_photo character varying,
  pessoa_assin character varying,
  contacto character varying,
  finish timestamp without time zone,
  meta_id character varying,
  meta_name character varying,
  key character varying,
  key_test character varying
  )
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_k_pessoas  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_k_pessoas TO public;
GRANT ALL ON TABLE public.update_form_k_pessoas TO postgres;

COPY public.update_form_k_pessoas FROM '/var/lib/share/projects/legend/dbupdate/form_k_registrar_pessoas.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_k_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_k_pessoas b
                 WHERE  a.key = b.key);
				 
DELETE from public.update_form_k_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key = public.update_form_k_pessoas.key);

DELETE FROM public.update_form_k_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_k_pessoas b
                 WHERE  a.key_test = b.key_test);
				 
DELETE from public.update_form_k_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key_test = public.update_form_k_pessoas.key_test);

UPDATE public.update_form_k_pessoas SET pessoa_prof = pessoa_prof_outra WHERE pessoa_prof = 'outro';

UPDATE update_form_k_pessoas
SET pessoa_foto = '<img src="'||pessoa_foto||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_k_pessoas
SET pessoa_id_photo = '<img src="'||pessoa_id_photo||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_k_pessoas
SET pessoa_assin = '<img src="'||pessoa_assin||'" style="width:1024px;height:1024px;" />';

INSERT INTO public.form_k_pessoas(
            sub_date, start, form_name, intronote, tec_name, 
            registo_data, prov_id, dist_id, posto_id, assoc_id, party_tipo, 
            ent_name, ent_tipo, ent_rep, pessoa_app, pessoa_nom, pessoa_role, 
            pessoa_gen, pessoa_civil, pessoa_prof, pessoa_nacion, nota_nacion, 
            pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, pessoa_doc, 
            pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, 
            pessoa_id_photo, pessoa_assin, contacto, finish, meta_id, meta_name, 
            key, key_test)
SELECT sub_date, start, form_name, intronote, tec_name, registo_data, 
       prov_id, dist_id, posto_id, assoc_id, party_tipo, ent_name, ent_tipo, 
       ent_rep, pessoa_app, pessoa_nom, pessoa_role, pessoa_gen, pessoa_civil, 
       pessoa_prof, pessoa_nacion, nota_nacion, pessoa_natural, 
       nasc_y_n, pessoa_nasc, pessoa_ida, pessoa_doc, pessoa_id, doc_local, 
       doc_emi, doc_val, doc_vital, pessoa_foto, pessoa_id_photo, pessoa_assin, 
       contacto, finish, meta_id, meta_name, key, key_test
FROM public.update_form_k_pessoas;
 
UPDATE public.form_k_pessoas SET ent_name = '' WHERE ent_name IS NULL;
  
UPDATE public.form_k_pessoas SET id_party = 'party'||id;

------------------------------------------------------------------

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
  form_l_registrar_parcela.enttipo, ---- 
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
  form_l_novas_pessoas.doc_id, 
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
  
-- ALTER TABLE public.update_form_k_novas_pessoas_l ADD CONSTRAINT update_form_k_novas_pessoas_l_pkey PRIMARY KEY (key_test);

ALTER TABLE public.update_form_k_novas_pessoas_l  OWNER to postgres;
GRANT ALL ON TABLE public.update_form_k_novas_pessoas_l TO postgres;
GRANT ALL ON TABLE public.update_form_k_novas_pessoas_l TO public;

--- create single instances of new people
DELETE FROM public.update_form_k_novas_pessoas_l a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_k_novas_pessoas_l b
                 WHERE  a.key_test = b.key_test);
--- delete added people already added to form k
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
       nasc, aida, doc, doc_id, localidade, emi, val, vital, foto, idfoto, 
       assin, contacto, finish, meta_inst_id, meta_inst_name, key, key_test
FROM public.update_form_k_novas_pessoas_l;
   

 
UPDATE public.form_k_pessoas SET id_party = 'party'||id;

 
 
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
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040024' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040024.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040025' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040025.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
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
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040024' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040024.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040025' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040025.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';


INSERT into public.form_l_titulares 
SELECT 
  'add'::text AS add,
  form_k_pessoas.id_party, 
  form_l_novas_pessoas.parentuid,
  'add'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid as key_test
FROM 
  public.form_k_pessoas, 
  public.form_l_novas_pessoas 
WHERE 
  form_k_pessoas.key_test = form_l_novas_pessoas.key_test AND  (form_l_novas_pessoas.role = 'titular' OR form_l_novas_pessoas.role = 'titular rep_menor' OR form_l_novas_pessoas.role = 'rep_menor') AND
'add'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid NOT IN (SELECT key_test From form_l_titulares)
ORDER BY
  form_k_pessoas.id_party ASC;


DROP TABLE public.update_form_k_pessoas;
DROP TABLE public.update_form_k_novas_pessoas_l;