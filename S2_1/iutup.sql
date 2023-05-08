-- MySQL Script generated by MySQL Workbench
-- Wed Apr 26 13:06:59 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`usuari` (
  `user_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(15) NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `birthdate` DATE,
  `sex` ENUM('man', 'female') NOT NULL,
  `country` VARCHAR(25) NOT NULL,
  `zipcode` VARCHAR(5) NOT NULL,
  `video` INT NOT NULL,
  `playlist` INT NOT NULL,
  `canal` INT NOT NULL,
  `likes` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_video_usuari` (`video` ASC) VISIBLE,
  INDEX `fk_playlist_usuari` (`playlist` ASC) VISIBLE,
  INDEX `fk_canal_usuari` (`canal` ASC) VISIBLE,
  INDEX `fk_likes_usuari` (`likes` ASC) VISIBLE,
  CONSTRAINT `fk_canal_usuari` FOREIGN KEY (`canal`) REFERENCES `youtube`.`canal` (`chanel_id`),
  CONSTRAINT `fk_likes_usuari` FOREIGN KEY (`likes`) REFERENCES `youtube`.`likes` (`likes_id`),
  CONSTRAINT `fk_playlist_usuari` FOREIGN KEY (`playlist`) REFERENCES `youtube`.`playlist` (`playlist_id`),
  CONSTRAINT `fk_video_usuari` FOREIGN KEY (`video`) REFERENCES `youtube`.`video` (`video_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `playlist_id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `date` DATE NOT NULL,
  `state` ENUM('public', 'private') NOT NULL,
  PRIMARY KEY (`playlist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`video` (
  `video_id` INT NOT NULL,
  `title` VARCHAR(15) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `sizeMB` INT NOT NULL,
  `file_name` VARCHAR(15) NOT NULL,
  `duration_minutes` INT NOT NULL,
  `thumbnail` BLOB NULL DEFAULT NULL,
  `reproductions` INT NULL DEFAULT NULL,
  `state` ENUM('public', 'private', 'hidden') NOT NULL,
  `publication` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` INT NOT NULL,
  `comentaris` INT NOT NULL,
  `etiquetes` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_likes_video` (`likes` ASC) VISIBLE,
  INDEX `fk_comentaris_video` (`comentaris` ASC) VISIBLE,
  INDEX `fk_etiquetes_video` (`etiquetes` ASC) VISIBLE,
  CONSTRAINT `fk_comentaris_video` FOREIGN KEY (`comentaris`) REFERENCES `youtube`.`comentaris` (`comments_id`),
  CONSTRAINT `fk_etiquetes_video` FOREIGN KEY (`etiquetes`) REFERENCES `youtube`.`etiquetes` (`label_id`),
  CONSTRAINT `fk_likes_video` FOREIGN KEY (`likes`) REFERENCES `youtube`.`likes` (`likes_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`contentP`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`contentP` (
  `playlist_playlist_id` INT NOT NULL,
  `video_video_id` INT NOT NULL,
  INDEX `fk_contentP_playlist_idx` (`playlist_playlist_id` ASC) VISIBLE,
  INDEX `fk_contentP_video1_idx` (`video_video_id` ASC) VISIBLE,
  CONSTRAINT `fk_contentP_playlist` FOREIGN KEY (`playlist_playlist_id`) REFERENCES `youtube`.`playlist` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contentP_video1` FOREIGN KEY (`video_video_id`) REFERENCES `youtube`.`video` (`video_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `youtube`.`agrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`agrada` (
  `enjoy_id` INT NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `opinion` ENUM('like', 'dislike') NULL DEFAULT NULL,
  PRIMARY KEY (`enjoy_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`likes` (
  `likes_id` INT NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `opinion` ENUM('like', 'dislike') NULL DEFAULT NULL,
  PRIMARY KEY (`likes_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`subscripcio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`subscripcio` (
  `subscription_id` INT NOT NULL,
  PRIMARY KEY (`subscription_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`canal` (
  `chanel_id` INT NOT NULL,
  `name` VARCHAR(25) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user` INT NOT NULL,
  `subscripcio` INT NOT NULL,
  `likes` INT NOT NULL,
  PRIMARY KEY (`chanel_id`),
  INDEX `fk_subscripcio_canal` (`subscripcio` ASC) VISIBLE,
  INDEX `fk_likes_canal` (`likes` ASC) VISIBLE,
  CONSTRAINT `fk_likes_canal` FOREIGN KEY (`likes`) REFERENCES `youtube`.`likes` (`likes_id`),
  CONSTRAINT `fk_subscripcio_canal` FOREIGN KEY (`subscripcio`) REFERENCES `youtube`.`subscripcio` (`subscription_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`comentaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentaris` (
  `comments_id` INT NOT NULL,
  `text` VARCHAR(255) NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `agrada` INT NOT NULL,
  PRIMARY KEY (`comments_id`),
  INDEX `fk_agrada_comentaris` (`agrada` ASC) VISIBLE,
  CONSTRAINT `fk_agrada_comentaris` FOREIGN KEY (`agrada`) REFERENCES `youtube`.`agrada` (`enjoy_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`etiquetes` (
  `label_id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`label_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `youtube`.`publication`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`publication` (
  `publication_id` INT NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `usuari` INT NOT NULL,
  PRIMARY KEY (`publication_id`),
  INDEX `fk_usuari_publication` (`usuari` ASC) VISIBLE,
  CONSTRAINT `fk_usuari_publication`
    FOREIGN KEY (`usuari`)
    REFERENCES `youtube`.`usuari` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `youtube`.`usuari` (user_id, email, password, name, birthdate, sex, country, zipcode, video, playlist, canal, likes) VALUES
	(1, 'A1@gmail.com', '1111', 'A1', NULL, 'man', 'spain', '08008', 1, 1, 1, 1);
INSERT INTO `youtube`.`playlist` (playlist_id, name, date, state) VALUES
	(1, 'Playlist1', '2023-01-01', 'public');
INSERT INTO `youtube`.`video` (video_id, title, description, sizeMB, file_name, duration_minutes, thumbnail, reproductions, state, publication, likes, comentaris, etiquetes) VALUES
	(1, 'Video1', 'Video guapo guapo', '111', 'video1.mp4', '5', NULL, 3, 'public', NULL, 1, 1, 1);
INSERT INTO `youtube`.`contentP` (playlist_playlist_id, video_video_id) VALUES
	(1, 1);
INSERT INTO `youtube`.`agrada` (enjoy_id, date, opinion) VALUES
	(1, NULL, 'like');
INSERT INTO `youtube`.`likes` (likes_id, date, opinion) VALUES
	(1, NULL, 'like'),
    (2, NULL, 'like');
INSERT INTO `youtube`.`subscripcio` (subscription_id) VALUES
	(1);
INSERT INTO `youtube`.`canal` (chanel_id, name, description, date, user, subscripcio, likes) VALUES
	(1, 'Canal1', 'Super canal número 1', NULL, 1, 1, 1);
INSERT INTO `youtube`.`comentaris` (comments_id, text, date, agrada) VALUES
	(1, 'Comentari', NULL, '1');
INSERT INTO `youtube`.`etiquetes` (label_id, name) VALUES
	(1, 'Etiqueta 1');
INSERT INTO `youtube`.`publication` (publication_id, date, usuari) VALUES
	(1, NULL, 1);
