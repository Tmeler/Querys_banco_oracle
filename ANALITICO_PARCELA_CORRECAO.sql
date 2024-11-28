select cto.fil_in_codigo,
       cto.filial as COD_FILIAL,
       cto.emp_nome AS EMPREENDIMENTO,
       cto.agn_st_nome AS CLIENTE,
         DECODE(UPPER(CTO.CTO_CH_TIPO),
              'P', 'PERMUTA',
              'V', 'VENDA',
              'M', 'ALUGUEL',
              'OUTRO') AS CTO_CH_TIPO,
       cto.cto_in_codigo AS NUM_CONTRATO,
       cto.und_st_codigo,
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
       par.par_ch_parcela,
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
	   DECODE(UPPER(COR.PARCOR_IN_INDICE),
              '0', 'Moeda Corrente',
              '2', 'IGP-M',
              '3', 'SALARIO MINIMO',
              '4', 'INCC',
              '92', 'INCC-DI',
              '93', 'INPC',
			  '94', 'IPCA',
			  '95', 'CUB',
			  '96', 'CUB $',
              'SEM CORREÇÃO') AS CORREÇÃO_PARCELA,
		COR.PARCOR_DT_VIGENCIA,
        COR.PARCOR_IN_DEFASAGEM		
from construcao.car_vw_contrato@hacasa cto,
     construcao.car_contrato@hacasa c,
     construcao.car_parcela@hacasa par,
     construcao.car_parcelataxa@hacasa tx,
     construcao.car_parcela_observacao@hacasa p,
     construcao.car_contrato_termo@hacasa ter,
     construcao.car_tipo_termo@hacasa t,
	 construcao.CAR_PARCELA_CORRECAO@hacasa COR
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
   --cto.cto_ch_status not in ('D','T') and TAREFA 209142: CONSIDERAR NA VIEW RECEITA DE CONTRATOS DISTRATADOS
   par.par_dt_vencimento BETWEEN ADD_MONTHS(TO_DATE(CURRENT_DATE),-120) AND ADD_MONTHS(TO_DATE(CURRENT_DATE),360) and
   par.org_tab_in_codigo = p.org_tab_in_codigo and
   par.org_pad_in_codigo = p.org_pad_in_codigo AND
   par.org_in_codigo     = p.org_in_codigo     and
   par.cto_in_codigo     = p.cto_in_codigo     and
   par.par_in_codigo     = p.par_in_codigo     AND
   par.org_pad_in_codigo = COR.org_pad_in_codigo (+) AND
   par.org_in_codigo     = COR.org_in_codigo (+) AND
   par.org_tau_st_codigo = COR.org_tau_st_codigo (+) AND
   par.cto_in_codigo     = COR.cto_in_codigo (+) and
   par.par_in_codigo     = COR.par_in_codigo (+) and
   PAR.PAR_CH_STATUS = 'A';