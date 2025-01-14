  SELECT --M.ORG_TAB_IN_CODIGO,   M.ORG_PAD_IN_CODIGO,    M.ORG_IN_CODIGO,     M.ORG_TAU_ST_CODIGO,
       M.CTO_IN_CODIGO,       M.MED_IN_CODIGO AS CÓD_MEDIÇÃO,        M.MED_DT_REFERENCIA, M.MED_CH_SITUACAO,
       M.MED_ST_OBSERVACAO,   M.MED_IN_NROFORMULARIO AS NOTA_FISCAL,
       M.MED_DT_PAGAMENTO,
       C.FIL_IN_CODIGO,      
       --C.EST_IN_CODIGO,       
       E.EST_ST_NOME,
       --C.TES_IN_CODIGO,       T.TES_ST_NOME,
       -- O.AGN_TAB_IN_CODIGO,   O.AGN_PAD_IN_CODIGO,    
       O.AGN_IN_CODIGO AS AGENTE,     O.AGN_TAU_ST_CODIGO, AG.AGN_ST_NOME,
       --G.CAT_ST_EXTENSO,      G.CAT_ST_APELIDO,       G.CAT_ST_NOME,
       C.CTO_CH_TIPOOBRA,
	   C.PRO_IN_REDUZIDO AS PROJETO,
       C.CUS_IN_REDUZIDO AS CENTRO_CUSTO,
       NVL(MI.MED_RE_VALOR,         0) MED_RE_VALOR,
       NVL(A.ADT_RE_VALOR,          0) ADT_RE_VALOR,
       NVL(DI.DESIT_RE_VALOR,       0) DESIT_RE_VALOR,
       NVL(RI.RETIT_RE_VALOR,       0) RETIT_RE_VALOR,
       NVL(RISS.RETIT_RE_VALOR,     0) RETIT_RE_BASERET,     -- Valor de ISS
       NVL(RINSS.RETIT_RE_VALOR,    0) RETIT_RE_VALORINSS,    -- Valor de INSS
       NVL(RIRRF.RETIT_RE_VALOR,    0) RETIT_RE_VALORIRRF,    -- Valor de IRRF
       NVL(RCAUCAO.RETIT_RE_VALOR,  0) RETIT_RE_VALORCAUCAO,  -- Valor de Caucao
       NVL(RSEMIxSS.RETIT_RE_VALOR, 0) RETIT_RE_VALORSEMIxSS, -- valor de TODAS as retenções <> 1,2,3,4 (fixas)
       NVL(DB.DES_RE_TOTAL,         0) DESB_RE_TOTAL,  -- VALOR DOS DESCONTOS DEDUZIDOS DA BASE DE CALCULO
       NVL(VM.MED_RE_VALORMAT,      0) MED_RE_VALORMAT -- VALOR DE MATERIAL DA MEDIÇÃO
     , NVL(RET1.RETIT_RE_VALOR,0)      VLR_RET_INSS
     , NVL(RET2.RETIT_RE_VALOR,0)      VLR_RET_IRRF
     , NVL(RET3.RETIT_RE_VALOR,0)      VLR_RET_ISS
     , NVL(RET4.RETIT_RE_VALOR,0)      VLR_RET_COFINS
     , NVL(RET5.RETIT_RE_VALOR,0)      VLR_RET_PIS
     , NVL(RET6.RETIT_RE_VALOR,0)      VLR_RET_CSLL
     , NVL(RET7.RETIT_RE_VALOR,0)      VLR_RET_CAUCAO

FROM   CONSTRUCAO.EMP_MEDICAO@hacasa        M,
       CONSTRUCAO.EMP_CONTRATO@HACASA       C,
       CONSTRUCAO.DBM_ESTRUTURA@HACASA      E,
       CONSTRUCAO.GLO_AGENTES_ID@HACASA     O,
       CONSTRUCAO.GLO_AGENTES@HACASA        AG,
       CONSTRUCAO.GLO_CATEGORIA@HACASA      G,
       CONSTRUCAO.DBM_TERC_ESTRUTURA@HACASA T,
      (SELECT ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
              CTO_IN_CODIGO,     MED_IN_CODIGO,     SUM(MEDIT_RE_VALOR) MED_RE_VALOR
       FROM   CONSTRUCAO.EMP_MEDICAO_ITEM@HACASA
       GROUP BY ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
                CTO_IN_CODIGO,     MED_IN_CODIGO
      ) MI,
      (SELECT ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
              CTO_IN_CODIGO,     MED_IN_CODIGO,     SUM(ADTIT_RE_VALOR) ADT_RE_VALOR
       FROM   CONSTRUCAO.EMP_ADIANTAMENTO_ITEM@HACASA
       WHERE  ADTIT_BO_DESCONTAR = 'S'
       GROUP BY ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
                CTO_IN_CODIGO,     MED_IN_CODIGO
      ) A,
      (SELECT ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
              CTO_IN_CODIGO,     MED_IN_CODIGO,     SUM(DESIT_RE_VALOR) DESIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_DESCONTO_ITEM@HACASA
       WHERE  DESIT_BO_DESCONTAR = 'S'
       GROUP BY ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
                CTO_IN_CODIGO,     MED_IN_CODIGO
      ) DI,
      (SELECT ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
              CTO_IN_CODIGO,     MED_IN_CODIGO,     SUM(RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA
       WHERE  RETIT_BO_DESCONTAR = 'S'
       GROUP BY ORG_TAB_IN_CODIGO, ORG_PAD_IN_CODIGO, ORG_IN_CODIGO, ORG_TAU_ST_CODIGO,
                CTO_IN_CODIGO,     MED_IN_CODIGO
      ) RI,
      (SELECT RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
              RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO,     SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA RI, CONSTRUCAO.EMP_RETENCAO@HACASA R
       WHERE  RI.ORG_TAB_IN_CODIGO  = R.ORG_TAB_IN_CODIGO
       AND    RI.ORG_PAD_IN_CODIGO  = R.ORG_PAD_IN_CODIGO
       AND    RI.ORG_IN_CODIGO      = R.ORG_IN_CODIGO
       AND    RI.ORG_TAU_ST_CODIGO  = R.ORG_TAU_ST_CODIGO
       AND    RI.CTO_IN_CODIGO      = R.CTO_IN_CODIGO
       AND    RI.RET_IN_CODIGO      = R.RET_IN_CODIGO
       AND    RI.RETIT_BO_DESCONTAR = 'S'
       GROUP BY RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
                RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO
	    ) RISS,
      (SELECT RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
              RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO,     SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA RI, CONSTRUCAO.EMP_RETENCAO@HACASA R
       WHERE  RI.ORG_TAB_IN_CODIGO  = R.ORG_TAB_IN_CODIGO
       AND    RI.ORG_PAD_IN_CODIGO  = R.ORG_PAD_IN_CODIGO
       AND    RI.ORG_IN_CODIGO      = R.ORG_IN_CODIGO
       AND    RI.ORG_TAU_ST_CODIGO  = R.ORG_TAU_ST_CODIGO
       AND    RI.CTO_IN_CODIGO      = R.CTO_IN_CODIGO
       AND    RI.RET_IN_CODIGO      = R.RET_IN_CODIGO
       AND    R.TDOC_IN_CODIGO      = 2 -- INSS
       AND    RI.RETIT_BO_DESCONTAR = 'S'
       GROUP BY RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
                RI.CTO_IN_CODIGO,        RI.MED_IN_CODIGO
      )RINSS,
      (SELECT RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
              RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO,     SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA RI, CONSTRUCAO.EMP_RETENCAO@HACASA R
       WHERE  RI.ORG_TAB_IN_CODIGO  = R.ORG_TAB_IN_CODIGO
       AND    RI.ORG_PAD_IN_CODIGO  = R.ORG_PAD_IN_CODIGO
       AND    RI.ORG_IN_CODIGO      = R.ORG_IN_CODIGO
       AND    RI.ORG_TAU_ST_CODIGO  = R.ORG_TAU_ST_CODIGO
       AND    RI.CTO_IN_CODIGO      = R.CTO_IN_CODIGO
       AND    RI.RET_IN_CODIGO      = R.RET_IN_CODIGO
       AND    R.TDOC_IN_CODIGO      = 4 -- CAUCAO
       AND    RI.RETIT_BO_DESCONTAR = 'S'
       GROUP BY RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
                RI.CTO_IN_CODIGO,        RI.MED_IN_CODIGO
      )RCAUCAO,
      (SELECT RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
              RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO,     SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA RI, CONSTRUCAO.EMP_RETENCAO@HACASA R
       WHERE  RI.ORG_TAB_IN_CODIGO  = R.ORG_TAB_IN_CODIGO
       AND    RI.ORG_PAD_IN_CODIGO  = R.ORG_PAD_IN_CODIGO
       AND    RI.ORG_IN_CODIGO      = R.ORG_IN_CODIGO
       AND    RI.ORG_TAU_ST_CODIGO  = R.ORG_TAU_ST_CODIGO
       AND    RI.CTO_IN_CODIGO      = R.CTO_IN_CODIGO
       AND    RI.RET_IN_CODIGO      = R.RET_IN_CODIGO
       AND    R.TDOC_IN_CODIGO      = 3 -- IRRF
       AND    RI.RETIT_BO_DESCONTAR = 'S'
       GROUP BY RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
                RI.CTO_IN_CODIGO,        RI.MED_IN_CODIGO
      )RIRRF,
      (SELECT RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
              RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO,     SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR
       FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA RI, CONSTRUCAO.EMP_RETENCAO@HACASA R
       WHERE  RI.ORG_TAB_IN_CODIGO = R.ORG_TAB_IN_CODIGO
       AND    RI.ORG_PAD_IN_CODIGO = R.ORG_PAD_IN_CODIGO
       AND    RI.ORG_IN_CODIGO     = R.ORG_IN_CODIGO
       AND    RI.ORG_TAU_ST_CODIGO = R.ORG_TAU_ST_CODIGO
       AND    RI.CTO_IN_CODIGO     = R.CTO_IN_CODIGO
       AND    RI.RET_IN_CODIGO     = R.RET_IN_CODIGO
       AND    R.TDOC_IN_CODIGO     NOT IN (1,2,3,4)
       GROUP BY RI.ORG_TAB_IN_CODIGO, RI.ORG_PAD_IN_CODIGO, RI.ORG_IN_CODIGO, RI.ORG_TAU_ST_CODIGO,
                RI.CTO_IN_CODIGO,     RI.MED_IN_CODIGO
      ) RSEMIxSS,
       (SELECT D.ORG_TAB_IN_CODIGO, D.ORG_PAD_IN_CODIGO, D.ORG_IN_CODIGO,   D.ORG_TAU_ST_CODIGO,
               DI.MED_IN_CODIGO,    D.CTO_IN_CODIGO,     M.MED_CH_SITUACAO,
               SUM(DI.DESIT_RE_VALOR) DES_RE_TOTAL
       FROM    CONSTRUCAO.EMP_DESCONTO@HACASA      D,
               CONSTRUCAO.EMP_DESCONTO_ITEM@HACASA DI,
               CONSTRUCAO.EMP_MEDICAO@HACASA       M
       WHERE   D.ORG_PAD_IN_CODIGO     = DI.ORG_PAD_IN_CODIGO
       AND     D.ORG_IN_CODIGO         = DI.ORG_IN_CODIGO
       AND     D.ORG_TAU_ST_CODIGO     = DI.ORG_TAU_ST_CODIGO
       AND     D.CTO_IN_CODIGO         = DI.CTO_IN_CODIGO
       AND     D.DES_IN_CODIGO         = DI.DES_IN_CODIGO
       AND     DI.DESIT_BO_DESCONTAR   = 'S'
       AND     DI.DESIT_BO_DEDUZ_BRUTO = 'S'
       AND     M.ORG_TAB_IN_CODIGO     = DI.ORG_TAB_IN_CODIGO
       AND     M.ORG_PAD_IN_CODIGO     = DI.ORG_PAD_IN_CODIGO
       AND     M.ORG_IN_CODIGO         = DI.ORG_IN_CODIGO
       AND     M.ORG_TAU_ST_CODIGO     = DI.ORG_TAU_ST_CODIGO
       AND     M.CTO_IN_CODIGO         = DI.CTO_IN_CODIGO
       AND     M.MED_IN_CODIGO         = DI.MED_IN_CODIGO
       AND     M.MED_CH_SITUACAO       <> 'I'
       GROUP BY D.ORG_TAB_IN_CODIGO, D.ORG_PAD_IN_CODIGO, D.ORG_IN_CODIGO, D.ORG_TAU_ST_CODIGO,
                DI.MED_IN_CODIGO,    D.CTO_IN_CODIGO,     M.MED_CH_SITUACAO
       ) DB,
       (SELECT MI.ORG_TAB_IN_CODIGO, MI.ORG_PAD_IN_CODIGO, MI.ORG_IN_CODIGO, MI.ORG_TAU_ST_CODIGO,
               MI.MED_IN_CODIGO,     MI.CTO_IN_CODIGO,     M.MED_CH_SITUACAO,
               SUM(MI.MEDIT_RE_VALOR * MI.MEDIT_RE_PERCMATERIAL / 100) MED_RE_VALORMAT
       FROM    CONSTRUCAO.EMP_MEDICAO_ITEM@HACASA MI, CONSTRUCAO.EMP_MEDICAO@HACASA M
       WHERE   MI.ORG_TAB_IN_CODIGO = M.ORG_TAB_IN_CODIGO
       AND     MI.ORG_PAD_IN_CODIGO = M.ORG_PAD_IN_CODIGO
       AND     MI.ORG_IN_CODIGO     = M.ORG_IN_CODIGO
       AND     MI.ORG_TAU_ST_CODIGO = M.ORG_TAU_ST_CODIGO
       AND     MI.CTO_IN_CODIGO     = M.CTO_IN_CODIGO
       AND     MI.MED_IN_CODIGO     = M.MED_IN_CODIGO
       AND     M.MED_CH_SITUACAO <> 'I' -- NÃO-INICIAL
       GROUP BY MI.ORG_TAB_IN_CODIGO, MI.ORG_PAD_IN_CODIGO, MI.ORG_IN_CODIGO, MI.ORG_TAU_ST_CODIGO,
                MI.MED_IN_CODIGO,     MI.CTO_IN_CODIGO,     M.MED_CH_SITUACAO
       ) VM,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'INSSRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET1,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'IRRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET2,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'ISSRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET3,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'COFINSRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET4,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'PISRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET5,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'CSLLRET')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET6,
       (SELECT RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               SUM(RI.RETIT_RE_VALOR) RETIT_RE_VALOR,
               G.TREF_ST_CODIGO
        FROM   CONSTRUCAO.EMP_RETENCAO_ITEM@HACASA  RI,
               CONSTRUCAO.EMP_RETENCAO@HACASA       R,
               CONSTRUCAO.EMP_DOCUMENTO_TIPO@HACASA T,
               CONSTRUCAO.GLO_ACAO@HACASA           G,
               CONSTRUCAO.FIN_TIPO_DOCUMENTO@HACASA D
        WHERE  R.TDOC_IN_CODIGO         = T.TDOC_IN_CODIGO
        AND    RI.ORG_TAB_IN_CODIGO     = R.ORG_TAB_IN_CODIGO
        AND    RI.ORG_PAD_IN_CODIGO     = R.ORG_PAD_IN_CODIGO
        AND    RI.ORG_IN_CODIGO         = R.ORG_IN_CODIGO
        AND    RI.ORG_TAU_ST_CODIGO     = R.ORG_TAU_ST_CODIGO
        AND    RI.CTO_IN_CODIGO         = R.CTO_IN_CODIGO
        AND    RI.RET_IN_CODIGO         = R.RET_IN_CODIGO
        AND    RI.RETIT_BO_DESCONTAR    = 'S'
        AND    G.TREF_ST_CODIGO         IN ( 'CAUCAO')
        AND    G.ACAO_TAB_IN_CODIGO(+)  = T.ACAO_TAB_IN_CODIGO
        AND    G.ACAO_PAD_IN_CODIGO(+)  = T.ACAO_PAD_IN_CODIGO
        AND    G.ACAO_IN_CODIGO(+)      = T.ACAO_IN_CODIGO
        AND    D.TPD_ST_CODIGO(+)       = G.CPAG_TPD_ST_CODIGO
      GROUP BY RI.ORG_TAB_IN_CODIGO,
               RI.ORG_IN_CODIGO,
               RI.ORG_PAD_IN_CODIGO,
               RI.ORG_TAU_ST_CODIGO,
               RI.CTO_IN_CODIGO,
               RI.MED_IN_CODIGO,
               G.TREF_ST_CODIGO) RET7
WHERE C.AGN_TAB_IN_CODIGO = O.AGN_TAB_IN_CODIGO
AND   C.AGN_PAD_IN_CODIGO = O.AGN_PAD_IN_CODIGO
AND   C.AGN_IN_CODIGO     = O.AGN_IN_CODIGO
AND   C.AGN_TAU_ST_CODIGO = O.AGN_TAU_ST_CODIGO
AND   C.AGN_TAB_IN_CODIGO = AG.AGN_TAB_IN_CODIGO
AND   C.AGN_PAD_IN_CODIGO = AG.AGN_PAD_IN_CODIGO
AND   C.AGN_IN_CODIGO     = AG.AGN_IN_CODIGO
AND   C.ORG_TAB_IN_CODIGO = E.ORG_TAB_IN_CODIGO (+)
AND   C.ORG_PAD_IN_CODIGO = E.ORG_PAD_IN_CODIGO (+)
AND   C.ORG_IN_CODIGO     = E.ORG_IN_CODIGO     (+)
AND   C.ORG_TAU_ST_CODIGO = E.ORG_TAU_ST_CODIGO (+)
AND   C.EST_IN_CODIGO     = E.EST_IN_CODIGO     (+)
AND   C.FIL_IN_CODIGO     = E.FIL_IN_CODIGO     (+)
AND   C.TES_IN_CODIGO     = T.TES_IN_CODIGO     (+)
AND   O.CAT_TAB_IN_CODIGO = G.CAT_TAB_IN_CODIGO (+)
AND   O.CAT_PAD_IN_CODIGO = G.CAT_PAD_IN_CODIGO (+)
AND   O.CAT_IDE_ST_CODIGO = G.CAT_IDE_ST_CODIGO (+)
AND   O.CAT_IN_REDUZIDO   = G.CAT_IN_REDUZIDO   (+)
AND   M.ORG_TAB_IN_CODIGO = C.ORG_TAB_IN_CODIGO
AND   M.ORG_PAD_IN_CODIGO = C.ORG_PAD_IN_CODIGO
AND   M.ORG_IN_CODIGO     = C.ORG_IN_CODIGO
AND   M.ORG_TAU_ST_CODIGO = C.ORG_TAU_ST_CODIGO
AND   M.CTO_IN_CODIGO     = C.CTO_IN_CODIGO
AND   M.ORG_TAB_IN_CODIGO = MI.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = MI.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = MI.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = MI.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = MI.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = MI.MED_IN_CODIGO     (+)
AND   M.MED_CH_SITUACAO	  IN ('L','B')  -- LIBERADA OU EM ANDAMENTO
AND   M.ORG_TAB_IN_CODIGO = A.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = A.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = A.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = A.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = A.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = A.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = DI.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = DI.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = DI.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = DI.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = DI.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = DI.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RI.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RI.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RI.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RI.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RI.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RI.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RISS.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RISS.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RISS.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RISS.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RISS.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RISS.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RINSS.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RINSS.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RINSS.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RINSS.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RINSS.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RINSS.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RSEMIxSS.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RSEMIxSS.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RSEMIxSS.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RSEMIxSS.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RSEMIxSS.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RSEMIxSS.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RIRRF.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RIRRF.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RIRRF.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RIRRF.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RIRRF.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RIRRF.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RCAUCAO.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RCAUCAO.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RCAUCAO.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RCAUCAO.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RCAUCAO.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RCAUCAO.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = DB.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = DB.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = DB.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = DB.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = DB.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = DB.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = VM.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = VM.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = VM.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = VM.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = VM.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = VM.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET1.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET1.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET1.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET1.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET1.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET1.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET2.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET2.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET2.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET2.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET2.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET2.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET3.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET3.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET3.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET3.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET3.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET3.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET4.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET4.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET4.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET4.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET4.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET4.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET5.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET5.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET5.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET5.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET5.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET5.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET6.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET6.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET6.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET6.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET6.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET6.MED_IN_CODIGO     (+)
AND   M.ORG_TAB_IN_CODIGO = RET7.ORG_TAB_IN_CODIGO (+)
AND   M.ORG_PAD_IN_CODIGO = RET7.ORG_PAD_IN_CODIGO (+)
AND   M.ORG_IN_CODIGO     = RET7.ORG_IN_CODIGO     (+)
AND   M.ORG_TAU_ST_CODIGO = RET7.ORG_TAU_ST_CODIGO (+)
AND   M.CTO_IN_CODIGO     = RET7.CTO_IN_CODIGO     (+)
AND   M.MED_IN_CODIGO     = RET7.MED_IN_CODIGO     (+)