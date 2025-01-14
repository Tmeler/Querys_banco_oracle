 SELECT M.ORG_TAB_IN_CODIGO||'|'||M.ORG_PAD_IN_CODIGO||'|'||M.ORG_IN_CODIGO||'|'||M.ORG_TAU_ST_CODIGO||'|'||M.MOV_TAB_IN_CODIGO||'|'||M.MOV_SEQ_IN_CODIGO||'|'||M.MOV_IN_NUMLANCTO AS ID_CONTASPAGAR,

       M.AGN_TAB_IN_CODIGO||'|'||M.AGN_PAD_IN_CODIGO||'|'||M.AGN_IN_CODIGO||'|'||M.AGN_TAU_ST_CODIGO AS ID_AGENTE,
       M.ACAO_TAB_IN_CODIGO||'|'||M.ACAO_PAD_IN_CODIGO||'|'||M.ACAO_IN_CODIGO AS ID_ACAO,
       DECODE(M.HIS_IN_REDUZIDO, NULL, NULL, M.HIS_TAB_IN_CODIGO||'|'||M.HIS_PAD_IN_CODIGO||'|'||M.HIS_IDE_ST_CODIGO||'|'||M.HIS_IN_REDUZIDO) AS ID_HISTORICO,

       M.ORG_IN_CODIGO AS COD_ORGANIZACAO,
       M.FIL_IN_CODIGO AS COD_FILIAL,
       M.TREF_ST_CODIGO AS TIPO_CPAGAR,
       M.TPD_ST_CODIGO AS TIPO_DOCUMENTO,
       M.MOV_ST_DOCUMENTO AS DOCUMENTO,
       M.MOV_DT_DATADOCTO AS DATA_DOCUMENTO,
       M.MOV_DT_DATAINC AS DATA_INCLUSAO,
       M.MOV_DT_VENCTO AS VENCIMENTO,
       M.MOV_DT_PRORROGADO AS VENCIMENTO_PRORROGADO,

       M.IND_IN_CODIGOIND AS COD_INDICE,
       M.IND_IN_CODIGOMOE AS COD_MOEDA,
       M.MOV_RE_COTACAOMOE AS COTACAO_MOEDA,
       M.USU_IN_INCLUSAO AS COD_USUARIO_INCLUSAO,

       M.MOV_IN_NUMLANCTO AS NUMLANCTO,
       M.AGN_PAD_IN_CODIGO AS PADRAO_AGENTE,
       M.AGN_IN_CODIGO AS COD_AGENTE,
       M.AGN_TAU_ST_CODIGO AS TIPO_AGENTE,
       M.MOV_BO_PREVISAO AS PREVISAO,
       M.ACAO_PAD_IN_CODIGO AS PADRAO_ACAO,
       M.ACAO_IN_CODIGO AS COD_ACAO,
       M.ACAOM_IN_SEQUENCIA AS ACAOM_IN_SEQUENCIA,
       M.BAN_IN_NUMERO AS NUMERO_BANCO,
       M.MOV_ST_PARCELA AS PARCELA,
       M.MOV_BO_APROVADOADM AS APROVADO_ADM,
       M.MOV_BO_TITRECONHECIDO AS TITULO_RECONHECIDO,
       M.MOV_BO_PAGLIBTESOUR AS PAG_LIBERADO,
       M.HIS_PAD_IN_CODIGO AS PADRAO_HISTORICO,
       M.HIS_IN_REDUZIDO AS COD_HISTORICO,
       M.FORP_IN_CODIGO AS COD_FORMA_PAGTO,
       M.PRIP_ST_CODIGO AS COD_PRIORIDADE_PAGTO,
       M.MOV_ST_HBKSTATUS AS STATUS_HBK,
       M.MOV_DT_ORCAMENTO AS DATA_ORCAMENTO,
       M.USU_IN_CODIGORECONHEC AS COD_USUARIO_RECONHECIMENO_TIT,
       M.MOV_DT_RECONHECIMENTO AS DATA_RECONHECIMENO_TITULO,
       M.USU_IN_CODIGOLIBPAGTO AS COD_USUARIO_LIBERACAO_PAGTO,
       M.MOV_DT_LIBERACAOPAGTO AS DATA_LIBERACAO_PAGTO,
       M.MOV_RE_SALDOCPACRE AS SALDO_CPA,
       M.MOV_RE_VALORMOEDA AS VALOR_MOEDA,
       P.FPA_TPD_ST_CODIGO AS TIPO_DOCUMENTO_FATURA,
       P.FPA_IN_NUMERO AS NUMERO_FATURA,
       P.CPA_RE_PERCJUROSEFET AS PERCENTUAL_JUROS,
       P.CPA_RE_VRMORAEFET AS VALOR_MORA,
       P.CPA_RE_PERCMULTAEFET AS PERCENTUAL_MULTA,
       P.CPA_RE_VRMULTAEFET AS VALOR_MULTA,
       P.CPA_RE_PERCDESCEFET AS PERCENTUAL_DESCONTO,
       P.CPA_RE_VRDESCCONDEFET AS VALOR_DESCONTO,
       P.CPA_RE_VRBASEIREFET AS BASE_IR,
       P.CPA_RE_VRIREFET AS VALOR_IR,
       P.SAP_ST_CODIGO AS SERIE_AP,
       P.CPA_IN_AP AS AP,
       P.CPA_DT_DTBASEMULTA AS DATA_BASE_MULTA,
       P.CPA_DT_DTBASEDESC AS DATA_BASE_DESCONTO,
       P.CPA_RE_PERCDESCEFET2 AS PERCENTUAL_DESCONTO2,
       P.CPA_RE_VRDESCCONDEFET2 AS VALOR_DESCONTO2,
       P.CPA_DT_DTBASEDESC2 AS DATA_BASE_DESCONTO2,
       F.FPA_ST_SOLICITANTE AS SOLICITANTE,
       F.FPA_ST_DOCTOINTERNO AS DOCUMENTO_INTERNO,
       P.CPA_RE_VRJUROSBAIXA AS VALOR_JUROS_BAIXA,
       F.FPA_RE_VALORINSS AS VALOR_INSS,
       F.FPA_RE_ALIQUOTAINSS AS PERCENTUAL_INSS
FROM CONSTRUCAO.FIN_MOVIMENTO@HACASA M

JOIN CONSTRUCAO.FIN_CONTASPAGAR@HACASA P ON
  (P.ORG_TAB_IN_CODIGO  = M.ORG_TAB_IN_CODIGO AND
   P.ORG_PAD_IN_CODIGO  = M.ORG_PAD_IN_CODIGO AND
   P.ORG_IN_CODIGO      = M.ORG_IN_CODIGO AND
   P.ORG_TAU_ST_CODIGO  = M.ORG_TAU_ST_CODIGO AND
   P.MOV_TAB_IN_CODIGO  = M.MOV_TAB_IN_CODIGO AND
   P.MOV_SEQ_IN_CODIGO  = M.MOV_SEQ_IN_CODIGO AND
   P.MOV_IN_NUMLANCTO   = M.MOV_IN_NUMLANCTO)

JOIN CONSTRUCAO.FIN_FATURAPAGAR@HACASA F ON
  (P.ORG_TAB_IN_CODIGO  = F.ORG_TAB_IN_CODIGO AND
   P.ORG_PAD_IN_CODIGO  = F.ORG_PAD_IN_CODIGO AND
   P.ORG_IN_CODIGO      = F.ORG_IN_CODIGO AND
   P.ORG_TAU_ST_CODIGO  = F.ORG_TAU_ST_CODIGO AND
   P.AGN_TAB_IN_CODIGO  = F.AGN_TAB_IN_CODIGO AND
   P.AGN_PAD_IN_CODIGO  = F.AGN_PAD_IN_CODIGO AND
   P.AGN_IN_CODIGO      = F.AGN_IN_CODIGO AND
   P.AGN_TAU_ST_CODIGO  = F.AGN_TAU_ST_CODIGO AND
   P.SER_TAB_IN_CODIGO  = F.SER_TAB_IN_CODIGO AND
   P.SER_ST_CODIGO      = F.SER_ST_CODIGO AND
   P.SER_IN_SEQUENCIA   = F.SER_IN_SEQUENCIA AND
   P.FPA_TPD_ST_CODIGO  = F.FPA_TPD_ST_CODIGO AND
   P.FPA_IN_NUMERO      = F.FPA_IN_NUMERO AND
   P.FPA_IN_CONTADOR    = F.FPA_IN_CONTADOR)

WHERE M.MOV_CH_SITUACAO    = 'N'
AND   M.MOV_CH_STATUSBXREF = 'N'
AND   M.MOV_CH_ORIGEM      = 'P'