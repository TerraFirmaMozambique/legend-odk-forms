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
FROM 
  odk_prod."LEGEND_L_2_V1_CORE",
  odk_prod."LEGEND_L_2_V1_RECIBO_IMAGE_BN"
 
  WHERE "LEGEND_L_2_V1_CORE"."_URI" NOT IN (SELECT key from form_l_registrar_parcela) AND
    "LEGEND_L_2_V1_RECIBO_IMAGE_BN"."_TOP_LEVEL_AURI" = "LEGEND_L_2_V1_CORE"."_URI";
-----------------------------------------------------------------	
	
Create TABLE public.updateuse_tipo AS ( SELECT "_TOP_LEVEL_AURI" as key, string_agg("VALUE", ' ')as info FROM odk_prod."LEGEND_L_2_V1_USE_TIPO"
 GROUP BY "_TOP_LEVEL_AURI");
 
update form_l_registrar_parcela
SET use_tipo = info
FROM updateuse_tipo
where form_l_registrar_parcela.key = updateuse_tipo.key;

DROP TABLE public.updateuse_tipo;

-------------------------------------------------
  

update form_l_registrar_parcela set geom=st_SetSrid(st_MakePoint(longitude, latitude), 4326);


------------------------------------------------------

INSERT INTO public.form_l_titulares(
            searchtext, found_party, parent_key, key_test)
  

SELECT DISTINCT
  "LEGEND_L_2_V1_TITULARES"."SEARCHTEXT", 
  "LEGEND_L_2_V1_TITULARES"."FOUND_PARTY", 
  "LEGEND_L_2_V1_TITULARES"."_PARENT_AURI",
   concat("LEGEND_L_2_V1_TITULARES"."SEARCHTEXT"||"LEGEND_L_2_V1_TITULARES"."FOUND_PARTY"||"LEGEND_L_2_V1_TITULARES"."_PARENT_AURI")as key_test
FROM 
  odk_prod."LEGEND_L_2_V1_TITULARES"

WHERE concat("LEGEND_L_2_V1_TITULARES"."SEARCHTEXT"||"LEGEND_L_2_V1_TITULARES"."FOUND_PARTY"||"LEGEND_L_2_V1_TITULARES"."_PARENT_AURI") not in (SELECT key_test FROM form_l_titulares) AND
"LEGEND_L_2_V1_TITULARES"."FOUND_PARTY" != '1';


--------------------------------000--------------------------------------------------

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
"LEGEND_L_2_V1_PONTOS"."_LAST_UPDATE_DATE"::timestamp without time zone > (SELECT MAX(update)
FROM public.form_l_registrar_pontos);
   
UPDATE form_l_registrar_pontos SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);

-------------------------------------

INSERT INTO public.form_l_testemunhas_v2(
            search_text, found_testem, testem_type, parent_uid, key)

SELECT DISTINCT 
  "LEGEND_L_2_V1_TESTEMUNHAS"."SEARCHTEXT_3", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."TESTEM_TYPE", 
  "LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI",
concat("LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM"||"LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI") as key
FROM 
odk_prod."LEGEND_L_2_V1_TESTEMUNHAS"
WHERE (concat("LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM"||"LEGEND_L_2_V1_TESTEMUNHAS"."_PARENT_AURI")  NOT IN (SELECT key FROM form_l_testemunhas_v2))AND 
"LEGEND_L_2_V1_TESTEMUNHAS"."FOUND_TESTEM" != '1';

 --------------------------------000----------------------------------------------------
 






