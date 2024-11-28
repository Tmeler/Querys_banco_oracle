select par.ORG_TAB_IN_CODIGO||'|'||par.ORG_PAD_IN_CODIGO||'|'||par.ORG_IN_CODIGO||'|'||par.ORG_TAU_ST_CODIGO||'|'||par.CTO_IN_CODIGO AS ID_CONTRATO,
       par.par_in_codigo,

       PAR.PAR_ST_AGENCIA,
       PAR.PAR_ST_CONTA,
       PAR.PAR_IN_RESIDUO,

       PAR.PAR_RE_VALORORIGINAL,
       PAR.PAR_RE_VALORPAGO,
       PAR.PAR_RE_VALORMULTA,
       PAR.PAR_RE_VALORATRASO,
       PAR.PAR_RE_VALORJUROS,
       PAR.PAR_RE_VALORJUROSBX,
       PAR.PAR_RE_VALORDESCONTO,
       PAR.PAR_RE_VALORRESIDUO,
       PAR.PAR_RE_VALORJUROSTP,
       PAR.PAR_RE_VALORJUROSREN,
       PAR.PAR_RE_CREDITO,
       PAR.PAR_RE_DIFTAXA,
       PAR.PAR_RE_CORRECAOVCTO,
       PAR.PAR_RE_JUROSVENCTO,
       PAR.PAR_RE_VALORBASEINV,
       PAR.PAR_RE_VALORBASETERRENEIRO,
       PAR.PAR_RE_VLRINFRA,
       PAR.PAR_RE_VALORITBI,
       PAR.PAR_RE_VALORCRI,
       PAR.PAR_RE_VLRRENEGOCIADOSEC,

       PAR.PAR_DT_VENCIMENTO,
       PAR.PAR_DT_MOVIMENTO,
       PAR.PAR_DT_BAIXA,
       PAR.PAR_DT_DEPOSITO,
       PAR.PAR_DT_REAJUSTE,
       PAR.PAR_DT_DESCONGELA,

       DECODE(PAR.PAR_DT_BAIXA,
              NULL,
              CASE
                WHEN PAR.PAR_DT_VENCIMENTO < TRUNC(SYSDATE) THEN (TRUNC(SYSDATE) - PAR.PAR_DT_VENCIMENTO)
              ELSE
                0
              END,
              PAR.PAR_DT_BAIXA - PAR.PAR_DT_VENCIMENTO -- Valor negativo significa pagamento antecipado
              ) AS DIAS_ATRASO,

       DECODE(PAR.PAR_DT_BAIXA,
              NULL,
              CASE
                WHEN PAR.PAR_DT_VENCIMENTO > TRUNC(SYSDATE) THEN (PAR.PAR_DT_VENCIMENTO - TRUNC(SYSDATE))
              ELSE
                0
              END,
              0) AS DIAS_A_VENCER,

       PAR.PAR_BO_CHEQUEDEVOLVIDO,
       PAR.PAR_BO_CONFDIVIDA,
       PAR.PAR_BO_CONSINVESTIDOR,
       PAR.PAR_BO_CONTRATUAL,
       PAR.PAR_BO_PAGOWEB,
       PAR.PAR_BO_REAJUSTADA,
       PAR.PAR_BO_SECURITIZADA,

       DECODE(UPPER(PAR.PAR_CH_AMORTIZACAO),
              'T', 'TABELA PRICE',
              'S', 'SACOC',
              'C', 'SAC',
              'OUTRO') AS PAR_CH_AMORTIZACAO,

       DECODE(UPPER(PAR.PAR_CH_ORIGEM),
              'R', 'RENEGOCIAÇÃO',
              'B', 'BAIXA PARCIAL',
              'J', 'REAJUSTE',
              'C', 'CONTRATO',
              'T', 'TABELA PRICE',
              'A', 'TERMO CONTRATUAL',
              'D', 'TERMO CONTRATUAL (NÃO ALTERA VL CONTR)',
              'X', 'APLICAÇÃO DE TAXA',
              'S', 'SAC',
              'OUTRO') AS PAR_CH_ORIGEM,

       DECODE(UPPER(PAR.PAR_CH_PARCELA),
              'I', 'INTERMEDIÁRIA',
              'C', 'CONCLUSÃO',
              'M', 'MENSAL',
              'R', 'RESÍDUO',
              'S', 'SINAL',
              'B', 'RES. COBRANÇA',
              'T', 'TAXA',
              'OUTRO') AS PAR_CH_PARCELA,

       DECODE(UPPER(PAR.PAR_CH_PROCESSO),
              'D', 'DESCONGELAMENTO',
              'A', 'ANTECIPAÇÃO',
              'R', 'REAJUSTE ANUAL',
              'P', 'ALTERAÇÃO DE PARCELA',
              'B', 'BAIXA PARCIAL',
              'S', 'RESÍDUO COBRANÇA',
              'X', 'SEM HISTÓRICO',
              'G', 'BAIXA COM VM SAC',
              'OUTRO') AS PAR_CH_PROCESSO,

       DECODE(UPPER(PAR.PAR_CH_RECEITA),
              'C', 'CARTEIRA',
              'F', 'FINANCIAMENTO',
              'G', 'FGTS',
              'B', 'BENS',
              'K', 'C.CRÉDITO',
              'P', 'PERMUTA',
              'S', 'SUBSIDIO',
              'I', 'FINANC. DIRETO',
              'OUTRO') AS PAR_CH_RECEITA,

       DECODE(UPPER(PAR.PAR_CH_RECEITABAIXA),
              'C', 'CHEQUE',
              'D', 'DINHEIRO',
              'E', 'BENS',
              'P', 'DEPÓSITO',
              'K', 'CARTA DE CRÉDITO',
              'T', 'PERMUTA',
              'B', 'BLOQUETO BANCÁRIO',
              'H', 'TED',
              'O', 'DOC',
              'A', 'BOLETO AVULSO',
              'R', 'REPASSE',
              'S', 'SECURITIZAÇÃO',
              'OUTRO') AS PAR_CH_RECEITABAIXA,

       DECODE(UPPER(PAR.PAR_CH_STATUS),
              'A', 'ATIVO',
              'I', 'INATIVO',
              'P', 'CH. PRÉ-DATADO',
              '1', 'CH. DEVOLVIDO',
              '2', 'CH. DEVOLVIDO 2X',
              'C', 'CH. NORMAL',
              'D', 'CH. DEPOSITADO',
              'U', 'CH. EM CUSTÓDIA',
              'OUTRO') AS PAR_CH_STATUS,

       CASE
         WHEN TO_CHAR(PAR.PAR_DT_VENCIMENTO, 'YYYYMM') < TO_CHAR(CTO.CTO_DT_ENTREGA_REAL, 'YYYYMM') THEN 'PRÉ CHAVES'
         WHEN TO_CHAR(PAR.PAR_DT_VENCIMENTO, 'YYYYMM') = TO_CHAR(ADD_MONTHS(CTO.CTO_DT_ENTREGA_REAL, 2), 'YYYYMM') THEN 'REPASSE'
         WHEN TO_CHAR(PAR.PAR_DT_VENCIMENTO, 'YYYYMM') > TO_CHAR(CTO.CTO_DT_ENTREGA_REAL, 'YYYYMM') THEN 'PÓS CHAVES'
       ELSE
         'CHAVES'
       END AS TIPO_PARCELA,

       DECODE(par.par_dt_baixa,
              NULL,
              'NÃO',
              'SIM') AS PARC_BAIXADA,

       DECODE(par.par_dt_baixa,
              NULL,
              0,
              par.PAR_RE_VALORPAGO +
              par.PAR_RE_VALORMULTA +
              par.PAR_RE_VALORJUROS +
              par.PAR_RE_VALORATRASO +
              par.PAR_RE_VALORCORRECAO -
              par.PAR_RE_VALORDESCONTO) as par_re_valorliquido,

       DECODE(par.par_dt_baixa,
              NULL,
              CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_VALORCORRECAO@HACASA(par.ORG_TAB_IN_CODIGO,
                                                         par.ORG_PAD_IN_CODIGO,
                                                         par.ORG_IN_CODIGO,
                                                         par.ORG_TAU_ST_CODIGO,
                                                         par.CTO_IN_CODIGO,
                                                         PAR.PAR_IN_CODIGO,
                                                         trunc(sysdate),
                                                         'RP',
                                                         'M',
                                                         -1) + PAR.PAR_RE_VALORCORRECAO,
              PAR.PAR_RE_VALORCORRECAO + PAR.PAR_RE_VALORCORRECAOBX + PAR.PAR_RE_VALORCORRECAO_ATR) AS "ValorCorrecao",

       DECODE(par.par_dt_baixa,
              NULL,
              CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_CORRIGE@HACASA(par.ORG_TAB_IN_CODIGO,
                                                   par.ORG_PAD_IN_CODIGO,
                                                   par.ORG_IN_CODIGO,
                                                   par.ORG_TAU_ST_CODIGO,
                                                   par.CTO_IN_CODIGO,
                                                   PAR.PAR_IN_CODIGO,
                                                   trunc(sysdate),
                                                   'R',
                                                   'A',
                                                   -1), 0) as "ValorSemEncargos",

      DECODE(par.par_dt_baixa,
             NULL,
             CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_CORRIGE@HACASA(par.ORG_TAB_IN_CODIGO,
                                                  par.ORG_PAD_IN_CODIGO,
                                                  par.ORG_IN_CODIGO,
                                                  par.ORG_TAU_ST_CODIGO,
                                                  par.CTO_IN_CODIGO,
                                                  par.PAR_IN_CODIGO,
                                                  trunc(sysdate),
                                                  'R',
                                                  'A',
                                                  -1) +
             (ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_CALCULAENCARGOS@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                 par.ORG_PAD_IN_CODIGO,
                                                                 par.ORG_IN_CODIGO,
                                                                 par.ORG_TAU_ST_CODIGO,
                                                                 par.CTO_IN_CODIGO,
                                                                 par.PAR_IN_CODIGO,
                                                                 trunc(sysdate),
                                                                 NVL(PAR_RE_VALORORIGINAL, 0) +
                                                                 NVL(PAR_RE_VALORJUROS, 0) +
                                                                 NVL(PAR_RE_VALORCORRECAO, 0) +
                                                                 ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_VALORCORRECAO@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                                                                  par.ORG_PAD_IN_CODIGO,
                                                                                                                  par.ORG_IN_CODIGO,
                                                                                                                  par.ORG_TAU_ST_CODIGO,
                                                                                                                  par.CTO_IN_CODIGO,
                                                                                                                  par.PAR_IN_CODIGO,
                                                                                                                  trunc(sysdate),
                                                                                                                  'RP',
                                                                                                                  'M',
                                                                                                                  -1), 2) +
                                                                 ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_VALORJUROS@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                                                               par.ORG_PAD_IN_CODIGO,
                                                                                                               par.ORG_IN_CODIGO,
                                                                                                               par.ORG_TAU_ST_CODIGO,
                                                                                                               par.CTO_IN_CODIGO,
                                                                                                               par.PAR_IN_CODIGO,
                                                                                                               trunc(sysdate),
                                                                                                               'RP',
                                                                                                               'M',
                                                                                                               -1), 2),
                                                                 'M',
                                                                 NVL('S', 'N'),
                                                                 NVL(0, 0),
                                                                 NVL(1, 1)), 2) +
              ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_CALCULAENCARGOS@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                 par.ORG_PAD_IN_CODIGO,
                                                                 par.ORG_IN_CODIGO,
                                                                 par.ORG_TAU_ST_CODIGO,
                                                                 par.CTO_IN_CODIGO,
                                                                 par.PAR_IN_CODIGO,
                                                                 trunc(sysdate),
                                                                 NVL(PAR_RE_VALORORIGINAL, 0) +
                                                                 NVL(PAR_RE_VALORJUROS, 0) +
                                                                 NVL(PAR_RE_VALORCORRECAO, 0) +
                                                                 ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_VALORCORRECAO@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                                                                  par.ORG_PAD_IN_CODIGO,
                                                                                                                  par.ORG_IN_CODIGO,
                                                                                                                  par.ORG_TAU_ST_CODIGO,
                                                                                                                  par.CTO_IN_CODIGO,
                                                                                                                  par.PAR_IN_CODIGO,
                                                                                                                  trunc(sysdate),
                                                                                                                  'RP',
                                                                                                                  'M',
                                                                                                                  -1), 2) +
                                                                 ROUND(CONSTRUCAO.PCK_CAR_FNC.FNC_CAR_VALORJUROS@HACASA(par.ORG_TAB_IN_CODIGO,
                                                                                                               par.ORG_PAD_IN_CODIGO,
                                                                                                               par.ORG_IN_CODIGO,
                                                                                                               par.ORG_TAU_ST_CODIGO,
                                                                                                               par.CTO_IN_CODIGO,
                                                                                                               par.PAR_IN_CODIGO,
                                                                                                               trunc(sysdate),
                                                                                                               'RP',
                                                                                                               'M',
                                                                                                               -1), 2),
                                                                 'A',
                                                                 NVL('S', 'N'),
                                                                 NVL(0, 0),
                                                                 NVL(1, 1)), 2)), 0) as "ValorComEncargos"

  from CONSTRUCAO.car_parcela@HACASA par
join CONSTRUCAO.car_contrato@HACASA cto on
  (cto.org_tab_in_codigo = par.org_tab_in_codigo AND
   cto.org_pad_in_codigo = par.org_pad_in_codigo AND
   cto.org_in_codigo     = par.org_in_codigo AND
   cto.org_tau_st_codigo = par.org_tau_st_codigo AND
   cto.cto_in_codigo     = par.cto_in_codigo)