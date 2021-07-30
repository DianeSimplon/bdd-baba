CREATE DATABASE IF NOT EXISTS MUSIQUES;

USE MUSIQUES;

CREATE TABLE Concert 
( 
  nom varchar(64),  
  nomOrchestre VARCHAR(64),
  date_ DATE ,  
  lieu varchar(64),
  prix int(11), 
  PRIMARY KEY (nom),
  FOREIGN KEY(nomOrchestre) REFERENCES Musicien(nom)
); 

CREATE TABLE Musicien
(
   
  nom varchar(64) , 
  instrument VARCHAR(64) , 
  anneeExperience int(11),
  nomOrchestre VARCHAR(64),
  PRIMARY KEY (nom),
  FOREIGN KEY(nomOrchestre) REFERENCES Concert(nom)
); 

CREATE TABLE Orchestre 
(
  nom varchar(64),  
  style VARCHAR(64),  
  chef VARCHAR(64), 
  PRIMARY KEY (nom)
);

 
 INSERT INTO Concert (nom, nomOrchestre, date_,lieu,prix)VALUES
 ('Ultrall', 'orchestre1','2021-06-15','Stade de France', 500),
 ('Die rich or trie dying','orchestre2','2004-09-03','Zenith', 100),
 ('Ultral','orchestre1','2014-09-05','NY',600),
 ('Life','orchestre3','2020-11-22','Dubai',400),
 ('Fiestea','orchestre3','2010-07-12','Miami',50),
 ('Power','orchestre2','1997-08-16','Douala',1000),
 ('Mozart','orchestre5','2019-04-20','Opéra Bastille',10),
 ('Zen','orchestre7','2015-02-22','LA',50),
 ('Relax','orchestre6','2016-01-01','PARIS',200);
 
 
 INSERT INTO Musicien (nom, instrument, anneeExperience, nomOrchestre)VALUES
 ('Yannick','guitare',10,'orchestre1'),
 ('Pratrick','piano',10,'orchestre1'),
 ('Cedric','violon',10,'orchestre1'),
 ('Jordan','batterie',2,'orchestre2'),
 ('Gaelle','saxophone',4,'orchestre3'),
 ('Georges','harmonica',20,'orchestre6');
 
 
 INSERT INTO Orchestre (nom, style, chef)VALUES
 ('orchestre1','jazz','leonardo'),
 ('orchestre2','pop','michaelgelo'),
 ('orchestre3','mb','raphael'),
 ('orchestre4','house','donatello'),
 ('orchestre5','classic','Smith'),
 ('orchestre6','classic','Smith'),
 ('orchestre7','blues','Ray');
 
 
 --1
 SELECT nom, instrument FROM Musicien WHERE anneeExperience<5;
 
 --2
SELECT instrument FROM Musicien WHERE nomOrchestre = 'Jazz92';

--3
SELECT * FROM Musicien WHERE instrument ='violon';

--4
SELECT instrument FROM Musicien WHERE anneeExperience>19;

--5
SELECT nom FROM Musicien WHERE anneeExperience BETWEEN 5 AND 10;
 
--6
SELECT instrument FROM Musicien WHERE instrument LIKE 'vio%';

--7
SELECT nom FROM Orchestre WHERE style='jazz';

--8
SELECT nom FROM Orchestre WHERE chef='John Smith';

--9
SELECT nom FROM Concert ORDER BY nom;

--10
SELECT nom, lieu, date_ FROM Concert WHERE date_='2015-12-31' AND lieu='Versailles';

--11
SELECT lieu FROM Concert WHERE prix >150;

--12
SELECT nom FROM Concert WHERE lieu='Opéra Bastille' AND prix< 50;

--13
SELECT nom FROM Concert WHERE date_ LIKE '2014%';



--MOYEN

--1
SELECT musicien.nom,instrument FROM Musicien WHERE anneeExperience > 3 AND nomOrchestre ='jazz' ORDER BY nom ;

--2
SELECT lieu, chef FROM Concert,Orchestre WHERE Concert.nom = Orchestre.nom AND chef = 'Smith' AND prix<20 ORDER BY lieu;

SELECT lieu FROM Concert
WHERE prix<20
AND nomOrchestre IN
(
    SELECT nom FROM  Orchestre
    WHERE chef = 'Smith' 
)
ORDER BY lieu;

-- ce qui est demande
SELECT lieu, chef FROM Concert
JOIN Orchestre
ON Concert.nomOrchestre = Orchestre.nom 
WHERE chef = 'Smith' 
AND prix<21 
ORDER BY lieu;

--3
SELECT count(nomOrchestre) FROM Concert
JOIN Orchestre 
ON Concert.nomOrchestre = Orchestre.nom
WHERE style = 'blues' AND date_ = '2015%';

--4
SELECT AVG(prix) FROM Concert 
JOIN orchestre 
ON Concert.nomOrchestre = Orchestre.nom
WHERE style = 'jazz' GROUP BY lieu;

--5
SELECT instrument FROM Concert 
JOIN Musicien
ON Concert.nomOrchestre = Musicien.nomOrchestre
JOIN orchestre
ON musicien.nomOrchestre=orchestre.nom
WHERE chef='Smith' AND date_='2016-01-01';

--6
SELECT AVG(anneeExperience) FROM Musicien 
JOIN orchestre
ON Musicien.nomOrchestre = orchestre.nom
WHERE instrument = 'trompette' GROUP BY style;

--MULTI- TABLES

--1
SELECT nom, instrument FROM Musicien
WHERE anneeExperience>=3 
AND nomOrchestre IN 
(
	SELECT nom FROM Orchestre
	WHERE style='jazz'
)
ORDER BY nom;

--2
SELECT lieu FROM concert
WHERE nomOrchestre IN
(
	SELECT nom FROM Orchestre
	WHERE chef = 'Smith' 
)
AND prix < 20 ORDER BY lieu;

--3
SELECT COUNT(style) FROM Orchestre
WHERE style='blues'
AND nom = ANY
(
	SELECT nomOrchestre FROM Concert
	WHERE date_ LIKE '2015%'
);

--4
SELECT AVG(prix) FROM Concert
WHERE nomOrchestre IN
(
	SELECT nom FROM Orchestre
	WHERE style = 'jazz'
)
GROUP BY lieu;

--5
SELECT instrument FROM musicien
WHERE nom IN
(
    SELECT nom FROM orchestre
    WHERE chef = 'Smith' AND nom IN
     (
         SELECT nom FROM concert
         WHERE date_ = '2016-01-01'
     )
);




