INSERT INTO public.form_l_registrar_parcela(
            sub_date, begin, formname, intronote, tec_name, registo_data, 
            prov_id, dist_id, posto_id, assocs_id, upn_id, upn_check, ocup, 
            ocup_outro, z_excl, part_excl, tipo_excl, conf, tipo_conf, desc_conf, 
            use_cat, use_tipo, use_prin, use_outro, demarcator, nomedemarcator, 
            party_type, add_party_number, party_menor, titulares_count, 
            searchtext1, foundrepmenor, searchtext2, foundrepent, entnome, 
            enttipo, reg_party_yn, reg_newparty_number, novas_pessoas_count, 
            testem_num, testemunhas_count,  
            regparty1yn, regnewparty1number, novaspessoas1count,  
            latitude, longitude, altitude, accuracy, limites_yn,  
            endnote, recibo_image, finish, meta_inst_id, meta_inst_name, 
            key)
      SELECT 
  "LEGEND_L_2_V1_CORE"."_SUBMISSION_DATE"::timestamp without time zone as sub_date, 
  "LEGEND_L_2_V1_CORE"."START"::timestamp without time zone as begin, 
  "LEGEND_L_2_V1_CORE"."MY_FORM_NAME" as formname, 
  "LEGEND_L_2_V1_CORE"."INTRONOTE" as intronote, 
  "LEGEND_L_2_V1_CORE"."TEC_NAME" as tec_name, 
  "LEGEND_L_2_V1_CORE"."REGISTO_DATA"::date as registo_data, 
  "LEGEND_L_2_V1_CORE"."PROV_ID" as prov_id, 
  "LEGEND_L_2_V1_CORE"."DIST_ID" as dist_id, 
  "LEGEND_L_2_V1_CORE"."POSTO_ID" as posto_id, 
  "LEGEND_L_2_V1_CORE"."ASSOC_ID" as assocs_id, 
  "LEGEND_L_2_V1_CORE"."PARCEL_ID"::integer as upn_id, 
  "LEGEND_L_2_V1_CORE"."PARCEL_ID_CHECK"::integer as upn_check, 
  "LEGEND_L_2_V1_CORE"."OCUP" as ocup, 
  "LEGEND_L_2_V1_CORE"."OCUP_OUTRO" as ocup_outro, 
  "LEGEND_L_2_V1_CORE"."Z_EXCL" as z_excl, 
  "LEGEND_L_2_V1_CORE"."PART_EXCL" as part_excl, 
  "LEGEND_L_2_V1_CORE"."TIPO_EXCL" as tipo_excl, 
  "LEGEND_L_2_V1_CORE"."CONF" as conf, 
  "LEGEND_L_2_V1_CORE"."TIPO_CONF" as tipo_conf, 
  "LEGEND_L_2_V1_CORE"."DESC_CONF" as desc_conf, 
  "LEGEND_L_2_V1_CORE"."USE_CAT" as use_cat, 
  'usetipo'::text  as use_tipo, 
  "LEGEND_L_2_V1_CORE"."USE_PRIN" as use_prin, 
  "LEGEND_L_2_V1_CORE"."USE_OTHER" as use_outro, 
  "LEGEND_L_2_V1_CORE"."DEMARCATOR" as demarcator, 
  "LEGEND_L_2_V1_CORE"."NOME_DEMARCATOR" as nomedemarcator, 
  "LEGEND_L_2_V1_CORE"."PARTY_TYPE" as party_type, 
  "LEGEND_L_2_V1_CORE"."ADD_PARTY_NUMBER" as add_party_number, 
  "LEGEND_L_2_V1_CORE"."PARTY_MENOR" as party_menor, 
  "LEGEND_L_2_V1_CORE"."TITULARES_COUNT"::integer as titulares_count, 
  "LEGEND_L_2_V1_CORE"."SEARCHTEXT_1" as searchtext1, 
  "LEGEND_L_2_V1_CORE"."FOUND_REP_MENOR" as foundrepmenor, 
  "LEGEND_L_2_V1_CORE"."SEARCHTEXT_2" as searchtext2, 
  "LEGEND_L_2_V1_CORE"."FOUND_REP_ENT" as foundrepent, 
  "LEGEND_L_2_V1_CORE"."LG1_ENT_NOME" as entnome, 
  "LEGEND_L_2_V1_CORE"."LG1_ENT_TIPO"as enttipo, 
  "LEGEND_L_2_V1_CORE"."REG_PARTY_YN" as reg_party_yn, 
  "LEGEND_L_2_V1_CORE"."REG_NEWPARTY_NUMBER" as reg_newparty_number, 
  "LEGEND_L_2_V1_CORE"."NOVAS_PESSOAS_COUNT"::integer as novas_pessoas_count, 
  "LEGEND_L_2_V1_CORE"."TESTEM_NUM" as testem_num, 
  "LEGEND_L_2_V1_CORE"."TESTEMUNHAS_COUNT"::integer as testemunhas_count, 
  "LEGEND_L_2_V1_CORE"."REG_PARTY1_YN" as regparty1yn, 
  "LEGEND_L_2_V1_CORE"."REG_NEWPARTY1_NUMBER" as reg_newparty_number, 
  "LEGEND_L_2_V1_CORE"."NOVAS_PESSOAS1_COUNT"::integer as novaspessoas1count, 
  "LEGEND_L_2_V1_CORE"."AUTO_GPS_LAT" as latitude, 
  "LEGEND_L_2_V1_CORE"."AUTO_GPS_LNG" as longitude, 
  "LEGEND_L_2_V1_CORE"."AUTO_GPS_ALT" as altitude, 
  "LEGEND_L_2_V1_CORE"."AUTO_GPS_ACC" as accuracy, 
  "LEGEND_L_2_V1_CORE"."LIMITES_YN" as limites_yn, 
  "LEGEND_L_2_V1_CORE"."ENDNOTE" as endnote,
  concat('<img src="http://tfmoz.ddns.net/legend/media_l_2/'||"LEGEND_L_2_V1_RECIBO_IMAGE_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') as recibo_image,
  "LEGEND_L_2_V1_CORE"."END"::timestamp without time zone as finish, 
  "LEGEND_L_2_V1_CORE"."META_INSTANCE_ID" as meta_inst_id, 
  "LEGEND_L_2_V1_CORE"."META_INSTANCE_NAME" as meta_inst_name, 
  "LEGEND_L_2_V1_CORE"."_URI" as key

	
FROM odk_prod."LEGEND_L_2_V1_CORE" LEFT JOIN odk_prod."LEGEND_L_2_V1_RECIBO_IMAGE_BN" ON odk_prod."LEGEND_L_2_V1_CORE"."_URI"  = "LEGEND_L_2_V1_RECIBO_IMAGE_BN"."_PARENT_AURI"

WHERE "LEGEND_L_2_V1_CORE"."_URI" NOT IN (SELECT key from form_l_registrar_parcela);	
	
	--------------------------------^Parcel Claim^---------------------------------
	
	Create TABLE public.updateuse_tipo AS ( SELECT "_TOP_LEVEL_AURI" as key, string_agg("VALUE", ' ')as info FROM odk_prod."LEGEND_L_2_V1_USE_TIPO"
 GROUP BY "_TOP_LEVEL_AURI");
 
update form_l_registrar_parcela
SET use_tipo = info
FROM updateuse_tipo
where form_l_registrar_parcela.key = updateuse_tipo.key;

DROP TABLE public.updateuse_tipo;
	
	
	--------------------------------^adjust use_tipo in Parcel Claim^---------------------------------
	
	
update form_l_registrar_parcela set geom=st_SetSrid(st_MakePoint(longitude, latitude), 4326);
	
	--------------------------------^make geographic point 4326^---------------------------------
	
	INSERT INTO public.form_l_titulares(
            searchtext, found_party, parent_key, key_test)
SELECT 
  "LEGEND_L_2_V1_TITULARES"."SEARCHTEXT" as searchtext, 
  "LEGEND_L_2_V1_TITULARES"."FOUND_PARTY" as found_party, 
  "LEGEND_L_2_V1_TITULARES"."_PARENT_AURI" as parent_key,
concat(  "LEGEND_L_2_V1_TITULARES"."SEARCHTEXT", "LEGEND_L_2_V1_TITULARES"."FOUND_PARTY", "LEGEND_L_2_V1_TITULARES"."_PARENT_AURI") AS key_test
FROM 
  odk_prod."LEGEND_L_2_V1_TITULARES"

WHERE "LEGEND_L_2_V1_TITULARES"."FOUND_PARTY" != '1'
AND concat(  "LEGEND_L_2_V1_TITULARES"."SEARCHTEXT", "LEGEND_L_2_V1_TITULARES"."FOUND_PARTY", "LEGEND_L_2_V1_TITULARES"."_PARENT_AURI") NOT IN (SELECT key_test FROM public.form_l_titulares) ;

	
	--------------------------------^titulars^---------------------------------
	
	SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, update, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, key, assocsid, upn)
SELECT  
concat('Point (',"AUTO_GPS_LIMIT_LNG",' ',"AUTO_GPS_LIMIT_LAT",')') as geom,
  "LEGEND_L_2_V1_PONTOS"."_LAST_UPDATE_DATE"::timestamp without time zone as update,
  "AUTO_GPS_LIMIT_LAT"::double precision as latitude, 
  "AUTO_GPS_LIMIT_LNG"::double precision as longitude, 
  "AUTO_GPS_LIMIT_ALT"::double precision as altitude, 
  "AUTO_GPS_LIMIT_ACC"::double precision as accuracy, 
  "UPN_GPS_LIMIT" as upngpslimit, 
  "_TOP_LEVEL_AURI" as parentuid,
  "LEGEND_L_2_V1_PONTOS"."_URI" as key,
  "ASSOC_ID" as assocsid,
  "PARCEL_ID"::numeric as upn
FROM
  odk_prod."LEGEND_L_2_V1_PONTOS", 
  odk_prod."LEGEND_L_2_V1_CORE"

 WHERE
 "LEGEND_L_2_V1_PONTOS"."_PARENT_AURI" = "LEGEND_L_2_V1_CORE"."_URI" AND
   concat('Point (',"AUTO_GPS_LIMIT_LNG",' ',"AUTO_GPS_LIMIT_LAT",')') != 'Point ( )'AND
"LEGEND_L_2_V1_PONTOS"."_LAST_UPDATE_DATE"::timestamp without time zone > (SELECT MAX(update)FROM public.form_l_registrar_pontos) AND 
"LEGEND_L_2_V1_PONTOS"."_URI" not in (SELECT key FROM public.form_l_registrar_pontos);
   
UPDATE form_l_registrar_pontos SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);


	--------------------------------^Points^---------------------------------
	
INSERT INTO public.form_l_testemunhas_v2(
            search_text, found_testem, testem_type, parent_uid, key)
SELECT 
  "LEGEND_L_2_V1_TESTEMUNHAS"."SEARCHTEXT_3", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."TESTEM_TYPE", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI" as parent_uid,
concat( 
  "LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM","LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI") as key
FROM 
  odk_prod."LEGEND_L_2_V1_TESTEMUNHAS"
WHERE
  "LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM" !='1'
AND concat( 
  "LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM","LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI") NOT IN (SELECT key FROM form_l_testemunhas_v2);
			
			
	--------------------------------^testemunhas^---------------------------------
	
INSERT INTO public.form_l_novas_pessoas(
            uuid, app, nom, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id )
SELECT DISTINCT
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_GEN", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_CIVIL", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_PROF", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_PROF_OTHER", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG3_PESSOA_NACION", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG3_PESSOA_NATURAL", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."NASC_Y_N", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_NASC":: date, 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."PESSOA_IDA", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS". "LG4_PESSOA_ID",
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_LOCAL", 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_EMI"::date, 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_VAL"::date, 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_DOC_VITAL", 
concat('<img src="http://tfmoz.ddns.net/legend/media/'||odk_prod."LEGEND_L_2_V1_PESSOA_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') , 
concat('<img src="http://tfmoz.ddns.net/legend/media/'||odk_prod."LEGEND_L_2_V1_ID_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') , 
concat('<img src="http://tfmoz.ddns.net/legend/media/'||odk_prod."LEGEND_L_2_V1_PESSOA_ASSIN_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />') ,
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."CONTACTO" as contacto, 
odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI" as parentuid,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID") AS party_name,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID") as party_name_key,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID") AS key_test,
odk_prod."LEGEND_L_2_V1_CORE"."PARCEL_ID"::integer

FROM 
  odk_prod."LEGEND_L_2_V1_CORE", 
  odk_prod."LEGEND_L_2_V1_ID_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_NOVAS_PESSOAS", 
  odk_prod."LEGEND_L_2_V1_PESSOA_FOTO_BN", 
  odk_prod."LEGEND_L_2_V1_PESSOA_ASSIN_BN"
  
WHERE 
  "LEGEND_L_2_V1_ID_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" AND
  "LEGEND_L_2_V1_NOVAS_PESSOAS"."_PARENT_AURI" = "LEGEND_L_2_V1_CORE"."_URI" AND
  "LEGEND_L_2_V1_PESSOA_FOTO_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" AND
  "LEGEND_L_2_V1_PESSOA_ASSIN_BN"."_PARENT_AURI" = "LEGEND_L_2_V1_NOVAS_PESSOAS"."_URI" AND
  CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG2_PESSOA_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS"."LG4_PESSOA_ID") NOT IN (SELECT key_test FROM form_l_novas_pessoas)
ORDER BY odk_prod."LEGEND_L_2_V1_CORE"."PARCEL_ID"::integer DESC ;

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

---------------------------------------------------------
  INSERT INTO public.unique_novas_pessoas(
            uuid, app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id)
  
  SELECT DISTINCT 
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
  
 
DELETE from public.unique_novas_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key_test = public.unique_novas_pessoas.key_test);

DELETE FROM public.unique_novas_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.unique_novas_pessoas b
                 WHERE  a.key_test = b.key_test);


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
SELECT DISTINCT
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

CREATE TABLE titular_check AS (SELECT 
  concat(form_l_novas_pessoas.app, form_l_novas_pessoas.nom, form_l_novas_pessoas.doc,form_l_novas_pessoas.doc_id) key_test1,
  public.form_k_pessoas.key_test,
  'add' as searchtext,
  public.form_k_pessoas.id_party,
  form_l_registrar_parcela.key,
  form_l_registrar_parcela.upn_id
FROM 
  public.form_l_registrar_parcela, 
  public.form_l_novas_pessoas,
  public.form_k_pessoas
WHERE 
form_l_registrar_parcela.key = form_l_novas_pessoas.parentuid AND
form_l_novas_pessoas.role != 'testem' AND
 -- form_l_novas_pessoas.parentuid = form_l_titulares.parent_key AND
concat(form_l_novas_pessoas.app, form_l_novas_pessoas.nom, form_l_novas_pessoas.doc, form_l_novas_pessoas.doc_id) = public.form_k_pessoas.key_test
ORDER BY form_l_registrar_parcela.upn_id ASC);

------------------------------------------------------------------------
DELETE from public.titular_check
WHERE EXISTS (SELECT 1 FROM public.form_l_titulares 
WHERE concat(id_party,key) = concat(public.form_l_titulares.found_party,public.form_l_titulares.parent_key));
--------------------

INSERT INTO public.form_l_titulares(
	searchtext, found_party, parent_key, key_test)
	
	SELECT searchtext, id_party, key, concat(searchtext, id_party, key)
	FROM public.titular_check
	where concat(titular_check.searchtext, titular_check.id_party, titular_check.key)NOT IN (SELECT key_test FROM form_l_titulares) ;
	
	DROP TABLE titular_check;
	
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
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_2_V1_TESTEM_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as pessoafoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_2_V1_TESTEM_ID_FOTO_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as idfoto,
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_2_V1_TESTEM_ASSIN_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text as assin,
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."TESTEM_CONTACTO" as contacto, 
  "LEGEND_L_2_V1_NOVAS_PESSOAS1"."_PARENT_AURI" as parentuid,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID") AS party_name,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS1"."_PARENT_AURI"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID") as party_name_key,
CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID") AS key_test,
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
  CONCAT("LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_APP"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG5_TESTEM_NOM"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_DOC"||"LEGEND_L_2_V1_NOVAS_PESSOAS1"."LG7_TESTEM_ID") NOT IN (SELECT key_test FROM form_l_novas_pessoas) ;
  
  --------------create table unique parties by taking out duplicates------
  
 INSERT INTO public.unique_novas_pessoas(
            uuid, app, nom, role, gen, civil, prof, prof_o, nacion, naturalidade, 
            nascyn, nasc, aida, doc, doc_id, localidade, emi, val, vital, 
            foto, idfoto, assin, contacto, parentuid, party_name, party_name_key, 
            key_test, parcel_id)
  
  SELECT DISTINCT 
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
  
 
DELETE from public.unique_novas_pessoas
WHERE EXISTS (SELECT 1 FROM public.form_k_pessoas 
WHERE key_test = public.unique_novas_pessoas.key_test);

DELETE FROM public.unique_novas_pessoas a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.unique_novas_pessoas b
                 WHERE  a.key_test = b.key_test);
				 
INSERT INTO public.form_k_pessoas(
            sub_date, start, form_name, intronote, tec_name, 
            registo_data, prov_id, dist_id, posto_id, assoc_id, 
            pessoa_app, pessoa_nom, pessoa_role, 
            pessoa_gen, pessoa_civil, pessoa_prof, pessoa_nacion, 
            pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, pessoa_doc, 
            pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, 
            pessoa_id_photo, pessoa_assin, contacto, finish, meta_id, meta_name, 
            key, key_test)
SELECT DISTINCT
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
-----------------------------------------------------------------
CREATE TABLE testem_check AS (SELECT 
 concat( form_l_novas_pessoas.app, 
  form_l_novas_pessoas.nom, 
  form_l_novas_pessoas.doc, 
  form_l_novas_pessoas.doc_id) as key_test1,
  public.form_k_pessoas.key_test,
  'add_test' as searchtext,
  public.form_k_pessoas.id_party,
  form_l_registrar_parcela.key,
  form_l_registrar_parcela.upn_id
FROM 
  public.form_l_registrar_parcela, 
  public.form_l_novas_pessoas,
  public.form_k_pessoas
WHERE 
  form_l_registrar_parcela.key = form_l_novas_pessoas.parentuid AND
  form_l_novas_pessoas.role = 'testem' AND
  concat( form_l_novas_pessoas.app, 
  form_l_novas_pessoas.nom, 
  form_l_novas_pessoas.doc, 
  form_l_novas_pessoas.doc_id) = public.form_k_pessoas.key_test
ORDER BY form_l_registrar_parcela.upn_id ASC);

ALTER TABLE testem_check ADD COLUMN party_key VARCHAR;

update testem_check SET party_key = concat(id_party,key);
----------------------------------------------------
DELETE FROM public.testem_check a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.testem_check b
                 WHERE  a.party_key = b.party_key);
				 
DELETE from public.testem_check
WHERE EXISTS (SELECT 1 FROM public.form_l_testemunhas_v2 
WHERE form_l_testemunhas_v2.key = testem_check.party_key);
-----------------------------------
INSERT INTO public.form_l_testemunhas_v2(
	search_text, found_testem, parent_uid, key)
	
	SELECT 
	searchtext, 
	id_party as found_testem, 
	key as parent_uid, 
	party_key as key
	FROM public.testem_check
	where party_key NOT IN (SELECT key FROM form_l_testemunhas_v2) ;
	
	DROP TABLE testem_check;	
	