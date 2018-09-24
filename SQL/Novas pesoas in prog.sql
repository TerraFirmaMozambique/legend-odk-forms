/* Novas pesoas */

UPDATE up_date_form_l_novas_pessoas SET role =  a.role FROM (SELECT "_PARENT_AURI"  as key , string_agg("VALUE", ' ')as role FROM odk_prod."LEGEND_L_V2_LG2_PESSOA_ROLE"
GROUP BY "_PARENT_AURI" 
ORDER BY "_PARENT_AURI"  ASC) as a
WHERE up_date_form_l_novas_pessoas.key  =  a.key


INSERT INTO public.form_l_novas_pessoas(
            app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test )

SELECT 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_APP" as app, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM" as nom,
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM" as role,
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_GEN" as gen, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_CIVIL" as civil, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."PESSOA_PROF" as prof, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."PESSOA_PROF_OTHER" as prof_o, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG3_PESSOA_NACION" as nacion, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG3_PESSOA_NATURAL" as naturalidade, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."NASC_Y_N" as nascyn, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."PESSOA_NASC":: date as nasc, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."PESSOA_IDA" as aida, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_DOC" as doc, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_ID" as doc_id, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_DOC_LOCAL" as local, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_DOC_EMI"::date as emi, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_DOC_VAL"::date as val, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."LG4_DOC_VITAL" as vital,
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_V2_PESSOA_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as pessoafoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_V2_ID_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as idfoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_V2_PESSOA_ASSIN_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as assin,
  "LEGEND_L_V2_NOVAS_PESSOAS"."CONTACTO" as contacto, 
  "LEGEND_L_V2_NOVAS_PESSOAS"."_PARENT_AURI" as parentuid,
CONCAT("LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_ID") AS party_name,
CONCAT("LEGEND_L_V2_NOVAS_PESSOAS"."_PARENT_AURI"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_ID") as party_name_key,
CONCAT("LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_ID") AS key_test

FROM 
  odk_prod."LEGEND_L_V2_NOVAS_PESSOAS", 
  odk_prod."LEGEND_L_V2_CORE",
  odk_prod."LEGEND_L_V2_ID_FOTO_BN", 
  odk_prod."LEGEND_L_V2_PESSOA_ASSIN_BN", 
  odk_prod."LEGEND_L_V2_PESSOA_FOTO_BN"
WHERE 
  "LEGEND_L_V2_NOVAS_PESSOAS"."_PARENT_AURI" = "LEGEND_L_V2_CORE"."_URI" AND
  "LEGEND_L_V2_ID_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_V2_NOVAS_PESSOAS"."_URI" AND
  "LEGEND_L_V2_PESSOA_ASSIN_BN"."_PARENT_AURI" = "LEGEND_L_V2_NOVAS_PESSOAS"."_URI" AND
  "LEGEND_L_V2_PESSOA_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_V2_NOVAS_PESSOAS"."_URI" AND
  CONCAT("LEGEND_L_V2_NOVAS_PESSOAS"."_PARENT_AURI"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_V2_NOVAS_PESSOAS"."LG4_PESSOA_ID") NOT IN (SELECT party_name_key FROM form_l_novas_pessoas) ;