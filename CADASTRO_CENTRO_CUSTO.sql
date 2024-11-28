SELECT CUS.CUS_TAB_IN_CODIGO||'|'||CUS.CUS_PAD_IN_CODIGO||'|'||CUS.CUS_IDE_ST_CODIGO||'|'||CUS.CUS_IN_REDUZIDO AS ID_CCUSTO,
       CUS.PAI_CUS_TAB_IN_CODIGO||'|'||CUS.PAI_CUS_PAD_IN_CODIGO||'|'||CUS.PAI_CUS_IDE_ST_CODIGO||'|'||CUS.PAI_CUS_IN_REDUZIDO AS ID_CCUSTO_PAI,
       CUS.CUS_IN_REDUZIDO AS COD_CCUSTO,
       CUS.CUS_ST_EXTENSO AS EXTENSO_CCUSTO,
       CUS.CUS_CH_TIPO_CONTA AS ANALITICO_SINTETICO,
       CUS.CUS_IN_NIVEL AS NIVEL_DO_EXTENSO,
       CUS.CUS_ST_APELIDO AS APELIDO,
       CUS.CUS_ST_DESCRICAO AS DESCRICAO
  FROM CONSTRUCAO.CON_CENTRO_CUSTO@HACASA CUS