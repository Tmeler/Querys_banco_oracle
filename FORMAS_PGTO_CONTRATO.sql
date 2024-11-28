  SELECT DISTINCT
X.ORGANIZ
,X.FILIAL --||' - '||AG.AGN_ST_FANTASIA FILIAL
,Y.EMP_ST_CODIGO EMPREED
,X.EMPREEND "NOME EMPREENDIMENTO"
,X.BLOCO
,X.UNIDADE
,Y.UND_RE_AREAPRIVATIVA "AREA PRIVATIVA"
,X.CONTRATO
,MAX(Y.AGN_IN_CODIGO||' - '||X.CLIENTE) CLIENTE
--,MAX(TA.AGN_ST_CNPJCPF) "CNPJ / CPF"
,MAX(UPPER(TA.AGN_ST_LOGRADOURO||','||TA.AGN_ST_NUMERO||' - '||TA.AGN_ST_COMPLEMENTO||' - '|| TA.AGN_ST_BAIRRO||' - '||TA.AGN_ST_MUNICIPIO||' - '||TA.UF_ST_SIGLA||' - '||TA.AGN_ST_CEP)) "ENDEREÇO"
--,max(TEL.TEA_ST_TELEFONE) TELEFONE
,max(CL.AGN_ST_EMAIL) "E-MAIL"
,max(X.dt_chave) dt_chave
,max(X.valor_financ) valor_financ
,max(X.vlr_rec_atualiz) vlr_rec_atualiz
,max(X.sdo_ate_chav) sdo_ate_chav
,max(X.vlr_chaves) vlr_chaves
,max(X.vlr_pos_chave) vlr_pos_chave
,X.emp_in_codigo
--,max(X.chv_empreend+X.sdo_ate_chav+X.vlr_pos_chave+X.vlr_chaves+X.valor_financ+X.vlr_rec_atualiz) "TOTAL GERAL"
--,max(X.chv_empreend) "COD_BLOCO"
FROM
(
select distinct --1.vlr_rec_atualiz
a.org_in_codigo ORGANIZ
,a.fil_in_codigo FILIAL
,a.emp_st_codigo
,a.emp_st_nome EMPREEND
,a.blo_st_codigo BLOCO
,a.cto_in_codigo CONTRATO
,a.und_st_codigo UNIDADE
,a.agn_st_nome CLIENTE
--,a.EMP_ST_CODIGO
,max(a.cto_dt_entrega) dt_chave
,sum(nvl(a.par_re_paratualizada,0)) vlr_rec_atualiz
,0 vlr_pos_chave
,0 valor_financ --
,0 sdo_ate_chav   --max(a1.sdo_ate_chav)
,0 vlr_chaves
,a.emp_in_codigo
from construcao.car_dw_parcela@hacasa a
where --1.vlr_rec_atualiz
      --a.org_in_codigo not in (98,99,100,101)
      a.dw_bo_receb is null
and   a.par_dt_baixa is not null
and   a.cto_ch_status     <> 'Q'
and   a.estrutura         <> 'G'
--and   a.org_in_codigo = 33
--and   a.cto_in_codigo = 1558
--and   a.und_st_codigo = '0301'
group by
a.org_in_codigo
,a.fil_in_codigo
,a.emp_st_nome
,a.blo_st_codigo
,a.cto_in_codigo
,a.und_st_codigo
,a.agn_st_nome
,a.EMP_ST_CODIGO
,a.emp_in_codigo
--order by a.cto_in_codigo


union all

select distinct --2.valor_financ
b.org_in_codigo ORGANIZ
,b.fil_in_codigo FILIAL
,b.emp_st_codigo
,b.emp_st_nome EMPREEND
,b.blo_st_codigo BLOCO
,b.cto_in_codigo CONTRATO
,b.und_st_codigo UNIDADE
,b.agn_st_nome CLIENTE
--,b.blo_in_codigo chv_empreend
,max(trunc(b.cto_dt_entrega)) dt_chave
,0 vlr_rec_atualiz
,0 vlr_pos_chave
,max(nvl(b.par_re_valor_financ,0)) valor_financ
,0 sdo_ate_chav
,0 vlr_chaves
,b.emp_in_codigo
from construcao.car_dw_parcela@hacasa b
where --2.valor_financ
      --b.org_in_codigo not in (98,99,100,101)
      b.dw_bo_receb is null
and   b.par_dt_baixa is null
--and   b.par_dt_vencimento = trunc(b.cto_dt_entrega)
and   b.par_ch_receita in ('F','I')
and   b.cto_ch_status     <> 'Q'
and   b.estrutura         <> 'G'
--and   b.org_in_codigo = 33
--and   b.cto_in_codigo = 1558
group by
b.org_in_codigo
,b.fil_in_codigo
,b.emp_st_codigo
,b.emp_st_nome
,b.blo_st_codigo
,b.und_st_codigo
,b.cto_in_codigo
,b.agn_st_nome
,b.blo_in_codigo
,b.emp_in_codigo
--order by b.cto_in_codigo

union all

select distinct --3.vlr_chaves
c.org_in_codigo ORGANIZ
,c.fil_in_codigo FILIAL
,c.emp_st_codigo
,c.emp_st_nome EMPREEND
,c.blo_st_codigo BLOCO
,c.cto_in_codigo CONTRATO
,c.und_st_codigo UNIDADE
,c.agn_st_nome CLIENTE
--,c.blo_in_codigo chv_empreend
,max(trunc(c.cto_dt_entrega)) dt_chave
,0 vlr_rec_atualiz
,0 vlr_pos_chave
,0 valor_financ --*
,0 sdo_ate_chav
,sum(nvl(c.par_re_paratualizada,0))  vlr_chaves
,c.emp_in_codigo
from construcao.car_dw_parcela@hacasa c
where --3.vlr_chaves
      --c.org_in_codigo not in (98,99,100,101)
       c.dw_bo_receb is null
--and   to_char(b.par_dt_vencimento,'MM/YYYY') = to_char(b.cto_dt_entrega,'MM/YYYY')
and   c.par_dt_vencimento = c.cto_dt_entrega --15-06-22 
and   c.par_dt_baixa is null
and   c.par_ch_receita in ('C')
and   c.par_ch_parcela in  ('C','M')
and   c.cto_ch_status     <> 'Q'
and   c.estrutura         <> 'G'
--and   b.org_in_codigo = 33
--and   c.cto_in_codigo = 1558
group by
c.org_in_codigo
,c.fil_in_codigo
,c.emp_st_codigo
,c.emp_st_nome
,c.blo_st_codigo
,c.und_st_codigo
,c.cto_in_codigo
,c.agn_st_nome
,c.blo_in_codigo
,c.emp_in_codigo
--order by b.cto_in_codigo

union all

select distinct ----4.sdo_ate_chav
d.org_in_codigo ORGANIZ
,d.fil_in_codigo FILIAL
,d.emp_st_codigo
,d.emp_st_nome EMPREEND
,d.blo_st_codigo BLOCO
,d.cto_in_codigo CONTRATO
,d.und_st_codigo UNIDADE
,d.agn_st_nome CLIENTE
,max(d.cto_dt_entrega) dt_chave
,0 vlr_rec_atualiz
,0 vlr_pos_chave
,0 valor_financ
,sum(nvl(d.par_re_paratualizada,0)) sdo_ate_chav
,0 vlr_chaves
,d.emp_in_codigo
from construcao.car_dw_parcela@hacasa d
where ----4.vlr_ate_chaves = sdo_ate_chav
   --   d.org_in_codigo not in (98,99,100,101)
      d.dw_bo_receb is null
and   d.par_dt_vencimento <= last_day(trunc(d.cto_dt_entrega))
and   d.par_dt_baixa is null
and   d.par_ch_receita in ('C')
and   d.par_ch_parcela in  ('M','I')
and   d.cto_ch_status     <> 'Q'
and   d.estrutura         <> 'G'
--and   b.org_in_codigo = 33
--and   d.cto_in_codigo = 1558
group by
d.org_in_codigo
,d.fil_in_codigo
,d.emp_st_codigo
,d.emp_st_nome
,d.blo_st_codigo
,d.und_st_codigo
,d.cto_in_codigo
,d.agn_st_nome
,d.blo_in_codigo
,d.emp_in_codigo
--order by b.cto_in_codigo

union all

select distinct --5.vlr_pos_chaves
e.org_in_codigo ORGANIZ
,e.fil_in_codigo FILIAL
,e.emp_st_codigo
,e.emp_st_nome EMPREEND
,e.blo_st_codigo BLOCO
,e.cto_in_codigo CONTRATO
,e.und_st_codigo UNIDADE
,e.agn_st_nome CLIENTE
,max(e.cto_dt_entrega) dt_chave
,0 vlr_rec_atualiz
,sum(nvl(e.par_re_paratualizada,0)) vlr_pos_chave
,0 valor_financ
,0 sdo_ate_chav
,0 vlr_chaves
,e.emp_in_codigo
from construcao.car_dw_parcela@hacasa e
where --5.vlr_pos_chaves
    --  e.org_in_codigo not in (98,99,100,101)
--and   b.org_in_codigo = 33
      e.dw_bo_receb is null
and   e.par_dt_vencimento > last_day(trunc(e.cto_dt_entrega))
and   e.par_dt_baixa is null
and   e.par_ch_receita in ('C')
and   e.par_ch_parcela in ('M','I')
and   e.cto_ch_status     <> 'Q'
and   e.estrutura         <> 'G'
--and   e.cto_in_codigo = 1558
group by
e.cto_in_codigo
,e.org_in_codigo
,e.fil_in_codigo
,e.emp_st_codigo
,e.emp_st_nome
,e.blo_st_codigo
,e.und_st_codigo
,e.agn_st_nome
,e.blo_in_codigo
,e.emp_in_codigo

) X
,CONSTRUCAO.CAR_DW_PARCELA@HACASA Y,CONSTRUCAO.GLO_AGENTES@HACASA AG,CONSTRUCAO.GLO_VW_TODOSAGENTESCNPJCPF@HACASA TA,CONSTRUCAO.GLO_TEL_AGENTES@HACASA TEL
,CONSTRUCAO.CAR_VW_CLIENTES_ASC@HACASA CL
WHERE  Y.dw_bo_receb is null
AND    Y.ORG_IN_CODIGO(+) = X.ORGANIZ
AND    Y.CTO_IN_CODIGO(+) = X.CONTRATO
AND    AG.AGN_IN_CODIGO(+) = Y.FIL_IN_CODIGO
AND    TA.AGN_IN_CODIGO(+) = Y.AGN_IN_CODIGO
AND    TEL.AGN_IN_CODIGO(+) = Y.AGN_IN_CODIGO
AND    CL.agn_in_codigo(+)  = Y.AGN_IN_CODIGO
--and    X.ORGANIZ         = 33
--AND    X.CONTRATO = 2189
--AND    X.UNIDADE = '0101'
--AND    X.BLOCO = 'TORRE A'
group by
X.CONTRATO
,X.ORGANIZ
,X.FILIAL
,Y.EMP_ST_CODIGO
,X.EMPREEND
,X.BLOCO
,X.UNIDADE
,Y.UND_RE_AREAPRIVATIVA
,X.CONTRATO
,Y.AGN_IN_CODIGO||' - '||X.CLIENTE
,TA.AGN_ST_CNPJCPF
,UPPER(TA.AGN_ST_LOGRADOURO||','||TA.AGN_ST_NUMERO||' - '||TA.AGN_ST_COMPLEMENTO||' - '|| TA.AGN_ST_BAIRRO||' - '||TA.AGN_ST_MUNICIPIO||' - '||TA.UF_ST_SIGLA||' - '||TA.AGN_ST_CEP)
,TEL.TEA_ST_TELEFONE
,CL.AGN_ST_EMAIL
,X.emp_in_codigo
ORDER BY
X.EMPREEND
,X.BLOCO
,X.UNIDADE