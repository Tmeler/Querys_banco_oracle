 select cto.fil_in_codigo,
       cto.filial,
       cto.emp_nome,
       cto.agn_st_nome,
       cto.cto_in_codigo,
       cto.und_st_codigo,
       t.tte_in_codigo,
       t.tte_st_descricao,
       par.par_in_codigo,
       p.par_st_observacao,
       par.par_ch_parcela,
       par.par_dt_vencimento,
       par.par_dt_baixa,
       par.par_re_valororiginal,
       par.par_re_valorpago,
       tx.ptx_re_valor,
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
   par.par_dt_vencimento BETWEEN  '01/01/2019' AND  '31/12/2025' and


   par.org_tab_in_codigo = p.org_tab_in_codigo and
   par.org_pad_in_codigo = p.org_pad_in_codigo AND
   par.org_in_codigo     = p.org_in_codigo     and
   par.cto_in_codigo     = p.cto_in_codigo     and
   par.par_in_codigo     = p.par_in_codigo