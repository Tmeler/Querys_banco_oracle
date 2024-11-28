  select ct.CTO_IN_CODIGO,
       ct.CTO_RE_VALORCONTRATO,
       CT.AGN_ST_NOME AS CLIENTE,
       CT.EMP_NOME,
       SD.CAS_DT_ALTERACAR
from construcao.car_vw_contrato@hacasa ct,
     CONSTRUCAO.CAR_CONTRATO_ATUSALDO@HACASA SD

WHERE CT.ORG_TAB_IN_CODIGO = CT.ORG_TAB_IN_CODIGO and
      CT.ORG_pad_IN_CODIGO = sd.ORG_pad_IN_CODIGO and
      CT.ORG_IN_CODIGO     = sd.ORG_IN_CODIGO and
      CT.ORG_tau_st_CODIGO = sd.ORG_tau_st_CODIGO and
      CT.CTO_IN_CODIGO     = sd.CTO_IN_CODIGO
order by SD.CAS_DT_ALTERACAR desc