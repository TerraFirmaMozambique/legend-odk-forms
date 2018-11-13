-- routine

INSERT INTO public.upd_nupn(
            upn, nupn)
SELECT upn, row_number FROM (SELECT
 assoc_id,
 upn,
 ROW_NUMBER () OVER (
 PARTITION BY povoado_id
 ORDER BY
 assoc_id, upn
 )
FROM
 certification
WHERE assoc_id = 'AS040003' ---- need to select which Assoc go in here by from OCC table as complete
AND nupn IS NULL
ORDER BY upn) as a;


UPDATE  certification
SET nupn = upd_nupn.nupn
FROM 
    public.upd_nupn
WHERE 
certification.upn = upd_nupn.upn AND 
certification.nupn IS NULL;



/*CREATE TABLE public.upd_nupn
(
  upn integer NOT NULL,
  nupn integer,
  CONSTRAINT upd_novas_pesoas_pkey PRIMARY KEY (upn)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.upd_nupn
  OWNER TO postgres;
GRANT ALL ON TABLE public.upd_nupn TO public;
GRANT ALL ON TABLE public.upd_nupn TO postgres;


update certification
set nupn = nupn
FROM upd_nupn
where certifiction.upn = upd_nupn.upn
*/