  SELECT cto.emp_nome AS "EMPREENDIMENTO",
       upper(cto.agn_st_nome) AS "CLIENTE",
       COALESCE(cad.cpf, cad.CGC) as "CNPJ/CPF",
       to_char(cto.cto_in_codigo) as "CONTRATO",
       cto.BLO_ST_CODIGO as "QUADRA",
       cto.und_st_codigo "LOTE",
       REG.PAR_CH_AVISOENVIADO ,
       REG.PAR_DT_DATACRIACAO,
       REG.PAR_IN_CODIGO,
       REG.PAR_IN_DIAS
FROM
    CONSTRUCAO.CAR_VW_CONTRATO@HACASA CTO,
    CONSTRUCAO.WCAR_VW_CLIENTE@HACASA CAD,
    CONSTRUCAO.CUS_CARPARCELA_AVISOMI@HACASA REG
WHERE 
    cto.agn_in_codigo = cad.agn_in_codigo AND
    REG.ORG_IN_CODIGO = CTO.ORG_IN_CODIGO AND
    REG.ORG_PAD_IN_CODIGO = CTO.ORG_PAD_IN_CODIGO AND
    REG.ORG_TAB_IN_CODIGO = CTO.ORG_TAB_IN_CODIGO AND
    REG.ORG_TAU_ST_CODIGO = CTO.ORG_TAU_ST_CODIGO AND
    REG.CTO_IN_CODIGO = cto.cto_in_codigo
order by cto.emp_nome, cto.agn_st_nome