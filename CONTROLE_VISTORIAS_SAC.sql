  SELECT cto.emp_nome AS "EMPREENDIMENTO",
    upper(cto.agn_st_nome) AS "CLIENTE",
    COALESCE(cad.cpf, cad.CGC) as "CPF/CNPJ",
    to_char(cto.cto_in_codigo) as "CONTRATO",
    DECODE(UPPER(CTO.CTO_CH_STATUS),
              'A', 'ATIVO',
              'U', 'INADIMPLENTE',
              'D', 'DISTRATADO',
              'T', 'TRANSFERIDO',
              'C', 'CESSÃO DE DIREITOS',
              'Q', 'QUITADO',
              'OUTRO') AS "SITUAÇÃO DO CONTRATO",
    cto.BLO_ST_CODIGO as "BLOCO",
    cto.und_st_codigo "UNIDADE",
    VST.CTO_VISTORIADO AS "VISTORIADO",
    VST.CTO_DT_VIST AS "DATA VISTORIA",
    VST.CTO_LIB_ENT AS "LIBERADO PARA ENTREGA",
    VST.CTO_APRO_VIST AS "APROVAÇÃO VISTORIA",
    VST.CTO_NOTIF_VIST AS "NOTIFICAÇÃO VISTORIA",
    VST.CTO_ENT_CHAVES AS "ENTREGA CHAVES",
    VST.CTO_DT_ENT_CH AS "DATA DA ENTREGA DE CHAVES",
    VST.CTO_NOTIF_CH AS "NOTIFICADO SOBRE AS CHAVES",
    VST.CTO_OBS_VIST AS "OBSERVAÇÕES"
FROM
    construcao.car_vw_contrato@hacasa cto,
    construcao.WCAR_VW_CLIENTE@hacasa cad,
    CONSTRUCAO.CAR_CONTRATOCMPESP@HACASA VST
WHERE 
    cto.agn_in_codigo = cad.agn_in_codigo AND
    VST.ORG_TAB_IN_CODIGO = CTO.ORG_TAB_IN_CODIGO AND
    VST.ORG_PAD_IN_CODIGO = CTO.ORG_PAD_IN_CODIGO AND
    VST.ORG_IN_CODIGO = CTO.ORG_IN_CODIGO AND
    VST.ORG_TAU_ST_CODIGO = CTO.ORG_TAU_ST_CODIGO AND
    VST.CTO_IN_CODIGO = CTO.CTO_IN_CODIGO 
ORDER BY cto.emp_nome, cto.agn_st_nome