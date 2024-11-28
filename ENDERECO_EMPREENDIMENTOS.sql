 select
       e.org_tab_in_codigo,
       e.org_pad_in_codigo,
       e.org_in_codigo,
       e.org_tau_st_codigo,
       e.blo_codigo    as blo_est_in_codigo,
       e.blo_st_codigo as blo_est_st_codigo,
       decode(b.blo_bo_enderecoproprio, 'S', eb.uf_st_sigla,        ee.uf_st_sigla         ) uf_st_sigla,
       decode(b.blo_bo_enderecoproprio, 'S', eb.pa_st_sigla,        ee.pa_st_sigla         ) pa_st_sigla,
       decode(b.blo_bo_enderecoproprio, 'S', eb.mun_in_codigo,      ee.mun_in_codigo       ) mun_in_codigo,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_municipio,   ee.ene_st_municipio    ) ene_st_municipio,
       decode(b.blo_bo_enderecoproprio, 'S', eb.tpl_st_sigla,       ee.tpl_st_sigla        ) tpl_st_sigla,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_logradouro,  ee.ene_st_logradouro   ) ene_st_logradouro,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_numero,      ee.ene_st_numero       ) ene_st_numero,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_bairro,      ee.ene_st_bairro       ) ene_st_bairro,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_cep,         ee.ene_st_cep          ) ene_st_cep,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_cxpostal,    ee.ene_st_cxpostal     ) ene_st_cxpostal,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_complemento, ee.ene_st_complemento  ) ene_st_complemento,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_cep,         ee.ene_st_cep          ) ene_st_cepcxpostal,
       decode(b.blo_bo_enderecoproprio, 'S', eb.ene_st_referencia,  ee.ene_st_referencia   ) ene_st_referencia
FROM   (select  emp.org_tab_in_codigo,
                emp.org_pad_in_codigo,
                emp.org_in_codigo,
                emp.org_tau_st_codigo,
                emp.fil_in_codigo,
                emp.est_in_codigo as emp_codigo,
                emp.est_st_codigo as emp_st_codigo,
                emp.est_st_nome   as emp_nome,
                etp.est_in_codigo as etp_codigo,
                etp.est_st_codigo as etp_st_codigo,
                etp.est_st_nome   as etp_nome,
                blo.est_in_codigo as blo_codigo,
                blo.est_st_codigo as blo_st_codigo,
                blo.est_st_nome   as blo_nome
        from
            construcao.dbm_estrutura@hacasa emp,
            construcao.dbm_estrutura@hacasa etp,
            construcao.dbm_estrutura@hacasa blo
        where
            emp.org_tab_in_codigo    = etp.org_tab_in_codigo and
            emp.org_pad_in_codigo    = etp.org_pad_in_codigo and
            emp.org_in_codigo        = etp.org_in_codigo     and
            emp.org_tau_st_codigo    = etp.org_tau_st_codigo and
            emp.est_in_codigo        = etp.pai_est_in_codigo and
            emp.est_ch_tipoestrutura = 'E'                   and
            etp.org_tab_in_codigo    = blo.org_tab_in_codigo and
            etp.org_pad_in_codigo    = blo.org_pad_in_codigo and
            etp.org_in_codigo        = blo.org_in_codigo     and
            etp.org_tau_st_codigo    = blo.org_tau_st_codigo and
            etp.est_in_codigo        = blo.pai_est_in_codigo and
            etp.est_ch_tipoestrutura = 'T'                   and
            blo.est_ch_tipoestrutura = 'B'
        ) e,
        construcao.dbm_bloco@hacasa b,
        construcao.dbm_endereco_estrutura@hacasa eb,
        construcao.dbm_endereco_estrutura@hacasa ee
where  e.org_tab_in_codigo = b.org_tab_in_codigo      and
       e.org_pad_in_codigo = b.org_pad_in_codigo      and
       e.org_in_codigo     = b.org_in_codigo          and
       e.org_tau_st_codigo = b.org_tau_st_codigo      and
       e.blo_codigo        = b.est_in_codigo          and
       e.org_tab_in_codigo = ee.org_tab_in_codigo (+) and
       e.org_pad_in_codigo = ee.org_pad_in_codigo (+) and
       e.org_in_codigo     = ee.org_in_codigo     (+) and
       e.org_tau_st_codigo = ee.org_tau_st_codigo (+) and
       e.emp_codigo        = ee.est_in_codigo     (+) and
       e.org_tab_in_codigo = eb.org_tab_in_codigo (+) and
       e.org_pad_in_codigo = eb.org_pad_in_codigo (+) and
       e.org_in_codigo     = eb.org_in_codigo     (+) and
       e.org_tau_st_codigo = eb.org_tau_st_codigo (+) and
       e.blo_codigo        = eb.est_in_codigo     (+)