CREATE TABLE public.upd_nupn
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