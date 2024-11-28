 SELECT R.ORG_TAB_IN_CODIGO||'|'||R.ORG_PAD_IN_CODIGO||'|'||R.ORG_IN_CODIGO||'|'||R.ORG_TAU_ST_CODIGO||'|'||R.MOV_TAB_IN_CODIGO||'|'||R.MOV_SEQ_IN_CODIGO||'|'||R.MOV_IN_NUMLANCTO AS ID_MOV_VINCULADO,

       R.REF_ORG_TAB_IN_CODIGO||'|'||R.REF_ORG_PAD_IN_CODIGO||'|'||R.REF_ORG_IN_CODIGO||'|'||R.REF_ORG_TAU_ST_CODIGO||'|'||R.REF_MOV_TAB_IN_CODIGO||'|'||R.REF_MOV_SEQ_IN_CODIGO||'|'||R.REF_MOV_IN_NUMLANCTO AS ID_MOV_ORIGINAL,

       V.AGN_TAB_IN_CODIGO||'|'||V.AGN_PAD_IN_CODIGO||'|'||V.AGN_IN_CODIGO||'|'||V.AGN_TAU_ST_CODIGO AS ID_AGENTE,
       V.ACAO_TAB_IN_CODIGO||'|'||V.ACAO_PAD_IN_CODIGO||'|'||V.ACAO_IN_CODIGO AS ID_ACAO,
       DECODE(V.HIS_IN_REDUZIDO, NULL, NULL, V.HIS_TAB_IN_CODIGO||'|'||V.HIS_PAD_IN_CODIGO||'|'||V.HIS_IDE_ST_CODIGO||'|'||V.HIS_IN_REDUZIDO) AS ID_HISTORICO,

       V.ORG_IN_CODIGO AS COD_ORGANIZACAO,
       V.FIL_IN_CODIGO AS COD_FILIAL,
       R.REF_ST_TIPO AS TIPO_REFERENCIA,
       V.MOV_CH_ORIGEM AS ORIGEM_MOVIMENTO,
       V.TPD_ST_CODIGO AS TIPO_DOCUMENTO,
       V.MOV_ST_DOCUMENTO AS DOCUMENTO,
       V.MOV_DT_DATADOCTO AS DATA_DOCUMENTO,
       V.MOV_DT_DATAINC AS DATA_INCLUSAO,
       V.MOV_DT_VENCTO AS VENCIMENTO,
       V.MOV_DT_PRORROGADO AS VENCIMENTO_PRORROGADO,

       V.IND_IN_CODIGOIND AS COD_INDICE,
       V.IND_IN_CODIGOMOE AS COD_MOEDA,
       V.MOV_RE_COTACAOMOE AS COTACAO_MOEDA,
       V.USU_IN_INCLUSAO AS COD_USUARIO_INCLUSAO,

       V.MOV_IN_NUMLANCTO AS NUMLANCTO,
       V.AGN_PAD_IN_CODIGO AS PADRAO_AGENTE,
       V.AGN_IN_CODIGO AS COD_AGENTE,
       V.AGN_TAU_ST_CODIGO AS TIPO_AGENTE,
       V.ACAO_PAD_IN_CODIGO AS PADRAO_ACAO,
       V.ACAO_IN_CODIGO AS COD_ACAO,
       V.ACAOM_IN_SEQUENCIA AS ACAOM_IN_SEQUENCIA,
       V.MOV_RE_VALORMOEDA AS VALOR_MOEDA
  FROM CONSTRUCAO.FIN_MOVIMENTO@HACASA V

JOIN CONSTRUCAO.FIN_REFERENCIAFIN@HACASA R ON
  (R.ORG_TAB_IN_CODIGO = V.ORG_TAB_IN_CODIGO AND
   R.ORG_PAD_IN_CODIGO = V.ORG_PAD_IN_CODIGO AND
   R.ORG_IN_CODIGO     = V.ORG_IN_CODIGO AND
   R.ORG_TAU_ST_CODIGO = V.ORG_TAU_ST_CODIGO AND
   R.MOV_TAB_IN_CODIGO = V.MOV_TAB_IN_CODIGO AND
   R.MOV_SEQ_IN_CODIGO = V.MOV_SEQ_IN_CODIGO AND
   R.MOV_IN_NUMLANCTO  = V.MOV_IN_NUMLANCTO)

JOIN CONSTRUCAO.FIN_MOVIMENTO@HACASA M ON
  (M.ORG_TAB_IN_CODIGO = R.REF_ORG_TAB_IN_CODIGO AND
   M.ORG_PAD_IN_CODIGO = R.REF_ORG_PAD_IN_CODIGO AND
   M.ORG_IN_CODIGO     = R.REF_ORG_IN_CODIGO AND
   M.ORG_TAU_ST_CODIGO = R.REF_ORG_TAU_ST_CODIGO AND
   M.MOV_TAB_IN_CODIGO = R.REF_MOV_TAB_IN_CODIGO AND
   M.MOV_SEQ_IN_CODIGO = R.REF_MOV_SEQ_IN_CODIGO AND
   M.MOV_IN_NUMLANCTO  = R.REF_MOV_IN_NUMLANCTO)

WHERE M.MOV_CH_ORIGEM      = 'M'
AND   M.MOV_CH_SITUACAO    = 'N'
AND   (M.TREF_ST_CODIGO IS NULL OR M.TREF_ST_CODIGO = 'TRANSF')
AND   V.MOV_CH_SITUACAO    = 'N'
AND   V.MOV_CH_STATUSBXREF = 'N'