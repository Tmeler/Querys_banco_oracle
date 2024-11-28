  select pr.pro_in_codigo as COD_ITEM,
       pr.pro_st_codreal,
       pr.pro_st_descricao,
       cl.tpc_st_classe
from construcao.est_produtos@hacasa pr,
     construcao.est_produtoclasse@hacasa cl
where pr.pro_tab_in_codigo = cl.pro_tab_in_codigo and
       pr.pro_pad_in_codigo = cl.pro_pad_in_codigo and
       pr.pro_in_codigo = cl.pro_in_codigo and
       pr.apl_in_codigo = cl.apl_in_codigo