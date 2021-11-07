DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

-- -----------------------------------------------------
-- Table `usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari` (
  `idusuari` INT UNSIGNED AUTO_INCREMENT,
  `nom usuari` VARCHAR(45) NULL,
  `email` VARCHAR(115) NULL,
  `password` VARCHAR(45) NULL,
  `sexe` ENUM('H', 'M', 'NB','others') NOT NULL,
  `data de naixement` DATE NULL,
  `país` VARCHAR(45) NULL,
  `codi postall` VARCHAR(45) NULL,
  `tipus` ENUM('free', 'premium') NOT NULL,
  PRIMARY KEY (`idusuari`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playlist` (
  `idplaylist` INT UNSIGNED AUTO_INCREMENT,
  `títol` VARCHAR(115) NULL,
  `num. cançons` INT NULL,
  `data creació` DATE NULL,
  `esEliminada` BINARY NOT NULL,
  `data eliminació` DATE NULL,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idplaylist`),
  INDEX `fk_playlist_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artista` (
  `idartista` INT UNSIGNED AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `img` BLOB NULL,
  PRIMARY KEY (`idartista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `album` (
  `idalbum` INT UNSIGNED AUTO_INCREMENT,
  `títol` VARCHAR(45) NULL,
  `any de publicació` INT NULL,
  `img portada` BLOB NULL,
  `artista_idartista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idalbum`),
  INDEX `fk_album_artista1_idx` (`artista_idartista` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_idartista`)
    REFERENCES `artista` (`idartista`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cançó`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cançó` (
  `idcançó` INT UNSIGNED AUTO_INCREMENT,
  `títol` VARCHAR(45) NULL,
  `durada` TIME NULL,
  `num. reproduccions` BIGINT NULL,
  `album_idalbum` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idcançó`),
  INDEX `fk_cançó_album_idx` (`album_idalbum` ASC) VISIBLE,
  CONSTRAINT `fk_cançó_album`
    FOREIGN KEY (`album_idalbum`)
    REFERENCES `album` (`idalbum`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `info pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `info pagament` (
  `idinfo_pagament` INT UNSIGNED AUTO_INCREMENT,
  `nom usuari paypal` VARCHAR(45) NULL,
  `num targeta` VARCHAR(45) NULL,
  `mes/any caducitat` VARCHAR(45) NULL,
  `codi seguretat` VARCHAR(5) NULL,
  PRIMARY KEY (`idinfo_pagament`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `subscripció`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `subscripció` (
  `idsubscripció` INT UNSIGNED AUTO_INCREMENT,
  `data inici` DATE NULL,
  `data renovació` DATE NULL,
  `forma de pagament` ENUM('crèdit','paypal') NOT NULL,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `info pagament_idinfo_pagament` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idsubscripció`),
  INDEX `fk_subscripció_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  INDEX `fk_subscripció_info pagament1_idx` (`info pagament_idinfo_pagament` ASC) VISIBLE,
  CONSTRAINT `fk_subscripció_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`) ,
  CONSTRAINT `fk_subscripció_info pagament1`
    FOREIGN KEY (`info pagament_idinfo_pagament`)
    REFERENCES `info pagament` (`idinfo_pagament`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuari_afegeix_cançó_a_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_afegeix_cançó_a_playlist` (
  `playlist_idplaylist` INT UNSIGNED NOT NULL,
  `cançó_idcançó` INT UNSIGNED NOT NULL,
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`playlist_idplaylist`, `cançó_idcançó`, `usuari_idusuari`),
  INDEX `fk_playlist_has_cançó_cançó1_idx` (`cançó_idcançó` ASC) VISIBLE,
  INDEX `fk_playlist_has_cançó_playlist1_idx` (`playlist_idplaylist` ASC) VISIBLE,
  INDEX `fk_playlist_has_cançó_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_cançó_playlist1`
    FOREIGN KEY (`playlist_idplaylist`)
    REFERENCES `playlist` (`idplaylist`)
    ,
  CONSTRAINT `fk_playlist_has_cançó_cançó1`
    FOREIGN KEY (`cançó_idcançó`)
    REFERENCES `cançó` (`idcançó`)
    ,
  CONSTRAINT `fk_playlist_has_cançó_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagament` (
  `num. d'ordre` INT NOT NULL,
  `total` DECIMAL NULL,
  `data` DATE NULL,
  `subscripció_idsubscripció` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`num. d'ordre`),
  INDEX `fk_pagament_subscripció1_idx` (`subscripció_idsubscripció` ASC) VISIBLE,
  CONSTRAINT `fk_pagament_subscripció1`
    FOREIGN KEY (`subscripció_idsubscripció`)
    REFERENCES `subscripció` (`idsubscripció`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuari_segueix_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_segueix_artista` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `artista_idartista` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_idusuari`, `artista_idartista`),
  INDEX `fk_usuari_has_artista_artista1_idx` (`artista_idartista` ASC) VISIBLE,
  INDEX `fk_usuari_has_artista_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_has_artista_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`),
  CONSTRAINT `fk_usuari_has_artista_artista1`
    FOREIGN KEY (`artista_idartista`)
    REFERENCES `artista` (`idartista`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artista_relaciona_artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `artista_relaciona_artista` (
  `artista_idartista` INT UNSIGNED NOT NULL,
  `artista_idartista1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`artista_idartista`, `artista_idartista1`),
  INDEX `fk_artista_has_artista_artista2_idx` (`artista_idartista1` ASC) VISIBLE,
  INDEX `fk_artista_has_artista_artista1_idx` (`artista_idartista` ASC) VISIBLE,
  CONSTRAINT `fk_artista_has_artista_artista1`
    FOREIGN KEY (`artista_idartista`)
    REFERENCES `artista` (`idartista`)
    ,
  CONSTRAINT `fk_artista_has_artista_artista2`
    FOREIGN KEY (`artista_idartista1`)
    REFERENCES `artista` (`idartista`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuari_té_cançó_favorita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_té_cançó_favorita` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `cançó_idcançó` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_idusuari`, `cançó_idcançó`),
  INDEX `fk_usuari_has_cançó_cançó1_idx` (`cançó_idcançó` ASC) VISIBLE,
  INDEX `fk_usuari_has_cançó_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_has_cançó_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`)
    ,
  CONSTRAINT `fk_usuari_has_cançó_cançó1`
    FOREIGN KEY (`cançó_idcançó`)
    REFERENCES `cançó` (`idcançó`)
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `usuari_té_album_favorit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuari_té_album_favorit` (
  `usuari_idusuari` INT UNSIGNED NOT NULL,
  `album_idalbum` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuari_idusuari`, `album_idalbum`),
  INDEX `fk_usuari_has_album_album1_idx` (`album_idalbum` ASC) VISIBLE,
  INDEX `fk_usuari_has_album_usuari1_idx` (`usuari_idusuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_has_album_usuari1`
    FOREIGN KEY (`usuari_idusuari`)
    REFERENCES `usuari` (`idusuari`)
    ,
  CONSTRAINT `fk_usuari_has_album_album1`
    FOREIGN KEY (`album_idalbum`)
    REFERENCES `album` (`idalbum`)
    )
ENGINE = InnoDB;


