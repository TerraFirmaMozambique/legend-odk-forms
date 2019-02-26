/*
This SQLCODE updates form_k_pessoas with new people received from the field by ODK form K pessoas
*/

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
--------------------------------------------------------
UPDATE public.update_form_k_pessoas SET pessoa_prof = pessoa_prof_outra WHERE pessoa_prof = 'outro';

UPDATE update_form_k_pessoas
SET pessoa_foto = '<img src="'||pessoa_foto||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_k_pessoas
SET pessoa_id_photo = '<img src="'||pessoa_id_photo||'" style="width:1024px;height:1024px;" />';
UPDATE update_form_k_pessoas
SET pessoa_assin = '<img src="'||pessoa_assin||'" style="width:1024px;height:1024px;" />';

--------------------------------------------------------------

 
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

