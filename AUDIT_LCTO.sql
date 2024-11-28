 select T.LAN_IN_SEQUENCIAL
      ,T.CRI_IN_CODIGO
      ,T.CRI_CH_TIPOCONTAB
      ,T.CRI_CH_PRINCIPAL
      ,T.ORG_TAB_IN_CODIGO
      ,T.ORG_PAD_IN_CODIGO
      ,T.ORG_IN_CODIGO
      ,T.FIL_IN_CODIGO
      ,T.ORG_TAU_ST_CODIGO
      ,T.ACAOM_IN_SEQUENCIA
      ,T.PATR_IN_SEQUENCIAL
      ,T.ACAO_TAB_IN_CODIGO
      ,T.ACAO_PAD_IN_CODIGO
      ,T.ACAO_IN_CODIGO
      ,T.LAN_DT_INICIAL
      ,T.LAN_DT_FINAL
      ,T.LAN_IN_QUANTIDADE
      ,T.LAN_RE_VALOR
      ,T.LAN_RE_VALORVENDA
      ,T.LAN_ST_DOCUMENTO
      ,T.LAN_CH_GERADO
      ,T.MBA_IN_CODIGO
      ,T.USU_IN_INCLUSAO
      ,T.LAN_DT_INCLUSAO
      ,T.USU_IN_ALTERACAO
      ,T.LAN_DT_ULTALTERACAO
      ,T.ACAOLP_IN_SEQUENCIA
      ,T.LAN_RE_VLBASEBAIXA
      ,T.LAN_ST_LAUDO
      ,T.RECUR_TAB_IN_CODIGO
      ,T.RECUR_PAD_IN_CODIGO
      ,T.RECUR_IN_CODIGO
      ,T.ORG_IN_CODIGOORI
      ,T.FIL_IN_CODIGOORI
      ,T.PATR_IN_SEQUENCIALORI
      ,T.AAP_IN_SEQUENCIAL
      ,T.LAN_BO_SEMVALOR
  from (select L.LAN_IN_SEQUENCIAL
              ,CS.CRI_IN_CODIGO
              ,CS.CRI_CH_TIPOCONTAB
              ,'S' CRI_CH_PRINCIPAL
              ,L.ORG_TAB_IN_CODIGO
              ,L.ORG_PAD_IN_CODIGO
              ,L.ORG_IN_CODIGO
              ,L.FIL_IN_CODIGO
              ,L.ORG_TAU_ST_CODIGO
              ,L.ACAOM_IN_SEQUENCIA
              ,L.PATR_IN_SEQUENCIAL
              ,L.ACAO_TAB_IN_CODIGO
              ,L.ACAO_PAD_IN_CODIGO
              ,L.ACAO_IN_CODIGO
              ,L.LAN_DT_INICIAL
              ,L.LAN_DT_FINAL
              ,L.LAN_IN_QUANTIDADE
              ,L.LAN_RE_VALOR
              ,L.LAN_RE_VALORVENDA
              ,L.LAN_ST_DOCUMENTO
              ,L.LAN_CH_GERADO
              ,L.MBA_IN_CODIGO
              ,L.USU_IN_INCLUSAO
              ,L.LAN_DT_INCLUSAO
              ,L.USU_IN_ALTERACAO
              ,L.LAN_DT_ULTALTERACAO
              ,L.ACAOLP_IN_SEQUENCIA
              ,L.LAN_RE_VLBASEBAIXA
              ,L.LAN_ST_LAUDO
              ,L.RECUR_TAB_IN_CODIGO
              ,L.RECUR_PAD_IN_CODIGO
              ,L.RECUR_IN_CODIGO
              ,L.ORG_IN_CODIGOORI
              ,L.FIL_IN_CODIGOORI
              ,L.PATR_IN_SEQUENCIALORI
              ,L.AAP_IN_SEQUENCIAL
              ,L.LAN_BO_SEMVALOR -- AVS 20/01/2012 PM620276
          from CONSTRUCAO.ATI_LANCAMENTO@HACASA       L
              ,CONSTRUCAO.ATI_GRUPO_ITEM@HACASA       GI
              ,CONSTRUCAO.ATI_GRUPOPATR@HACASA        G
              ,CONSTRUCAO.ATI_CRITERIOS_SALDOS@HACASA CS
         where L.PATR_IN_SEQUENCIAL = GI.PATR_IN_SEQUENCIAL
           and GI.GRU_IN_SEQUENCIAL = G.GRU_IN_SEQUENCIAL
           and CS.TAB_IN_CODIGO = G.GRU_TAB_IN_CODIGO
           and CS.PAD_IN_CODIGO = G.GRU_PAD_IN_CODIGO
           and CS.IDE_ST_CODIGO = G.GRU_IDE_ST_CODIGO
           and CS.CRI_CH_PRINCIPAL = 'S'
        union all
        select L.LAN_IN_SEQUENCIAL
              ,LAV.CRI_IN_CODIGO
              ,CS.CRI_CH_TIPOCONTAB
              ,'N' CRI_CH_PRINCIPAL
              ,L.ORG_TAB_IN_CODIGO
              ,L.ORG_PAD_IN_CODIGO
              ,L.ORG_IN_CODIGO
              ,L.FIL_IN_CODIGO
              ,L.ORG_TAU_ST_CODIGO
              ,LAV.ACAOM_IN_SEQUENCIA
              ,L.PATR_IN_SEQUENCIAL
              ,L.ACAO_TAB_IN_CODIGO
              ,L.ACAO_PAD_IN_CODIGO
              ,L.ACAO_IN_CODIGO
              ,L.LAN_DT_INICIAL
              ,L.LAN_DT_FINAL
              ,L.LAN_IN_QUANTIDADE
              ,LAV.LAV_RE_VALORCRITERIO LAN_RE_VALOR
              ,L.LAN_RE_VALORVENDA
              ,L.LAN_ST_DOCUMENTO
              ,L.LAN_CH_GERADO
              ,L.MBA_IN_CODIGO
              ,L.USU_IN_INCLUSAO
              ,L.LAN_DT_INCLUSAO
              ,L.USU_IN_ALTERACAO
              ,L.LAN_DT_ULTALTERACAO
              ,LAV.ACAOLP_IN_SEQUENCIA
              ,L.LAN_RE_VLBASEBAIXA
              ,L.LAN_ST_LAUDO
              ,L.RECUR_TAB_IN_CODIGO
              ,L.RECUR_PAD_IN_CODIGO
              ,L.RECUR_IN_CODIGO
              ,L.ORG_IN_CODIGOORI
              ,L.FIL_IN_CODIGOORI
              ,L.PATR_IN_SEQUENCIALORI
              ,L.AAP_IN_SEQUENCIAL
              ,L.LAN_BO_SEMVALOR -- AVS 20/01/2012 PM620276
          from CONSTRUCAO.ATI_LANCAMENTO@HACASA       L
              ,CONSTRUCAO.ATI_LANCAMENTO_VALOR@HACASA LAV
              ,CONSTRUCAO.ATI_CRITERIOS_SALDOS@HACASA CS
         where L.LAN_IN_SEQUENCIAL = LAV.LAN_IN_SEQUENCIAL
           and LAV.CRI_IN_CODIGO = CS.CRI_IN_CODIGO) T;