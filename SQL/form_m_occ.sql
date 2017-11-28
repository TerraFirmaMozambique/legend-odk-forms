

CREATE TABLE public.update_form_m_occ
(

sub_date timestamp without time zone,
start timestamp without time zone,
formname character varying,
intronote character varying,
tecnome character varying,
addnome character varying,
provid character varying,
distid character varying,
postoid character varying,
associd character varying,
foundpov character varying,
parcelid integer,
parcelidcheck integer,
outcome character varying,
partyid character varying,
partyidcheck character varying,
issues character varying,
parcelidnew character varying,
pessoaappnew character varying,
pessoanomnew character varying,
pessoagennew character varying,
pessoadocnew character varying,
pessoaidnew character varying,
data_new date,
pessoaidvalnew character varying,
limits_image character varying,
limitesnew character varying,
finish timestamp without time zone,
inst_id character varying,
inst_name character varying,
key character varying
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_m_occ  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_m_occ TO postgres;

COPY public.update_form_m_occ FROM '/var/lib/share/projects/legend/dbupdate/form_m_occ.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_m_occ a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_m_occ b
                 WHERE  a.key = b.key);
				 

DELETE from public.update_form_m_occ
WHERE EXISTS (SELECT 1 FROM public.form_m_occ
WHERE key = public.update_form_m_occ.key );

INSERT INTO public.form_m_occ(
            sub_date, start, formname, intronote, tecnome, addnome, provid, 
            distid, postoid, associd, foundpov, parcelid, parcelidcheck, 
            outcome, partyid, partyidcheck, issues, parcelidnew, pessoaappnew, 
            pessoanomnew, pessoagennew, pessoadocnew, pessoaidnew, data_new, 
            pessoaidvalnew, limits_image, limitesnew, finish, inst_id, inst_name, 
            key)
SELECT sub_date, start, formname, intronote, tecnome, addnome, provid, 
       distid, postoid, associd, foundpov, parcelid, parcelidcheck, 
       outcome, partyid, partyidcheck, issues, parcelidnew, pessoaappnew, 
       pessoanomnew, pessoagennew, pessoadocnew, pessoaidnew, data_new, 
       pessoaidvalnew, limits_image, limitesnew, finish, inst_id, inst_name, 
       key
  FROM public.update_form_m_occ;

  
DROP TABLE public.update_form_m_occ;



