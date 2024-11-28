 SELECT
       count(*) TOT_ITENS_AGRUPADOS,  T.PRO_IN_REDUZIDO, T.PRO_ST_DESCRICAO DESC_PROJETO,
       I.ORG_TAB_IN_CODIGO, I.ORG_PAD_IN_CODIGO, I.ORG_IN_CODIGO, I.ORG_TAU_ST_CODIGO, S.FIL_IN_CODIGO,
       I.PRO_TAB_IN_CODIGO, I.PRO_PAD_IN_CODIGO, I.PRO_IN_CODIGO,
       P.PRO_ST_ALTERNATIVO,
       sum(i.soi_re_qtnecessidade) TOTAL_SOI_RE_QTNECESSIDADE,
       sum(I.SOI_RE_QUANTIDADE) TOTAL_SOI_RE_QUANTIDADE,
       SUM(I.SOI_RE_QUANTIDADESOL) TOTAL_SOI_RE_QTDECONVERTIDA,
       I.SOI_CH_STATUS,
       I.COT_SER_TAB_IN_CODIGO, I.COT_SER_IN_SEQUENCIA, I.COT_IN_CODIGO, I.COI_IN_CODIGO,
       I.UNI_TAB_IN_CODIGO, I.UNI_PAD_IN_CODIGO, I.UNI_ST_UNIDADE,
       sum(I.SOI_RE_QUANTIDADESOL) TOTAL_SOI_RE_QUANTIDADESOL
       FROM construcao.Est_ItensSoli@hacasa I,
            construcao.Est_Solicitacao@hacasa S,
            construcao.Est_Produtos@hacasa P,
            construcao.est_solicitacaoproj@hacasa J,
            construcao.GLO_PROJETOS@hacasa T
       WHERE I.ORG_TAB_IN_CODIGO = S.ORG_TAB_IN_CODIGO AND
             I.ORG_PAD_IN_CODIGO = S.ORG_PAD_IN_CODIGO AND
             I.ORG_IN_CODIGO     = S.ORG_IN_CODIGO     AND
             I.ORG_TAU_ST_CODIGO = S.ORG_TAU_ST_CODIGO AND
             I.SER_TAB_IN_CODIGO = S.SER_TAB_IN_CODIGO AND
             I.SER_IN_SEQUENCIA  = S.SER_IN_SEQUENCIA  AND
             I.SOL_IN_CODIGO     = S.SOL_IN_CODIGO     AND
             I.PRO_TAB_IN_CODIGO = P.PRO_TAB_IN_CODIGO AND
             I.PRO_PAD_IN_CODIGO = P.PRO_PAD_IN_CODIGO AND
             I.PRO_IN_CODIGO     = P.PRO_IN_CODIGO     AND
             I.ORG_TAB_IN_CODIGO = J.ORG_TAB_IN_CODIGO AND
             I.ORG_PAD_IN_CODIGO = J.ORG_PAD_IN_CODIGO AND
             I.ORG_IN_CODIGO     = J.ORG_IN_CODIGO     AND
             I.ORG_TAU_ST_CODIGO = J.ORG_TAU_ST_CODIGO AND
             I.SER_TAB_IN_CODIGO = J.SER_TAB_IN_CODIGO AND
             I.SER_IN_SEQUENCIA  = J.SER_IN_SEQUENCIA  AND
             I.SOL_IN_CODIGO     = J.SOL_IN_CODIGO     AND
             I.SOI_IN_CODIGO     = J.SOI_IN_CODIGO     AND
             J.PROJ_TAB_IN_CODIGO = T.PRO_TAB_IN_CODIGO AND
             J.PROJ_PAD_IN_CODIGO = T.PRO_PAD_IN_CODIGO AND
             J.PROJ_IDE_ST_CODIGO = T.PRO_IDE_ST_CODIGO AND
             J.PROJ_IN_REDUZIDO   = T.PRO_IN_REDUZIDO
group by
       T.PRO_IN_REDUZIDO, T.PRO_ST_DESCRICAO,
       I.ORG_TAB_IN_CODIGO, I.ORG_PAD_IN_CODIGO, I.ORG_IN_CODIGO, I.ORG_TAU_ST_CODIGO, S.FIL_IN_CODIGO,
       I.PRO_TAB_IN_CODIGO, I.PRO_PAD_IN_CODIGO, I.PRO_IN_CODIGO,
       P.PRO_ST_ALTERNATIVO,
       I.SOI_CH_STATUS,
       I.COT_SER_TAB_IN_CODIGO, I.COT_SER_IN_SEQUENCIA, I.COT_IN_CODIGO, I.COI_IN_CODIGO,
       I.UNI_TAB_IN_CODIGO, I.UNI_PAD_IN_CODIGO, I.UNI_ST_UNIDADE
ORDER BY
I.ORG_IN_CODIGO, I.PRO_IN_CODIGO