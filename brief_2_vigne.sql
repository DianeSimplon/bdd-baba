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