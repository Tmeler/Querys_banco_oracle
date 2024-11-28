  select
            to_char(t."PARCELA") as "parcela",
            to_char(t."CONTRATO") as "contrato",
            to_char(t."DATA VENC.") as "data_vencimento",
            t."VALOR ORIGINAL" as "valor_original",
            t."VALOR CORRIGIR" as "valor_correcao",
            t."VALOR CORRIGIDO" as "valor_corrigido"
from
(
    select
        cto.cto_in_codigo as "CONTRATO",
        par.par_in_codigo as "PARCELA",
        par.par_dt_vencimento as "DATA VENC.",
        par.par_re_valororiginal as "VALOR ORIGINAL",
        par.par_re_valorcorrecao as "VALOR CORRIGIR",
        (par.par_re_valororiginal) + (par.par_re_valorcorrecao) as "VALOR CORRIGIDO",
        to_char(cto.cto_in_codigo) || '_' || 
        extract(year from par.par_dt_vencimento) || '_' || 
        lpad(extract( month from par.par_dt_vencimento), 2, '0') || '_' || 
        lpad(extract(day from par.par_dt_vencimento), 2, '0') as "ID"
    
    from construcao.car_vw_contrato@hacasa cto,
        construcao.car_contrato@hacasa c,
        construcao.car_parcela@hacasa par,
        construcao.car_parcelataxa@hacasa tx,
        construcao.car_parcela_observacao@hacasa p,
        construcao.car_contrato_termo@hacasa ter,
        construcao.car_tipo_termo@hacasa t
    
    where
    
            
    cto.org_tab_in_codigo = c.org_tab_in_codigo AND
    cto.org_pad_in_codigo = c.org_pad_in_codigo AND
    cto.org_in_codigo     = c.org_in_codigo AND
    cto.org_tau_st_codigo = c.org_tau_st_codigo AND
    cto.cto_in_codigo     = c.cto_in_codigo and
    cto.fil_in_codigo     = c.fil_in_codigo and
    cto.cnd_in_codigo     = c.cnd_in_codigo and
    
    
    par.org_tab_in_codigo = ter.org_tab_in_codigo(+) AND
    par.org_pad_in_codigo = ter.org_pad_in_codigo (+) AND
    par.org_in_codigo     = ter.org_in_codigo (+) AND
    par.org_tau_st_codigo = ter.org_tau_st_codigo (+) AND
    par.cto_in_codigo     = ter.cto_in_codigo (+)and
    par.cnd_in_codigo     = ter.cnd_in_codigo(+) and
    
    
    par.org_tab_in_codigo = tx.org_tab_in_codigo (+) AND
    par.org_pad_in_codigo = tx.org_pad_in_codigo (+) AND
    par.org_in_codigo     = tx.org_in_codigo (+) AND
    par.org_tau_st_codigo = tx.org_tau_st_codigo (+) AND
    par.cto_in_codigo     = tx.cto_in_codigo (+) and
    par.par_in_codigo     = tx.par_in_codigo (+) and
    
    
    
    ter.tte_in_codigo     = t.tte_in_codigo(+) and
    
    cto.org_tab_in_codigo = p.org_tab_in_codigo AND
    cto.org_pad_in_codigo = p.org_pad_in_codigo AND
    cto.org_in_codigo     = p.org_in_codigo AND
    cto.org_tau_st_codigo = p.org_tau_st_codigo AND
    cto.cto_in_codigo     = p.cto_in_codigo and
    
    cto.org_tab_in_codigo = par.org_tab_in_codigo AND
    cto.org_pad_in_codigo = par.org_pad_in_codigo AND
    cto.org_in_codigo     = par.org_in_codigo AND
    cto.org_tau_st_codigo = par.org_tau_st_codigo AND
    cto.cto_ch_status not in ('D','T') and
    -- par.par_dt_baixa is null and
    
    par.org_tab_in_codigo = p.org_tab_in_codigo and
    par.org_pad_in_codigo = p.org_pad_in_codigo AND
    par.org_in_codigo     = p.org_in_codigo     and
    par.cto_in_codigo     = p.cto_in_codigo     and
    par.par_in_codigo     = p.par_in_codigo
) t;
