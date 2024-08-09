PRAGMA foreign_keys = on;

.print ''
.print 'Neste momento temos na nossa base de dados as jornadas 1 à 33'
.print ''

SELECT numeroJornada FROM Jornada;

.print ''
.print 'Sendo estas as classificacões das equipas na jornada 33'
.print ''

SELECT * FROM Classificacao WHERE numeroJornada = 33 GROUP BY lugartabela;

.print ''
.print 'Adicionaremos agora a jornada 34...'
.print ''

INSERT INTO Jornada Values(34);

.print ''
.print 'As jornadas na base de dados são agora da 1 à 34'
.print ''

SELECT numeroJornada FROM Jornada;

.print ''
.print 'Verifica-se que as classificacoes das equipas na jornada 34 são iguais as da jornada 33, a inserção dos jogos dessa jornada leve à atualização correta das classificações'
.print ''

SELECT * FROM Classificacao WHERE numeroJornada = 34 GROUP BY lugartabela;

.print ''
.print 'A remover a jornada 34 e respetivas classificacoes...'

DELETE FROM Jornada WHERE numeroJornada = 34;
DELETE FROM Classificacao WHERE numeroJornada = 34;
