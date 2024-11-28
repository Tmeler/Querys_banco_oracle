 SELECT
  EMP.ORG_TAB_IN_CODIGO,
  EMP.PRO_IN_REDUZIDO,
  EMP.ORG_PAD_IN_CODIGO,
  EMP.ORG_IN_CODIGO,
  EMP.ORG_TAU_ST_CODIGO,
  EMP.EST_IN_CODIGO EMP_CODIGO,
  EMP.EST_ST_CODIGO EMP_ST_CODIGO,
  EMP.EST_ST_NOME EMP_NOME,
  ETP_CODIGO,
  ETP_ST_CODIGO,
  ETP_NOME,
  BLO_CODIGO,
  BLO_ST_CODIGO,
  BLO_NOME,
  BLO_DT_ENTREGA,
  UND_CODIGO,
  UND_ST_CODIGO,
  UND_NOME,
  UND_STATUS,
  UND_AREATOTAL,
  UND_PESO,
  UND_IN_ANDAR,
  UND_IN_DEPENDENCIAS,
  TPU_IN_CODIGO,
  UND_RE_AREAPRIVATIVA,
  UND_RE_AREACOMUM,
  UND_RE_FRACAO,
  UND_RE_FRACAOTER,
  UND_RE_FRACAOSOC,
  UND_RE_FRACAOTERSOC,
  UND_RE_FRACAO_IDEAL,
  UND_RE_QUOTA,
  UND_RE_PESO,
  UND_RE_AREAGARAGEM,
  UND_RE_AREAOUTROS,
  UND_RE_AREATERRACO,
  TPU_ST_DESCRICAO,
  CND_IN_CODIGO,
  UND_BO_AREAPRIVATIVA,
  UND_BO_AREACOMUM,
  UND_BO_AREAGARAGEM,
  UND_BO_AREATERRACO,
  UND_BO_AREAOUTROS
FROM
  CONSTRUCAO.DBM_ESTRUTURA@HACASA EMP,
  (
    SELECT
      ETP.ORG_TAB_IN_CODIGO TAB_IN_CODIGO,
      ETP.ORG_PAD_IN_CODIGO PAD_IN_CODIGO,
      ETP.ORG_IN_CODIGO IN_CODIGO,
      ETP.ORG_TAU_ST_CODIGO TAU_ST_CODIGO,
      ETP.EST_IN_CODIGO ETP_CODIGO,
      ETP.EST_ST_CODIGO ETP_ST_CODIGO,
      ETP.EST_ST_NOME ETP_NOME,
      BLO_CODIGO,
      BLO_ST_CODIGO,
      BLO_NOME,
      BLO_DT_ENTREGA,
      UND_CODIGO,
      UND_ST_CODIGO,
      UND_NOME,
      UND_STATUS,
      UND_AREATOTAL,
      UND_PESO,
      UND_IN_ANDAR,
      UND_IN_DEPENDENCIAS,
      TPU_IN_CODIGO,
      UND_RE_AREAPRIVATIVA,
      UND_RE_AREACOMUM,
      UND_RE_FRACAO,
      UND_RE_FRACAOTER,
      UND_RE_FRACAOSOC,
      UND_RE_FRACAOTERSOC,
      UND_RE_FRACAO_IDEAL,
      UND_RE_QUOTA,
      UND_RE_PESO,
      UND_RE_AREAGARAGEM,
      UND_RE_AREAOUTROS,
      UND_RE_AREATERRACO,
      TPU_ST_DESCRICAO,
      ETP.PAI_EST_IN_CODIGO ETP_PAI_EST,
      CND_IN_CODIGO,
      UND_BO_AREAPRIVATIVA,
      UND_BO_AREACOMUM,
      UND_BO_AREAGARAGEM,
      UND_BO_AREATERRACO,
      UND_BO_AREAOUTROS
    FROM
      CONSTRUCAO.DBM_ESTRUTURA@HACASA ETP,
      (
        SELECT
          BLO.ORG_TAB_IN_CODIGO TAB_IN_CODIGO,
          BLO.ORG_PAD_IN_CODIGO PAD_IN_CODIGO,
          BLO.ORG_IN_CODIGO IN_CODIGO,
          BLO.ORG_TAU_ST_CODIGO TAU_ST_CODIGO,
          BLO.EST_IN_CODIGO BLO_CODIGO,
          BLO.EST_ST_CODIGO BLO_ST_CODIGO,
          BLO.EST_ST_NOME BLO_NOME,
          UND_CODIGO,
          UND_ST_CODIGO,
          UND_NOME,
          UND_STATUS,
          UND_AREATOTAL,
          UND_IN_ANDAR,
          UND_IN_DEPENDENCIAS,
          TPU_IN_CODIGO,
          UND_RE_AREAPRIVATIVA,
          UND_RE_AREACOMUM,
          UND_RE_FRACAO,
          UND_RE_FRACAOTER,
          UND_RE_FRACAOSOC,
          UND_RE_FRACAOTERSOC,
          UND_RE_FRACAO_IDEAL,
          UND_RE_QUOTA,
          UND_RE_PESO,
          UND_RE_AREAGARAGEM,
          UND_RE_AREAOUTROS,
          UND_RE_AREATERRACO,
          TPU_ST_DESCRICAO,
	        UND_PESO,
          BLO.PAI_EST_IN_CODIGO BLO_PAI_EST,
          TRUNC(ENT.ENT_DT_ENTREGA)  BLO_DT_ENTREGA,
          CND_IN_CODIGO,
          UND_BO_AREAPRIVATIVA,
          UND_BO_AREACOMUM,
          UND_BO_AREAGARAGEM,
          UND_BO_AREATERRACO,
          UND_BO_AREAOUTROS
        FROM
          CONSTRUCAO.DBM_ESTRUTURA@HACASA BLO,
          CONSTRUCAO.DBM_ENTREGA_OBRA@HACASA ENT,
          (
            SELECT
              UND.ORG_TAB_IN_CODIGO TAB_IN_CODIGO,
              UND.ORG_PAD_IN_CODIGO PAD_IN_CODIGO,
              UND.ORG_IN_CODIGO IN_CODIGO,
              UND.ORG_TAU_ST_CODIGO TAU_ST_CODIGO,
              UND.EST_IN_CODIGO UND_CODIGO,
              UND.EST_ST_CODIGO UND_ST_CODIGO,
              UND.EST_ST_NOME UND_NOME,
              UND.PAI_EST_IN_CODIGO UND_PAI_EST,
              UNI.UND_CH_STATUS UND_STATUS,
              UNI.UND_RE_AREATOTAL UND_AREATOTAL,
	            UNI.UND_RE_PESO UND_PESO,
              UNI.TPU_IN_CODIGO TPU_IN_CODIGO,
              T.TPU_ST_DESCRICAO TPU_ST_DESCRICAO,
              UNI.UND_RE_AREAPRIVATIVA,
              UNI.UND_RE_AREACOMUM,
              CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                          UNI.ORG_PAD_IN_CODIGO,
                                                          UNI.ORG_IN_CODIGO,
                                                          UNI.ORG_TAU_ST_CODIGO,
                                                          UNI.EST_IN_CODIGO,
                                                          1) UND_RE_FRACAO,
              CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                          UNI.ORG_PAD_IN_CODIGO,
                                                          UNI.ORG_IN_CODIGO,
                                                          UNI.ORG_TAU_ST_CODIGO,
                                                          UNI.EST_IN_CODIGO,
                                                          2) UND_RE_FRACAOTER,
              CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                          UNI.ORG_PAD_IN_CODIGO,
                                                          UNI.ORG_IN_CODIGO,
                                                          UNI.ORG_TAU_ST_CODIGO,
                                                          UNI.EST_IN_CODIGO,
                                                          3) UND_RE_FRACAOSOC,
              CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                          UNI.ORG_PAD_IN_CODIGO,
                                                          UNI.ORG_IN_CODIGO,
                                                          UNI.ORG_TAU_ST_CODIGO,
                                                          UNI.EST_IN_CODIGO,
                                                          4) UND_RE_FRACAOTERSOC,
              CONSTRUCAO.PCK_DBM_FNC.FNC_DBM_GETFRACAO_VIGENTE@HACASA(UNI.ORG_TAB_IN_CODIGO,
                                                          UNI.ORG_PAD_IN_CODIGO,
                                                          UNI.ORG_IN_CODIGO,
                                                          UNI.ORG_TAU_ST_CODIGO,
                                                          UNI.EST_IN_CODIGO,
                                                          5) UND_RE_FRACAO_IDEAL,
              UNI.UND_RE_QUOTA,
              UNI.UND_RE_PESO,
              UNI.UND_RE_AREAGARAGEM,
              UNI.UND_RE_AREAOUTROS,
              UNI.UND_RE_AREATERRACO,
              UNI.UND_IN_ANDAR UND_IN_ANDAR,
              UNI.UND_IN_DEPENDENCIAS UND_IN_DEPENDENCIAS,
              UNI.CND_IN_CODIGO,  -- COD. DA PROPOSTA QUE RESERVOU A UNIDADE, CASO HAJA. AWR PM 17933/13534
              UNI.UND_BO_AREAPRIVATIVA,
              UNI.UND_BO_AREACOMUM,
              UNI.UND_BO_AREAGARAGEM,
              UNI.UND_BO_AREATERRACO,
              UNI.UND_BO_AREAOUTROS
         FROM
              CONSTRUCAO.DBM_ESTRUTURA@HACASA UND,
              CONSTRUCAO.DBM_UNIDADE@HACASA UNI,
              CONSTRUCAO.DBM_TIPOLOGIA_UNIDADE@HACASA T
            WHERE
              UND.EST_CH_TIPOESTRUTURA = 'U' AND
              UND.ORG_TAB_IN_CODIGO = UNI.ORG_TAB_IN_CODIGO AND
              UND.ORG_PAD_IN_CODIGO = UNI.ORG_PAD_IN_CODIGO AND
              UND.ORG_IN_CODIGO = UNI.ORG_IN_CODIGO AND
              UND.ORG_TAU_ST_CODIGO = UNI.ORG_TAU_ST_CODIGO AND
              UND.EST_IN_CODIGO = UNI.EST_IN_CODIGO AND
              T.TPU_IN_CODIGO = UNI.TPU_IN_CODIGO
          )
        WHERE
          BLO.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO AND
          BLO.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO AND
          BLO.ORG_IN_CODIGO = IN_CODIGO AND
          BLO.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO AND
          BLO.EST_IN_CODIGO = UND_PAI_EST AND
          BLO.EST_CH_TIPOESTRUTURA = 'B' AND
          ENT.ORG_TAB_IN_CODIGO (+) = BLO.ORG_TAB_IN_CODIGO AND
          ENT.ORG_PAD_IN_CODIGO (+) = BLO.ORG_PAD_IN_CODIGO AND
          ENT.ORG_IN_CODIGO (+) = BLO.ORG_IN_CODIGO AND
          ENT.ORG_TAU_ST_CODIGO (+) = BLO.ORG_TAU_ST_CODIGO AND
          ENT.EST_IN_CODIGO (+) = BLO.EST_IN_CODIGO AND
          (ENT.ENT_DT_CADASTRO  = (  SELECT MAX(EO.ENT_DT_CADASTRO)
                               		     FROM CONSTRUCAO.DBM_ENTREGA_OBRA@HACASA EO
                   			              WHERE EO.ORG_TAB_IN_CODIGO = BLO.ORG_TAB_IN_CODIGO
                   			                AND EO.ORG_PAD_IN_CODIGO = BLO.ORG_PAD_IN_CODIGO
                   			                AND EO.ORG_IN_CODIGO     = BLO.ORG_IN_CODIGO
                   			                AND EO.ORG_TAU_ST_CODIGO = BLO.ORG_TAU_ST_CODIGO
                   			                AND EO.EST_IN_CODIGO     = BLO.EST_IN_CODIGO )
           or ENT.ENT_DT_CADASTRO IS NULL )
      )
    WHERE
      ETP.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO AND
      ETP.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO AND
      ETP.ORG_IN_CODIGO = IN_CODIGO AND
      ETP.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO AND
      ETP.EST_IN_CODIGO = BLO_PAI_EST AND
      ETP.EST_CH_TIPOESTRUTURA = 'T'
  )
WHERE
  EMP.ORG_TAB_IN_CODIGO = TAB_IN_CODIGO AND
  EMP.ORG_PAD_IN_CODIGO = PAD_IN_CODIGO AND
  EMP.ORG_IN_CODIGO = IN_CODIGO AND
  EMP.ORG_TAU_ST_CODIGO = TAU_ST_CODIGO AND
  EMP.EST_IN_CODIGO = ETP_PAI_EST AND
  EMP.EST_CH_TIPOESTRUTURA = 'E'