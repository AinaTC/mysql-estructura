
DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;
-- -----------------------------------------------------
-- Table  `client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `client` (
  `nom` VARCHAR(55) NULL,
  `email` VARCHAR(255) NULL,
  `tel` VARCHAR(15) NULL,
  `id` INT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
  `adreça` VARCHAR(115) NULL,
  `data registre` DATETIME NULL,
   `id_client_recomenat` INT  UNSIGNED NULL,
   FOREIGN KEY (`id_client_recomenat`) REFERENCES `client` (`id`)
 );


-- -----------------------------------------------------
-- Table `proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveidor` (
  `NIF` VARCHAR(25) NOT NULL,
  `tel` VARCHAR(15) NULL,
  `fax` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `adreça` VARCHAR(45) NULL,
  `país` VARCHAR(45) NULL,
  `codi postal` VARCHAR(45) NULL,
  `ciutat` VARCHAR(45) NULL,
  PRIMARY KEY (`NIF`));


-- -----------------------------------------------------
-- Table `marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marca` (
  `idmarca` INT UNSIGNED AUTO_INCREMENT,
  `nomMarca` VARCHAR(45) NULL,
  `proveidor_NIF` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idmarca`),
  FOREIGN KEY (`proveidor_NIF`) REFERENCES `proveidor` (`NIF`)
);


-- -----------------------------------------------------
-- Table `treballador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treballador` (
  `id` INT UNSIGNED AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulleres` (
  `idulleres` INT UNSIGNED AUTO_INCREMENT,
  `color montura` VARCHAR(25) NULL,
  `color vidres` VARCHAR(25) NULL,
  `preu` DECIMAL NULL,
  `graduacio vidre dreta` DECIMAL NULL,
  `graduacio vidre esquerre` DECIMAL NULL,
  `tipus muntura` ENUM('flotant', 'pasta', 'metàl·lica') NOT NULL,
  `data i hora venta` DATETIME NULL,
  `client_id` INT  UNSIGNED NOT NULL,
  `marca_idmarca` INT  UNSIGNED NOT NULL,
  `treballador_id` INT  UNSIGNED NOT NULL,
  PRIMARY KEY (`idulleres`),
  FOREIGN KEY (`marca_idmarca`) REFERENCES `marca` (`idmarca`),
  FOREIGN KEY (`treballador_id`) REFERENCES `treballador` (`id`),
  FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
);


  INSERT INTO `client` (`nom`,`tel`,`email`,`adreça`,`data registre`,`id_client_recomenat`)
VALUES
  ("Eagan Mathews","02 13 86 88 83","egestas.blandit.nam@aol.org","996 In St.","2021/03/28", Null),
  ("Kylynn Rowe","07 64 14 26 36","et.tristique@protonmail.edu","866-6176 Lectus Avenue","2021/10/17",1),
  ("Jorden Romero","07 73 69 58 34","magna.suspendisse@outlook.ca","Ap #954-1794 Non Avenue","2021/12/09", Null),
  ("Lamar Mclean","04 48 64 90 15","nec.cursus@icloud.couk","897-8155 Aptent Rd.","2021/09/01",1),
  ("Carson Kennedy","07 93 84 84 66","duis.elementum@hotmail.edu","Ap #907-3429 Et Road","2020/10/05",3);
 
  INSERT INTO `proveidor` (`nom`,`tel`,`adreça`,`fax`,`codi postal`,`país`,`ciutat`,`NIF`)
VALUES
  ("Eagan Mathews","02 13 86 88 83","996 In St.","02 94 75 94 47","26875","India","Banjarbaru","QYC35KTP1YX"),
  ("Kylynn Rowe","07 64 14 26 36","866-6176 Lectus Avenue","07 84 67 38 38","65922","Mexico","Asan","CDA87CFC8CX"),
  ("Jorden Romero","07 73 69 58 34","Ap #954-1794 Non Avenue","03 82 50 75 61","10315","Nigeria","Tharparkar","PKD81WWM8SL"),
  ("Lamar Mclean","04 48 64 90 15","897-8155 Aptent Rd.","04 76 84 64 91","85151","United Kingdom","Solok","POZ41UVU3VP"),
  ("Carson Kennedy","07 93 84 84 66","Ap #907-3429 Et Road","02 46 43 14 55","62012","Germany","Delft","UBK58GMV2GI");

INSERT INTO `marca` (`nomMarca`,`proveidor_NIF`)
VALUES
  ("Neque PC","QYC35KTP1YX"),
  ("Elit A Foundation","QYC35KTP1YX"),
  ("Aliquam Tincidunt Ltd","POZ41UVU3VP"),
  ("Nec Leo Foundation","UBK58GMV2GI"),
  ("Gravida Aliquam LLP","CDA87CFC8CX");
  
  INSERT INTO `treballador` (`nom`)
VALUES
  ("Darryl Davenport"),
  ("Nicholas Leach"),
  ("Rhiannon Salinas"),
  ("Charity Potts"),
  ("Heather Reed");

  
INSERT INTO `ulleres` (`preu`,`graduacio vidre dreta`,`graduacio vidre esquerre`,`data i hora venta`,`color montura`,`color vidres`,`tipus muntura`,`client_id`,`marca_idmarca`, `treballador_id`)
VALUES
  (334,-7.06,3.23,"2021-12-17 00:30:17","verd","transparent","flotant",1,1,1),
  (175,-3.34,0.67,"2022-05-16 18:09:48","gris","transparent","pasta",1,2,2),
  (360,0.94,1.61,"2021-03-15 05:01:03","negre","groc","metàl·lica",2,3,3),
  (221,3.84,-2.83,"2022-03-05 05:32:02","rosa","groc","flotant",2,1,4),
  (313,-0.13,0.96,"2021-06-05 22:07:08","marró","verd","pasta",3,2,5);

  -- Llista el total de factures d'un client en un període determinat
  select count(*) as total_factures from ulleres as u left join client as c on u.client_id = c.id where c.nom="Jorden Romero" AND u.`data i hora venta` between '2020-03-17 06:42:10' and '2022-03-17 07:42:50' group by client_id;

-- Llista els diferents models d'ulleres que ha venut un empleat durant un any
 select u.* from ulleres as u left join treballador as t on t.id = u.treballador_id where t.nom="Heather Reed" AND  year(u.`data i hora venta`) = 2021;

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica
select * from proveidor where NIF IN (select m.proveidor_NIF from marca as m inner join ulleres as u on u.marca_idmarca = m.idmarca);
