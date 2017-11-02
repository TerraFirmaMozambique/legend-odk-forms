


CREATE TABLE public.update_form_a1_pontos_interesse_limites
(
geom geometry(Point,0),
sub_date timestamp without time zone,
start timestamp without time zone,
myformname character varying,
intronote character varying,
tec_nome character varying,
add_nome character varying,
today date,
latitude double precision,
longitude double precision,
altitude double precision,
accuracy double precision,
poi_tipo character varying,
poi_disput character varying,
disput character varying,
poi_descriptor character varying,
poi_alt character varying,
rio_nome character varying,
esc_nome character varying,
igr_nome character varying,
leader_name character varying,
flo_nome character varying,
mont_nome character varying,
cem_nome character varying,
duat_nome character varying,
contr_ref character varying,
poi_boundary character varying,
des_area character varying,
des_area_out character varying,
uso_area character varying,
cul character varying,
cul_out character varying,
casa character varying,
cdisagr character varying,
casa_tipo character varying,
prob character varying,
out_prob character varying,
mud character varying,
fut character varying,
poi_picture character varying,
finish timestamp without time zone,
inst_id character varying,
inst_name character varying,
key character varying

)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_a1_pontos_interesse_limites
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_a1_pontos_interesse_limites TO postgres;

COPY public.update_form_a1_pontos_interesse_limites FROM '/var/lib/share/projects/legend/dbupdate/form_a1_pontos_interesse_limites.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_a1_pontos_interesse_limites a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_a1_pontos_interesse_limites b
                 WHERE  a.key = b.key);

DELETE from public.update_form_a1_pontos_interesse_limites
WHERE EXISTS (SELECT 1 FROM public.form_a1_pontos_interesse_limites
WHERE key = public.update_form_a1_pontos_interesse_limites.key );


SELECT UpdateGeometrySRID('form_a1_pontos_interesse_limites','geom',0);
INSERT INTO public.form_a1_pontos_interesse_limites(
            geom, sub_date, start, myformname, intronote, tec_nome, add_nome, 
            today, latitude, longitude, altitude, accuracy, poi_tipo, poi_disput, 
            disput, poi_descriptor, poi_alt, rio_nome, esc_nome, igr_nome, 
            leader_name, flo_nome, mont_nome, cem_nome, duat_nome, contr_ref, 
            poi_boundary, des_area, des_area_out, uso_area, cul, cul_out, 
            casa, cdisagr, casa_tipo, prob, out_prob, mud, fut, poi_picture, 
            finish, inst_id, inst_name, key)
SELECT geom, sub_date, start, myformname, intronote, tec_nome, add_nome, 
       today, latitude, longitude, altitude, accuracy, poi_tipo, poi_disput, 
       disput, poi_descriptor, poi_alt, rio_nome, esc_nome, igr_nome, 
       leader_name, flo_nome, mont_nome, cem_nome, duat_nome, contr_ref, 
       poi_boundary, des_area, des_area_out, uso_area, cul, cul_out, 
       casa, cdisagr, casa_tipo, prob, out_prob, mud, fut, poi_picture, 
       finish, inst_id, inst_name, key
  FROM public.update_form_a1_pontos_interesse_limites;


SELECT UpdateGeometrySRID('form_a1_pontos_interesse_limites','geom',4326);

DROP TABLE public.update_form_a1_pontos_interesse_limites;

