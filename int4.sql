.mode columns 
.headers on 
.nullvalue NULL 

select A.id as idEquipa, A.nome as nomeEquipa,
 round(A.qntGolos*1.0/B.qntJogos,2) as MediaGolosPorJogo

from 
(select equipa.idequipa as id, equipa.nome as nome, count(idevento) as qntGolos
 from jogo, golo, equipa
 where jogo.idjogo = golo.idjogo 
and (equipa.idequipa = jogo.equipacasa or 
equipa.idequipa = jogo.equipavisitante) and 
golo.equipafavor=equipa.idequipa
 group by equipa.idequipa) as A,

 (select equipa.idequipa as id, equipa.nome, count(idJogo) as qntJogos 
 from jogo, equipa
  where (equipa.idequipa = jogo.equipacasa or
   equipa.idequipa = jogo.equipavisitante)
  group by equipa.idequipa) AS B
  
  where A.id = B.id
  order by 3 desc;
