-- Legend update titulares in L

CREATE TABLE public.update_form_l_titulares
(
  searchtext character varying,
  found_party character varying,
  parent_key character varying
  
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_titulares   OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_titulares TO postgres;

COPY public.update_form_l_titulares FROM '/var/lib/share/projects/legend/dbupdate/form_l_titulares.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';

-- Create a unique reference colum 
ALTER TABLE public.update_form_l_titulares ADD COLUMN key character varying;

UPDATE public.update_form_l_titulares SET key = concat (("parent_key")||("searchtext")||("found_party"));

DELETE FROM public.update_form_l_titulares
WHERE found_party = '1';

DELETE FROM public.update_form_l_titulares a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_titulares b
                 WHERE  a.key = b.key);
				 
DELETE from public.update_form_l_titulares
WHERE EXISTS (SELECT 1 FROM public.form_l_titulares 
WHERE key = public.update_form_l_titulares.key);


INSERT INTO public.form_l_titulares(
            searchtext, found_party, parent_key, key)
SELECT searchtext, found_party, parent_key, key
  FROM public.update_form_l_titulares;
  
DELETE FROM public.form_l_titulares a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.form_l_titulares b
                 WHERE  a.key = b.key);
				 
DROP TABLE public.update_form_l_titulares;