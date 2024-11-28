 SELECT T.lan_in_sequencial
      ,T.cri_in_codigo
      ,T.cri_ch_tipocontab
      ,T.cri_ch_principal
      ,T.org_tab_in_codigo
      ,T.org_pad_in_codigo
      ,T.org_in_codigo
      ,T.fil_in_codigo
      ,T.org_tau_st_codigo
      ,T.acaom_in_sequencia
      ,T.patr_in_sequencial
      ,T.acao_tab_in_codigo
      ,T.acao_pad_in_codigo
      ,T.acao_in_codigo
      ,T.lan_dt_inicial
      ,T.lan_dt_final
      ,T.lan_in_quantidade
      ,T.lan_re_valor
      ,T.lan_re_valorvenda
      ,T.lan_st_documento
      ,T.lan_ch_gerado
      ,T.mba_in_codigo
      ,T.usu_in_inclusao
      ,T.lan_dt_inclusao
      ,T.usu_in_alteracao
      ,T.lan_dt_ultalteracao
      ,T.acaolp_in_sequencia
      ,T.lan_re_vlbasebaixa
      ,T.lan_st_laudo
      ,T.recur_tab_in_codigo
      ,T.recur_pad_in_codigo
      ,T.recur_in_codigo
      ,T.org_in_codigoori
      ,T.fil_in_codigoori
      ,T.patr_in_sequencialori
      ,T.aap_in_sequencial
      ,T.lan_bo_semvalor
  FROM (SELECT L.lan_in_sequencial
              ,CS.cri_in_codigo
              ,CS.cri_ch_tipocontab
              ,'S' cri_ch_principal
              ,L.org_tab_in_codigo
              ,L.org_pad_in_codigo
              ,L.org_in_codigo
              ,L.fil_in_codigo
              ,L.org_tau_st_codigo
              ,L.acaom_in_sequencia
              ,L.patr_in_sequencial
              ,L.acao_tab_in_codigo
              ,L.acao_pad_in_codigo
              ,L.acao_in_codigo
              ,L.lan_dt_inicial
              ,L.lan_dt_final
              ,L.lan_in_quantidade
              ,L.lan_re_valor
              ,L.lan_re_valorvenda
              ,L.lan_st_documento
              ,L.lan_ch_gerado
              ,L.mba_in_codigo
              ,L.usu_in_inclusao
              ,L.lan_dt_inclusao
              ,L.usu_in_alteracao
              ,L.lan_dt_ultalteracao
              ,L.acaolp_in_sequencia
              ,L.lan_re_vlbasebaixa
              ,L.lan_st_laudo
              ,L.recur_tab_in_codigo
              ,L.recur_pad_in_codigo
              ,L.recur_in_codigo
              ,L.org_in_codigoori
              ,L.fil_in_codigoori
              ,L.patr_in_sequencialori
              ,L.aap_in_sequencial
              ,L.lan_bo_semvalor 
          FROM construcao.ati_lancamento@hacasa       L
              ,construcao.ati_grupo_item@hacasa       gi
              ,construcao.ati_grupopatr@hacasa        G
              ,construcao.ati_criterios_saldos@hacasa CS
         WHERE L.patr_in_sequencial = gi.patr_in_sequencial
           AND gi.gru_in_sequencial = G.gru_in_sequencial
           AND CS.tab_in_codigo = G.gru_tab_in_codigo
           AND CS.pad_in_codigo = G.gru_pad_in_codigo
           AND CS.ide_st_codigo = G.gru_ide_st_codigo
           AND CS.cri_ch_principal = 'S'
        UNION ALL
        SELECT L.lan_in_sequencial
              ,lav.cri_in_codigo
              ,CS.cri_ch_tipocontab
              ,'N' cri_ch_principal
              ,L.org_tab_in_codigo
              ,L.org_pad_in_codigo
              ,L.org_in_codigo
              ,L.fil_in_codigo
              ,L.org_tau_st_codigo
              ,lav.acaom_in_sequencia
              ,L.patr_in_sequencial
              ,L.acao_tab_in_codigo
              ,L.acao_pad_in_codigo
              ,L.acao_in_codigo
              ,L.lan_dt_inicial
              ,L.lan_dt_final
              ,L.lan_in_quantidade
              ,lav.lav_re_valorcriterio lan_re_valor
              ,L.lan_re_valorvenda
              ,L.lan_st_documento
              ,L.lan_ch_gerado
              ,L.mba_in_codigo
              ,L.usu_in_inclusao
              ,L.lan_dt_inclusao
              ,L.usu_in_alteracao
              ,L.lan_dt_ultalteracao
              ,lav.acaolp_in_sequencia
              ,L.lan_re_vlbasebaixa
              ,L.lan_st_laudo
              ,L.recur_tab_in_codigo
              ,L.recur_pad_in_codigo
              ,L.recur_in_codigo
              ,L.org_in_codigoori
              ,L.fil_in_codigoori
              ,L.patr_in_sequencialori
              ,L.aap_in_sequencial
              ,L.lan_bo_semvalor 
          FROM construcao.ati_lancamento@hacasa       L
              ,construcao.ati_lancamento_valor@hacasa lav
              ,construcao.ati_criterios_saldos@hacasa CS
         WHERE L.lan_in_sequencial = lav.lan_in_sequencial
           AND lav.cri_in_codigo = CS.cri_in_codigo) T