/* Update points from odk_prod selection based on latest timestamp */

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, update, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, key, assocsid, upn)
SELECT  
concat('Point (',"AUTO_GPS_LIMIT_LNG",' ',"AUTO_GPS_LIMIT_LAT",')') as geom,
  "LEGEND_L_V2_PONTOS"."_LAST_UPDATE_DATE"::timestamp without time zone as update,
  "AUTO_GPS_LIMIT_LAT"::double precision as latitude, 
  "AUTO_GPS_LIMIT_LNG"::double precision as longitude, 
  "AUTO_GPS_LIMIT_ALT"::double precision as altitude, 
  "AUTO_GPS_LIMIT_ACC"::double precision as accuracy, 
  "UPN_GPS_LIMIT" as upngpslimit, 
  "_TOP_LEVEL_AURI" as parentuid,
  "LEGEND_L_V2_PONTOS"."_URI" as key,
  "ASSOC_ID" as assocsid,
  "PARCEL_ID"::numeric as upn
FROM
  odk_prod."LEGEND_L_V2_PONTOS", 
  odk_prod."LEGEND_L_V2_CORE"

WHERE 
  "LEGEND_L_V2_PONTOS"."_PARENT_AURI" = "LEGEND_L_V2_CORE"."_URI" AND
   concat('Point (',"AUTO_GPS_LIMIT_LNG",' ',"AUTO_GPS_LIMIT_LAT",')') != 'Point ( )'AND
"LEGEND_L_V2_PONTOS"."_LAST_UPDATE_DATE"::timestamp without time zone > (SELECT MAX(update)
FROM public.form_l_registrar_pontos);
   
UPDATE form_l_registrar_pontos SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);