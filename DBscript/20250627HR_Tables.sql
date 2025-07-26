-- MySQL Workbench Synchronization
-- Generated: 2025-06-28 16:41
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

CREATE TABLE IF NOT EXISTS `Elecon`.`PUNISHMENT_TYPES` (
  `punish_code` INT(11) NOT NULL AUTO_INCREMENT,
  `punish_name` VARCHAR(200) NOT NULL,
  `punish_desc` VARCHAR(200) NULL DEFAULT NULL,
  `deduct_from_salary` VARCHAR(2) NULL DEFAULT 'N',
  `pun_ded_effect` VARCHAR(2) NULL DEFAULT 'F',
  `pun_ded_val` DECIMAL(8,3) NULL DEFAULT 0.0,
  `from_column` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`punish_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`VACATION_TYPES` (
  `vacation_code` INT(11) NOT NULL AUTO_INCREMENT,
  `vacation_name` VARCHAR(200) NOT NULL,
  `vacation_desc` VARCHAR(200) NULL DEFAULT NULL,
  `deduct_from_salary` VARCHAR(2) NULL DEFAULT 'N',
  `vac_ded_effect` VARCHAR(2) NULL DEFAULT 'F',
  `vac_ded_val` DECIMAL(8,3) NULL DEFAULT NULL,
  `from_column` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`vacation_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`BENEFIT_TYPES` (
  `benefit_code` INT(11) NOT NULL AUTO_INCREMENT,
  `benefit_name` VARCHAR(200) NOT NULL,
  `benefit_desc` VARCHAR(200) NULL DEFAULT NULL,
  `benefit_effect` VARCHAR(2) NOT NULL DEFAULT 'F' COMMENT 'Benefit effect in (F---fixed / V----variable)',
  `benefit_val` DECIMAL(9,3) NULL DEFAULT NULL,
  `from_column` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`benefit_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`DEDUCTION_TYPES` (
  `deduction_code` INT(11) NOT NULL AUTO_INCREMENT,
  `deduction_name` VARCHAR(200) NOT NULL,
  `deduction_desc` VARCHAR(200) NULL DEFAULT NULL,
  `deduction_effect` VARCHAR(2) NULL DEFAULT 'F' COMMENT 'deduction effect (F----fixed / V----variable)',
  `deduction_val` DECIMAL(9,3) NULL DEFAULT NULL,
  `from_column` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`deduction_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`BONUS_TYPES` (
  `bonus_code` INT(11) NOT NULL AUTO_INCREMENT,
  `bonus_name` VARCHAR(200) NOT NULL,
  `bonus_desc` VARCHAR(200) NULL DEFAULT NULL,
  `bonus_effect` VARCHAR(2) NULL DEFAULT 'F' COMMENT 'Bonus Effect (F----fixed / V----variable)',
  `bonus_val` DECIMAL(9,3) NULL DEFAULT 0.0,
  `from_column` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`bonus_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
UPDATE `Elecon`.`SYSTEM_FNCTNS` SET `tf_link` = '/WEB-INF/setup_data/setup_data.xml#setup_data' WHERE (`fncn_id` = 'HCM01');
