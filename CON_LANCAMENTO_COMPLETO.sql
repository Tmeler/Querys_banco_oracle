  SELECT 
CAB.LAN_IN_CODIGO,
CAB.ACAO_TAB_IN_CODIGO,
CAB.ACAO_PAD_IN_CODIGO,
CAB.ACAO_IN_CODIGO,
CAB.LOT_TAB_IN_CODIGO,
CAB.LOT_SEQ_IN_CODIGO,
CAB.LOT_IN_CODIGO,
CAB.LAN_CH_STATUS,
CAB.LAN_RE_TOTDEBITO,
CAB.LAN_RE_TOTCREDITO,
CAB.SIS_IN_CODIGO,
CAB.TLA_IN_CODIGO,
CAB.LAN_IN_ANOMES,
CAB.LAN_IN_LANCMES,
CAB.LAN_DT_IMPORTACAO,
CAB.PRD_IN_CODIGO,
CAB.RED_IN_CODIGO,
CAB.LAN_CH_TIPOCONTAB,
CAB.LAN_CH_TIPOCONTABUSU,
CAB.LAN_CH_AVPSTATUS,
CAB.LAN_ST_AVPCODERRO,
CAB.LAN_BO_ECD,
LIN.AGN_IN_CODIGO,
LIN.AGN_PAD_IN_CODIGO,
LIN.AGN_TAB_IN_CODIGO,
LIN.CRE_IDE_ST_CODIGO,
LIN.CRE_IN_REDUZIDO,
LIN.DEB_IDE_ST_CODIGO,
LIN.DEB_IN_REDUZIDO,
LIN.DEB_ST_EXTENSOANT,
LIN.DEB_ST_PARCELA,
LIN.FIL_IN_CODIGO,
LIN.ITE_CH_CONCBAN,
LIN.ITE_CH_CONCCON,
LIN.ITE_DT_ATUORCAMENTO,
LIN.ITE_DT_CONVERSAO,
LIN.ITE_DT_INCLUSAO,
LIN.ITE_DT_ORCAMENTO,
LIN.ITE_DT_ULTALTERACAO,
LIN.ITE_IN_CODIGO,
LIN.ITE_RE_VALOR,
LIN.ITE_ST_COMPLEMENTO,
LIN.ITE_ST_CONCILIACAO,
LIN.PLA_PAD_IN_CODIGO,
LIN.PLA_TAB_IN_CODIGO,
LIN.USU_IN_ALTERACAO,
LIN.USU_IN_INCLUSAO
FROM CONSTRUCAO.CON_LANCAMENTO@HACASA CAB,
     CONSTRUCAO.CON_ITEM_LANCAMENTO@HACASA LIN
WHERE 
CAB.ORG_TAB_IN_CODIGO = LIN.ORG_TAB_IN_CODIGO AND
CAB.ORG_PAD_IN_CODIGO = LIN.ORG_PAD_IN_CODIGO AND 
CAB.ORG_IN_CODIGO = LIN.ORG_IN_CODIGO AND
CAB.ORG_TAU_ST_CODIGO = LIN.ORG_TAU_ST_CODIGO AND
CAB.LAN_TAB_IN_CODIGO = LIN.LAN_TAB_IN_CODIGO AND
CAB.LAN_SEQ_IN_CODIGO = LIN.LAN_SEQ_IN_CODIGO AND
CAB.LAN_IN_CODIGO = LIN.LAN_IN_CODIGO AND
CAB.LAN_DT_LANCAMENTO = LIN.LAN_DT_LANCAMENTO