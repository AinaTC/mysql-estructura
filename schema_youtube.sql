

DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

-- -----------------------------------------------------
-- Table `usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari` (
  `idusuari` INT UNSIGNED AUTO_INCREMENT,
  `nom usuari` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `data naixement` DATE NULL,
  `sexe` ENUM('H', 'M', 'NB','others') NOT NULL,
  `pais` VARCHAR(45) NULL,
  `codi postal` VARCHAR(5) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idusuari`));


-- -----------------------------------------------------
-- Table `canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `canal` (
  `idcanal` INT UNSIGNED AUTO_INCREMENT,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `nom canal` VARCHAR(45) NULL,
  `descripcio` LONGTEXT NULL,
  `data de creaió` DATETIME NULL,
  PRIMARY KEY (`idcanal`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`)
    );


-- -----------------------------------------------------
-- Table `video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video` (
  `idvideo` INT UNSIGNED AUTO_INCREMENT,
  `usuari_que_publica_idusuari` INT UNSIGNED NOT NULL,
  `titol` VARCHAR(45) NULL,
  `descripcio` LONGTEXT NULL,
  `mida` INT NULL,
  `nom arxiu` VARCHAR(45) NULL,
  `durada` TIME NULL,
  `num. reproduccions` INT NULL,
  `thumbnail` VARCHAR(45) NULL,
  `num. likes` INT NULL,
  `num. dislikes` INT NULL,
  `estat` ENUM('públic', 'ocult' , 'privat') NOT NULL,
  `data i hora publicació` DATETIME NULL,
  PRIMARY KEY (`idvideo`),
  FOREIGN KEY (`usuari_que_publica_idusuari`) REFERENCES `usuari` (`idusuari`)
    );


-- -----------------------------------------------------
-- Table `playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playlist` (
  `idplaylist` INT UNSIGNED AUTO_INCREMENT,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `data creacio` DATETIME NULL,
  `nom` VARCHAR(45) NULL,
  `estat` ENUM('pública', 'privada') NOT NULL,
  PRIMARY KEY (`idplaylist`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`)
    );


-- -----------------------------------------------------
-- Table `comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comentari` (
  `idcomentari` INT UNSIGNED AUTO_INCREMENT,
  `text` LONGTEXT NULL,
  `data i hora` DATETIME NULL,
  PRIMARY KEY (`idcomentari`));


-- -----------------------------------------------------
-- Table `etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `etiqueta` (
  `idetiqueta` INT UNSIGNED AUTO_INCREMENT,
  `nom etiqueta` VARCHAR(45) NULL,
  PRIMARY KEY (`idetiqueta`));


-- -----------------------------------------------------
-- Table `usuari_subscriu_canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_subscriu_canal` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `canal_idcanal` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_idusuari`, `canal_idcanal`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`),
  FOREIGN KEY (`canal_idcanal`) REFERENCES `canal` (`idcanal`)
    );


-- -----------------------------------------------------
-- Table `video_has_etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_has_etiqueta` (
  `video_idvideo` INT UNSIGNED NOT NULL,
  `etiqueta_idetiqueta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`video_idvideo`, `etiqueta_idetiqueta`),
  FOREIGN KEY (`video_idvideo`) REFERENCES `video` (`idvideo`),
  FOREIGN KEY (`etiqueta_idetiqueta`) REFERENCES `etiqueta` (`idetiqueta`)
    );


-- -----------------------------------------------------
-- Table `usuari_likes_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_likes_video` (
  `video_idvideo` INT UNSIGNED NOT NULL,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `tipus` ENUM('LIKE','DISLIKE') NOT NULL,
  `data i hora` DATETIME NULL,
  PRIMARY KEY (`video_idvideo`, `usuari_idusuari`),
  FOREIGN KEY (`video_idvideo`) REFERENCES `video` (`idvideo`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`)
    );


-- -----------------------------------------------------
-- Table `usuari_likes_comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_likes_comentari` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `comentari_idcomentari` INT UNSIGNED NOT NULL,
  `tipus` ENUM('LIKE','DISLIKE') NOT NULL,
  `data i hora` DATETIME NULL,
  PRIMARY KEY (`usuari_idusuari`, `comentari_idcomentari`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`),
  FOREIGN KEY (`comentari_idcomentari`) REFERENCES `comentari` (`idcomentari`)
    );


-- -----------------------------------------------------
-- Table `usuari_escriu_comentari_a_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_escriu_comentari_a_video` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `comentari_idcomentari` INT UNSIGNED NOT NULL,
  `video_idvideo` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_idusuari`, `comentari_idcomentari`, `video_idvideo`),
  FOREIGN KEY (`usuari_idusuari`) REFERENCES `usuari` (`idusuari`),
  FOREIGN KEY (`comentari_idcomentari`) REFERENCES `comentari` (`idcomentari`),
  FOREIGN KEY (`video_idvideo`) REFERENCES `video` (`idvideo`)
    );

