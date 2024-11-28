  select S.PLA_TAB_IN_CODIGO,
       S.PLA_PAD_IN_CODIGO,
       S.PLA_IDE_ST_CODIGO,
       S.PLA_IN_REDUZIDO,
       S.CUS_TAB_IN_CODIGO,
       S.CUS_PAD_IN_CODIGO,
       S.CUS_IDE_ST_CODIGO,
       S.CUS_IN_REDUZIDO,
       S.PRO_TAB_IN_CODIGO,
       S.PRO_PAD_IN_CODIGO,
       S.PRO_IDE_ST_CODIGO,
       S.PRO_IN_REDUZIDO,
       S.AGN_TAB_IN_CODIGO,
       S.AGN_PAD_IN_CODIGO,
       S.AGN_IN_CODIGO,
       SA.CRI_IN_CODIGO,
       SA.SLD_DT_DIA,
       SA.SLD_CH_TIPO,
       PC.PLA_ST_EXTENSO,
       PC.PLA_CH_TIPO_CONTA,
       PC.PLA_ST_APELIDO,
       PC.PLA_ST_DESCRICAO,
       C.CUS_ST_EXTENSO,
       C.CUS_ST_APELIDO,
       C.CUS_CH_TIPO_CONTA,
       C.CUS_ST_DESCRICAO,
       PR.PRO_ST_EXTENSO,
       PR.PRO_ST_APELIDO,
       PR.PRO_ST_DESCRICAO,
       PR.PRO_CH_ANASIN,
       A.AGN_ST_NOME,
       A.AGN_ST_FANTASIA,
       S.SLD_RE_VLDEVEDOR,
       S.SLD_RE_VLCREDOR,
       SA.ORG_TAB_IN_CODIGO,
       SA.ORG_PAD_IN_CODIGO,
       SA.ORG_IN_CODIGO,
       SA.ORG_TAU_ST_CODIGO,
       PC.PLA_CH_CENTROCUSTO,
       PC.PLA_CH_PROJETO,
       PC.PLA_CH_FILIAL,
       SA.SLD_CH_TIPOCONTAB,
       PC.PLA_BO_DIFSOCFIS,
       SA.SLD_BO_VINCULOLAN
  from CONSTRUCAO.CON_SALDOSAGENTE@HACASA S
  inner join (select SA.*
                from CONSTRUCAO.CON_SALDOAUXILIARAGENTE@HACASA SA
               where SA.SLD_CH_TIPO in ('D', 'R', 'T')
               union all
              select SA.*
                from CONSTRUCAO.CON_SALDOAUXILIARAGENTE@HACASA SA
               inner join CONSTRUCAO.GLO_DEFINICAO@HACASA D
                       on D.ORG_TAB_IN_CODIGO = SA.ORG_TAB_IN_CODIGO
                      and D.ORG_PAD_IN_CODIGO = SA.ORG_PAD_IN_CODIGO
                      and D.FIL_IN_CODIGO     = SA.ORG_IN_CODIGO
                      and D.ORG_TAU_ST_CODIGO = SA.ORG_TAU_ST_CODIGO
                      and D.DEF_DT_INICIO     = SA.SLD_DT_DIA
               where SA.SLD_CH_TIPO = 'A'
                 and D.TAB_IN_CODIGO = 1) SA
          on S.SAAGN_IN_NUMERO = SA.SAAGN_IN_NUMERO
  inner join CONSTRUCAO.CON_PLANO_CONTA@HACASA PC
          on S.PLA_TAB_IN_CODIGO = PC.PLA_TAB_IN_CODIGO
         and S.PLA_PAD_IN_CODIGO = PC.PLA_PAD_IN_CODIGO
         and S.PLA_IDE_ST_CODIGO = PC.PLA_IDE_ST_CODIGO
         and S.PLA_IN_REDUZIDO   = PC.PLA_IN_REDUZIDO
  inner join CONSTRUCAO.CON_CENTRO_CUSTO@HACASA C
          on S.CUS_TAB_IN_CODIGO = C.CUS_TAB_IN_CODIGO
         and S.CUS_PAD_IN_CODIGO = C.CUS_PAD_IN_CODIGO
         and S.CUS_IDE_ST_CODIGO = C.CUS_IDE_ST_CODIGO
         and S.CUS_IN_REDUZIDO   = C.CUS_IN_REDUZIDO
  inner join CONSTRUCAO.GLO_PROJETOS@HACASA PR
          on S.PRO_TAB_IN_CODIGO = PR.PRO_TAB_IN_CODIGO
         and S.PRO_PAD_IN_CODIGO = PR.PRO_PAD_IN_CODIGO
         and S.PRO_IDE_ST_CODIGO = PR.PRO_IDE_ST_CODIGO
         and S.PRO_IN_REDUZIDO   = PR.PRO_IN_REDUZIDO
   left join CONSTRUCAO.GLO_AGENTES@HACASA A
          on S.AGN_TAB_IN_CODIGO = A.AGN_TAB_IN_CODIGO
         and S.AGN_PAD_IN_CODIGO = A.AGN_PAD_IN_CODIGO
         and S.AGN_IN_CODIGO     = A.AGN_IN_CODIGO