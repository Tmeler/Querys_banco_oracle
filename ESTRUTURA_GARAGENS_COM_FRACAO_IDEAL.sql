 SELECT
   EMP.ORG_TAB_IN_CODIGO
  ,EMP.ORG_PAD_IN_CODIGO
  ,EMP.ORG_IN_CODIGO
  ,EMP.ORG_TAU_ST_CODIGO
  ,EMP.EST_IN_CODIGO EMP_CODIGO
  ,EMP.EST_ST_CODIGO EMP_ST_CODIGO
  ,EMP.EST_ST_NOME EMP_NOME
  ,ETP_CODIGO
  ,ETP_ST_CODIGO
  ,ETP_NOME
  ,BLO_CODIGO
  ,BLO_ST_CODIGO
  ,BLO_NOME
  ,ORDEM
  ,UND_CH_TIPO
  ,UND_CODIGO
  ,UND_ST_CODIGO
  ,UND_NOME
  ,UND_STATUS
  ,UND_AREATOTAL
  ,UND_PESO
  ,UND_RE_AREAPRIVATIVA
  ,UND_RE_AREACOMUM
  ,UND_RE_FRACAO
  ,UND_RE_FRACAOTER
  ,UND_RE_FRACAOSOC
  ,UND_RE_FRACAOTERSOC
  ,UND_RE_FRACAO_IDEAL
  ,UND_RE_QUOTA
  ,UND_RE_PESO
  ,UND_RE_AREAGARAGEM
  ,UND_RE_AREAOUTROS
  ,UND_RE_AREATERRACO
  ,CND_IN_CODIGO
  ,UND_BO_CUSTOREF
  ,UND_BO_AREAPRIVATIVA
  ,UND_BO_AREACOMUM
  ,UND_BO_AREAGARAGEM
  ,UND_BO_AREATERRACO
  ,UND_BO_AREAOUTROS
  ,UND_DT_ENTREGAEFETIVA
  --,decode(UND_DT_ENTREGAEFETIVA
    --      ,Null
      --    ,CONSTRUCAO.Fnc_DBM_DataEntregaEfetiva@HACASA(ORG_TAB_IN_CODIGO
        --                                   ,ORG_PAD_IN_CODIGO
          --                                 ,ORG_IN_CODIGO
            --                               ,ORG_TAU_ST_CODIGO
              --                             ,UND_CODIGO
                --                           ,und_ch_tipo)
          --,UND_DT_ENTREGAEFETIVA) as UND_ENTREGAEFETIVA
FROM
  CONSTRUCAO.DBM_ESTRUTURA@HACASA EMP,
  (
   (
    SELECT
       ETP.ORG_TAB_IN_CODIGO TAB_IN_CODIGO
      ,ETP.ORG_PAD_IN_CODIGO PAD_IN_CODIGO
      ,ETP.ORG_IN_CODIGO IN_CODIGO
      ,ETP.ORG_TAU_ST_CODIGO TAU_ST_CODIGO
      ,ETP.EST_IN_CODIGO ETP_CODIGO
      ,ETP.EST_ST_CODIGO ETP_ST_CODIGO
      ,ETP.EST_ST_NOME ETP_NOME
      ,BLO_CODIGO
      ,BLO_ST_CODIGO
      ,BLO_NOME
      ,1 ORDEM
      ,'U' UND_CH_TIPO
      ,UND_CODIGO
      ,UND_ST_CODIGO
      ,UND_NOME
      ,UND_STATUS
      ,UND_AREATOTAL
      ,UND_PESO
      ,UND_RE_AREAPRIVATIVA
      ,UND_RE_AREACOMUM
      ,UND_RE_FRACAO
      ,UND_RE_FRACAOTER
      ,UND_RE_FRACAOSOC
      ,UND_RE_FRACAOTERSOC
      ,UND_RE_FRACAO_IDEAL
      ,UND_RE_QUOTA
      ,UND_RE_PESO
      ,UND_RE_AREAGARAGEM
      ,UND_RE_AREAOUTROS
      ,UND_RE_AREATERRACO
      ,ETP.PAI_EST_IN_CODIGO ETP_PAI_EST
      ,CND_IN_CODIGO
      ,UND_BO_CUSTOREF
      ,UND_BO_AREAPRIVATIVA
      ,UND_BO_AREACOMUM
      ,UND_BO_AREAGARAGEM
      ,UND_BO_AREATERRACO
      ,UND_BO_AREAOUTROS
      ,UND_DT_ENTREGAEFETIVA
    FROM
      CONSTRUCAO.DBM_ESTRUTURA@HACASA ETP,
      (
        SELECT
           BLO.ORG_TAB_IN_CODIGO TAB_IN_CODIGO
          ,BLO.ORG_PAD_IN_CODIGO PAD_IN_CODIGO
          ,BLO.ORG_IN_CODIGO IN_CODIGO
          ,BLO.ORG_TAU_ST_CODIGO TAU_ST_CODIGO
          ,BLO.EST_IN_CODIGO BLO_CODIGO
          ,BLO.EST_ST_CODIGO BLO_ST_CODIGO
          ,BLO.EST_ST_NOME BLO_NOME
          ,UND_CODIGO
          ,UND_ST_CODIGO
          ,UND_NOME
          ,UND_STATUS
          ,UND_AREATOTAL
          ,UND_RE_AREAPRIVATIVA
          ,UND_RE_AREACOMUM
          ,UND_RE_FRACAO
          ,UND_RE_FRACAOTER
          ,UND_RE_FRACAOSOC
          ,UND_RE_FRACAOTERSOC
          ,UND_RE_FRACAO_IDEAL
          ,UND_RE_QUOTA
          ,UND_RE_PESO
          ,UND_RE_AREAGARAGEM
          ,UND_RE_AREAOUTROS
          ,UND_RE_AREATERRACO
          ,UND_PESO
          ,BLO.PAI_EST_IN_CODIGO BLO_PAI_EST
          ,CND_IN_CODIGO
          ,UND_BO_CUSTOREF
          ,UND_BO_AREAPRIVATIVA
          ,UND_BO_AREACOMUM
          ,UND_BO_AREAGARAGEM
          ,UND_BO_AREATERRACO
          ,UND_BO_AREAOUTROS
          ,UND_DT_ENTREGAEFETIVA
        FROM
          CONSTRUCAO.DBM_ESTRUTURA@HACASA BLO,
          (
            SELECT
               UND.ORG_TAB_IN_CODIGO TAB_IN_CODIGO
              ,UND.ORG_PAD_IN_CODIGO PAD_IN_CODIGO
              ,UND.ORG_IN_CODIGO IN_CODIGO
              ,UND.ORG_TAU_ST_CODIGO TAU_ST_CODIGO
              ,UND.EST_IN_CODIGO UND_CODIGO
              ,UND.EST_ST_CODIGO UND_ST_CODIGO
              ,UND.EST_ST_NOME UND_NOME
              ,UND.PAI_EST_IN_CODIGO UND_PAI_EST
              ,UNI.UND_CH_STATUS UND_STATUS
              ,UNI.UND_RE_AREATOTAL UND_AREATOTAL
              ,UNI.UND_RE_PESO UND_PESO
              ,UNI.UND_RE_AREAPRIVATIVA
              ,UNI.UND_RE_AREACOMUM
              ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                           UNI.ORG_PAD_IN_CODIGO,
                                                           UNI.ORG_IN_CODIGO,
                                                           UNI.ORG_TAU_ST_CODIGO,
                                                           UNI.EST_IN_CODIGO,
                                                           1) UND_RE_FRACAO
              ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                           UNI.ORG_PAD_IN_CODIGO,
                                                           UNI.ORG_IN_CODIGO,
                                                           UNI.ORG_TAU_ST_CODIGO,
                                                           UNI.EST_IN_CODIGO,
                                                           2) UND_RE_FRACAOTER
              ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                           UNI.ORG_PAD_IN_CODIGO,
                                                           UNI.ORG_IN_CODIGO,
                                                           UNI.ORG_TAU_ST_CODIGO,
                                                           UNI.EST_IN_CODIGO,
                                                           3) UND_RE_FRACAOSOC
              ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                           UNI.ORG_PAD_IN_CODIGO,
                                                           UNI.ORG_IN_CODIGO,
                                                           UNI.ORG_TAU_ST_CODIGO,
                                                           UNI.EST_IN_CODIGO,
                                                           4) UND_RE_FRACAOTERSOC
              ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                           UNI.ORG_PAD_IN_CODIGO,
                                                           UNI.ORG_IN_CODIGO,
                                                           UNI.ORG_TAU_ST_CODIGO,
                                                           UNI.EST_IN_CODIGO,
                                                           5) UND_RE_FRACAO_IDEAL
              ,UNI.UND_RE_QUOTA
              ,UNI.UND_RE_PESO
              ,UNI.UND_RE_AREAGARAGEM
              ,UNI.UND_RE_AREAOUTROS
              ,UNI.UND_RE_AREATERRACO
              ,UNI.CND_IN_CODIGO  -- CD. DA PROPOSTA QUE RESERVOU A UNIDADE, CASO HAJA. AWR PM 17933/13534
              ,UNI.UND_BO_CUSTOREF
              ,UNI.UND_BO_AREAPRIVATIVA
              ,UNI.UND_BO_AREACOMUM
              ,UNI.UND_BO_AREAGARAGEM
              ,UNI.UND_BO_AREATERRACO
              ,UNI.UND_BO_AREAOUTROS
              ,UNI.UND_DT_ENTREGAEFETIVA
            FROM
              CONSTRUCAO.DBM_ESTRUTURA@HACASA UND
             ,CONSTRUCAO.DBM_UNIDADE@HACASA UNI
            WHERE UND.EST_CH_TIPOESTRUTURA = 'U'
              AND UND.ORG_TAB_IN_CODIGO = UNI.ORG_TAB_IN_CODIGO
              AND UND.ORG_PAD_IN_CODIGO = UNI.ORG_PAD_IN_CODIGO
              AND UND.ORG_IN_CODIGO     = UNI.ORG_IN_CODIGO
              AND UND.ORG_TAU_ST_CODIGO = UNI.ORG_TAU_ST_CODIGO
              AND UND.EST_IN_CODIGO     = UNI.EST_IN_CODIGO
          )
        WHERE BLO.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO
          AND BLO.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO
          AND BLO.ORG_IN_CODIGO = IN_CODIGO
          AND BLO.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO
          AND BLO.EST_IN_CODIGO = UND_PAI_EST
          AND BLO.EST_CH_TIPOESTRUTURA = 'B'
      )
    WHERE ETP.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO
      AND ETP.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO
      AND ETP.ORG_IN_CODIGO = IN_CODIGO
      AND ETP.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO
      AND ETP.EST_IN_CODIGO = BLO_PAI_EST
      AND ETP.EST_CH_TIPOESTRUTURA = 'T'
   )
   UNION
   (
    SELECT
       EGR.ORG_TAB_IN_CODIGO TAB_IN_CODIGO
      ,EGR.ORG_PAD_IN_CODIGO PAD_IN_CODIGO
      ,EGR.ORG_IN_CODIGO IN_CODIGO
      ,EGR.ORG_TAU_ST_CODIGO TAU_ST_CODIGO
      ,0   ETP_CODIGO
      ,' ' ETP_ST_CODIGO
      ,' ' ETP_NOME
      ,BLO.EST_IN_CODIGO BLO_CODIGO
      ,BLO.EST_ST_CODIGO BLO_ST_CODIGO
      ,BLO.EST_ST_NOME   BLO_NOME
      ,2   ORDEM
      ,'G' UND_CH_TIPO
      ,EGR.EST_IN_CODIGO UND_CODIGO
      ,EGR.EST_ST_CODIGO UND_ST_CODIGO
      ,EGR.EST_ST_NOME UND_NOME
      ,GAR.GAR_CH_STATUS UND_STATUS
      ,GAR.GAR_RE_AREA UND_AREATOTAL
      ,GAR.GAR_RE_PESO UND_PESO
      ,GAR.GAR_RE_AREA UND_RE_AREAPRIVATIVA
      ,0 UND_RE_AREACOMUM
      ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(GAR.ORG_TAB_IN_CODIGO,
                                                   GAR.ORG_PAD_IN_CODIGO,
                                                   GAR.ORG_IN_CODIGO,
                                                   GAR.ORG_TAU_ST_CODIGO,
                                                   GAR.EST_IN_CODIGO,
                                                   1) UND_RE_FRACAO
      ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(GAR.ORG_TAB_IN_CODIGO,
                                                   GAR.ORG_PAD_IN_CODIGO,
                                                   GAR.ORG_IN_CODIGO,
                                                   GAR.ORG_TAU_ST_CODIGO,
                                                   GAR.EST_IN_CODIGO,
                                                   2) UND_RE_FRACAOTER
      ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(GAR.ORG_TAB_IN_CODIGO,
                                                   GAR.ORG_PAD_IN_CODIGO,
                                                   GAR.ORG_IN_CODIGO,
                                                   GAR.ORG_TAU_ST_CODIGO,
                                                   GAR.EST_IN_CODIGO,
                                                   3) UND_RE_FRACAOSOC
      ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(GAR.ORG_TAB_IN_CODIGO,
                                                   GAR.ORG_PAD_IN_CODIGO,
                                                   GAR.ORG_IN_CODIGO,
                                                   GAR.ORG_TAU_ST_CODIGO,
                                                   GAR.EST_IN_CODIGO,
                                                   4) UND_RE_FRACAOTERSOC
      ,CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(GAR.ORG_TAB_IN_CODIGO,
                                                   GAR.ORG_PAD_IN_CODIGO,
                                                   GAR.ORG_IN_CODIGO,
                                                   GAR.ORG_TAU_ST_CODIGO,
                                                   GAR.EST_IN_CODIGO,
                                                   5) UND_RE_FRACAO_IDEAL
      ,GAR.GAR_RE_QUOTA UND_RE_QUOTA
      ,GAR.GAR_RE_PESO UND_RE_PESO
      ,0 UND_RE_AREAGARAGEM
      ,0 UND_RE_AREAOUTROS
      ,0 UND_RE_AREATERRACO
      ,GAR.EMP_EST_IN_CODIGO ETP_PAI_EST
      ,GAR.CND_IN_CODIGO  -- CD. DA PROPOSTA QUE RESERVOU A GARAGEM, CASO HAJA. AWR PM 17933/13534
      ,GAR.GAR_BO_CUSTOREF UND_BO_CUSTOREF
      ,'N' UND_BO_AREAPRIVATIVA
      ,'N' UND_BO_AREACOMUM
      ,'N' UND_BO_AREAGARAGEM
      ,'N' UND_BO_AREATERRACO
      ,'N' UND_BO_AREAOUTROS
      ,GAR.GAR_DT_ENTREGAEFETIVA as UND_DT_ENTREGAEFETIVA
    FROM
       CONSTRUCAO.DBM_ESTRUTURA@HACASA EGR
      ,CONSTRUCAO.DBM_ESTRUTURA@HACASA BLO
      ,CONSTRUCAO.DBM_GARAGEM@HACASA GAR
    WHERE EGR.EST_CH_TIPOESTRUTURA = 'G'
      AND EGR.ORG_TAB_IN_CODIGO = GAR.ORG_TAB_IN_CODIGO
      AND EGR.ORG_PAD_IN_CODIGO = GAR.ORG_PAD_IN_CODIGO
      AND EGR.ORG_IN_CODIGO     = GAR.ORG_IN_CODIGO
      AND EGR.ORG_TAU_ST_CODIGO = GAR.ORG_TAU_ST_CODIGO
      AND EGR.EST_IN_CODIGO     = GAR.EST_IN_CODIGO
      AND GAR.ORG_TAB_IN_CODIGO = BLO.ORG_TAB_IN_CODIGO(+)
      AND GAR.ORG_PAD_IN_CODIGO = BLO.ORG_PAD_IN_CODIGO(+)
      AND GAR.ORG_IN_CODIGO     = BLO.ORG_IN_CODIGO    (+)
      AND GAR.ORG_TAU_ST_CODIGO = BLO.ORG_TAU_ST_CODIGO(+)
      AND GAR.BLO_EST_IN_CODIGO = BLO.EST_IN_CODIGO    (+)
   )
  )
WHERE EMP.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO
  AND EMP.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO
  AND EMP.ORG_IN_CODIGO     = IN_CODIGO
  AND EMP.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO
  AND EMP.EST_IN_CODIGO     = ETP_PAI_EST
  AND EMP.EST_CH_TIPOESTRUTURA = 'E'