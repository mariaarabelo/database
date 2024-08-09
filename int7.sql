.mode columns 
.headers on 
.nullvalue NULL

select round(portugueses/total,2) AS percentagemPT
 from  ((select COUNT(nacionalidade)*100.0 portugueses from Jogador where nacionalidade = "Portugal"),
        (select COUNT(nacionalidade) as total from Jogador));
