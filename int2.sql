.mode columns 
.headers on 
.nullvalue NULL 

SELECT Jogador.idjogador, Jogador.nome, Equipa.nome, COUNT(*) AS golos
FROM Jogador, Equipa, Golo
WHERE Jogador.idequipa = Equipa.idequipa AND Golo.equipafavor = Equipa.idequipa AND Golo.idjogador = Jogador.idjogador
GROUP BY Jogador.idjogador
HAVING jogador.idequipa = Golo.equipafavor
ORDER BY 4 DESC, 2
LIMIT 10;
