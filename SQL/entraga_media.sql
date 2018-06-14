COPY (SELECT 
  substr(certification.povoado_id,3,9)||'-'|| lpad(certification.nupn::text, 6, '0') AS nupn,
  lpad(certification.upn::text, 6, '0')::integer AS upn_key, 
  party.app, 
  party.nome, 
  party.doc, 
  party.doc_id, 
  party.contacto,
  'Declaracao emitida'::character varying as resultado

FROM 
  public.certification, 
  public.party
WHERE 
  certification.upn = party.parcel_id and  certification.assoc_id = 'AS040001'
ORDER BY
  certification.upn ASC
) TO '/var/lib/share/projects/legend/ODK Forms/legend-odk-forms/S_registo_entrega/S_registo_entrega-media/AS040001.csv' DELIMITER ',' NULL AS '' CSV HEADER ENCODING 'latin1';
