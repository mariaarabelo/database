PRAGMA foreign_keys = on;

.mode columns
.headers on
.nullvalue NULL

.print ''
.print 'Substituições do primeiro jogo da época:'
.print ''

SELECT *
FROM Substituicao
WHERE idjogo = 1;

.print ''
.print 'Podemos verificar que o jogador de id 445 saiu no minuto 82 do jogo. Assim, a partir do minuto 82 não poderá entrar de novo em campo'
.print ''
.print 'Inserção de uma substituição em que o jogador de id 445 entra em campo após ter saído...'
.print ''

INSERT INTO Substituicao VALUES (0, 85, 1, 445, 428);

.print ''
.print 'Verifica-se que a substituição não foi inserida:'
.print '' 

SELECT *
FROM Substituicao
WHERE idjogo = 1;

.print ''
.print 'Inserção de uma substituição válida...' 
.print ''

INSERT INTO Substituicao VALUES (0, 72, 1, 430, 428);

.print 'Verifica-se que a substituição foi inserida:'
.print ''

SELECT *
FROM Substituicao
WHERE idjogo = 1;

.print ''
.print 'A remover a substituição que foi inserida...'
.print ''

DELETE FROM SUBSTITUICAO WHERE idEvento = 0
