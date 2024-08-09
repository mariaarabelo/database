PRAGMA foreign_keys = on;
/*atualiza os pontos quando se insere um jogo*/
DROP TRIGGER IF EXISTS AtualizaPontos;
Create Trigger AtualizaPontos
AFTER INSERT ON Jogo
FOR EACH ROW

BEGIN
      UPDATE Classificacao
      SET pontos = pontos + (CASE WHEN idequipa = new.equipavencedora THEN 3 When  new.equipavencedora is NULL  THEN 1 ELSE 0 END)
      WHERE numeroJornada >= new.numerojornada AND (idequipa = new.equipacasa OR idequipa = new.equipavisitante);
      UPDATE Classificacao
      SET pontos = pontos + 0
      WHERE numeroJornada >= new.numerojornada ;
END;

/*Atualiza o lugar na tabela quando de uma equipa quando os seus pontos são atualizados*/
DROP TRIGGER IF EXISTS AtualizaLugar;
Create Trigger AtualizaLugar
AFTER UPDATE of pontos ON Classificacao
FOR each ROW
BEGIN
    UPDATE Classificacao
    set lugartabela= 1+(SELECT count(*) FROM(SELECT pontos from Classificacao c where new.numerojornada=c.numerojornada 
    and (new.pontos<c.pontos OR (new.pontos=c.pontos and(
        (SELECT SUM(golosM)-SUM(golosS)
        FROM (SELECT CASE WHEN Jogo.equipacasa = new.idequipa THEN SUBSTR(resultado, 0, INSTR(resultado, '-')) ELSE  SUBSTR(resultado, INSTR(resultado, '-') + 1) END AS golosM,
                CAse WHEN Jogo.equipacasa= new.idequipa then SUBSTR(resultado, INSTR(resultado, '-') + 1) ELSE SUBSTR(resultado, 0, INSTR(resultado, '-')) end AS golosS
                FROM Jogo
                WHERE Jogo.numerojornada <= new.numerojornada AND (Jogo.equipacasa = new.idequipa OR Jogo.equipavisitante = new.idequipa)
                )) 
          <
        (SELECT SUM(golosM)-SUM(golosS)
        FROM (SELECT Case WHen Jogo.equipacasa=c.idequipa THEN SUBSTR(resultado, 0, INSTR(resultado, '-')) ELSE  SUBSTR(resultado, INSTR(resultado, '-') + 1) END AS golosM,
                CAse WHEN Jogo.equipacasa= c.idequipa then SUBSTR(resultado, INSTR(resultado, '-') + 1) ELSE SUBSTR(resultado, 0, INSTR(resultado, '-')) end AS golosS
                FROM Jogo
                WHERE Jogo.numerojornada <= new.numerojornada AND (Jogo.equipacasa = c.idequipa OR Jogo.equipavisitante = c.idequipa)
          )))))))
     where idequipa=new.idequipa and numerojornada>=new.numerojornada; 
     /*Para dicidir o lugar na tabela cria-se uma tabela que contenha todas as equipas que tenham mais pontos que a equipa a qual queremos ver o lugar e todas as equipas
     que tenham o mesmo numero de pontos mas uma maior diferença entre os golos marcados e os golos sofridos, a seguir a isso conta-se quantas linhas tem essa tabela
     e soma-se 1 para obter o lugar da tabela da equipa*/
     
END;

/* ao atualizar o lugar na tabela vai atualizar as qualificações */
DROP TRIGGER IF EXISTS atualizarQualificacoes;
CREATE TRIGGER atualizarQualificacoes
After UPDATE OF lugartabela ON Classificacao
FOR EACH ROW
BEGIN
	UPDATE Equipa
    set qualificadochampions= case WHEN new.lugartabela<=3 then 1 ELSE 0 END,
    qualificadoeuropa= case WHEN new.lugartabela=4 then 1 ELSE 0 END,
    qualificadoconference= case WHEN new.lugartabela<=6 AND new.lugartabela>4 then 1 ELSE 0 END,
   	despromovido= case WHEN new.lugartabela>=16 then 1 ELSE 0 END
    where idequipa=new.idequipa;
END;



