-- Legend update points in L


CREATE TABLE public.update_form_l_pontos
(
  geom geometry(Point,0),
  latitude double precision,
  longitude double precision,
  altitude double precision,
  accuracy double precision,
  limits character varying,
  parent_key character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_pontos
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_pontos TO postgres;

COPY public.update_form_l_pontos FROM '/var/lib/share/projects/legend/dbupdate/legend_L_pontos.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER;
	
DELETE FROM public.update_form_l_pontos a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_pontos b
                 WHERE  a.key = b.key);
	
	DELETE FROM public.update_form_l_pontos
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_pontos 
WHERE key = public.update_form_l_pontos.key );

SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',0);

INSERT INTO public.form_l_registrar_pontos(
            geom, latitude, longitude, altitude, accuracy, upngpslimit, parentuid, 
            key)
SELECT geom, latitude, longitude, altitude, accuracy, limits, parent_key, 
       key
  FROM public.update_form_l_pontos;
  
SELECT UpdateGeometrySRID('form_l_registrar_pontos','geom',4326);


DROP TABLE public.update_form_l_pontos;