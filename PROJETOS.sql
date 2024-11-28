 select PCBA.PRO_IN_REDUZIDO AS COD_PROJETO,
       --PCBA.PRO_IN_SEQUENCIAL,
       --PCBA.PAD_IN_SEQUENCIAL,
       --P.PAD_ST_CODIGO,
       nvl(PCBA.PRO_ST_EXTENSO, PMEGA.PRO_ST_EXTENSO) PRO_ST_EXTENSO,
       nvl(PCBA.PRO_ST_DESCRICAO, PMEGA.PRO_ST_DESCRICAO) PRO_ST_DESCRICAO,
       nvl(PCBA.PRO_CH_TIPOCONTA, PMEGA.PRO_CH_ANASIN) PRO_CH_TIPOCONTA,
       PCBA.PRO_TAB_IN_CODIGO
       --PCBA.PRO_PAD_IN_CODIGO,
       --PCBA.PRO_IDE_ST_CODIGO       
  from CONSTRUCAO.CBA_PROJETO@HACASA PCBA,
       CONSTRUCAO.GLO_PROJETOS@HACASA PMEGA,
       CONSTRUCAO.CBA_PADRAO@HACASA P
 where PCBA.PRO_TAB_IN_CODIGO = PMEGA.PRO_TAB_IN_CODIGO (+)
   and PCBA.PRO_PAD_IN_CODIGO = PMEGA.PRO_PAD_IN_CODIGO (+)
   and PCBA.PRO_IDE_ST_CODIGO = PMEGA.PRO_IDE_ST_CODIGO (+)
   and PCBA.PRO_IN_REDUZIDO   = PMEGA.PRO_IN_REDUZIDO (+)
   and PCBA.PAD_IN_SEQUENCIAL = P.PAD_IN_SEQUENCIAL
  order by PCBA.PRO_IN_REDUZIDO