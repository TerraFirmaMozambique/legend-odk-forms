INSERT INTO public.form_l_testemunhas_v2(
	search_text, found_testem, parent_uid, key)

Select
	'add' AS search_text,
	'party4685' AS found_testem,
	public.form_l_registrar_parcela.meta_inst_id AS parent_uid,
	concat('add','party4685',public.form_l_registrar_parcela.meta_inst_id) AS key
FROM public.form_l_registrar_parcela LEFT JOIN public.form_l_testemunhas_v2 ON public.form_l_registrar_parcela.meta_inst_id = public.form_l_testemunhas_v2.parent_uid
WHERE public.form_l_testemunhas_v2.found_testem IS NULL AND public.form_l_registrar_parcela.assocs_id ='AS040012' 
ORDER BY public.form_l_registrar_parcela.assocs_id, public.form_l_registrar_parcela.upn_id;
	