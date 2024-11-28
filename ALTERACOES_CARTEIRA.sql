 select LOG_ST_TEXTO, LOG_ST_USUARIO, LOG_DT_GERACAO
from construcao.dbm_log@hacasa
where LOG_ST_MODULO = 'CARTEIRA'
order BY LOG_DT_GERACAO desc