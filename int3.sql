.mode columns 
.headers on 
.nullvalue NULL 

select equipa.idequipa, nome
from equipa
WHERE despromovido = 1
order by 1;
