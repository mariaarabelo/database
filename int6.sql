.mode columns 
.headers on 
.nullvalue NULL 

SELECT Equipa.idequipa, Equipa.nome, ROUND(avg(idade), 2) AS idadeMedia
FROM Equipa, Jogador
WHERE Equipa.idequipa = Jogador.idequipa
GROUP BY Jogador.idequipa
order by 3, 1 ;
