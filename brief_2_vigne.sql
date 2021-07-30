CREATE DATABASE IF NOT EXISTS VIGNES;

USE VIGNES;

CREATE TABLE Producteur 
( 
  numProd int(11) AUTO_INCREMENT NOT NULL,
  nom varchar(64),  
  domaine VARCHAR(64),  
  region varchar(64),
  PRIMARY KEY (numProd)
); 

CREATE TABLE Vin
(
  numVin int(11) AUTO_INCREMENT NOT NULL,
  appellation varchar(64) , 
  couleur VARCHAR(64) , 
  annee int(11),
  degre int(11),
  PRIMARY KEY (numVin)
); 

CREATE TABLE Recolte 
(
  nProd int(11),  
  nVin int(11),  
  quantite int(11),
  FOREIGN KEY(nProd) REFERENCES Producteur(numProd),
  FOREIGN KEY(nVin) REFERENCES Vin(numVin)
);
 
 INSERT INTO Producteur (nom, domaine,region)VALUES
 ('Producteur1','Graves', 'Bordeaux'),
 ('Producteur2','Domaine Roblet-Monnot','Bourgogne'),
 ('Producteur3','Domaine des Rouges','Bourgogne'),
 ('Dupond','Domaine Marcel Richaud','Côte Du Rhône'),
 ('Producteur5','La Grande Oncle','Alsace'),
 ('Producteur6','Domaine Pierre Label','Bourgogne'),
 ('Dupond','Domaine Mikulski','Bourgogne'),
 ('Producteur8','Domaine Tissot','Jura'),
 ('Producteur9','Domaine Peyre Rose','Languedoc Roussillon'),
 ('Producteur10','Domaine Chapelas','Côte Du Rhône'),
 ('Producteur11','Domaine Pierre Labet','Côte Du Rhône');
 
 INSERT INTO Vin (appellation, couleur, annee,degre)VALUES
 ('Château Villa Bel-Air','Rouge',2014, 13),
 ('Domaine Roblet-Monnot','Rouge',2017, 13),
 ('La Fussière','Rouge',2017,13),
 ('Mistral AOC','Rouge',2004,15),
 ('La Grande Oncle Charles','Blanc',2018,13),
 ('Vielles Vignes','Blanc',2017, 13),
 ('Genevrière','Blanc',1999, 13),
 ('Cremant du Jura Blanc','Blanc',2015,15),
 ('Syrah Leone','Rosé',1995,15),
 ('Domaine Chapelas Rosé','Rosé',2004,14),
 ('Vieilles Vignes','Blanc',2000,'15');
 
 INSERT INTO Recolte (nProd, nVin, quantite)VALUES
 (1,1,20),
 (2,2,40),
 (3,3,50),
 (4,4,100),
 (5,5,70),
 (6,6,90),
 (7,7,200),
 (8,8,5),
 (9,9,25),
 (10,10,100),
 (11,20,70);
 
 
--facile

--1
SELECT appellation FROM Vin WHERE annee LIKE '1995%';

--2
SELECT appellation, couleur, annee,degre FROM Vin 
WHERE annee > 2000;

--3
SELECT appellation FROM Vin WHERE annee BETWEEN 2000 AND 2009;

--4
SELECT appellation FROM Vin WHERE couleur = 'Blanc' AND degre > 14;

--5
SELECT appellation FROM Vin WHERE appellation LIKE '%AOC%';

--6
SELECT domaine FROM Producteur WHERE region ='Bordeaux';

--7
SELECT nom, region FROM producteur WHERE numProd=5;

--8
SELECT nom FROM Producteur WHERE region = 'Beaujolais';

--9
SELECT * FROM Producteur WHERE nom LIKE 'Dupon%'; 

--10
SELECT nom FROM Producteur ORDER BY nom;

--NIVEAU Moyen

--1
SELECT annee FROM Vin WHERE degre >13 GROUP BY couleur ORDER BY annee DESC;

--2
SELECT * FROM Vin WHERE prix ORDER BY(couleur, degre) AND degre > AVG(degre);

--3
SELECT min(degre), MAX(degre) FROM Vin WHERE appellation AND couleur;

--vrai reponse
SELECT min(degre), MAX(degre),appellation,couleur FROM Vin ;

--MULTI-TABLES

--1
SELECT nom FROM Producteur 
JOIN Recolte ON Producteur.numProd = Recolte.nProd
WHERE nVin =20 AND quantite>50;

--2
SELECT COUNT(nVin) FROM recolte
JOIN vin ON recolte.nVin = vin.numVin
WHERE Couleur ='rouge' AND annee = 2004;

--3
SELECT sum(quantite),annee FROM Recolte
JOIN vin ON Recolte.nVin=vin.numVin
WHERE couleur ='blanc';

--4
SELECT annee, AVG(degre) FROM Vin WHERE couleur ='blanc';

--5
SELECT nom, domaine FROM Producteur
JOIN recolte ON Producteur.numProd= recolte.nProd
JOIN vin ON recolte.nVin= vin.numVin
WHERE couleur = 'rouge';

--6
SELECT appellation, nProd, quantite FROM Vin 
JOIN recolte ON Vin.numVin = recolte.nVin
WHERE annee = 1999 AND quantite = 200;

--MULTI-TABLES AVEC REQUETE IMBRIQUE

--vmts01
SELECT nom FROM Producteur WHERE nVin = 20 
AND vin.numVin=Recolte.nVin
(
	SELECT * FROM recolte 
    WHERE quantite > 50
);

SELECT nom FROM producteur 
INNER JOIN récolte 
ON nProd=numProd 
AND quantite > 50 
INNER JOIN vin 
ON numVin=20; 

vmts02
SELECT count(nProd) FROM récolte 
WHERE nVin IN
(
	SELECT numVIn FROM vin 
	WHERE couleur = 'Rouge' 
	AND annee=2014
); 
vmts03
SELECT AVG(degre),annee 
FROM vin WHERE couleur='blanc' 
GROUP BY annee

vmts04
SELECT nom,domaine FROM producteur 
WHERE numProd IN 
(
	SELECT nProd FROM récolte 
	WHERE nVin IN 
	(
		SELECT numVin FROM vin 
		WHERE couleur='rouge'
	)
); 
