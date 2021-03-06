/* Legend L2 Core Table */

/*SELECT string_agg("VALUE", ' ') FROM odk_prod."LEGEND_L_V2_USE_TIPO"
GROUP BY "_TOP_LEVEL_AURI" 
*/

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
  "LEGEND_L_V2_CORE"."_SUBMISSION_DATE"::timestamp without time zone, 
  "LEGEND_L_V2_CORE"."START"::timestamp without time zone, 
  "LEGEND_L_V2_CORE"."MY_FORM_NAME", 
  "LEGEND_L_V2_CORE"."INTRONOTE", 
  "LEGEND_L_V2_CORE"."TEC_NAME", 
  "LEGEND_L_V2_CORE"."REGISTO_DATA"::date, 
  "LEGEND_L_V2_CORE"."PROV_ID", 
  "LEGEND_L_V2_CORE"."DIST_ID", 
  "LEGEND_L_V2_CORE"."POSTO_ID", 
  "LEGEND_L_V2_CORE"."ASSOC_ID", 
  "LEGEND_L_V2_CORE"."PARCEL_ID"::integer, 
  "LEGEND_L_V2_CORE"."PARCEL_ID_CHECK"::integer, 
  "LEGEND_L_V2_CORE"."OCUP", 
  "LEGEND_L_V2_CORE"."OCUP_OUTRO", 
  "LEGEND_L_V2_CORE"."Z_EXCL", 
  "LEGEND_L_V2_CORE"."PART_EXCL", 
  "LEGEND_L_V2_CORE"."TIPO_EXCL", 
  "LEGEND_L_V2_CORE"."CONF", 
  "LEGEND_L_V2_CORE"."TIPO_CONF", 
  "LEGEND_L_V2_CORE"."DESC_CONF", 
  "LEGEND_L_V2_CORE"."USE_CAT", 
  'usetipo'::text as usetipo, 
  "LEGEND_L_V2_CORE"."USE_PRIN", 
  "LEGEND_L_V2_CORE"."USE_OTHER", 
  "LEGEND_L_V2_CORE"."DEMARCATOR", 
  "LEGEND_L_V2_CORE"."NOME_DEMARCATOR", 
  "LEGEND_L_V2_CORE"."PARTY_TYPE", 
  "LEGEND_L_V2_CORE"."ADD_PARTY_NUMBER", 
  "LEGEND_L_V2_CORE"."PARTY_MENOR", 
  "LEGEND_L_V2_CORE"."TITULARES_COUNT"::integer, 
  "LEGEND_L_V2_CORE"."SEARCHTEXT_1", 
  "LEGEND_L_V2_CORE"."FOUND_REP_MENOR", 
  "LEGEND_L_V2_CORE"."SEARCHTEXT_2", 
  "LEGEND_L_V2_CORE"."FOUND_REP_ENT", 
  "LEGEND_L_V2_CORE"."LG1_ENT_NOME", 
  "LEGEND_L_V2_CORE"."LG1_ENT_TIPO", 
  "LEGEND_L_V2_CORE"."REG_PARTY_YN", 
  "LEGEND_L_V2_CORE"."REG_NEWPARTY_NUMBER", 
  "LEGEND_L_V2_CORE"."NOVAS_PESSOAS_COUNT"::integer, 
  "LEGEND_L_V2_CORE"."TESTEM_NUM", 
  "LEGEND_L_V2_CORE"."TESTEMUNHAS_COUNT"::integer, 
  "LEGEND_L_V2_CORE"."REG_PARTY1_YN", 
  "LEGEND_L_V2_CORE"."REG_NEWPARTY1_NUMBER", 
  "LEGEND_L_V2_CORE"."NOVAS_PESSOAS1_COUNT"::integer, 
  "LEGEND_L_V2_CORE"."AUTO_GPS_LAT", 
  "LEGEND_L_V2_CORE"."AUTO_GPS_LNG", 
  "LEGEND_L_V2_CORE"."AUTO_GPS_ALT", 
  "LEGEND_L_V2_CORE"."AUTO_GPS_ACC", 
  "LEGEND_L_V2_CORE"."LIMITES_YN", 
  "LEGEND_L_V2_CORE"."ENDNOTE",
  concat('<img src="http://tfmoz.ddns.net/legend/media/'||"LEGEND_L_V2_RECIBO_IMAGE_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')as image_path,
  "LEGEND_L_V2_CORE"."END"::timestamp without time zone, 
  "LEGEND_L_V2_CORE"."META_INSTANCE_ID", 
  "LEGEND_L_V2_CORE"."META_INSTANCE_NAME", 
  "LEGEND_L_V2_CORE"."_URI"
FROM 
  odk_prod."LEGEND_L_V2_CORE",
  odk_prod."LEGEND_L_V2_RECIBO_IMAGE_BN"
 
  WHERE "LEGEND_L_V2_CORE"."_URI" NOT IN (SELECT key from form_l_registrar_parcela) AND
    "LEGEND_L_V2_RECIBO_IMAGE_BN"."_TOP_LEVEL_AURI" = "LEGEND_L_V2_CORE"."_URI";
-----------------------------------------------------------------	
	
Create TABLE public.updateuse_tipo AS ( SELECT "_TOP_LEVEL_AURI" as key, string_agg("VALUE", ' ')as info FROM odk_prod."LEGEND_L_V2_USE_TIPO"
 GROUP BY "_TOP_LEVEL_AURI");
 
update form_l_registrar_parcela
SET use_tipo = info
FROM updateuse_tipo
where form_l_registrar_parcela.key = updateuse_tipo.key;

DROP TABLE public.updateuse_tipo;
------------------------------------------------------------  

update form_l_registrar_parcela set geom=st_SetSrid(st_MakePoint(longitude, latitude), 4326);
   
  
  
  
  