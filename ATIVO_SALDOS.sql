SELECT S.SLD_IN_SEQUENCIAL SLD_IN_SEQUENCIAL
      ,S.CRI_IN_CODIGO CRI_IN_CODIGO
      ,S.SLD_DT_DIA SLD_DT_DIA
      ,S.ORG_TAB_IN_CODIGO ORG_TAB_IN_CODIGO
      ,S.ORG_PAD_IN_CODIGO ORG_PAD_IN_CODIGO
      ,S.ORG_IN_CODIGO ORG_IN_CODIGO
      ,S.ORG_TAU_ST_CODIGO ORG_TAU_ST_CODIGO
      ,S.GRU_IN_SEQUENCIAL GRU_IN_SEQUENCIAL
      ,S.PATR_IN_SEQUENCIAL PATR_IN_SEQUENCIAL
      ,S.CUS_TAB_IN_CODIGO CUS_TAB_IN_CODIGO
      ,S.CUS_PAD_IN_CODIGO CUS_PAD_IN_CODIGO
      ,S.CUS_IDE_ST_CODIGO CUS_IDE_ST_CODIGO
      ,S.CUS_IN_REDUZIDO CUS_IN_REDUZIDO
      ,S.PRO_TAB_IN_CODIGO PRO_TAB_IN_CODIGO
      ,S.PRO_PAD_IN_CODIGO PRO_PAD_IN_CODIGO
      ,S.PRO_IDE_ST_CODIGO PRO_IDE_ST_CODIGO
      ,S.PRO_IN_REDUZIDO PRO_IN_REDUZIDO
      ,S.SLD_RE_AQUISICAO SLD_RE_AQUISICAO
      ,S.SLD_RE_CORRECAO SLD_RE_CORRECAO
      ,S.SLD_RE_DEPRECIACAO SLD_RE_DEPRECIACAO
      ,S.SLD_RE_CORRDEP SLD_RE_CORRDEP
      ,S.SLD_RE_BAIXA SLD_RE_BAIXA
      ,S.SLD_RE_BAIXADEP SLD_RE_BAIXADEP
      ,S.SLD_RE_SALDOATUAL SLD_RE_SALDOATUAL
      ,S.SLD_RE_LUCRO SLD_RE_LUCRO
      ,S.SLD_RE_PREJUIZO SLD_RE_PREJUIZO
      ,C.CUS_ST_EXTENSO CUS_ST_EXTENSO
      ,C.CUS_CH_TIPO_CONTA CUS_CH_TIPO_CONTA
      ,C.CUS_ST_DESCRICAO CUS_ST_DESCRICAO
      ,C.CUS_ST_APELIDO CUS_ST_APELIDO
      ,P.PRO_ST_EXTENSO PRO_ST_EXTENSO
      ,P.PRO_ST_APELIDO PRO_ST_APELIDO
      ,P.PRO_CH_ANASIN PRO_CH_ANASIN
      ,P.PRO_ST_DESCRICAO PRO_ST_DESCRICAO
      ,G.GRU_ST_EXTENSO GRU_ST_EXTENSO
      ,G.GRU_ST_APELIDO GRU_ST_APELIDO
      ,G.GRU_CH_TIPO_CONTA GRU_CH_TIPO_CONTA
      ,G.GRU_ST_DESCRICAO GRU_ST_DESCRICAO
      ,G.GRU_TAB_IN_CODIGO GRU_TAB_IN_CODIGO
      ,G.GRU_PAD_IN_CODIGO GRU_PAD_IN_CODIGO
      ,G.GRU_IDE_ST_CODIGO GRU_IDE_ST_CODIGO
      ,G.GRU_IN_REDUZIDO GRU_IN_REDUZIDO
      ,I.PATR_ST_EXTENSO PATR_ST_EXTENSO
      ,I.PATR_ST_DESCRICAO PATR_ST_DESCRICAO
      ,S.SLD_RE_SALDOCORR SLD_RE_SALDOCORR
      ,S.SLD_RE_SALDODEP SLD_RE_SALDODEP
      ,S.SLD_RE_SALDOATUALDEP SLD_RE_SALDOATUALDEP
      ,S.SLD_RE_TRANSFERENCIA SLD_RE_TRANSFERENCIA
      ,S.SLD_RE_TRANSFERENCIADEP SLD_RE_TRANSFERENCIADEP
      ,S.SLD_RE_TRANSFERENCIAFIL SLD_RE_TRANSFERENCIAFIL
      ,S.SLD_RE_TRANSFERENCIADEPFIL SLD_RE_TRANSFERENCIADEPFIL
      ,S.SLD_RE_RESIDUAL
      ,S.SLD_RE_DEPRECIACAOAAP
      ,S.SLD_RE_SALDOATUALDEPAAP
      ,S.SLD_RE_SALDOATUALAAP
      ,S.SLD_RE_BAIXAAAP
      ,S.SLD_RE_BAIXADEPAAP
      ,S.SLD_RE_TRANSFERENCIAAAP
      ,S.SLD_RE_TRANSFERENCIADEPAAP
      ,S.SLD_RE_TRANSFERENCIAFILAAP
      ,S.SLD_RE_TRANSFERENCIADEPFILAAP
      ,S.SLD_RE_SALDOAAP
  FROM CONSTRUCAO.ATI_SALDOS@HACASA S
      ,CONSTRUCAO.CON_CENTRO_CUSTO@HACASA C
      ,CONSTRUCAO.GLO_PROJETOS@HACASA P
      ,CONSTRUCAO.ATI_GRUPOPATR@HACASA G
      ,CONSTRUCAO.ATI_ITEMPATRIMONIO@HACASA I
 WHERE S.GRU_IN_SEQUENCIAL = G.GRU_IN_SEQUENCIAL
   AND S.CUS_TAB_IN_CODIGO = C.CUS_TAB_IN_CODIGO
   AND S.CUS_PAD_IN_CODIGO = C.CUS_PAD_IN_CODIGO
   AND S.CUS_IDE_ST_CODIGO = C.CUS_IDE_ST_CODIGO
   AND S.CUS_IN_REDUZIDO   = C.CUS_IN_REDUZIDO
   AND S.PRO_TAB_IN_CODIGO = P.PRO_TAB_IN_CODIGO
   AND S.PRO_PAD_IN_CODIGO = P.PRO_PAD_IN_CODIGO
   AND S.PRO_IDE_ST_CODIGO = P.PRO_IDE_ST_CODIGO
   AND S.PRO_IN_REDUZIDO   = P.PRO_IN_REDUZIDO
   AND S.PATR_IN_SEQUENCIAL = I.PATR_IN_SEQUENCIAL