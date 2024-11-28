 SELECT O2.PAI_ORG_IN_CODIGO ORG_IN_CODIGO,
       O.ORG_ST_FANTASIA,
       B.ORG_IN_CODIGO FIL_IN_CODIGO,
       O2.ORG_ST_FANTASIA FIL_ST_FANTASIA,
       PC.PLA_TAB_IN_CODIGO,
       PC.PLA_PAD_IN_CODIGO,
       PC.PLA_IDE_ST_CODIGO,
       PC.PLA_IN_REDUZIDO,
       PC.PLA_ST_EXTENSO,
       PC.PLA_ST_DESCRICAO,
       PC.PLA_ST_EXTENSO || ' - ' || PC.PLA_ST_DESCRICAO CONTA,
       decode(PC.PLA_CH_TIPO_CONTA, 'A', 'Analítica', 'Sintética') TIPO_CONTA,
       CC.CUS_TAB_IN_CODIGO,
       CC.CUS_PAD_IN_CODIGO,
       CC.CUS_IDE_ST_CODIGO,
       CC.CUS_IN_REDUZIDO,
       CC.CUS_ST_EXTENSO,
       CC.CUS_ST_DESCRICAO,
       CC.CUS_ST_EXTENSO || ' - ' || CC.CUS_ST_DESCRICAO CCUSTO,
       decode(CC.CUS_CH_TIPO_CONTA, 'A', 'Analítico', 'Sintético') TIPO_CCUSTO,
       PR.PRO_TAB_IN_CODIGO,
       PR.PRO_PAD_IN_CODIGO,
       PR.PRO_IDE_ST_CODIGO,
       PR.PRO_IN_REDUZIDO,
       PR.PRO_ST_EXTENSO,
       PR.PRO_ST_DESCRICAO,
       PR.PRO_ST_EXTENSO || ' - ' || PR.PRO_ST_DESCRICAO PROJETO,
       decode(PR.PRO_CH_ANASIN, 'A', 'Analítico', 'Sintético') TIPO_PROJETO,
       B.BAL_RE_VAL1 SLD_RE_SALDOANTERIOR,
       B.BAL_RE_VAL2 SLD_RE_DEBITO,
       B.BAL_RE_VAL3 SLD_RE_CREDITO,
       B.BAL_RE_VAL1 + B.BAL_RE_VAL2 - B.BAL_RE_VAL3 SLD_RE_SALDOATUAL,
       B.COMP_ST_NOME,
       B.BAL_IN_CHAVE,
       O2.ORG_RE_PARTCONTGER,
       AGN.AGN_IN_CODIGO, --PCONT-2161
       AGN.AGN_ST_FANTASIA, --PCONT-2161
       AGN.AGN_ST_NOME --PCONT-2161
  FROM CONSTRUCAO.CON_BALANCETE@HACASA B,
       CONSTRUCAO.GLO_VW_ORGANIZACAO@HACASA O,
       CONSTRUCAO.GLO_VW_ORGANIZACAO@HACASA O2,
       CONSTRUCAO.CON_PLANO_CONTA@HACASA PC,
       CONSTRUCAO.CON_CENTRO_CUSTO@HACASA CC,
       CONSTRUCAO.GLO_PROJETOS@HACASA PR,
       CONSTRUCAO.GLO_AGENTES@HACASA AGN --PCONT-2161
 WHERE B.ORG_TAB_IN_CODIGO      = O2.ORG_TAB_IN_CODIGO (+)
   AND B.ORG_PAD_IN_CODIGO      = O2.ORG_PAD_IN_CODIGO (+)
   AND B.ORG_IN_CODIGO          = O2.ORG_IN_CODIGO (+)
   AND B.ORG_TAU_ST_CODIGO      = O2.ORG_TAU_ST_CODIGO (+)
   AND O2.PAI_ORG_TAB_IN_CODIGO = O.ORG_TAB_IN_CODIGO (+)
   AND O2.PAI_ORG_PAD_IN_CODIGO = O.ORG_PAD_IN_CODIGO (+)
   AND O2.PAI_ORG_IN_CODIGO     = O.ORG_IN_CODIGO (+)
   AND B.PLA_TAB_IN_CODIGO      = PC.PLA_TAB_IN_CODIGO (+)
   AND B.PLA_PAD_IN_CODIGO      = PC.PLA_PAD_IN_CODIGO (+)
   AND B.PLA_IDE_ST_CODIGO      = PC.PLA_IDE_ST_CODIGO (+)
   And B.PLA_IN_REDUZIDO        = PC.PLA_IN_REDUZIDO   (+)
   AND B.CUS_TAB_IN_CODIGO      = CC.CUS_TAB_IN_CODIGO (+)
   AND B.CUS_PAD_IN_CODIGO      = CC.CUS_PAD_IN_CODIGO (+)
   AND B.CUS_IDE_ST_CODIGO      = CC.CUS_IDE_ST_CODIGO (+)
   AND B.CUS_IN_REDUZIDO        = CC.CUS_IN_REDUZIDO   (+)
   AND B.PRO_TAB_IN_CODIGO      = PR.PRO_TAB_IN_CODIGO (+)
   AND B.PRO_PAD_IN_CODIGO      = PR.PRO_PAD_IN_CODIGO (+)
   AND B.PRO_IDE_ST_CODIGO      = PR.PRO_IDE_ST_CODIGO (+)
   AND B.PRO_IN_REDUZIDO        = PR.PRO_IN_REDUZIDO   (+)      
   AND B.AGN_TAB_IN_CODIGO      = AGN.AGN_TAB_IN_CODIGO (+) --PCONT-2161
   AND B.AGN_PAD_IN_CODIGO      = AGN.AGN_PAD_IN_CODIGO (+) --PCONT-2161
   AND B.AGN_IN_CODIGO          = AGN.AGN_IN_CODIGO (+) --PCONT-2161
   AND B.BAL_CH_TIPO            in ('DF', 'DP', 'DC', 'DR', 'DA') --PCONT-2161
   AND ((PC.PLA_TAB_IN_CODIGO = 1) or
         ((PC.PLA_TAB_IN_CODIGO = 6) and
          (PC.PLA_CH_TIPO_DEMO  = 'N'))) -- CAP 01/12/2014 PADM-417 - não listar os registros de resultado no Painel Contábil
 --order by B.BAL_ST_ORDEM