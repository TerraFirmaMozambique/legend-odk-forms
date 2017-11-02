
CREATE TABLE public.update_form_a2_limites_povoados
(
 geom geometry(Point,0),
sub_date timestamp without time zone,
start timestamp without time zone,
myformname character varying,
intronote character varying,
tec_nome character varying,
add_nome character varying,
data date,
prov_id character varying,
dist_id character varying,
posto_id character varying,
searchtext character varying,
found_pov character varying,
add_pov character varying,
part_m integer,
part_h integer,
cam__foto character varying,
latitude double precision,
longitude double precision,
altitude double precision,
accuracy double precision,
pontos_pov character varying,
map_foto character varying,
finish timestamp without time zone,
inst_id character varying,
inst_name character varying,
key character varying 
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_a2_limites_povoados
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_a2_limites_povoados TO postgres;

COPY public.update_form_a2_limites_povoados FROM '/var/lib/share/projects/legend/dbupdate/form_a2__limites_povoados.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_a2_limites_povoados a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_a2_limites_povoados b
                 WHERE  a.key = b.key);

DELETE from public.update_form_a2_limites_povoados
WHERE EXISTS (SELECT 1 FROM public.form_a2_limites_povoados
WHERE key = public.update_form_a2_limites_povoados.key );

SELECT UpdateGeometrySRID('form_a2_limites_povoados','geom',0);

INSERT INTO public.form_a2_limites_povoados(
            geom, sub_date, start, myformname, intronote, tec_nome, add_nome, 
            data, prov_id, dist_id, posto_id, searchtext, found_pov, add_pov, 
            part_m, part_h, cam__foto, latitude, longitude, altitude, accuracy, 
            pontos_pov, map_foto, finish, inst_id, inst_name, key)
SELECT geom, sub_date, start, myformname, intronote, tec_nome, add_nome, 
       data, prov_id, dist_id, posto_id, searchtext, found_pov, add_pov, 
       part_m, part_h, cam__foto, latitude, longitude, altitude, accuracy, 
       pontos_pov, map_foto, finish, inst_id, inst_name, key
  FROM public.update_form_a2_limites_povoados;


SELECT UpdateGeometrySRID('form_a2_limites_povoados','geom',4326);



CREATE TABLE public.update_form_a2_pontos
(
geom geometry(Point,0),
latitude double precision,
longitude double precision,
altitude double precision,
accuracy double precision,
camgeopon character varying,
parentuid character varying,
key character varying 
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_a2_pontos
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_a2_pontos TO postgres;


COPY public.update_form_a2_pontos FROM '/var/lib/share/projects/legend/dbupdate/form_a2_pontos.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_a2_pontos a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_a2_pontos b
                 WHERE  a.key = b.key);

DELETE from public.update_form_a2_pontos
WHERE EXISTS (SELECT 1 FROM public.form_a2_pontos
WHERE key = public.update_form_a2_pontos.key );

SELECT UpdateGeometrySRID('form_a2_pontos','geom',0);

INSERT INTO public.form_a2_pontos(
            geom, latitude, longitude, altitude, accuracy, camgeopon, parentuid, 
            key)
SELECT geom, latitude, longitude, altitude, accuracy, camgeopon, parentuid, 
       key
  FROM public.update_form_a2_pontos;


SELECT UpdateGeometrySRID('form_a2_pontos','geom',4326);


DROP TABLE public.update_form_a2_limites_povoados;

DROP TABLE public.update_form_a2_pontos;



