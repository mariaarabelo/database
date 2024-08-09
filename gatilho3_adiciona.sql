PRAGMA foreign_keys = on;

.mode columns 
.headers on 
.nullvalue NULL 


DROP TRIGGER IF EXISTS verificaSubstituicao;
create trigger VerificaSubstituicao
before insert on Substituicao
FOR EACH ROW
when exists (select * from Substituicao where
 new.idjogo = substituicao.idjogo
 and new.idjogadorentra = idjogadorsai
 and new.minuto >minuto)
Begin
    SELECT RAISE(ABORT, "Jogador não pode entrar após ter saído");
end;
