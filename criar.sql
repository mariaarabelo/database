DROP TABLE IF EXISTS Equipa;
CREATE TABLE Equipa (
    idEquipa INTEGER PRIMARY KEY,
    nome TEXT
        CONSTRAINT nomeNaoNulo NOT NULL,
    localidade TEXT
        CONSTRAINT localNaoNulo NOT NULL,
    qualificadoChampions BOOLEAN,
    qualificadoConference BOOLEAN,
    qualificadoEuropa BOOLEAN,
    despromovido BOOLEAN
);

DROP TABLE IF EXISTS Estadio;
CREATE TABLE Estadio (
    idEstadio INTEGER PRIMARY KEY, 
    nome TEXT
        CONSTRAINT nomeNaoNulo NOT NULL,
    capacidade INTEGER
        CONSTRAINT capacidadePositiva CHECK (capacidade>0),
    idEquipa INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
        CONSTRAINT equipaNaoNula NOT NULL,
    CONSTRAINT EquipaUnica UNIQUE(idEquipa)
);

DROP TABLE IF EXISTS Jornada;
CREATE TABLE Jornada (
   numeroJornada INTEGER PRIMARY KEY CHECK(numeroJornada >= 1 AND numeroJornada <= 34)
);

DROP TABLE IF EXISTS Jogo;
CREATE TABLE Jogo (
    idJogo INTEGER PRIMARY KEY,
    data_ DATETIME
        CONSTRAINT dataNaoNula NOT NULL,
    resultado TEXT
        CONSTRAINT resultadoNaoNulo NOT NULL,
    numeroJornada INTEGER REFERENCES Jornada(numeroJornada)ON DELETE CASCADE ON UPDATE CASCADE,
    equipaCasa INTEGER REFERENCES Equipa(idEquipa)ON DELETE CASCADE ON UPDATE CASCADE NOT NULL ,
    equipaVisitante INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    equipaVencedora INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT vencedorValido CHECK(equipaVencedora = NULL OR equipaVencedora=equipaVisitante OR equipaVencedora=equipaCasa),
    UNIQUE(equipaCasa,equipaVisitante)
);

DROP TABLE IF EXISTS Jogador;
CREATE TABLE Jogador (
    idJogador INTEGER PRIMARY KEY,
    nome TEXT
        CONSTRAINT nomeNaoNulo NOT NULL,
    idade INTEGER 
        CONSTRAINT idadeNaoNula NOT NULL,
    numeroCamisola INTEGER
        CONSTRAINT numeroValido CHECK(numeroCamisola>0 AND numeroCamisola<100),
    nacionalidade TEXT
        CONSTRAINT nacionalidadeValido NOT NULL,
    idEquipa INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS Golo;
CREATE TABLE Golo (
    idEvento INTEGER PRIMARY KEY,
    minuto INTEGER
        CONSTRAINT minutoValido CHECK(minuto>=0),
    idJogo INTEGER REFERENCES Jogo(idJogo) ON DELETE CASCADE ON UPDATE CASCADE ,
    equipaFavor INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
    idJogador INTEGER REFERENCES Jogador(idJogador) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Cartao;
CREATE TABLE Cartao (
   idEvento INTEGER PRIMARY KEY,
    minuto INTEGER 
        CONSTRAINT minutoValido CHECK(minuto>=0),
    cor TEXT 
        CONSTRAINT corValida CHECK(cor = 'Amarelo' OR cor = 'Vermelho'),
    idJogo INTEGER REFERENCES Jogo(idJogo)ON DELETE CASCADE ON UPDATE CASCADE,
    idJogador INTEGER REFERENCES Jogador(idJogador)ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Substituicao;
CREATE TABLE Substituicao (
    idEvento INTEGER PRIMARY KEY,
    minuto INTEGER
        CONSTRAINT minutoValido CHECK(minuto>=0),
    idJogo INTEGER REFERENCES Jogo(idJogo)ON DELETE CASCADE ON UPDATE CASCADE,
    idJogadorEntra INTEGER REFERENCES Jogador(idJogador)ON DELETE CASCADE ON UPDATE CASCADE,
    idJogadorSai INTEGER REFERENCES Jogador(idJogador) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT JogoJogadorEntraUnico UNIQUE(idJogo, idJogadorEntra)
    CONSTRAINT JogoJogadorSaiUnico UNIQUE(idJogo, idJogadorSai)
);

DROP TABLE IF EXISTS Outro;
CREATE TABLE Outro (
    idEvento INTEGER PRIMARY KEY,
    minuto INTEGER
        CONSTRAINT minutoValido CHECK(minuto>=0),
    idJogo INTEGER REFERENCES Jogo(idJogo)ON DELETE CASCADE ON UPDATE CASCADE,
    idJogador INTEGER REFERENCES Jogador(idJogador)ON DELETE CASCADE ON UPDATE CASCADE,
    descricao TEXT
        CONSTRAINT descricaoValida NOT NULL

);


DROP TABLE IF EXISTS Classificacao;
CREATE TABLE Classificacao (
    lugarTabela INTEGER,
    pontos INTEGER,
    idEquipa INTEGER REFERENCES Equipa(idEquipa) ON DELETE CASCADE ON UPDATE CASCADE,
    numeroJornada INTEGER REFERENCES Jornada(numeroJornada)ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(idEquipa,numeroJornada)
   
);

.read gatilho1_adiciona.sql
.read gatilho2_adiciona.sql
.read gatilho3_adiciona.sql
