CREATE TABLE public.update_form_c1_reg_associacao
(
  sub_date timestamp without time zone,
  begin timestamp without time zone,
  my_form_name character varying,
  intronote character varying,
  tec_nome character varying,
  add_nome character varying,
  registo_date date,
  prov_id character varying,
  dist_id character varying,
  posto_id character varying,
  assoc_nome character varying,
  pov_ids character varying,
  add_pov character varying,
  povoados_count integer,
  set_of_povoados character varying,
  finish timestamp without time zone,
  meta_id character varying,
  meta_name character varying,
  key character varying NOT NULL
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_c1_reg_associacao
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_c1_reg_associacao TO postgres;

COPY public.update_form_c1_reg_associacao FROM '/var/lib/share/projects/legend/dbupdate/form_c1_reg_associacao_pov.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_c1_reg_associacao a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_c1_reg_associacao b
                 WHERE  a.key = b.key);

DELETE from public.update_form_c1_reg_associacao
WHERE EXISTS (SELECT 1 FROM public.form_c1_reg_associacao
WHERE key = public.update_form_c1_reg_associacao.key );

INSERT INTO public.form_c1_reg_associacao(
            sub_date, begin, my_form_name, intronote, tec_nome, add_nome, 
            registo_date, prov_id, dist_id, posto_id, assoc_nome, pov_ids, 
            add_pov, povoados_count, set_of_povoados, finish, meta_id, meta_name, 
            key)
SELECT sub_date, begin, my_form_name, intronote, tec_nome, add_nome, 
       registo_date, prov_id, dist_id, posto_id, assoc_nome, pov_ids, 
       add_pov, povoados_count, set_of_povoados, finish, meta_id, meta_name, 
       key
  FROM public.update_form_c1_reg_associacao;
  
  
  
  CREATE TABLE public.update_form_c1_reg_associacao_pov
(
  sel_field character varying,
  sel_label character varying,
  pov_familias integer,
  parent_key character varying,
  key character varying NOT NULL,
  set_of_povoados character varying
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.update_form_c1_reg_associacao_pov
  OWNER TO postgres;
GRANT ALL ON TABLE public.update_form_c1_reg_associacao_pov TO postgres;

COPY public.update_form_c1_reg_associacao_pov FROM '/var/lib/share/projects/legend/dbupdate/form_c1_reg_associacao_povoados.csv'  USING DELIMITERS ',' WITH NULL AS '' CSV HEADER ENCODING 'latin1';

DELETE FROM public.update_form_c1_reg_associacao_pov a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.update_form_c1_reg_associacao_pov b
                 WHERE  a.key = b.key);

DELETE from public.update_form_c1_reg_associacao_pov
WHERE EXISTS (SELECT 1 FROM public.form_c1_reg_associacao_pov
WHERE key = public.update_form_c1_reg_associacao_pov.key );
  
  
INSERT INTO public.form_c1_reg_associacao_pov(
            sel_field, sel_label, pov_familias, parent_key, key, set_of_povoados)
SELECT sel_field, sel_label, pov_familias, parent_key, key, set_of_povoados
FROM public.update_form_c1_reg_associacao_pov;
			
  
DROP TABLE public.update_form_c1_reg_associacao;
DROP TABLE public.update_form_c1_reg_associacao_pov;