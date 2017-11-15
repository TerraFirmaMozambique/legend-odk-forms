-- Legend update points in L


CREATE TABLE public.update_form_l_registrar_pontos
(
    geom geometry(Point, 0),
    latitude double precision,
    longitude double precision,
    altitude double precision,
    accuracy double precision,
    upngpslimit character varying COLLATE pg_catalog."default",
    parentuid character varying COLLATE pg_catalog."default" NOT NULL,
    key character varying COLLATE pg_catalog."default"
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_registrar_pontos
  OWNER TO postgres;

GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_pontos TO public;

	COPY public.update_form_l_registrar_pontos FROM '/var/lib/share/projects/legend/dbupdate/form_l_registrar_pontos.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_l_registrar_pontos a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_registrar_pontos b
                 WHERE  a.key = b.key);
	
	DELETE FROM public.update_form_l_registrar_pontos
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_pontos 
WHERE key = public.update_form_l_registrar_pontos.key );

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
            key)
SELECT geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
       key
  FROM public.update_form_l_registrar_pontos;


SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);

DROP TABLE public.update_form_l_registrar_pontos;