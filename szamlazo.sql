CONNECT TO szamlazo;

DROP TABLE Cimek;
DROP TABLE Vevok;
DROP TABLE Szamlak;
DROP TABLE Tetel;
DROP TABLE Termek;
DROP SEQUENCE cimkod_seq;
DROP SEQUENCE tetelkod_seq;
DROP SEQUENCE termekkod_seq;


CREATE SEQUENCE tetelkod_seq AS int 
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE;

CREATE SEQUENCE cimkod_seq AS int 
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE;

CREATE SEQUENCE termekkod_seq AS int 
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE;


CREATE TABLE Cimek 
(Cimkod int NOT NULL, 
  Ir_szam char(4) NOT NULL, 
  Varos char(25) NOT NULL,
  Utca char(25) Not NULL,
  PRIMARY KEY (Cimkod));

Insert into Cimek values 
(NEXT VALUE FOR cimkod_seq,'1111','Varos 1','XY utca 5'), 
(NEXT VALUE FOR cimkod_seq,'2222','Fovaros','YZ ut 33'), 
(NEXT VALUE FOR cimkod_seq,'3333','Varos 2','asd utca 1'), 
(NEXT VALUE FOR cimkod_seq,'4444','Falu','Fo ut 55'),
(NEXT VALUE FOR cimkod_seq,'5555','Varos 3','ABC utca 123');

CREATE TABLE Vevok
( Adoszam char(7) NOT NULL, 
  Vnev char(50) NOT NULL, 
  Cimkod int NOT NULL,
  PRIMARY KEY(Adoszam,Cimkod),
  FOREIGN KEY (Cimkod)
    REFERENCES Cimek (Cimkod) ON DELETE CASCADE);


Insert into Vevok values 
('9999999','Nev1', 1), 
('8888888','Nev2', 2), 
('7777777','Nev3', 3), 
('6666666','Nev4', 4),
('5555555','Nev5', 5);



CREATE TABLE Termek 
( Termekkod int NOT NULL,
  Tnev char(25) NOT NULL, 
  Egyseg char(2) NOT NULL, 
  Ar int CHECK (Ar > 0),
  PRIMARY KEY (Termekkod));

Insert into Termek values 
(NEXT VALUE FOR termekkod_seq,'Termek 1','db',100), 
(NEXT VALUE FOR termekkod_seq,'Termek 2','kg',10), 
(NEXT VALUE FOR termekkod_seq,'Termek 3','l',1), 
(NEXT VALUE FOR termekkod_seq,'Termek 4','kg',50), 
(NEXT VALUE FOR termekkod_seq,'Termek 5','kg',20);


CREATE TABLE Szamlak 
( Szamlaszam char(8) NOT NULL,
  Kiallitas DATE NOT NULL,
  Fiz_mod char(2) DEFAULT 'KP',
  Adoszam char(7) NOT NULL,
  PRIMARY KEY (Szamlaszam));


Insert into Szamlak values 
('11600006','2020-09-12','BU','9999999'),
('10300888','2022-11-07','KF','8888888'),
('10300889','2022-11-07','KP','5555555'),
('11600015','2020-09-12','BU','7777777'),
('10300002','2022-11-07','KF','6666666');


CREATE TABLE Tetel 
( Tetelkod int NOT NULL,
  Mennyiseg int NOT NULL,
  Termekkod int NOT NULL,
  Szamlaszam char(8) NOT NULL,
  PRIMARY KEY (Tetelkod,Termekkod,Szamlaszam),
  FOREIGN KEY (Termekkod)
    REFERENCES Termek (Termekkod) ON DELETE CASCADE,
  FOREIGN KEY (Szamlaszam)
    REFERENCES Szamlak (Szamlaszam) ON DELETE RESTRICT);


Insert into Tetel values 
(NEXT VALUE FOR tetelkod_seq,1,1,'11600006'), 
(NEXT VALUE FOR tetelkod_seq,10,2,'11600006'), 
(NEXT VALUE FOR tetelkod_seq,100,3,'10300888'), 
(NEXT VALUE FOR tetelkod_seq,2,4,'11600015'), 
(NEXT VALUE FOR tetelkod_seq,5,5,'10300889'),
(NEXT VALUE FOR tetelkod_seq,20,3,'10300002');







