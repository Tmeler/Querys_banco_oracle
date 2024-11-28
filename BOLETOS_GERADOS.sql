select     --pd.org_in_codigo,
           --dfi.fil_in_codigo,
           pd.cto_in_codigo,
           pd.par_in_codigo,
           pd.par_ch_statusenvio,
           pd.hcon_in_sequencia,
           pd.hcob_in_sequencia,
           pd.par_re_tarifabanco,
           pd.par_re_vlrpago,
           pd.par_st_motivo1,
           pd.par_st_motivo2,
           pd.par_st_motivo3,
           pd.par_st_motivo4,
           pd.par_st_motivo5,
           mfi.dfi_in_codigo,
           mfi.mfi_in_codigo,
           mfi.mfi_dt_envio,
           mfi.mfi_st_anonossonumbanc,
           mfi.mfi_st_linhadig,
           mfi.mfi_st_codigobarra,
           mfi.mfi_in_numerohbk,
           dfi.bol_in_codigo,
           mfi.mfi_re_valor,
           mfi.mfi_dt_vencimento,
           mfi.mfi_st_descricao,
           mfi.mfi_st_parcela,
           mfi.mfi_st_nossonumero,
           mfi.mfi_re_jurosmora,
           mfi.mfi_re_jurosmulta,
           mfi.mfi_dt_dtbasemulta,
           mfi.mfi_re_jurosbx,
           mfi.mfi_re_correcaobx,
           mfi.mfi_bo_indprojetado,
           mfi.mfi_re_residuo_ind_cobrado,
           mfi.mfi_re_valorbase,
           mfi.mfi_in_carenciaatraso,
           mfi.mfi_re_correcaodiaria,
           mfi.mfi_re_vmatraso,
           mfi.mfi_bo_vltaxencargos

      from CONSTRUCAO.Mlog$_Car_Parcela_Destino@HACASA  pd,
           CONSTRUCAO.Mlog$_Car_Movimento_Financeiro@HACASA mfi,
           CONSTRUCAO.Mlog$_Car_Documento_Financeiro@HACASA dfi
     where dfi.dfi_in_codigo = mfi.dfi_in_codigo
       and dfi.org_tab_in_codigo = pd.org_tab_in_codigo
       and dfi.org_pad_in_codigo = pd.org_pad_in_codigo
       and dfi.org_in_codigo = pd.org_in_codigo
       and dfi.org_tau_st_codigo = pd.org_tau_st_codigo
       and dfi.cto_in_codigo = pd.cto_in_codigo
       and dfi.par_in_codigo = pd.par_in_codigo;