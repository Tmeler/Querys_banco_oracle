 SELECT
SM.CTO_IN_CODIGO,
SM.PAR_IN_CODIGO,
SM.AGN_IN_CODIGO,
SM.AGN_ST_NOME,
SM.BLO_IN_CODIGO,
SM.BLO_RE_CUSTOCOM,
SM.BLO_ST_CODIGO,
SM.BLO_ST_NOME,
SM.CALCULAATRASO,
SM.CALCULAMORA,
SM.CND_CH_STATUS,
SM.CND_IN_CODIGO,
SM.CNDIT_IN_CODIGO,
SM.CSF_IN_CODIGO,
SM.CSF_ST_DESCRICAO,
SM.CTC_IN_CODIGO,
SM.CTO_BO_TAXAEMPR,
SM.CTO_CH_CLASSIFICACAO,
SM.CTO_CH_ORIGEM,
SM.CTO_CH_STATUS,
SM.CTO_CH_TIPO,
SM.CTO_CH_TIPOMULTA,
SM.CTO_DS_ORIGEM,
SM.CTO_DS_STATUS,
SM.CTO_DS_TIPO,
SM.CTO_DT_ASSINATURA,
SM.CTO_DT_CADASTRO,
SM.CTO_DT_ENTREGA,
SM.CTO_DT_FINANC,
SM.CTO_DT_IMPORTACAO,
SM.CTO_DT_STATUS,
SM.CTO_DT_ULT_VENCIMENTO,
SM.CTOENV_CH_ORIGEM,
SM.CTO_IN_INDICE,
SM.CTO_NR_MESES_ADIMPLENTE,
SM.CTO_NR_MESES_ASSINATURA,
SM.CTO_NR_MESES_AVENCER,
SM.CTO_RE_GARANTIA,
SM.CTO_RE_JUROS,
SM.CTO_RE_MORA,
SM.CTO_RE_TOTALRESIDUO,
SM.CTO_RE_VALORCONTRATO,
SM.CTO_RE_VALORCONTRATO_ATU,
SM.DATA_BASE,
SM.EMP_ST_NOME,
SM.ENT_DT_ENTREGA,
SM.ESTRUTURA,
SM.ETP_IN_CODIGO,
SM.ETP_ST_CODIGO,
SM.ETP_ST_NOME,
SM.FIL_IN_CODIGO,
SM.FNCGETVALORRESIDUO,
SM.ORG_TAU_ST_CODIGO,
SM.PAR_BO_CONFDIVIDA,
SM.PAR_BO_CONTRATUAL,
SM.PAR_BO_CORRIGEVCTO,
SM.PAR_BO_GERARESIDUO,
SM.PAR_BO_REAJUSTADA,
SM.PAR_BO_RESCOB,
SM.PAR_BO_SELECIONADO,
SM.PAR_BO_TABELAPRICE,
SM.PAR_CH_ORIGEM,
SM.PAR_CH_PARCELA,
SM.PAR_CH_PROCESSO,
SM.PAR_CH_PRORATABX,
SM.PAR_CH_RECEITA,
SM.PAR_CH_RECEITABAIXA,
SM.PAR_DT_BAIXA,
SM.PAR_DT_DEPOSITO,
SM.PAR_DT_DESCONGELA,
SM.PAR_DT_DTVIGENCIA,
SM.PAR_DT_GERACAO,
SM.PAR_DT_MOVIMENTO,
SM.PAR_DT_PROCESSO,
SM.PAR_DT_REAJUSTE,
SM.PAR_DT_REALIZACAOBX,
SM.PAR_DT_STATUS,
SM.PAR_DT_VENCIMENTO,
SM.PAR_IN_CODCTOBANCO,
SM.PAR_IN_CODINDICE,
SM.PAR_IN_CODRENEGSAC,
SM.PAR_IN_CODRENEGTP,
SM.PAR_IN_RECIBO,
SM.PAR_IN_RESIDUO,
SM.PAR_NR_PARCELASATRASO,
SM.PAR_NR_PARCELASVENCER,
SM.PAR_RE_CORATEVCTO,
SM.PAR_RE_CORRECAOATRASO,
SM.PAR_RE_CORRECAOTOTAL AS CORRECAO_PARCELA,
SM.PAR_RE_CORRECAOVCTO,
SM.PAR_RE_CREDITO,
SM.PAR_RE_DIFTAXA,
SM.PAR_RE_JROTPNCOBRADO,
SM.PAR_RE_JUROSTOTAL,
SM.PAR_RE_JUROSVENCTO,
SM.PAR_RE_MORAATRASO AS SIMULA_MORA_VCTO,
SM.PAR_RE_MULTAATRASO AS SIMULA_MULTA_VCTO,
SM.PAR_RE_PAGOCORRIGIDO,
SM.PAR_RE_PARATUALIZADA,
SM.PAR_RE_PARCORRIGIDA AS SIMULA_PARCELA_CORRECAO,
SM.PAR_RE_PARCORRIGIDA_MV AS CORRECAO_SIMULADA,
SM.PAR_RE_PERCVMJUROS,
SM.PAR_RE_RECEB_ATUALIZADO,
SM.PAR_RE_RESIDUOCOBRANCA,
SM.PAR_RE_SALDOQUITACAO,
SM.PAR_RE_TAXAMORA,
SM.PAR_RE_TAXAMULTA,
SM.PAR_RE_TAXASADIC,
SM.PAR_RE_TOTALAPAGAR,
SM.PAR_RE_TX_VLR_PRESENTE,
SM.PAR_RE_VALOR_ATRASO,
SM.PAR_RE_VALORATRASO,
SM.PAR_RE_VALOR_ATRASOCORR,
SM.PAR_RE_VALOR_ATRASOCORRR,
SM.PAR_RE_VALOR_ATRASOENC,
SM.PAR_RE_VALOR_ATRASOENCR,
SM.PAR_RE_VALOR_ATRASOR,
SM.PAR_RE_VALORCORRECAO,
SM.PAR_RE_VALORCORRECAO_ATR,
SM.PAR_RE_VALORCORRECAOBX,
SM.PAR_RE_VALORDESCONTO,
SM.PAR_RE_VALOR_FINANC,
SM.PAR_RE_VALOR_FUTURO,
SM.PAR_RE_VALORJUROS,
SM.PAR_RE_VALORJUROSBX,
SM.PAR_RE_VALORJUROSREN,
SM.PAR_RE_VALORJUROSTP,
SM.PAR_RE_VALORMULTA,
SM.PAR_RE_VALORORIGINAL,
SM.PAR_RE_VALORPAGO,
SM.PAR_RE_VALOR_PRESENTE AS SIMULA_VALOR_PRESENTE,
SM.PAR_RE_VALORRESCOB_AGERAR,
SM.PAR_RE_VALORRESIDUO,
SM.PAR_RE_VALORRESIDUO_CC,
SM.PAR_RE_VALORVENCER,
SM.PAR_RE_VLRPAGO,
SM.PAR_RE_VLR_PRESENTE,
SM.PAR_RE_VLRQUITACAO,
SM.PAR_RE_VLR_SIMULATP,
SM.PAR_ST_AGENCIA,
SM.PAR_ST_CHEQUE,
SM.PAR_ST_CONTA,
SM.PAR_ST_HISTORICO,
SM.PAR_ST_OBS_CLIENTE,
SM.PAR_ST_OBSERVACAO,
SM.PAR_ST_OBSGERACAO,
SM.PAR_ST_OBSPROCESSO,
SM.PAR_ST_REAJUSINDICE,
SM.PAR_ST_RESIDUO,
SM.PRO_IN_REDUZIDO,
SM.PRO_PAD_IN_CODIGO,
SM.PRO_ST_DESCRICAO,
SM.PRO_ST_EXTENSO,
SM.PRO_TAB_IN_CODIGO,
SM.REA_IN_CODIGO,
SM.RESCOB_IN_CODIGO,
SM.TAB_BO_TIPO,
SM.TAB_RE_VALORTOTAL,
SM.TPU_IN_CODIGO,
SM.TPU_ST_DESCRICAO,
SM.TTE_IN_CODIGO,
SM.UND_IN_CODIGO,
SM.UND_RE_AREAPRIVATIVA,
SM.UND_ST_CODIGO,
SM.UND_ST_NOME,
SM.VLRCORRECAO_A,
SM.VLRCORRECAO_A_MESANT,
SM.VLRCORRECAO_A_SYSDATE,
SM.VLRJUROS_A
FROM CONSTRUCAO.CAR_DW_PARCELA@HACASA SM
WHERE SM.PAR_CH_STATUS = 'A' AND --DESCONSIDERA PARCELAS ANTES RENEGOCIAÇÃO
      SM.DW_BO_RECEB is null AND --FILTRO PARA PEGAR PARCELAS GRAVADAS NO BANCO
      SM.PAR_DT_REALIZACAOBX IS NULL --FILTRO PARA PEGAR APENAS PARCELAS EM ABERTO
ORDER BY SM.CTO_IN_CODIGO, SM.par_in_codigo ASC