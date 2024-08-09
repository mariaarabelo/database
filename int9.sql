.mode columns 
.headers on 
.nullvalue NULL

/*Todos os golos que um jogador marcou*/
Drop view if exists Golos_ ;
CREATE VIEW Golos_ AS
 SELECT  id,nome, golos AS Golos,ide from(
	SELECT Jogador.idJogador as id,nome,0 as golos,idequipa as ide from Jogador where  Jogador.idjogador not in(SELECT Jogador.idjogador from Jogador left join Golo on Jogador.idjogador=Golo.idjogador where idequipa=equipafavor   )
UNION
	Select Jogador.idJogador as id2,nome, COUNT(idevento) as golos,idequipa as ide From Jogador left join Golo on Jogador.idjogador=Golo.idjogador where idequipa==equipafavor  GROUP by Jogador.idJogador
  ) ;
  
/*Todas as assistencias que um jogador fez*/
Drop view if exists Assistencias_;
CREATE View Assistencias_ AS
SELECT id,Assistencia,ide FROM(
  SELECT Jogador.idjogador AS id, 0 as Assistencia,idequipa as ide FROM Jogador WHERE idjogador NOT in(SELECT Jogador.idjogador FROM Jogador LEFT JOIN Outro ON Jogador.idjogador=Outro.idjogador WHERE descricao='Assistencia' )
UNION
  SELECT Jogador.idjogador AS id,COUNT(idevento) as Assistencia,idequipa as ide  FROM Jogador LEFT JOIN Outro ON Jogador.idjogador=Outro.idjogador WHERE descricao='Assistencia'  GROup by Jogador.idjogador
);  

/*Todos os auto golos que um jogador marcou*/
Drop view if exists AutoGolos_ ;
CREATE View AutoGolos_ AS
SELECT  id,nome, golos AS AutoGolos,ide from(
	SELECT Jogador.idJogador as id,nome,0 as golos,idequipa as ide from Jogador where  Jogador.idjogador not in(SELECT Jogador.idjogador from Jogador left join Golo on Jogador.idjogador=Golo.idjogador where idequipa<>equipafavor   )
UNION
	Select Jogador.idJogador as id2,nome, COUNT(idevento) as golos,idequipa as ide From Jogador left join Golo on Jogador.idjogador=Golo.idjogador where idequipa<>equipafavor GROUP by Jogador.idJogador
  );
 
/*Todos os penalties  que um jogador defendeu*/
Drop view if exists Penalties_Defendidos_ ;
CREATE VIEW Penalties_Defendidos_ AS
SELECT id,Penalties_Defendidos,ide FROM(
  SELECT Jogador.idjogador AS id, 0 as Penalties_Defendidos,idequipa as ide FROM Jogador WHERE  idjogador NOT in(SELECT Jogador.idjogador FROM Jogador LEFT JOIN Outro ON Jogador.idjogador=Outro.idjogador WHERE descricao='Penalti defendido' )
UNION
  SELECT Jogador.idjogador AS id,COUNT(idevento) as Penalty_Defendido,idequipa as ide  FROM Jogador LEFT JOIN Outro ON Jogador.idjogador=Outro.idjogador WHERE descricao='Penalti defendido'  GROup by Jogador.idjogador
); 
 
/*Todos os amarelos que um jogador recebeu*/ 
Drop view if exists Amarelos_ ; 
CREATE VIEW Amarelos_ AS  
SELECT id,Amarelos,ide FROM(
	SELECT Jogador.idjogador AS id,0 as Amarelos,idequipa as ide from Jogador where  idjogador NOt IN (SELECT Jogador.idJogador FROm Jogador LEFT JOIN Cartao ON Jogador.idjogador=Cartao.idJogador WHERE cor='Amarelo')
UNION
	SELECT Jogador.idjogador as id,COUNT(idevento) as Amarelos,idequipa as ide from Jogador  LEFT JOIN  Cartao ON Jogador.idjogador==Cartao.idjogador WHERE cor='Amarelo' GROUP BY Jogador.idjogador
);

/*Todos os vermelhos que um jogador recebeu*/
Drop view if exists Vermelhos_ ;
CREATE VIEW Vermelhos_ AS
SELECT id,Vermelhos ,ide FROM(
	SELECT Jogador.idjogador AS id,0 as Vermelhos,idequipa as ide from Jogador where idjogador NOT IN (SELECT Jogador.idJogador FROm Jogador LEFT JOIN Cartao ON Jogador.idjogador=Cartao.idJogador WHERE cor='Vermelho')
UNION
	SELECT Jogador.idjogador as id,COUNT(idevento) as Vermelhos,idequipa as ide from Jogador  LEFT JOIN  Cartao ON Jogador.idjogador==Cartao.idjogador WHERE cor='Vermelho'  GROUP BY Jogador.idjogador
);  



SELECT A.id,A.nome,Golos,Assistencia,AutoGolos,Penalties_Defendidos,Amarelos,Vermelhos FROM(
(Golos_ ) AS A,
(Assistencias_) AS B,
(AutoGolos_) AS C,
(Penalties_Defendidos_) AS D,
(Amarelos_) AS E,    
(Vermelhos_) AS F    
  ) WHERE A.id=B.id and A.id=C.id and A.id=D.id AND A.id=E.id AND A.id=F.id and A.ide=B.ide and A.ide=C.ide and A.ide=D.ide and A.ide=E.ide and A.ide=F.ide and A.ide=3
  order by 1;

