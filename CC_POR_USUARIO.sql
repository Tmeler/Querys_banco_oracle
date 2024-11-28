  SELECT
          u.gru_in_codigo,
          u.gru_st_nome,
          u.gru_ch_status,
          p.cus_in_reduzido,
          p.cus_st_extenso,
          p.cus_st_descricao,
          p.cus_dt_limite
  FROM construcao.CON_CCUSTO_usuario@hacasa pu,
       construcao.CON_CENTRO_CUSTO@hacasa p,
       construcao.glo_grupo_usuario@hacasa u
 WHERE u.gru_in_codigo     = pu.gru_in_codigo
      AND p.cus_tab_in_codigo     = pu.cus_tab_in_codigo 
      AND p.cus_pad_in_codigo     = pu.cus_pad_in_codigo
      AND p.cus_ide_st_codigo     = pu.cus_ide_st_codigo
      AND p.cus_in_reduzido     = pu.cus_in_reduzido
      AND pu.cus_in_reduzido     = p.cus_in_reduzido (+)
      AND p.cus_bo_global = 'N'