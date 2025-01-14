SELECT    I.CRE_IN_REDUZIDO CREDITO
          ,I.DEB_IN_REDUZIDO DEBITO
          ,P.PRO_IN_REDUZIDO PROJETO
          ,P.RPRO_CH_NATUREZA NATUREZA
          ,P.RPRO_RE_VALOR VALOR
          ,L.LAN_IN_CODIGO LANÇAMENTO
          ,L.ACAO_IN_CODIGO CÓD_ACAO
          ,L.LOT_IN_CODIGO LOTE
          ,L.LAN_CH_STATUS STATUS_LCTO
          ,I.LAN_DT_LANCAMENTO DATA
          ,L.LAN_IN_ANOMES ANO_MES
          ,C.CUS_IN_REDUZIDO CENTRO_CUSTO
          ,I.FIL_IN_CODIGO FIL_IN_CODIGO
          ,I.AGN_IN_CODIGO AGENTE
          ,I.ITE_ST_COMPLEMENTO
          ,L.LAN_CH_TIPOCONTAB -- LM 20/08/2010 PM457704
          ,L.LAN_CH_TIPOCONTABUSU -- LM 20/08/2010 PM457704
FROM CONSTRUCAO.CON_ITEM_LANCAMENTO@HACASA I
    ,CONSTRUCAO.CON_LANCAMENTO_PRO@HACASA P
    ,CONSTRUCAO.CON_LANCAMENTO@HACASA L
    ,CONSTRUCAO.CON_LANCAMENTO_CC@HACASA C
    ,CONSTRUCAO.GLO_ACAO@HACASA A
  WHERE L.ORG_TAB_IN_CODIGO = I.ORG_TAB_IN_CODIGO and
L.ORG_PAD_IN_CODIGO = I.ORG_PAD_IN_CODIGO and
L.ORG_IN_CODIGO = I.ORG_IN_CODIGO and
L.ORG_TAU_ST_CODIGO = I.ORG_TAU_ST_CODIGO and
L.LAN_TAB_IN_CODIGO = I.LAN_TAB_IN_CODIGO and
L.LAN_SEQ_IN_CODIGO = I.LAN_SEQ_IN_CODIGO and
L.LAN_IN_CODIGO = I.LAN_IN_CODIGO and
L.ACAO_TAB_IN_CODIGO = A.ACAO_TAB_IN_CODIGO and
L.ACAO_PAD_IN_CODIGO = A.ACAO_PAD_IN_CODIGO and
L.ACAO_IN_CODIGO = A.ACAO_IN_CODIGO and
I.ORG_TAB_IN_CODIGO = C.ORG_TAB_IN_CODIGO and
I.ORG_PAD_IN_CODIGO = C.ORG_PAD_IN_CODIGO and
I.ORG_IN_CODIGO = C.ORG_IN_CODIGO and
I.ORG_TAU_ST_CODIGO = C.ORG_TAU_ST_CODIGO and
I.LAN_TAB_IN_CODIGO = C.LAN_TAB_IN_CODIGO and
I.LAN_SEQ_IN_CODIGO = C.LAN_SEQ_IN_CODIGO and
I.LAN_IN_CODIGO = C.LAN_IN_CODIGO and
I.ITE_IN_CODIGO = C.ITE_IN_CODIGO and
C.ORG_TAB_IN_CODIGO = P.ORG_TAB_IN_CODIGO and
C.ORG_PAD_IN_CODIGO = P.ORG_PAD_IN_CODIGO and
C.ORG_IN_CODIGO = P.ORG_IN_CODIGO and
C.ORG_TAU_ST_CODIGO = P.ORG_TAU_ST_CODIGO and
C.LAN_TAB_IN_CODIGO = P.LAN_TAB_IN_CODIGO and
C.LAN_SEQ_IN_CODIGO = P.LAN_SEQ_IN_CODIGO and
C.LAN_IN_CODIGO = P.LAN_IN_CODIGO and
C.ITE_IN_CODIGO = P.ITE_IN_CODIGO and
C.LCC_CH_NATUREZA = P.LCC_CH_NATUREZA and
C.LCC_IN_SEQUENCIAL = P.LCC_IN_SEQUENCIAL
ORDER BY I.LAN_DT_LANCAMENTO DESC