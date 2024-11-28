  SELECT 
VAL.CLA_IDE_ST_CODIGO,
VAL.CLA_IN_REDUZIDO,
VAL.CLA_PAD_IN_CODIGO,
VAL.CLA_TAB_IN_CODIGO,
VAL.LCC_IN_NUMERO,
VAL.LCL_CH_NATUREZA,
VAL.LPR_CH_STATUSBXREF,
VAL.LPR_IN_NUMERO,
VAL.LPR_RE_PERCENTUAL,
VAL.LPR_RE_VALOR,
VAL.LPR_RE_VALORCRE,
VAL.LPR_RE_VALORCREMOE,
VAL.LPR_RE_VALORDEB,
VAL.LPR_RE_VALORDEBMOE,
VAL.LPR_RE_VALORMOE,
VAL.LPR_ST_DOCINTERNO,
VAL.LPR_ST_OBSERVACAO,
VAL.MOV_IN_NUMLANCTO,
VAL.MOV_SEQ_IN_CODIGO,
VAL.MOV_TAB_IN_CODIGO,
VAL.ORG_IN_CODIGO,
VAL.ORG_PAD_IN_CODIGO,
VAL.ORG_TAB_IN_CODIGO,
VAL.ORG_TAU_ST_CODIGO,
VAL.PRO_IDE_ST_CODIGO,
VAL.PRO_IN_REDUZIDO,
VAL.PRO_PAD_IN_CODIGO,
VAL.PRO_TAB_IN_CODIGO
FROM CONSTRUCAO.FIN_LANCPROJ@HACASA VAL,
     CONSTRUCAO.MLOG$_GLO_PROJETOS@HACASA GER
WHERE   
VAL.PRO_IDE_ST_CODIGO = GER.PRO_IDE_ST_CODIGO AND 
VAL.PRO_IN_REDUZIDO = GER.PRO_IN_REDUZIDO AND 
VAL.PRO_PAD_IN_CODIGO = GER.PRO_PAD_IN_CODIGO AND
VAL.PRO_TAB_IN_CODIGO = GER.PRO_TAB_IN_CODIGO