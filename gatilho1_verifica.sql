PRAGMA foreign_keys = on;

.print ''

.print 'Classificações das equipas na jornada 33'

.print ''

SELECT * FROM Classificacao WHERE numeroJornada=33 order by lugartabela;

.print ''

.print 'Equipas em risco de despromoção '

.print ''

SELECT Equipa.idequipa, Equipa.nome, despromovido FROM Equipa WHERE despromovido = 1;

.print ''

.print 'Vamos alterar os pontos do Tondela de maneira a que fique a uma vitoria de parar de estar em risco de despromoção'

.print ''

Update Classificacao 
Set pontos = 29
Where idequipa=17 and numeroJornada =33;

.print 'E agora vamos simular um jogo em que o Tondela ganhou'

INSERT INTO Jogo VALUES (4, '2022-05-08 15:30', '0-3', 33, 5, 17, 17);

.print 'Classificacao após vitoria'
.print ' '

SELECT * FROM Classificacao WHERE numeroJornada = 33 ORDER BY lugartabela;

.print ' '

.print 'Equipas em risco de despromocao após vitoria de Tondela'

.print ' '

SELECT Equipa.idequipa, Equipa.nome, despromovido FROM Equipa WHERE despromovido = 1;

.print ''

.print 'A reverter as modificações feitas...'

.print ''

DELETE FROM Jogo where idJogo = 4;
UPDATE Classificacao SET pontos = 27 WHERE idequipa = 17;
UPDATE Classificacao SET lugartabela = 15 WHERE idequipa = 15;
