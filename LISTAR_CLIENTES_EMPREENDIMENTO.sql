  select cto.emp_nome AS "empreendimento",
    upper(cto.agn_st_nome) AS "cliente",
    COALESCE(cad.cpf, cad.CGC) as "cpf_cnpj",
    to_char(cto.cto_in_codigo) as "contrato",
    cto.BLO_ST_CODIGO as "quadra",
    cto.und_st_codigo "lote"
from
    construcao.car_vw_contrato@hacasa cto,
    construcao.WCAR_VW_CLIENTE@hacasa cad
where 
    cto.agn_in_codigo = cad.agn_in_codigo
    --and cto.fil_in_codigo = 4
order by cto.emp_nome, cto.agn_st_nome