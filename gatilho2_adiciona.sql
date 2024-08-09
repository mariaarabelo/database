PRAGMA foreign_keys = on;

DROP TRIGGER IF EXISTS inicializaClassificacoes;
CREATE TRIGGER inicializaClassificacoes
AFTER INSERT ON Jornada
FOR EACH ROW
WHEN new.numerojornada <> 1
BEGIN
	INSERT INTO Classificacao
    	SELECT c.lugartabela, c.pontos, c.idequipa, new.numerojornada
        FROM Classificacao c
        WHERE c.numerojornada = new.numerojornada - 1;
    
END
