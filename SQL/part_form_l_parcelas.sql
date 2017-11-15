-- Legend update parcelas in L

CREATE TABLE public.update_form_l_registrar_parcela
(
  geom geometry(Point,0),
  sub_date timestamp without time zone,
  begin timestamp without time zone,
  formname character varying,
  intronote character varying,
  tec_name character varying,
  registo_data date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  assocs_id character varying,
  upn_id character varying,
  upn_check character varying,
  ocup character varying,
  ocup_outro character varying,
  z_excl character varying,
  part_excl character varying,
  tipo_excl character varying,
  conf character varying,
  tipo_conf character varying,
  desc_conf character varying,
  use_cat character varying,
  use_tipo character varying,
  use_prin character varying,
  use_outro character varying,
  demarcator character varying,
  nomedemarcator character varying,
  party_type character varying,
  add_party_number integer,
  party_menor character varying,
  titulares_count integer,
  set_of_titulares character varying,
  searchtext1 character varying,
  foundrepmenor character varying,
  searchtext2 character varying,
  foundrepent character varying,
  entnome character varying,
  enttipo character varying,
  reg_party_yn character varying,
  reg_newparty_number integer,
  novas_pessoas_count integer,
  set_of_novas_pessoas character varying,
  testem_num integer,
  testemunhas_count integer,
  set_of_testemunhas character varying,
  regparty1yn character varying,
  regnewparty1number integer,
  novaspessoas1count integer,
  novaspessoas1 character varying,
  latitude double precision,
  longitude double precision,
  altitude double precision,
  accuracy double precision,
  limites_yn character varying,
  set_of_pontos character varying,
  endnote character varying,
  recibo_image character varying,
  finish timestamp without time zone,
  meta_inst_id character varying,
  meta_inst_name character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_l_registrar_parcela
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_parcela TO postgres;
GRANT ALL ON TABLE public.update_form_l_registrar_parcela TO public;


COPY public.update_form_l_registrar_parcela FROM '/var/lib/share/projects/legend/dbupdate/form_l_registrar_parcelas.csv'  USING DELIMITERS ',' NULL AS '' CSV HEADER ENCODING 'latin1';


DELETE FROM public.update_form_l_registrar_parcela a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_l_registrar_parcela b
                 WHERE  a.key = b.key);
	
	DELETE FROM public.update_form_l_registrar_parcela
WHERE EXISTS (SELECT 1 FROM public.form_l_registrar_parcela 
WHERE key = public.update_form_l_registrar_parcela.key );

SELECT UpdateGeometrySRID('form_l_registrar_parcela','geom',0);

INSERT INTO public.form_l_registrar_parcela(
            geom, sub_date, begin, formname, intronote, tec_name, registo_data, 
            prov_id, dist_id, posto_id, assocs_id, upn_id, upn_check, ocup, 
            ocup_outro, z_excl, part_excl, tipo_excl, conf, tipo_conf, desc_conf, 
            use_cat, use_tipo, use_prin, use_outro, demarcator, nomedemarcator, 
            party_type, add_party_number, party_menor, titulares_count, set_of_titulares, 
            searchtext1, foundrepmenor, searchtext2, foundrepent, entnome, 
            enttipo, reg_party_yn, reg_newparty_number, novas_pessoas_count, 
            set_of_novas_pessoas, testem_num, testemunhas_count, set_of_testemunhas, 
            regparty1yn, regnewparty1number, novaspessoas1count, novaspessoas1, 
            latitude, longitude, altitude, accuracy, limites_yn, set_of_pontos, 
            endnote, recibo_image, finish, meta_inst_id, meta_inst_name, 
            key)
SELECT geom, sub_date, begin, formname, intronote, tec_name, registo_data, 
       prov_id, dist_id, posto_id, assocs_id, upn_id, upn_check, ocup, 
       ocup_outro, z_excl, part_excl, tipo_excl, conf, tipo_conf, desc_conf, 
       use_cat, use_tipo, use_prin, use_outro, demarcator, nomedemarcator, 
       party_type, add_party_number, party_menor, titulares_count, set_of_titulares, 
       searchtext1, foundrepmenor, searchtext2, foundrepent, entnome, 
       enttipo, reg_party_yn, reg_newparty_number, novas_pessoas_count, 
       set_of_novas_pessoas, testem_num, testemunhas_count, set_of_testemunhas, 
       regparty1yn, regnewparty1number, novaspessoas1count, novaspessoas1, 
       latitude, longitude, altitude, accuracy, limites_yn, set_of_pontos, 
       endnote, recibo_image, finish, meta_inst_id, meta_inst_name, 
       key
  FROM public.update_form_l_registrar_parcela;



SELECT UpdateGeometrySRID('form_l_registrar_parcela','geom',4326);

DROP TABLE public.update_form_l_registrar_parcela;

