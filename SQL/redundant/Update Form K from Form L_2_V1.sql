INSERT INTO public.form_l_novas_pessoas(
            uuid, app, nom, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id )

SELECT 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" as uuid,
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP" as app, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM" as nom,
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_GEN" as gen, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_CIVIL" as civil, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_PROF" as prof, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_PROF_OTHER" as prof_o, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG3_PESSOA_NACION" as nacion, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG3_PESSOA_NATURAL" as naturalidade, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."NASC_Y_N" as nascyn, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_NASC":: date as nasc, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_IDA" as aida, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC" as doc, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID" as doc_id, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_LOCAL" as localidade, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_EMI"::date as emi, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_VAL"::date as val, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_VITAL" as vital,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_PESSOA_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') as foto,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_ID_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') as idfoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_PESSOA_ASSIN_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') as assin,
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."CONTACTO" as contacto, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI" as parentuid,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID")) AS party_name,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID")) as party_name_key,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID")) AS key_test,
"LEGEND_L_2_V1_CORE"."PARCEL_ID"::integer as parcel_id

FROM 
  odk_prod."LEGEND_L_2_V1_CORE",
  odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS", 
  odk_prod."LEGEND_L_2_V1_ID_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_PESSOA_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_PESSOA_ASSIN_BN"
WHERE 
    "LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI" = "LEGEND_L_2_V1_CORE"."_URI" 
AND "LEGEND_L_2_V1_ID_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" 
AND "LEGEND_L_2_V1_PESSOA_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" 
AND "LEGEND_L_2_V1_PESSOA_ASSIN_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI"
AND "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" NOT IN (SELECT uuid FROM form_l_novas_pessoas);

-------------------------update role--------------------------

Create TABLE public.update_role AS ( SELECT "_PARENT_AURI" as key, string_agg("VALUE", ' ')as info FROM odk_prod."LEGEND_L_2_V1_LG2_PESSOA_ROLE"
 
GROUP BY "_PARENT_AURI");
 
update form_l_novas_pessoas
SET role = info
FROM 
public.update_role

where   

update_role.key = form_l_novas_pessoas.uuid;

DROP TABLE public.update_role;

-------------------------include those testemunhas------------------------

INSERT INTO public.form_l_novas_pessoas(
            uuid, app, nom, role, gen, civil, prof, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id )
SELECT 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_URI" as uuid,
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP" as app, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM" as nom,
  'testem' as role,
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_GEN" as gen, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_CIVIL" as civil, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_PROF" as prof, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG6_TESTEM_NACION" as nacion, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG6_TESTEM_NATURAL" as naturalidade, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_NASC_Y_N" as nascyn, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_NASC":: date as nasc, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_IDA" as aida, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC" as doc, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID" as doc_id, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC_LOCAL" as local, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC_EMI"::date as emi, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC_VAL"::date as val, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC_VITAL" as vital,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_TESTEM_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as pessoafoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_TESTEM_ID_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as idfoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_TESTEM_ASSIN_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as assin,
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_CONTACTO" as contacto, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_PARENT_AURI" as parentuid,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID")) AS party_name,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS1"."_PARENT_AURI"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID")) as party_name_key,
CONCAT(("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"),("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID")) AS key_test,
"LEGEND_L_2_V1_CORE"."PARCEL_ID"::integer as parcel_id

FROM 
  odk_prod."LEGEND_L_2_V1_CORE",
  odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS1",
  odk_prod."LEGEND_L_2_V1_TESTEM_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_TESTEM_ID_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_TESTEM_ASSIN_BN"
WHERE 
   
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_PARENT_AURI" = "LEGEND_L_2_V1_CORE"."_URI" AND
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_URI" = "LEGEND_L_2_V1_TESTEM_ID_FOTO_BN"."_PARENT_AURI" AND
  "LEGEND_L_2_V1_TESTEM_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_URI" AND
  "LEGEND_L_2_V1_TESTEM_ASSIN_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_URI" AND
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_URI" NOT IN (SELECT uuid FROM form_l_novas_pessoas);
  
  --------------create table unique parties by taking out duplicates------
  
  INSERT INTO public.unique_novas_pessoas(
            uuid, app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id)
  
  SELECT 
  form_l_novas_pessoas.uuid, 
  form_l_novas_pessoas.app, 
  form_l_novas_pessoas.nom, 
  form_l_novas_pessoas.role, 
  form_l_novas_pessoas.gen, 
  form_l_novas_pessoas.civil, 
  form_l_novas_pessoas.prof, 
  form_l_novas_pessoas.prof_o, 
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
  form_l_novas_pessoas.parentuid, 
  form_l_novas_pessoas.party_name, 
  form_l_novas_pessoas.party_name_key, 
  form_l_novas_pessoas.key_test, 
  form_l_novas_pessoas.parcel_id::text
FROM 
  public.form_l_novas_pessoas;
  
DELETE FROM public.unique_novas_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.unique_novas_pessoas b
                 WHERE  a.key_test = b.key_test);
				 
DELETE from public.unique_novas_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key_test = public.unique_novas_pessoas.key_test);

--- Create Party ID for new persons------

INSERT INTO public.form_k_pessoas(
            sub_date, start, form_name, intronote, tec_name, 
            registo_data, prov_id, dist_id, posto_id, assoc_id, 
            pessoa_app, pessoa_nom, pessoa_role, 
            pessoa_gen, pessoa_civil, pessoa_prof, pessoa_nacion, 
            pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, pessoa_doc, 
            pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, 
            pessoa_id_photo, pessoa_assin, contacto, finish, meta_id, meta_name, 
            key, key_test)
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
  unique_novas_pessoas.app, 
  unique_novas_pessoas.nom, 
  unique_novas_pessoas.role, 
  unique_novas_pessoas.gen, 
  unique_novas_pessoas.civil, 
  unique_novas_pessoas.prof, 
  unique_novas_pessoas.nacion, 
  unique_novas_pessoas.naturalidade, 
  unique_novas_pessoas.nascyn, 
  unique_novas_pessoas.nasc, 
  unique_novas_pessoas.aida, 
  unique_novas_pessoas.doc, 
  unique_novas_pessoas.doc_id, 
  unique_novas_pessoas.localidade, 
  unique_novas_pessoas.emi, 
  unique_novas_pessoas.val, 
  unique_novas_pessoas.vital, 
  unique_novas_pessoas.foto, 
  unique_novas_pessoas.idfoto, 
  unique_novas_pessoas.assin, 
  unique_novas_pessoas.contacto, 
  form_l_registrar_parcela.finish, 
  form_l_registrar_parcela.meta_inst_id, 
  form_l_registrar_parcela.meta_inst_name, 
  form_l_registrar_parcela.key, 
  unique_novas_pessoas.key_test
FROM 
  public.unique_novas_pessoas, 
  public.form_l_registrar_parcela
WHERE 
  form_l_registrar_parcela.key = unique_novas_pessoas.parentuid
AND unique_novas_pessoas.key_test NOT IN (SELECT key_test FROM form_k_pessoas);


UPDATE public.form_k_pessoas SET id_party = 'party'||id
WHERE form_k_pessoas.id_party = 'party';


/*COPY (SELECT id_party AS party_id_key, COALESCE(ent_name||pessoa_nom||' '||pessoa_app||' '||pessoa_doc||' '|| pessoa_id) AS party_name FROM public.form_k_pessoas WHERE form_k_pessoas.assoc_id = 'AS040001' ORDER BY id ASC) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/L_registo_parcelas/LEGEND_L_registo_parcelas_cduats-media//AS040001.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
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

*/
------------------------ insterts relations into titulars for new persons

INSERT INTO public.form_l_titulares(
            searchtext, found_party, parent_key, key_test)
SELECT DISTINCT
  'add'::text AS searchtext,
  form_k_pessoas.id_party AS found_party, 
  form_l_novas_pessoas.parentuid AS parent_key,
  'add'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid AS key_test
FROM 
  public.form_k_pessoas, 
  public.form_l_novas_pessoas 
WHERE 
  form_k_pessoas.key_test = form_l_novas_pessoas.key_test
AND  (form_l_novas_pessoas.role = 'titular' OR form_l_novas_pessoas.role = 'titular rep_menor' OR form_l_novas_pessoas.role = 'rep_menor') AND
'add'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid NOT IN (SELECT key_test From form_l_titulares) AND form_k_pessoas.id_party||form_l_novas_pessoas.parentuid NOT IN (SELECT found_party||parent_key FROM form_l_titulares)
ORDER BY
  form_k_pessoas.id_party ASC;
  
  
DELETE FROM public.form_l_titulares a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.form_l_titulares b
                 WHERE  a.found_party||parent_key = b.found_party||parent_key);  
  
  
  ------------------------ insterts relations into titulars for new persons
  
INSERT INTO public.form_l_testemunhas_v2(
            search_text, found_testem, testem_type, parent_uid, key)
SELECT DISTINCT
  'add_test'::character varying AS add_test,
  form_k_pessoas.id_party AS found_testem, 
  form_l_novas_pessoas.parentuid AS parent_uid,
  'add_test'::character varying as testem_type ,
  'add_test'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid::character varying as key_test
FROM 
  public.form_k_pessoas, 
  public.form_l_novas_pessoas 
WHERE 
  form_k_pessoas.key_test = form_l_novas_pessoas.key_test 
AND  form_l_novas_pessoas.role = 'testem'
AND 'add_test'||form_k_pessoas.id_party||form_l_novas_pessoas.parentuid::character varying NOT IN (SELECT key FROM form_l_testemunhas_v2)
AND id_party||parentuid NOT IN (SELECT found_testem||parent_uid From form_l_testemunhas_v2)
ORDER BY
  form_k_pessoas.id_party ASC;
  

  
  
------------------------------000000000000000000000000000000--------------------
INSERT INTO public.party
SELECT DISTINCT id_party, upn, pessoa_app, pessoa_nom, genero, estado_civil, pessoa_prof, prof_other, pessoa_nacion, pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, documento, pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, pessoa_id_photo, pessoa_assin, contacto, key FROM
(SELECT form_k_pessoas.id_party::text, digitisations.upn, form_k_pessoas.pessoa_app, form_k_pessoas.pessoa_nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_k_pessoas.pessoa_prof, form_k_pessoas.pessoa_prof as prof_other, form_k_pessoas.pessoa_nacion, form_k_pessoas.pessoa_natural, form_k_pessoas.nasc_y_n, form_k_pessoas.pessoa_nasc, form_k_pessoas.pessoa_ida, table_doc_identificacao.documento, form_k_pessoas.pessoa_id, form_k_pessoas.doc_local, form_k_pessoas.doc_emi, form_k_pessoas.doc_val, form_k_pessoas.doc_vital, form_k_pessoas.pessoa_foto, form_k_pessoas.pessoa_id_photo, form_k_pessoas.pessoa_assin, form_k_pessoas.contacto::text,  form_k_pessoas.id_party||digitisations.upn AS key FROM  public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.form_k_pessoas AS form_k_pessoas RIGHT OUTER JOIN public.form_l_titulares AS form_l_titulares ON form_k_pessoas.id_party = form_l_titulares.found_party ON table_genero_pessoa.code = form_k_pessoas.pessoa_gen ON table_doc_identificacao.code = form_k_pessoas.pessoa_doc, public.form_l_registrar_parcela AS form_l_registrar_parcela LEFT OUTER JOIN public.digitisations AS digitisations ON form_l_registrar_parcela.upn_id = digitisations.upn , public.table_estado_civil AS table_estado_civil WHERE form_l_registrar_parcela.key = form_l_titulares.parent_key AND table_estado_civil.code = form_k_pessoas.pessoa_civil) AS a
WHERE a.key NOT IN (SELECT key FROM party) AND a.upn IS NOT NULL
ORDER BY upn;

DELETE FROM public.party a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.party b
                 WHERE  a.key = b.key);
