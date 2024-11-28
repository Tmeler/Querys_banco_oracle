 select -- Proposta
       cnd.org_tab_in_codigo
     , cnd.org_pad_in_codigo
     , cnd.org_in_codigo
     , cnd.org_tau_st_codigo
     , cnd.cnd_in_codigo
     , cnd.fil_in_codigo
     , cnd.cnd_dt_cadastro
     , cnd.cnd_re_valor
     , emp.est_in_codigo as emp_est_in_codigo
     , emp.est_st_codigo as emp_est_st_codigo
     , emp.est_st_nome   as emp_est_st_nome
     , blo.est_in_codigo as blo_est_in_codigo
     , blo.est_st_codigo as blo_est_st_codigo
     , blo.est_st_nome   as blo_est_st_nome
     , etp.est_in_codigo as etp_est_in_codigo
     , etp.est_st_codigo as etp_est_st_codigo
     , etp.est_st_nome   as etp_est_st_nome
     , und.est_in_codigo as und_est_in_codigo
     , und.est_st_codigo as und_est_st_codigo
     , und.est_st_nome   as und_est_st_nome
     , usr.usr_in_codigo
     , usr.usr_st_nome
     , com.com_re_valor
     , com.com_bo_pgto
     , decode(com.com_dt_pgto,null,cnd.cnd_dt_cadastro,com.com_dt_pgto) as com_dt_pgto
     , to_char(to_char(decode(com.com_dt_pgto,null,cnd.cnd_dt_cadastro,com.com_dt_pgto),'dd'))   as com_dt_pgto_dia
     , to_char(to_char(decode(com.com_dt_pgto,null,cnd.cnd_dt_cadastro,com.com_dt_pgto),'mm'))   as com_dt_pgto_mes
     , to_char(to_char(decode(com.com_dt_pgto,null,cnd.cnd_dt_cadastro,com.com_dt_pgto),'yyyy')) as com_dt_pgto_ano
     , agn.agn_tab_in_codigo
     , agn.agn_pad_in_codigo
     , agn.agn_in_codigo
     , agn.agn_st_fantasia
     , agn.agn_st_nome
  from construcao.dbm_condicao@hacasa cnd
 inner join construcao.wglo_usuario@hacasa usr
    on usr.usr_in_codigo     = cnd.usr_in_codigo
 inner join construcao.dbm_condicao_envolvido@hacasa  env
    on env.org_tab_in_codigo = cnd.org_tab_in_codigo
   and env.org_pad_in_codigo = cnd.org_pad_in_codigo
   and env.org_in_codigo     = cnd.org_in_codigo
   and env.org_tau_st_codigo = cnd.org_tau_st_codigo
   and env.cnd_in_codigo     = cnd.cnd_in_codigo
 inner join construcao.dbm_estrutura@hacasa und
    on und.org_tab_in_codigo = env.est_org_tab_in_codigo
   and und.org_pad_in_codigo = env.est_org_pad_in_codigo
   and und.org_in_codigo     = env.est_org_in_codigo
   and und.org_tau_st_codigo = env.org_tau_st_codigo
   and und.est_in_codigo     = env.est_in_codigo
 inner join construcao.dbm_estrutura@hacasa blo
     on blo.org_tab_in_codigo = und.org_tab_in_codigo
    and blo.org_pad_in_codigo = und.org_pad_in_codigo
    and blo.org_in_codigo     = und.org_in_codigo
    and blo.org_tau_st_codigo = und.org_tau_st_codigo
    and blo.est_in_codigo     = und.pai_est_in_codigo
 inner join construcao.dbm_estrutura@hacasa etp
    on etp.org_tab_in_codigo = blo.org_tab_in_codigo
   and etp.org_pad_in_codigo = blo.org_pad_in_codigo
   and etp.org_in_codigo     = blo.org_in_codigo
   and etp.org_tau_st_codigo = blo.org_tau_st_codigo
   and etp.est_in_codigo     = blo.pai_est_in_codigo
 inner join construcao.dbm_estrutura@hacasa emp
    on emp.org_tab_in_codigo = etp.org_tab_in_codigo
   and emp.org_pad_in_codigo = etp.org_pad_in_codigo
   and emp.org_in_codigo     = etp.org_in_codigo
   and emp.org_tau_st_codigo = etp.org_tau_st_codigo
   and emp.est_in_codigo     = etp.pai_est_in_codigo
 inner join (-- Comiss?es a integrar
             select cr.org_tab_in_codigo
                  , cr.org_pad_in_codigo
                  , cr.org_in_codigo
                  , cr.org_tau_st_codigo
                  , cr.cnd_in_codigo
                  , cr.com_re_valor
                  , to_date(null) as com_dt_pgto
                  , nvl(co.com_bo_enviada,'N') as com_bo_pgto
                  , cr.agn_tab_in_codigo
                  , cr.agn_pad_in_codigo
                  , cr.agn_in_codigo
               from construcao.dbm_condicao_responsavel@hacasa cr
               left join construcao.cmr_representante_proposta@hacasa rp
                 on rp.org_tab_in_codigo = cr.org_tab_in_codigo
                and rp.org_pad_in_codigo = cr.org_pad_in_codigo
                and rp.org_in_codigo     = cr.org_in_codigo
                and rp.org_tau_st_codigo = cr.org_tau_st_codigo
                and rp.cnd_in_codigo     = cr.cnd_in_codigo
               left join construcao.cmr_comissao@hacasa co
                 on co.org_tab_in_codigo = rp.org_tab_in_codigo
                and co.org_pad_in_codigo = rp.org_pad_in_codigo
                and co.org_in_codigo     = rp.org_in_codigo
                and co.org_tau_st_codigo = rp.org_tau_st_codigo
                and co.com_in_codigo     = rp.com_in_codigo
              where nvl(cr.com_bo_integra,'N') = 'S'
                and nvl(cr.com_re_valor,0) > 0
              union
             select cr.org_tab_in_codigo
                  , cr.org_pad_in_codigo
                  , cr.org_in_codigo
                  , cr.org_tau_st_codigo
                  , cr.cnd_in_codigo
                  , ra.cra_re_valor as com_re_valor
                  , ra.cra_dt_vencimento as com_dt_pgto
                  , 'S' as com_bo_pgto
                  , cr.agn_tab_in_codigo
                  , cr.agn_pad_in_codigo
                  , cr.agn_in_codigo
               from construcao.dbm_condicao_responsavel@hacasa cr
              inner join construcao.dbm_condicao_rateio@hacasa ra
                 on ra.org_tab_in_codigo = cr.org_tab_in_codigo
                and ra.org_pad_in_codigo = cr.org_pad_in_codigo
                and ra.org_in_codigo     = cr.org_in_codigo
                and ra.org_tau_st_codigo = cr.org_tau_st_codigo
                and ra.agn_tab_in_codigo = cr.agn_tab_in_codigo
                and ra.agn_pad_in_codigo = cr.agn_pad_in_codigo
                and ra.agn_in_codigo     = cr.agn_in_codigo
                and ra.cnd_in_codigo     = cr.cnd_in_codigo
              where nvl(cr.com_bo_deduzcomissao,'N') = 'S'
                and nvl(ra.cra_re_valor,0) > 0
                and ra.anc_ch_tipo = 'P') com
    on com.org_tab_in_codigo = cnd.org_tab_in_codigo
   and com.org_pad_in_codigo = cnd.org_pad_in_codigo
   and com.org_in_codigo     = cnd.org_in_codigo
   and com.org_tau_st_codigo = cnd.org_tau_st_codigo
   and com.cnd_in_codigo     = cnd.cnd_in_codigo
 inner join (select ag.agn_tab_in_codigo
                  , ag.agn_pad_in_codigo
                  , ag.agn_in_codigo
                  , ag.agn_st_fantasia
                  , ag.agn_st_nome
               from construcao.glo_agentes@hacasa ag
              inner join construcao.glo_agentes_id@hacasa ai
                 on ag.agn_tab_in_codigo = ai.agn_tab_in_codigo
                and ag.agn_pad_in_codigo = ai.agn_pad_in_codigo
                and ag.agn_in_codigo     = ai.agn_in_codigo
              where ai.agn_tau_st_codigo = 'R') agn
    on agn.agn_tab_in_codigo = com.agn_tab_in_codigo
   and agn.agn_pad_in_codigo = com.agn_pad_in_codigo
   and agn.agn_in_codigo     = com.agn_in_codigo
 where cnd.cnd_ch_tipo = 'P'          -- Somente propostas
   and cnd.usr_in_codigo is not null  -- Somente propostas do Portal de Vendas
   and cnd.tab_st_codigo is not null  -- Somente propostas do Comercial
   and nvl(emp.est_bo_webcomercial,'N') = 'S'
   and ((cnd.cnd_ch_status = 'A') and (nvl(cnd.cnd_bo_travavenda,'N') = 'S')
    or  (cnd.cnd_ch_status in ('L','G')))