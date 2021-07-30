CREATE DATABASE IF NOT EXISTS S6_MVC_BTP;

USE S6_MVC_BTP;

CREATE TABLE Client 
(
  id int AUTO_INCREMENT NOT NULL, 
  nom varchar(64),  
  anneeNaiss int(11),  
  ville varchar(64),  
  PRIMARY KEY (id)
);  

CREATE TABLE Fournisseur
(
  id int(11) AUTO_INCREMENT NOT NULL,  
  nom varchar(64) , 
  age int(11) , 
  ville varchar(64),  
  PRIMARY KEY (id)
); 

CREATE TABLE Produit 
(
  
  label varchar(64) ,  
  idF int(11),  
  prix int(11) , 
  PRIMARY KEY (label, idF) 
);
 
CREATE TABLE Commande 
(
  num int(11),
  idC int(11),  
  labelP varchar(64),  
  quantite int(11),
  PRIMARY KEY (num, idC, labelP) 
);

INSERT INTO client (nom, anneeNaiss, ville)VALUES
 ('Jean', 1965, '75006 Paris'),
 ('Paul', 1958, '75003 Paris'),
 ('Vincent',1954,'94200 Evry'),
 ('Pierre', 1950,'92400 Courbevoie'),
 ('Daniel', 1963,'44000 Nantes');
 
 INSERT INTO Fournisseur (nom, age, ville)VALUES
 ('Abounayan', 52, '92190 Meudon'),
 ('Cima', 37, '44150 Nantes'),
 ('Vincent',48,'92230 Gennevilliers'),
 ('Pierre', 61,'75018 Paris'),
 ('Daniel', 29,'49100 Angers');
 
 INSERT INTO Produit (label, idF, prix)VALUES
 ('sable', 1, 300),
 ('briques', 1, 1500),
 ('parpaing',1,1150),
 ('sable', 2,350),
 ('tuiles', 3,1200),
 ('parpaing', 3, 1300),
 ('briques', 4, 1500),
 ('ciment',4,1300),
 ('parpaing', 4,1450),
 ('briques', 5,1450),
 ('tuiles', 5,1100);
 
 INSERT INTO Commande (num, idC, labelP, quantite)VALUES
 (1,1,'briques',5),
 (1,1,'ciment',10),
 (2,2,'briques',12),
 (2,2,'sable',9),
 (2,2,'parpaing',15),
 (3,3,'sable',17),
 (4,4,'briques',8),
 (4,4,'tuiles',17),
 (5,5,'parpaing',10),
 (5,5,'ciment',14),
 (6,5,'briques',21),
 (7,2,'ciment',12),
 (8,4,'parpaing',8),
 (9,1,'tuiles',15);
 
--1 toutes les informations sur client
SELECT * FROM Client ;

--2 les info utiles sur Client
SELECT nom, anneeNaiss, ville FROM Client;

--3 le nom des clients dont l'age>50
SELECT nom, anneeNaiss FROM Client WHERE anneeNaiss<1971;

--4 
SELECT DISTINCT label FROM Produit;

--5
SELECT DISTINCT label FROM Produit ORDER BY label DESC;

--6
--a
SELECT * FROM Commande WHERE quantite BETWEEN 8 AND 18;

--b
SELECT * FROM Commande WHERE (quantite>=8) AND (quantite<19);

--7
SELECT nom, ville FROM Client WHERE nom LIKE 'P%';

--8
SELECT nom,ville FROM Fournisseur WHERE ville LIKE '%Paris';

--9
SELECT idF, prix FROM Produit WHERE label ='briques' OR label ='parpaing';
SELECT idF, prix FROM Produit WHERE label IN('briques','parpaing');

--10
SELECT nom,labelP,quantite FROM Client JOIN Commande ON Client.id = Commande.idC;

--11
SELECT nom, labelP FROM Client, Commande WHERE Client.id = Commande.idC;

SELECT nom, labelP FROM Client CROSS JOIN Commande WHERE Client.id = Commande.idC;

--12
SELECT nom FROM Client  
INNER JOIN Commande ON Client.id = Commande.idC
WHERE labelP = 'briques'
ORDER BY nom ;

--13
SELECT label, labelP FROM Fournisseur
JOIN Produit ON  Fournisseur.id =Produit.idF
WHERE DISTINCT label IN('briques','parpaing');

SELECT nom FROM fournisseur
WHERE id IN(
    SELECT idF
    FROM produit
    WHERE label IN('briques','parpaing'));
	
--13.2
SELECT label FROM Produit JOIN fournisseur ON produit.idF = fournisseur.idWHERE ville LIKE '%Paris';

SELECT label FROM Produit, fournisseur WHERE Produit.idF = fournisseur.id AND ville LIKE '%Paris';

SELECT label FROM Produit 
WHERE idF IN(
    SELECT id
    FROM fournisseur 
    WHERE ville LIKE '%Paris');
	
--14
SELECT nom, ville FROM Client
JOIN Commande ON Client.id = Commande.idC
WHERE labelP ='briques' 
AND ((quantite>=10) AND (quantite<16));

--15
SELECT fournisseur.nom, commande.labelP, produit.prix FROM Fournisseur
JOIN Produit ON  Fournisseur.id =Produit.idF
JOIN commande ON produit.label = commande.labelP
JOIN client ON client.id = commande.idC 	
WHERE client.nom='jean';

SELECT fournisseur.nom, commande.labelP, produit.prix FROM Fournisseur, client, commande, produit
WHERE Fournisseur.id = Produit.idF
AND produit.label = commande.labelP
AND client.id = commande.idC 	
AND client.nom='jean';

SELECT nom, produit.label, produit.prix FROM Fournisseur,produit
WHERE Fournisseur.id = Produit.idF
AND label IN
(
    SELECT labelP FROM commande
    WHERE idC IN
    (
    	SELECT id FROM client
        WHERE nom='Jean'
		
    )
);

--16
SELECT nom, produit.label, produit.prix FROM Fournisseur,produit
WHERE Fournisseur.id = Produit.idF
AND label IN
(
    SELECT labelP FROM commande
    WHERE idC IN
    (
    	SELECT id FROM client
        WHERE nom='Jean'
		ORDER BY fournisseur.nom DESC
    )
);

--17
SELECT label, AVG(prix) FROM Produit GROUP BY label;

--18
SELECT label, AVG(prix) as moyene FROM Produit GROUP BY label HAVING moyene>1200;

--20
SELECT  label,AVG(prix) as moyenne FROM Produit
WHERE prix<
(
    SELECT AVG(prix) FROM produit
);

--21
SELECT label, fournisseur.nom, AVG(prix) FROM Produit,fournisseur
WHERE idF = ANY
(
    SELECT id FROM fournisseur
    GROUP BY label
    AND fournisseur.nom =3
);