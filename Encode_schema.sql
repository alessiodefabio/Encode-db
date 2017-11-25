-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema encode
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema encode
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `encode` DEFAULT CHARACTER SET utf8 ;
USE `encode` ;

-- -----------------------------------------------------
-- Table `encode`.`topicmaps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`topicmaps` (
  `topicMap_id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  `version` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`topicMap_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`efforts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`efforts` (
  `effort_id` INT(11) NOT NULL AUTO_INCREMENT,
  `effortType` VARCHAR(20) NULL DEFAULT NULL,
  `effort` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`effort_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`scopes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`scopes` (
  `scope_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `effort_id` INT(11) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`scope_id`),
  INDEX `effort_id` (`effort_id` ASC),
  CONSTRAINT `scopes_ibfk_1`
    FOREIGN KEY (`effort_id`)
    REFERENCES `encode`.`efforts` (`effort_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`usersinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`usersinfo` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(15) NOT NULL,
  `password` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `role` VARCHAR(10) NULL DEFAULT NULL,
  `reg_date` TIMESTAMP(4) NULL DEFAULT NULL,
  `is_active` TINYINT(4) NULL DEFAULT NULL,
  UNIQUE INDEX `users_user_id_pk` (`user_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`topictypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`topictypes` (
  `topicType_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `description` VARCHAR(50) NULL DEFAULT NULL,
  `user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`topicType_id`),
  INDEX `topictypes` (`user_id` ASC),
  CONSTRAINT `topictypes_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `encode`.`usersinfo` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`topics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`topics` (
  `topic_id` INT(11) NOT NULL AUTO_INCREMENT,
  `topicMap_id` INT(11) NOT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `subjectLocator` VARCHAR(50) NULL DEFAULT NULL,
  `subjectIdentifier` VARCHAR(50) NULL DEFAULT NULL,
  `scope_id` INT(11) NULL DEFAULT NULL,
  `topicType_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  INDEX `topic_ibfk_1` (`topicMap_id` ASC),
  INDEX `topic_ibfk_2` (`scope_id` ASC),
  INDEX `topics_topic_id_index` (`topic_id` ASC),
  INDEX `topic_ibfk_3` (`topicType_id` ASC),
  CONSTRAINT `topic_ibfk_1`
    FOREIGN KEY (`topicMap_id`)
    REFERENCES `encode`.`topicmaps` (`topicMap_id`),
  CONSTRAINT `topic_ibfk_2`
    FOREIGN KEY (`scope_id`)
    REFERENCES `encode`.`scopes` (`scope_id`),
  CONSTRAINT `topic_ibfk_3`
    FOREIGN KEY (`topicType_id`)
    REFERENCES `encode`.`topictypes` (`topicType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`associations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`associations` (
  `association_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `description` VARCHAR(20) NULL DEFAULT NULL,
  `scope_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`association_id`),
  INDEX `scope_id` (`scope_id` ASC),
  CONSTRAINT `associations_ibfk_1`
    FOREIGN KEY (`scope_id`)
    REFERENCES `encode`.`scopes` (`scope_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`associatedtopic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`associatedtopic` (
  `associatedTopic_id` INT(11) NOT NULL,
  `topic_id_in` INT(11) NOT NULL,
  `topic_id_out` INT(11) NOT NULL,
  `association_id` INT(11) NOT NULL,
  PRIMARY KEY (`associatedTopic_id`),
  INDEX `associatedtopic_ibfk_idx` (`topic_id_in` ASC),
  INDEX `associatedtopic_ibfk2` (`association_id` ASC),
  CONSTRAINT `associatedtopic_ibfk`
    FOREIGN KEY (`topic_id_in`)
    REFERENCES `encode`.`topics` (`topic_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `associatedtopic_ibfk2`
    FOREIGN KEY (`association_id`)
    REFERENCES `encode`.`associations` (`association_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`learningpath`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`learningpath` (
  `learningpath_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NULL DEFAULT NULL,
  `learningPath` JSON NULL DEFAULT NULL,
  PRIMARY KEY (`learningpath_id`),
  INDEX `learningPath_users_id_fk` (`user_id` ASC),
  CONSTRAINT `learningPath_users_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `encode`.`usersinfo` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`mapping` (
  `mapping_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `topicmap_id` INT(11) NOT NULL,
  `creation_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mapping_id`),
  INDEX `mapping_ibfk_idx` (`user_id` ASC),
  INDEX `mapping_ibfk2_idx` (`topicmap_id` ASC),
  CONSTRAINT `mapping_ibfk`
    FOREIGN KEY (`user_id`)
    REFERENCES `encode`.`usersinfo` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mapping_ibfk2`
    FOREIGN KEY (`topicmap_id`)
    REFERENCES `encode`.`topicmaps` (`topicMap_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`occurrences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`occurrences` (
  `occurrence_id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_value` INT(11) NULL DEFAULT NULL,
  `scope_id` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `data_reference` VARCHAR(50) NULL DEFAULT NULL,
  `topic_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`occurrence_id`),
  INDEX `scope_id` (`scope_id` ASC),
  INDEX `occurrences_topics_topic_id_fk` (`topic_id` ASC),
  CONSTRAINT `occurrences_ibfk_2`
    FOREIGN KEY (`scope_id`)
    REFERENCES `encode`.`scopes` (`scope_id`),
  CONSTRAINT `occurrences_topics_topic_id_fk`
    FOREIGN KEY (`topic_id`)
    REFERENCES `encode`.`topics` (`topic_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `encode`.`variantname`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `encode`.`variantname` (
  `variantName_id` INT(11) NOT NULL AUTO_INCREMENT,
  `topic_id` INT(11) NULL DEFAULT NULL,
  `variantname` VARCHAR(20) NULL DEFAULT NULL,
  `scope_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`variantName_id`),
  INDEX `topic_id` (`topic_id` ASC),
  INDEX `variantname_scopes_scope_id_fk` (`scope_id` ASC),
  CONSTRAINT `variantname_ibfk_1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `encode`.`topics` (`topic_id`),
  CONSTRAINT `variantname_scopes_scope_id_fk`
    FOREIGN KEY (`scope_id`)
    REFERENCES `encode`.`scopes` (`scope_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

