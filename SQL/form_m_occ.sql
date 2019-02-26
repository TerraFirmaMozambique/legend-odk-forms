/*
Dont forget to download the media files and put in tfmoz.ddns.net/legend/m_occ/...........

CREATE TABLE public.update_form_m_occ
(
    sub_date timestamp without time zone,
    start timestamp without time zone,
    formname character varying COLLATE pg_catalog."default",
    intronote character varying COLLATE pg_catalog."default",
    tecnome character varying COLLATE pg_catalog."default",
    addnome character varying COLLATE pg_catalog."default",
    provid character varying COLLATE pg_catalog."default",
    distid character varying COLLATE pg_catalog."default",
    postoid character varying COLLATE pg_catalog."default",
    associd character varying COLLATE pg_catalog."default",
    foundpov character varying COLLATE pg_catalog."default",
    parcelid integer,
    parcelidcheck integer,
    outcome character varying COLLATE pg_catalog."default",
    partyid character varying COLLATE pg_catalog."default",
    partyidcheck character varying COLLATE pg_catalog."default",
    issues character varying COLLATE pg_catalog."default",
    parcelidnew character varying COLLATE pg_catalog."default",
    pessoaappnew character varying COLLATE pg_catalog."default",
    pessoanomnew character varying COLLATE pg_catalog."default",
    pessoagennew character varying COLLATE pg_catalog."default",
    pessoadocnew character varying COLLATE pg_catalog."default",
    pessoaidnew character varying COLLATE pg_catalog."default",
    data_new date,
    limits_image character varying COLLATE pg_catalog."default",
    limitesnew character varying COLLATE pg_catalog."default",
    finish timestamp without time zone,
    inst_id character varying COLLATE pg_catalog."default",
    inst_name character varying COLLATE pg_catalog."default",
    key character varying COLLATE pg_catalog."default" NOT NULL,
    
)
WITH (
    OIDS = TRUE
)
TABLESPACE pg_default;

ALTER TABLE public.update_form_m_occ OWNER to postgres;

GRANT ALL ON TABLE public.update_form_m_occ TO maria;

GRANT ALL ON TABLE public.update_form_m_occ TO postgres;
*/

------------------------------------------------------------------------------

INSERT INTO public.update_form_m_occ(
            sub_date, start, formname, intronote, tecnome, addnome, provid, 
            distid, postoid, associd, foundpov, parcelid, parcelidcheck, 
            outcome, partyid, partyidcheck, issues, parcelidnew, pessoaappnew, 
            pessoanomnew, pessoagennew, pessoadocnew, pessoaidnew, data_new, 
            limits_image, limitesnew, finish, inst_id, inst_name, 
            key)
SELECT 
odk_prod."LEGEND_M_V3_CORE"."_SUBMISSION_DATE", 
odk_prod."LEGEND_M_V3_CORE"."START", 
odk_prod."LEGEND_M_V3_CORE"."MY_FORM_NAME", 
odk_prod."LEGEND_M_V3_CORE"."INTRONOTE", 
odk_prod."LEGEND_M_V3_CORE"."TEC_NOME", 
odk_prod."LEGEND_M_V3_CORE"."ADD_NOME", 
odk_prod."LEGEND_M_V3_CORE"."PROV_ID", 
odk_prod."LEGEND_M_V3_CORE"."DIST_ID", 
odk_prod."LEGEND_M_V3_CORE"."POSTO_ID", 
odk_prod."LEGEND_M_V3_CORE"."ASSOC_ID", 
odk_prod."LEGEND_M_V3_CORE"."FOUND_POV", 
odk_prod."LEGEND_M_V3_CORE"."PARCEL_ID"::integer, 
odk_prod."LEGEND_M_V3_CORE"."PARCEL_ID_CHECK"::integer, 
odk_prod."LEGEND_M_V3_CORE"."OUTCOME", 
concat('party',odk_prod."LEGEND_M_V3_CORE"."PARTY_ID"), 
concat('party',odk_prod."LEGEND_M_V3_CORE"."PARTY_ID_CHECK"), 
odk_prod."LEGEND_M_V3_ISSUES"."VALUE", 
odk_prod."LEGEND_M_V3_CORE"."PARCEL_ID_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PESSOA_APP_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PESSOA_NOM_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PESSOA_GEN_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PESSOA_DOC_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PESSOA_ID_NEW", 
odk_prod."LEGEND_M_V3_CORE"."DATA_NEW", 
odk_prod."LEGEND_M_V3_CORE"."PARCEL_ID", 
concat('<img src="http://tfmoz.ddns.net/legend/m_occ/'||odk_prod."LEGEND_M_V3_LIMITES_NEW_IMAGE_BN"."UNROOTED_FILE_PATH"||'" style="width:1024px;height:1024px;" />')::text AS limitesnew,
odk_prod."LEGEND_M_V3_CORE"."END", 
odk_prod."LEGEND_M_V3_CORE"."META_INSTANCE_ID", 
odk_prod."LEGEND_M_V3_CORE"."META_INSTANCE_NAME", 
odk_prod."LEGEND_M_V3_CORE"."_URI"

FROM  (odk_prod."LEGEND_M_V3_CORE" LEFT JOIN odk_prod."LEGEND_M_V3_ISSUES" ON  odk_prod."LEGEND_M_V3_CORE"."_URI" = odk_prod."LEGEND_M_V3_ISSUES"."_PARENT_AURI") 
LEFT JOIN odk_prod."LEGEND_M_V3_LIMITES_NEW_IMAGE_BN" ON odk_prod."LEGEND_M_V3_CORE"."_URI" = odk_prod."LEGEND_M_V3_LIMITES_NEW_IMAGE_BN"."_PARENT_AURI"
WHERE odk_prod."LEGEND_M_V3_CORE"."_URI" NOT IN (SELECT form_m_occ.key FROM public.form_m_occ)
ORDER BY "_SUBMISSION_DATE" DESC;

-----------------------------------------------------------------------------


Create TABLE public.update_issue AS ( 
SELECT 
  "LEGEND_M_V3_CORE"."_URI" as key, 
  string_agg("LEGEND_M_V3_ISSUES"."VALUE", ' ') as info
FROM 
  odk_prod."LEGEND_M_V3_CORE", 
  odk_prod."LEGEND_M_V3_ISSUES"
WHERE 
  "LEGEND_M_V3_CORE"."_URI" = "LEGEND_M_V3_ISSUES"."_PARENT_AURI"

GROUP BY "LEGEND_M_V3_CORE"."_URI");
 
update update_form_m_occ
SET issues = info
FROM 
public.update_issue
where   
update_issue.key = update_form_m_occ.key;

DROP TABLE public.update_issue;


---------------------------------------------------------------------------------

DELETE FROM public.update_form_m_occ a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_m_occ b
                 WHERE  a.key = b.key);
				 
--------------------------------------------------------------------------------------				 
				 
INSERT INTO public.form_m_occ(
	sub_date, start, formname, intronote, tecnome, addnome, provid, distid, postoid, associd, foundpov, parcelid, parcelidcheck, outcome, partyid, partyidcheck, issues, parcelidnew, pessoaappnew, pessoanomnew, pessoagennew, pessoadocnew, pessoaidnew, data_new, limits_image, limitesnew, finish, inst_id, inst_name, key)
SELECT 
sub_date, start, formname, intronote, tecnome, addnome, provid, distid, postoid, associd, foundpov, parcelid, parcelidcheck, outcome, partyid, partyidcheck, issues, parcelidnew, pessoaappnew, pessoanomnew, pessoagennew, pessoadocnew, pessoaidnew, data_new, limits_image, limitesnew, finish, inst_id, inst_name, key	
FROM public.update_form_m_occ
WHERE update_form_m_occ.key not in (select key from form_m_occ);

----------------------------------------------------------------------

DELETE from public.update_form_m_occ
WHERE EXISTS (SELECT 1 FROM public.form_m_occ 
WHERE form_m_occ.key = public.update_form_m_occ.key);

--------------------------------------------------------------








