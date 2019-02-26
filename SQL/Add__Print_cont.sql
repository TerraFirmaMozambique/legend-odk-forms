


ALTER TABLE certification ADD COLUMN print VARCHAR;

CREATE TABLE public.print as (SELECT form_l_registrar_parcela.assocs_id, form_l_registrar_parcela.upn_id
FROM public.form_l_registrar_parcela form_l_registrar_parcela, public.form_l_testemunhas form_l_testemunhas
WHERE form_l_registrar_parcela.key = form_l_testemunhas.parent_key
ORDER BY form_l_registrar_parcela.assocs_id);

UPDATE  certification
SET print = 'p'
WHERE upn IN (
SELECT upn_id
FROM print);

Drop Table public.print;