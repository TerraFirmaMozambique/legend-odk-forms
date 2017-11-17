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
                 WHERE  a.key = b.key);
	
<<<<<<< HEAD
	DELETE FROM public.update_form_l_pontos
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_pontos 
WHERE key = public.update_form_l_pontos.key );
=======
	DELETE FROM public.update_form_l_registrar_pontos
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_pontos 
WHERE key = public.update_form_l_registrar_pontos.key );
>>>>>>> 496edf1ed466a77210755b2a04561b0f9f631c8f

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
            key)
SELECT geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
       key
<<<<<<< HEAD
  FROM public.update_form_l_pontos;
  
SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);
=======
  FROM public.update_form_l_registrar_pontos;

>>>>>>> 496edf1ed466a77210755b2a04561b0f9f631c8f

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);

<<<<<<< HEAD
DROP TABLE public.update_form_l_pontos;
=======
DROP TABLE public.update_form_l_registrar_pontos;
>>>>>>> 496edf1ed466a77210755b2a04561b0f9f631c8f
