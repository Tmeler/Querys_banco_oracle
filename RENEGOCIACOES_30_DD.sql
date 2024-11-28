  SELECT
   SM.CTO_IN_CODIGO,
   SM.PAR_ST_HISTORICO,
   SM.PAR_ST_OBSERVACAO,
   SM.PAR_ST_OBSGERACAO,
   SM.AGN_ST_NOME,
   SM.EMP_ST_NOME,
   SM.PAR_DT_GERACAO,
   SM.PAR_DT_VENCIMENTO, -- Agrupa pela data de vencimento
   SUM(SM.PAR_RE_PARATUALIZADA) AS SOMA_PAR_RE_PARATUALIZADA -- Soma os valores para cada data
FROM
   CONSTRUCAO.CAR_DW_PARCELA@HACASA SM
WHERE
   SM.PAR_CH_STATUS = 'A'
   AND SM.DW_BO_RECEB IS NULL
   AND SM.PAR_DT_REALIZACAOBX IS NULL
   AND SM.PAR_DT_GERACAO >= TRUNC(SYSDATE - 30) -- Considera os últimos 30 dias
   AND SM.PAR_ST_HISTORICO LIKE '%Reneg%'
GROUP BY
   SM.CTO_IN_CODIGO,
   SM.PAR_ST_HISTORICO,
   SM.PAR_ST_OBSERVACAO,
   SM.PAR_ST_OBSGERACAO,
   SM.PRO_ST_DESCRICAO,
   SM.AGN_IN_CODIGO,
   SM.AGN_ST_NOME,
   SM.EMP_ST_NOME,
   SM.PAR_RE_CORRECAOTOTAL,
   SM.FIL_IN_CODIGO,
   SM.PAR_DT_GERACAO,
   SM.PAR_DT_VENCIMENTO
ORDER BY
   SM.PAR_DT_GERACAO DESC