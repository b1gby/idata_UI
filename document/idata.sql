-- MySQL Script generated by MySQL Workbench
-- Fri Jul 26 16:51:08 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `u_id` INT NOT NULL AUTO_INCREMENT,
  `pwd` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `unit` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `t_id` VARCHAR(45) NULL,
  PRIMARY KEY (`u_id`),
  UNIQUE INDEX `u_id_UNIQUE` (`u_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ResearchInsitution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ResearchInsitution` (
  `ri_id` INT NOT NULL AUTO_INCREMENT,
  `ri_name` VARCHAR(45) NULL,
  `head_name` VARCHAR(45) NULL,
  `contacts` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `introduce` VARCHAR(45) NULL,
  PRIMARY KEY (`ri_id`),
  UNIQUE INDEX `ri_id_UNIQUE` (`ri_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataResource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataResource` (
  `dr_id` INT NOT NULL AUTO_INCREMENT,
  `api` VARCHAR(45) NULL,
  `introduce` VARCHAR(45) NULL,
  `access_count` VARCHAR(45) NULL,
  `ri_id` INT NOT NULL,
  PRIMARY KEY (`dr_id`, `ri_id`),
  UNIQUE INDEX `dr_id_UNIQUE` (`dr_id` ASC) VISIBLE,
  INDEX `fk_DataResource_ResearchInsitution1_idx` (`ri_id` ASC) VISIBLE,
  CONSTRAINT `fk_DataResource_ResearchInsitution1`
    FOREIGN KEY (`ri_id`)
    REFERENCES `mydb`.`ResearchInsitution` (`ri_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataTags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataTags` (
  `t_id` INT NOT NULL AUTO_INCREMENT,
  `tagname` VARCHAR(45) NULL,
  PRIMARY KEY (`t_id`),
  UNIQUE INDEX `t_id_UNIQUE` (`t_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataResource_has_DataTags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataResource_has_DataTags` (
  `DataResource_dr_id` INT NOT NULL,
  `DataTags_t_id` INT NOT NULL,
  PRIMARY KEY (`DataResource_dr_id`, `DataTags_t_id`),
  INDEX `fk_DataResource_has_DataTags_DataTags1_idx` (`DataTags_t_id` ASC) VISIBLE,
  INDEX `fk_DataResource_has_DataTags_DataResource1_idx` (`DataResource_dr_id` ASC) VISIBLE,
  CONSTRAINT `fk_DataResource_has_DataTags_DataResource1`
    FOREIGN KEY (`DataResource_dr_id`)
    REFERENCES `mydb`.`DataResource` (`dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DataResource_has_DataTags_DataTags1`
    FOREIGN KEY (`DataTags_t_id`)
    REFERENCES `mydb`.`DataTags` (`t_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Achievement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Achievement` (
  `a_id` INT NOT NULL AUTO_INCREMENT,
  `detail` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `u_id` INT NOT NULL,
  `dr_id` INT NOT NULL,
  PRIMARY KEY (`a_id`, `u_id`, `dr_id`),
  UNIQUE INDEX `a_id_UNIQUE` (`a_id` ASC) VISIBLE,
  INDEX `fk_Achievement_Users1_idx` (`u_id` ASC) VISIBLE,
  INDEX `fk_Achievement_DataResource1_idx` (`dr_id` ASC) VISIBLE,
  CONSTRAINT `fk_Achievement_Users1`
    FOREIGN KEY (`u_id`)
    REFERENCES `mydb`.`Users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Achievement_DataResource1`
    FOREIGN KEY (`dr_id`)
    REFERENCES `mydb`.`DataResource` (`dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AchieveType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AchieveType` (
  `at_id` INT NOT NULL,
  `typename` VARCHAR(45) NULL,
  `a_id` INT NOT NULL,
  PRIMARY KEY (`at_id`, `a_id`),
  INDEX `fk_AchieveType_Achievement1_idx` (`a_id` ASC) VISIBLE,
  CONSTRAINT `fk_AchieveType_Achievement1`
    FOREIGN KEY (`a_id`)
    REFERENCES `mydb`.`Achievement` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Scores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Scores` (
  `s_id` INT NOT NULL AUTO_INCREMENT,
  `point` INT NULL,
  `dr_id` INT NOT NULL,
  `u_id` INT NOT NULL,
  PRIMARY KEY (`s_id`, `dr_id`, `u_id`),
  UNIQUE INDEX `s_id_UNIQUE` (`s_id` ASC) VISIBLE,
  INDEX `fk_Scores_DataResource1_idx` (`dr_id` ASC) VISIBLE,
  INDEX `fk_Scores_Users1_idx` (`u_id` ASC) VISIBLE,
  CONSTRAINT `fk_Scores_DataResource1`
    FOREIGN KEY (`dr_id`)
    REFERENCES `mydb`.`DataResource` (`dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Scores_Users1`
    FOREIGN KEY (`u_id`)
    REFERENCES `mydb`.`Users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LoginRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LoginRecord` (
  `lr_id` INT NOT NULL AUTO_INCREMENT,
  `login_time` DATE NULL,
  `login_ip` VARCHAR(45) NULL,
  `uid` INT NOT NULL,
  PRIMARY KEY (`lr_id`, `uid`),
  UNIQUE INDEX `lr_id_UNIQUE` (`lr_id` ASC) VISIBLE,
  INDEX `fk_LoginRecord_Users1_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `fk_LoginRecord_Users1`
    FOREIGN KEY (`uid`)
    REFERENCES `mydb`.`Users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ApplyRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ApplyRecord` (
  `ar_id` INT NOT NULL AUTO_INCREMENT,
  `apply_time` DATE NULL,
  `secret_key` VARCHAR(45) NULL,
  `ui_d` INT NOT NULL,
  `dr_id` INT NOT NULL,
  PRIMARY KEY (`ar_id`, `ui_d`, `dr_id`),
  UNIQUE INDEX `ar_id_UNIQUE` (`ar_id` ASC) VISIBLE,
  INDEX `fk_ApplyRecord_Users1_idx` (`ui_d` ASC) VISIBLE,
  INDEX `fk_ApplyRecord_DataResource1_idx` (`dr_id` ASC) VISIBLE,
  CONSTRAINT `fk_ApplyRecord_Users1`
    FOREIGN KEY (`ui_d`)
    REFERENCES `mydb`.`Users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ApplyRecord_DataResource1`
    FOREIGN KEY (`dr_id`)
    REFERENCES `mydb`.`DataResource` (`dr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DataSubmit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DataSubmit` (
  `ds_id` INT NOT NULL AUTO_INCREMENT,
  `sub_time` VARCHAR(45) NULL,
  `contacts` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `uid` INT NOT NULL,
  PRIMARY KEY (`ds_id`, `uid`),
  UNIQUE INDEX `ds_id_UNIQUE` (`ds_id` ASC) VISIBLE,
  INDEX `fk_DataSubmit_Users1_idx` (`uid` ASC) VISIBLE,
  CONSTRAINT `fk_DataSubmit_Users1`
    FOREIGN KEY (`uid`)
    REFERENCES `mydb`.`Users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;