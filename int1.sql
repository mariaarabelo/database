.mode columns 
.headers on 
.nullvalue NULL 

select idJogador, j.nome as nome, numeroCamisola, nacionalidade
from jogador as j, equipa
where j.idEquipa = equipa.idEquipa and equipa.nome = "Benfica"
order by 3, 1;
