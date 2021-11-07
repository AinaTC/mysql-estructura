DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;
-- -----------------------------------------------------
-- Table `provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `provincia` (
  `idprovincia` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `nom` VARCHAR(45) NULL);


-- -----------------------------------------------------
-- Table `localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localitat` (
  `idlocalitat` INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY ,
  `nom` VARCHAR(115) NULL,
   `provincia_idprovincia` INT UNSIGNED NOT NULL,
  FOREIGN KEY( `provincia_idprovincia`)  REFERENCES `provincia` (`idprovincia`)
    );


-- -----------------------------------------------------
-- Table `botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `botiga` (
  `idbotiga` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
  `adreça` VARCHAR(225) NULL,
  `codi postal` VARCHAR(5) NULL,
  `localitat_idlocalitat` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`localitat_idlocalitat`) REFERENCES `localitat` (`idlocalitat` )
    );


-- -----------------------------------------------------
-- Table `categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `categoria` (
  `idcategoria` INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  `nom` VARCHAR(45) NULL
  );


-- -----------------------------------------------------
-- Table `treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treballador` (
  `idtreballador` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY  ,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(115) NULL,
  `NIF` VARCHAR(45) NULL,
  `tel.` VARCHAR(45) NULL,
  `tipus` ENUM('cuiner','repartidor') NOT NULL,
  `botiga_idbotiga` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`botiga_idbotiga`) REFERENCES `botiga` (`idbotiga`)
    );


-- -----------------------------------------------------
-- Table `client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `client` (
  `idclient` INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  `nom` VARCHAR(45) NULL,
  `cognoms` VARCHAR(115) NULL,
  `adreça` VARCHAR(225) NULL,
  `codi postal` VARCHAR(5) NULL,
  `tel.` VARCHAR(15) NULL,
  `localitat_idlocalitat` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`localitat_idlocalitat`)  REFERENCES `localitat` (`idlocalitat` )
    );


-- -----------------------------------------------------
-- Table `comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comanda` (
  `idcomanda` INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  `recollida` ENUM('a domicili','a botiga') NOT NULL,
  `preu total` DECIMAL NULL,
  `data i hora` DATETIME NULL,
  `num. pizzes` INT NULL,
  `num. hamburgueses` INT NULL,
  `num. begudes` INT NULL,
  `data i hora lliurament` DATETIME NULL,
  `treballador_idtreballador` INT UNSIGNED NOT NULL,
  `client_idclient` INT UNSIGNED NOT NULL,
  `botiga_idbotiga` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`treballador_idtreballador`) REFERENCES `treballador` (`idtreballador`),
  FOREIGN KEY (`client_idclient`) REFERENCES `client` (`idclient`),
  FOREIGN KEY (`botiga_idbotiga`) REFERENCES `botiga` (`idbotiga`)
    );


-- -----------------------------------------------------
-- Table `producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `producte` (
  `idproducte` INT  UNSIGNED  AUTO_INCREMENT   PRIMARY KEY,
  `descripció` TEXT NULL,
  `imatge` BLOB NULL,
  `preu` DECIMAL NULL,
  `tipus` ENUM('pizza','hamburguesa','beguda') NOT NULL,
  `nom` VARCHAR(45) NULL,
  `categoria_idcategoria` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`categoria_idcategoria`) REFERENCES `categoria` (`idcategoria`)
    );


-- -----------------------------------------------------
-- Table `comanda_has_producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comanda_has_producte` (
  `comanda_idcomanda` INT UNSIGNED  NOT NULL,
  `producte_idproducte` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`comanda_idcomanda`, `producte_idproducte`),
  FOREIGN KEY (`comanda_idcomanda`)    REFERENCES `comanda` (`idcomanda`),
  FOREIGN KEY (`producte_idproducte`)    REFERENCES `producte` (`idproducte`)
    );


INSERT INTO `provincia` (`nom`)
VALUES
  ("Sussex"),
  ("Cà Mau"),
  ("Lima"),
  ("Gangwon"),
  ("Herefordshire");


  INSERT INTO `localitat` (`nom`,`provincia_idprovincia`)
VALUES
  ("Sibolga",1),
  ("Velden am Wörther See",2),
  ("Almere",3),
  ("Silvassa",1),
  ("Acosse",2);


INSERT INTO `botiga` (`adreça`,`codi postal`,`localitat_idlocalitat`)
VALUES
  ("P.O. Box 416, 1503 Eget St.","73725",1),
  ("P.O. Box 919, 1321 Tempor Ave","34668",2),
  ("P.O. Box 877, 6237 Ipsum St.","22162",3),
  ("Ap #816-4136 Etiam St.","22328",4),
  ("Ap #704-2594 Lorem St.","32863",5);

INSERT INTO `categoria` (`nom`)
VALUES
  ("Linda"),
  ("TaShya"),
  ("Karly"),
  ("Sheila"),
  ("Sacha");

  
INSERT INTO `treballador` (`nom`,`cognoms`,`tel.`,`tipus`,`NIF`,`botiga_idbotiga`)
VALUES
  ("Elizabeth","Barnes","07 76 18 83 98","cuiner","GVN06DHN5PY",1),
  ("Grady","Savage","06 62 58 78 27","cuiner","USQ53PJB6PT",1),
  ("Hayden","Reese","09 47 95 36 67","repartidor","JTB12WCB0UJ",2),
  ("Jared","Dunn","08 78 55 26 03","repartidor","BEF94JFL9FO",2),
  ("Rowan","Moore","01 38 36 63 64","cuiner","RNL68QQI1MU",1);

INSERT INTO `client` (`nom`,`cognoms`,`tel.`,`adreça`,`codi postal`,`localitat_idlocalitat`)
VALUES
  ("Elizabeth","Barnes","07 76 18 83 98","2239 Luctus Ave","29617",1),
  ("Grady","Savage","06 62 58 78 27","150-2492 Habitant Road","68522",1),
  ("Hayden","Reese","09 47 95 36 67","Ap #225-3658 Et, Street","71697",2),
  ("Jared","Dunn","08 78 55 26 03","572-2388 Enim, Rd.","60808",2),
  ("Rowan","Moore","01 38 36 63 64","P.O. Box 168, 7441 Aliquet St.","52249",3);

  INSERT INTO `comanda` (`recollida`,`preu total`,`data i hora`,`treballador_idtreballador`,`client_idclient`,`botiga_idbotiga`)
VALUES
  ('a domicili',29,"2022-11-06 17:41:58",3,1,1),
  ('a domicili',94,"2022-07-19 12:04:32",3,1,1),
  ('a botiga',62,"2021-11-26 18:40:04",3,2,2),
  ('a botiga',88,"2022-04-19 05:21:42",4,2,2),
  ('a domicili',39,"2021-05-25 12:57:26",4,1,1);

INSERT INTO `producte` (`tipus`,`descripció`,`categoria_idcategoria`,`nom`)
VALUES
  ("pizza","sem elit, pharetra",1,"4 formatges"),
  ("pizza","aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus",1,"Margarita"),
  ("hamburguesa","aliquet. Phasellus fermentum convallis ligula. Donec luctus",2,"Pollastre"),
  ("hamburguesa","aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio.",2,"Vegetal"),
  ("beguda","amet massa. Quisque porttitor eros nec",1,"Fanta");

  INSERT INTO `comanda_has_producte` (`comanda_idcomanda`,`producte_idproducte`)
VALUES
  (1,2),
  (1,5),
  (2,2),
  (2,3),
  (3,4);


-- Llista quants productes de la categoria 'begudes' s'han venut en una determinada localitat
select count(p.tipus) as `begudes venudes` from comanda_has_producte as cp left join producte as p on cp.producte_idproducte = p.idproducte left join categoria as c on c.idcategoria = p.categoria_idcategoria group by p.tipus having p.tipus = "beguda" ;

-- Llista quantes comandes ha efectuat un determinat empleat
select count(*) as `comandes repartides` from comanda as c left join treballador as t on c.treballador_idtreballador = t.idtreballador where t.nom ="Jared" AND t.cognoms = "Dunn" group by t.idtreballador;
