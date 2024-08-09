.mode columns 
.headers on 
.nullvalue NULL

SELECT Equipa.idequipa, Equipa.nome, vitorias, empates, derrotas
FROM Equipa, (SELECT Equipa.idequipa, COUNT(*) as vitorias
              FROM Equipa, Jogo
              WHERE Jogo.equipavencedora = Equipa.idequipa
              GROUP BY Equipa.idequipa) V,
             (SELECT Equipa.idequipa, COUNT(*) as empates
              FROM Equipa, Jogo
              WHERE Jogo.equipavencedora IS NULL AND (Equipa.idequipa = Jogo.equipacasa OR Equipa.idequipa = Jogo.equipavisitante)
              GROUP BY Equipa.idequipa) E,
             (SELECT Equipa.idequipa, COUNT(*) as derrotas
              FROM Equipa, Jogo
              WHERE (Equipa.idequipa = Jogo.equipacasa AND Jogo.equipavencedora = Jogo.equipavisitante) OR (Equipa.idequipa = Jogo.equipavisitante AND Jogo.equipavencedora = Jogo.equipacasa)
              GROUP BY Equipa.idequipa) D
WHERE Equipa.idequipa = V.idequipa AND Equipa.idequipa = E.idequipa AND Equipa.idequipa = D.idequipa
ORDER BY 3 DESC, 4 DESC, 5 DESC
