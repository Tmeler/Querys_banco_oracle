 SELECT
       cto.org_pad_in_codigo
     , cto.org_in_codigo
     , cto.org_tau_st_codigo
     , cto.cto_in_codigo
     , cto.fil_in_codigo
     , cto.cnd_in_codigo
     , cto.cto_re_valorcontrato
	 , DECODE(UPPER(CTO.CTO_CH_TIPO),
              'P', 'PERMUTA',
              'V', 'VENDA',
              'M', 'ALUGUEL',
              'OUTRO') AS CTO_CH_TIPO
     , cto.cto_bo_etiqueta
     , cto.cto_bo_selecionado
     , cto.cto_dt_cadastro
     , cto.cto_ch_status
     , cto.cto_dt_status
     , cto.cto_ch_classificacao
     , cto.cto_dt_classificacao
     , cto.cto_bo_impresso
     , cto.cto_dt_impressao
     , cto.cto_re_mora
     , cto.cto_re_juros
     , cto.cto_re_tabelaprice
     , cto.cto_bo_tabelaprice
     , cto.cto_bo_statustp
     , cto.cto_ch_origem
     , cto.cto_dt_entrega
     , cto.cto_bo_prorata
     , cto.pro_tab_in_codigo
     , cto.pro_pad_in_codigo
     , cto.pro_ide_st_codigo
     , cto.pro_in_reduzido
     , cto.cus_tab_in_codigo
     , cto.cus_pad_in_codigo
     , cto.cus_ide_st_codigo
     , cto.cus_in_reduzido
     , cto.pai_cto_in_codigo
     , cto.cto_st_path_texto
     , cto.cto_re_taxaant
     , cto.cto_re_taxaant_tp
     , cto.cto_re_taxaant_sac
     , cto.cto_st_observacao
     , cto.cto_bo_proratabx
     , cto.cto_dt_geracaotp
     , cto.cto_dt_referenciatp
     , cto.cto_bo_contabiliza
     , cto.cto_bo_descprorata
     , cto.cto_in_indice
     , cto.cto_ch_tipomulta
     , cto.cto_re_totalresiduo
     , cto.csf_in_codigo -- novo campo para classificac?o de contratos
     , cte.ctoenv_ch_origem
     , cto.cto_in_carenciaatraso
     , env.env_tipo
     , agn.agn_st_nome
     , agn.agn_tab_in_codigo
     , agn.agn_pad_in_codigo
     , agn.agn_in_codigo
     , emp_codigo
     , emp_st_codigo
     , emp_nome
     , etp_codigo
     , etp_st_codigo
     , etp_nome
     , blo_codigo
     , blo_st_codigo
     , blo_nome
     , und_codigo
     , und_st_codigo
     , und_nome
     , fil.agn_st_nome filial
     , cto.cto_bo_dacaopagterreno
     , cto.cto_bo_enviaregistradora
FROM construcao.car_contrato@hacasa         cto
   , construcao.car_contrato_cliente@hacasa cli
   , construcao.glo_agentes@hacasa          agn
   , construcao.car_vw_contrato_envolvido@hacasa cte
   , construcao.dbm_vw_envolvido@hacasa          env
   , construcao.glo_agentes@hacasa               fil
WHERE cli.org_tab_in_codigo = cto.org_tab_in_codigo
  AND cli.org_pad_in_codigo = cto.org_pad_in_codigo
  AND cli.org_in_codigo     = cto.org_in_codigo
  AND cli.org_tau_st_codigo = cto.org_tau_st_codigo
  AND cli.cto_in_codigo     = cto.cto_in_codigo
  AND agn.agn_tab_in_codigo = cli.agn_tab_in_codigo
  AND agn.agn_pad_in_codigo = cli.agn_pad_in_codigo
  AND agn.agn_in_codigo     = cli.agn_in_codigo
  AND cte.org_tab_in_codigo = cto.org_tab_in_codigo
  AND cte.org_pad_in_codigo = cto.org_pad_in_codigo
  AND cte.org_in_codigo     = cto.org_in_codigo
  AND cte.org_tau_st_codigo = cto.org_tau_st_codigo
  AND cte.cto_in_codigo     = cto.cto_in_codigo
  AND env.tab_in_codigo     = cte.env_tab_in_codigo
  AND env.pad_in_codigo     = cte.env_pad_in_codigo
  AND env.org_in_codigo     = cte.env_org_in_codigo
  AND env.tau_st_codigo     = cte.env_tau_st_codigo
  AND env.und_codigo        = cte.env_in_codigo
  AND env.env_tipo          = cte.ctoenv_ch_origem
  AND fil.agn_tab_in_codigo = cto.org_tab_in_codigo
  AND fil.agn_pad_in_codigo = cto.org_pad_in_codigo
  AND fil.agn_in_codigo     = cto.fil_in_codigo