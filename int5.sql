.mode columns 
.headers on 
.nullvalue NULL 

SELECT Classificacao.lugartabela, Equipa.idequipa, Equipa.nome, Classificacao.pontos
FROM Classificacao, Equipa
WHERE Classificacao.idequipa = Equipa.idequipa AND numerojornada = 33
order by lugartabela asc;
