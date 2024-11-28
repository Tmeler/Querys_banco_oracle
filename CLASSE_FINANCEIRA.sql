 SELECT CLA.CLA_TAB_IN_CODIGO||'|'||CLA.CLA_PAD_IN_CODIGO||'|'||CLA.CLA_IDE_ST_CODIGO||'|'||CLA.CLA_IN_REDUZIDO AS ID_CLASSE,
       CLA.PAI_CLA_TAB_IN_CODIGO||'|'||CLA.PAI_CLA_PAD_IN_CODIGO||'|'||CLA.PAI_CLA_IDE_ST_CODIGO||'|'||CLA.PAI_CLA_IN_REDUZIDO AS ID_CLASSE_PAI,
       CLA.CLA_IN_REDUZIDO AS COD_CLASSE,
       CLA.CLA_ST_EXTENSO AS EXTENSO_CLASSE,
       CLA.CLA_CH_ANASIN AS ANALITICA_SINTETICA,
       CLA.CLA_CH_NATUREZA AS NATUREZA_CLASSE,
       CLA.CLA_IN_NIVEL AS NIVEL_DO_EXTENSO,
       CLA.CLA_ST_APELIDO AS APELIDO,
       CLA.CLA_ST_DESCRICAO AS DESCRICAO
  FROM CONSTRUCAO.FIN_CLASSE@HACASA CLA