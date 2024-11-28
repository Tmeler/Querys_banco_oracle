        SELECT
            ag.AGN_IN_CODIGO        as cliente_id,
            ag.AGN_ST_NOME          as nome,
            ag.AGN_ST_FANTASIA      as nome_fantasia,
            ag.AGN_ST_EMAIL         as email,
            tel.TEA_ST_TELEFONE     as telefone_num,
            tel.TEA_ST_TIPO         as telefone_tipo
            
        FROM 
            construcao.GLO_AGENTES@hacasa ag,
            construcao.GLO_TEL_AGENTES@hacasa tel
        
        WHERE
            --ag.AGN_IN_CODIGO IN ('550', '4') and
            ag.AGN_IN_CODIGO = tel.AGN_IN_CODIGO
        ORDER BY ag.AGN_IN_CODIGO
    ),
    contratos as
    (
        SELECT 
            cto.emp_nome                AS empreendimento,
            upper(cto.agn_st_nome)      AS cliente,
            COALESCE(cad.cpf, cad.CGC)  as cpf_cnpj,
            to_char(cto.cto_in_codigo)  as contrato,
            cto.BLO_ST_CODIGO           as quadra,
            cto.und_st_codigo           as lote,
            cto.agn_in_codigo           as cliente_id
        FROM
            construcao.car_vw_contrato@hacasa cto,
            construcao.WCAR_VW_CLIENTE@hacasa cad
        WHERE 
            cto.agn_in_codigo = cad.agn_in_codigo
            --and cto.fil_in_codigo = 4
            and cto.cto_ch_status = 'A'
        ORDER BY cto.emp_nome, cto.agn_st_nome
    )

SELECT 
    con.empreendimento,
    con.cliente_id,
    con.cliente,
    con.contrato,
    cli.email,
    cli.telefone_num,
    cli.telefone_tipo
FROM contratos con
LEFT JOIN clientes cli ON cli.cliente_id = con.cliente_id;
