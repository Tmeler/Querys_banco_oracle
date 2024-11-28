 SELECT L.ORG_TAB_IN_CODIGO,
    L.ORG_PAD_IN_CODIGO,
    L.ORG_IN_CODIGO,
    L.ORG_TAU_ST_CODIGO,
    L.LAN_TAB_IN_CODIGO,
    L.LAN_SEQ_IN_CODIGO,
    L.LAN_IN_CODIGO,
    I.ITE_IN_CODIGO,
    I.PLA_TAB_IN_CODIGO,
    I.PLA_PAD_IN_CODIGO,
    I.DEB_IDE_ST_CODIGO,
    I.DEB_IN_REDUZIDO,
    I.LAN_DT_LANCAMENTO,
    I.FIL_IN_CODIGO,
    I.ITE_RE_VALOR,
    0 as valor1
FROM
    construcao.CON_Item_Lancamento@hacasa I,
    construcao.CON_Lancamento@hacasa L
  WHERE L.Org_Tab_In_Codigo  = I.Org_Tab_In_Codigo and
    L.Org_Pad_In_Codigo  = I.Org_Pad_In_Codigo and
    L.Org_In_Codigo      = I.Org_In_Codigo     and
    L.Org_TAu_St_Codigo  = I.Org_TAu_St_Codigo and
    L.Lan_Tab_In_Codigo  = I.Lan_Tab_In_Codigo and
    L.Lan_Seq_In_Codigo  = I.Lan_Seq_In_Codigo and
    L.Lan_In_Codigo      = I.Lan_In_Codigo     and
    L.Lan_Ch_Status      = 'A'                 and
    not (L.Sis_In_Codigo = 4 and
         L.Tla_In_Codigo in (3,5))
UNION
SELECT
    L.ORG_TAB_IN_CODIGO,
    L.ORG_PAD_IN_CODIGO,
    L.ORG_IN_CODIGO,
    L.ORG_TAU_ST_CODIGO,
    L.LAN_TAB_IN_CODIGO,
    L.LAN_SEQ_IN_CODIGO,
    L.LAN_IN_CODIGO,
    I.ITE_IN_CODIGO,
    I.PLA_TAB_IN_CODIGO,
    I.PLA_PAD_IN_CODIGO,
    I.CRE_IDE_ST_CODIGO,
    I.CRE_IN_REDUZIDO,
    I.LAN_DT_LANCAMENTO,
    I.FIL_IN_CODIGO,
    0 as valor2,
    I.ITE_RE_VALOR
FROM
    construcao.CON_Item_Lancamento@hacasa I,
    construcao.CON_Lancamento@hacasa L
WHERE
    L.Org_Tab_In_Codigo  = I.Org_Tab_In_Codigo and
    L.Org_Pad_In_Codigo  = I.Org_Pad_In_Codigo and
    L.Org_In_Codigo      = I.Org_In_Codigo     and
    L.Org_TAu_St_Codigo  = I.Org_TAu_St_Codigo and
    L.Lan_Tab_In_Codigo  = I.Lan_Tab_In_Codigo and
    L.Lan_Seq_In_Codigo  = I.Lan_Seq_In_Codigo and
    L.Lan_In_Codigo      = I.Lan_In_Codigo     and
    L.Lan_Ch_Status      = 'A'                 and
    not (L.Sis_In_Codigo = 4 and
         L.Tla_In_Codigo in (3,5));