.mode columns 
.headers on 
.nullvalue NULL

-- Tabela temporária para calcular golos das equipas a jogar em casa
CREATE VIEW eqCasa AS
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, COUNT(*) AS golosPorEquipa
FROM Equipa, Jogo, Golo
WHERE Equipa.idequipa = Golo.equipafavor AND Golo.idjogo = Jogo.idjogo AND Equipa.idequipa = Jogo.equipacasa
GROUP BY 3, 1
UNION
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, 0 AS golosPorEquipa
FROM Equipa, Jogo, Golo
WHERE Equipa.idequipa NOT in ( select Golo.equipafavor FROM Golo WHERE Golo.idjogo = Jogo.idjogo) AND Golo.idjogo = Jogo.idjogo AND Equipa.idequipa = Jogo.equipacasa
GROUP BY 3, 1
UNION
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, 0 AS golosPorEquipa
FROM Jogo, Equipa
WHERE Equipa.idequipa = Jogo.equipacasa AND resultado = '0-0'
GROUP BY 3, 1;

-- Tabela temporária para calcular golos das equipas a jogar fora
CREATE VIEW eqVisitante AS
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, COUNT(*) AS golosPorEquipa
FROM Equipa, Jogo, Golo
WHERE Equipa.idequipa = Golo.equipafavor AND Golo.idjogo = Jogo.idjogo AND Equipa.idequipa = Jogo.equipavisitante
GROUP BY 3, 1
UNION
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, 0 AS golosPorEquipa
FROM Equipa, Jogo, Golo
WHERE Equipa.idequipa NOT in ( select Golo.equipafavor FROM Golo WHERE Golo.idjogo = Jogo.idjogo) AND Golo.idjogo = Jogo.idjogo AND Equipa.idequipa = Jogo.equipavisitante
GROUP BY 3, 1
UNION
SELECT Equipa.idequipa, Equipa.nome, Jogo.idjogo, 0 AS golosPorEquipa
FROM Jogo, Equipa
WHERE Equipa.idequipa = Jogo.equipavisitante AND resultado = '0-0'
GROUP BY 3, 1;


SELECT equipa1Casa.nome, equipa1Casa.golosPorEquipa + equipa1Visitante.golosPorEquipa AS goloseq1, equipa2Casa.golosPorEquipa + equipa2Visitante.golosPorEquipa AS goloseq2, equipa2Casa.nome
FROM eqCasa equipa1Casa, eqVisitante equipa1Visitante, eqCasa equipa2Casa, eqVisitante equipa2Visitante
WHERE equipa1Casa.idequipa = equipa1Visitante.idequipa 
AND equipa2Casa.idequipa = equipa2Visitante.idequipa 
and (equipa1Casa.nome < equipa2Casa.nome OR equipa1Visitante.nome < equipa2Visitante.nome) 
AND equipa1Casa.idjogo = equipa2Visitante.idjogo 
AND equipa1Visitante.idjogo = equipa2Casa.idjogo 
AND equipa1Casa.idjogo <> equipa1Visitante.idjogo 
AND equipa2Casa.idjogo <> equipa2Visitante.idjogo 
ORDER BY 1, 4;

DROP VIEW eqCasa;
DROP VIEW eqVisitante;
