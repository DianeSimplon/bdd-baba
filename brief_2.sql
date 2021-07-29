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
 ('Ultrall', 'orchestre','2021-06-15','Stade de France', 500),
 ('Die rich or trie dying','orchestre','2004-09-03','Zenith', 100),
 ('Ultral','orchestre','2014-09-05','NY',600),
 ('Life','orchestre','2020-11-22','Dubai',400),
 ('Fiestea','orchestre','2010-07-12','Miami',50),
 ('Power','orchestre','1997-08-16','Douala',1000),
 ('Mozart','orchestre5','2019-04-20','Opéra Bastille',10),
 ('Zen','orchestre7','2015-02-22','LA',50),
 ('Relax','orchestre6','2016-01-01','PARIS',200);
 
 
 INSERT INTO Musicien (nom, instrument, anneeExperience, nomOrchestre)VALUES
 ('Yannick','guitare',10,'orchestre1'),
 ('Pratrick','piano',10,'orchestre1'),
 ('Cedric','violon',10,'orchestre1'),
 ('Jordan','batterie',2,'orchestre2'),
 ('Gaelle','saxophone',4,'orchestre'),
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
 SELECT instrument 
 