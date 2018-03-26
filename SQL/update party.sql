CREATE TABLE public.udparty
(
  id character varying,
  parcel_id integer,
  app character varying,
  nome character varying,
  gen character varying,
  civil character varying,
  prof character varying,
  prof_other character varying,
  nacion character varying,
  naturalidade character varying,
  nascyn character varying,
  nasc date,
  ida character varying,
  doc character varying,
  doc_id character varying,
  doc_local character varying,
  doc_emi date,
  doc_val date,
  doc_vital character varying,
  foto character varying,
  doc_foto character varying,
  assin character varying,
  contacto character varying,
  key character varying NOT NULL
  
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.udparty
  OWNER TO postgres;
GRANT ALL ON TABLE public.udparty TO public;
GRANT ALL ON TABLE public.udparty TO postgres;

INSERT INTO public.udparty
SELECT party_id, parcel_id, app, nom, genero, estado_civil, prof, prof_o, nacion, naturalidade, nascyn, nasc, aida, documento, id, localidade, emi, val, vital,foto, idfoto, assin, contacto, key FROM 
(SELECT form_l_novas_pessoas.oid as party_id,form_l_novas_pessoas.parcel_id, form_l_novas_pessoas.app, form_l_novas_pessoas.nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_l_novas_pessoas.prof, form_l_novas_pessoas.prof_o, form_l_novas_pessoas.nacion, form_l_novas_pessoas.naturalidade, form_l_novas_pessoas.nascyn, form_l_novas_pessoas.nasc, form_l_novas_pessoas.aida, table_doc_identificacao.documento, form_l_novas_pessoas.id, form_l_novas_pessoas.localidade, form_l_novas_pessoas.emi, form_l_novas_pessoas.val, form_l_novas_pessoas.vital, form_l_novas_pessoas.foto, form_l_novas_pessoas.idfoto, form_l_novas_pessoas.assin, form_l_novas_pessoas.contacto, form_l_novas_pessoas.oid::text||form_l_novas_pessoas.parcel_id::text as key FROM  public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_estado_civil AS table_estado_civil RIGHT OUTER JOIN public.form_l_novas_pessoas AS form_l_novas_pessoas ON table_estado_civil.code = form_l_novas_pessoas.civil ON table_doc_identificacao.code = form_l_novas_pessoas.doc ON table_genero_pessoa.code = form_l_novas_pessoas.gen) AS a
WHERE a.key NOT IN (SELECT key FROM udparty);

INSERT INTO public.udparty
SELECT id_party, upn, pessoa_app, pessoa_nom, genero, estado_civil, pessoa_prof, prof_other, pessoa_nacion, pessoa_natural, nasc_y_n, pessoa_nasc, pessoa_ida, documento, pessoa_id, doc_local, doc_emi, doc_val, doc_vital, pessoa_foto, pessoa_id_photo, pessoa_assin, contacto, key FROM
(SELECT form_k_pessoas.id_party::text, digitisations.upn, form_k_pessoas.pessoa_app, form_k_pessoas.pessoa_nom, table_genero_pessoa.genero, table_estado_civil.estado_civil, form_k_pessoas.pessoa_prof, form_k_pessoas.pessoa_prof as prof_other, form_k_pessoas.pessoa_nacion, form_k_pessoas.pessoa_natural, form_k_pessoas.nasc_y_n, form_k_pessoas.pessoa_nasc, form_k_pessoas.pessoa_ida, table_doc_identificacao.documento, form_k_pessoas.pessoa_id, form_k_pessoas.doc_local, form_k_pessoas.doc_emi, form_k_pessoas.doc_val, form_k_pessoas.doc_vital, form_k_pessoas.pessoa_foto, form_k_pessoas.pessoa_id_photo, form_k_pessoas.pessoa_assin, form_k_pessoas.contacto::text,  form_k_pessoas.id_party|| digitisations.upn as key FROM  public.table_doc_identificacao AS table_doc_identificacao RIGHT OUTER JOIN public.table_genero_pessoa AS table_genero_pessoa RIGHT OUTER JOIN public.form_k_pessoas AS form_k_pessoas RIGHT OUTER JOIN public.form_l_titulares AS form_l_titulares ON form_k_pessoas.id_party = form_l_titulares.found_party ON table_genero_pessoa.code = form_k_pessoas.pessoa_gen ON table_doc_identificacao.code = form_k_pessoas.pessoa_doc, public.form_l_registrar_parcela AS form_l_registrar_parcela LEFT OUTER JOIN public.digitisations AS digitisations ON form_l_registrar_parcela.upn_id = digitisations.upn , public.table_estado_civil AS table_estado_civil WHERE form_l_registrar_parcela.key = form_l_titulares.parent_key AND table_estado_civil.code = form_k_pessoas.pessoa_civil) AS a
WHERE a.key NOT IN (SELECT key FROM udparty);



DELETE FROM public.udparty a
WHERE a.ctid <> (SELECT min(b.ctid)
                 FROM   public.udparty b
                 WHERE  a.key = b.key);

DELETE from public.udparty
WHERE EXISTS (SELECT 1 FROM public.party 
WHERE key = public.udparty.key);	



INSERT INTO public.party(
            id, parcel_id, app, nome, gen, civil, prof, prof_other, nacion, 
            naturalidade, nascyn, nasc, ida, doc, doc_id, doc_local, doc_emi, 
            doc_val, doc_vital, foto, doc_foto, assin, contacto, key)
SELECT id, parcel_id, app, nome, gen, civil, prof, prof_other, nacion, 
       naturalidade, nascyn, nasc, ida, doc, doc_id, doc_local, doc_emi, 
       doc_val, doc_vital, foto, doc_foto, assin, contacto, key
  FROM public.udparty;		


DROP TABLE public.udparty;  