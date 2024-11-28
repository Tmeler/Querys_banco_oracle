 select
   cto.fil_in_codigo,
   cto.filial as COD_FILIAL,
   cto.emp_nome AS EMPREENDIMENTO,
   cto.agn_st_nome AS CLIENTE,
   cto.cto_in_codigo AS NUM_CONTRATO,
   cto.und_st_codigo,
   cto.pro_in_reduzido AS PROJETO,
   DECODE(UPPER(CTO.CTO_CH_STATUS),
       'A', 'ATIVO',
       'U', 'INADIMPLENTE',
       'D', 'DISTRATADO',
       'T', 'TRANSFERIDO',
       'C', 'CESSÃO DE DIREITOS',
       'Q', 'QUITADO',
       'OUTRO') AS CTO_CH_STATUS,
   par.par_in_codigo,
   p.par_st_observacao,
   DECODE(UPPER(par.par_ch_parcela),
       'M', 'MENSAL',
       'S', 'SINAL',
       'I', 'INTERMEDIÁRIA',
       'C', 'CONCLUSÃO',
       'C', 'CESSÃO DE DIREITOS',
       'Q', 'QUITADO',
       'OUTRO') AS TIPO_PARCELA,
   par.par_dt_vencimento,
   par.par_dt_baixa,
   par.par_re_valororiginal,
   par.par_re_valorpago,
   par.par_re_valormulta,
   par.par_re_valoratraso,
   par.par_re_valorjuros,
   par.par_re_valorjurosbx,
   par.par_re_valorcorrecao,
   par.par_re_valorcorrecaobx,
   par.par_re_valordesconto,
   par.par_re_valorresiduo,
   par.par_re_valorjurostp,
   par.par_re_valorjurosren,
   par.par_re_valorcorrecao_atr,
   SUM(tx.ptx_re_valor) as "TAXAS ADICIONAIS", -- TAREFA 211006 - INCLUIR AS TAXAS ADICIONIS PARA CÁLCULO PARCELA / TAREFA 215652 - AJUSTAR COLUNA TAXAS ADICIONAIS VALORES DUPLICADOS (Meler)
   MAX(tx.ptx_dt_calculo) as "DATA INSERIDA TX" -- TAREFA 211006 - INCLUIR A DATA DE REFERÊNCIA DA TAXA
from
   construcao.car_vw_contrato@hacasa cto
   join construcao.car_contrato@hacasa c on cto.org_tab_in_codigo = c.org_tab_in_codigo
       and cto.org_pad_in_codigo = c.org_pad_in_codigo
       and cto.org_in_codigo = c.org_in_codigo
       and cto.org_tau_st_codigo = c.org_tau_st_codigo
       and cto.cto_in_codigo = c.cto_in_codigo
       and cto.fil_in_codigo = c.fil_in_codigo
       and cto.cnd_in_codigo = c.cnd_in_codigo
   join construcao.car_parcela@hacasa par on cto.org_tab_in_codigo = par.org_tab_in_codigo
       and cto.org_pad_in_codigo = par.org_pad_in_codigo
       and cto.org_in_codigo = par.org_in_codigo
       and cto.org_tau_st_codigo = par.org_tau_st_codigo
       and cto.cto_in_codigo = par.cto_in_codigo
   join construcao.car_parcela_observacao@hacasa p on cto.org_tab_in_codigo = p.org_tab_in_codigo
       and cto.org_pad_in_codigo = p.org_pad_in_codigo
       and cto.org_in_codigo = p.org_in_codigo
       and cto.org_tau_st_codigo = p.org_tau_st_codigo
       and cto.cto_in_codigo = p.cto_in_codigo
       and par.par_in_codigo = p.par_in_codigo
   left join construcao.car_parcelataxa@hacasa tx on par.org_tab_in_codigo = tx.org_tab_in_codigo
       and par.org_pad_in_codigo = tx.org_pad_in_codigo
       and par.org_in_codigo = tx.org_in_codigo
       and par.org_tau_st_codigo = tx.org_tau_st_codigo
       and par.cto_in_codigo = tx.cto_in_codigo
       and par.par_in_codigo = tx.par_in_codigo
   left join construcao.car_contrato_termo@hacasa ter on par.org_tab_in_codigo = ter.org_tab_in_codigo
       and par.org_pad_in_codigo = ter.org_pad_in_codigo
       and par.org_in_codigo = ter.org_in_codigo
       and par.org_tau_st_codigo = ter.org_tau_st_codigo
       and par.cto_in_codigo = ter.cto_in_codigo
       and par.cnd_in_codigo = ter.cnd_in_codigo
   left join construcao.car_tipo_termo@hacasa t on ter.tte_in_codigo = t.tte_in_codigo
where
   par.par_dt_vencimento BETWEEN ADD_MONTHS(TO_DATE(CURRENT_DATE), -120) AND ADD_MONTHS(TO_DATE(CURRENT_DATE), 360)
   and PAR.PAR_CH_STATUS = 'A'
group by
   cto.fil_in_codigo,
   cto.filial,
   cto.emp_nome,
   cto.agn_st_nome,
   cto.cto_in_codigo,
   cto.und_st_codigo,
   cto.pro_in_reduzido,
   DECODE(UPPER(CTO.CTO_CH_STATUS),
       'A', 'ATIVO',
       'U', 'INADIMPLENTE',
       'D', 'DISTRATADO',
       'T', 'TRANSFERIDO',
       'C', 'CESSÃO DE DIREITOS',
       'Q', 'QUITADO',
       'OUTRO'),
   par.par_in_codigo,
   p.par_st_observacao,
   DECODE(UPPER(par.par_ch_parcela),
       'M', 'MENSAL',
       'S', 'SINAL',
       'I', 'INTERMEDIÁRIA',
       'C', 'CONCLUSÃO',
       'C', 'CESSÃO DE DIREITOS',
       'Q', 'QUITADO',
       'OUTRO'),
   par.par_dt_vencimento,
   par.par_dt_baixa,
   par.par_re_valororiginal,
   par.par_re_valorpago,
   par.par_re_valormulta,
   par.par_re_valoratraso,
   par.par_re_valorjuros,
   par.par_re_valorjurosbx,
   par.par_re_valorcorrecao,
   par.par_re_valorcorrecaobx,
   par.par_re_valordesconto,
   par.par_re_valorresiduo,
   par.par_re_valorjurostp,
   par.par_re_valorjurosren,
   par.par_re_valorcorrecao_atr