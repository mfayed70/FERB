-- MySQL Workbench Synchronization
-- Generated: 2025-09-03 15:23
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

    CREATE TABLE IF NOT EXISTS `Elecon`.`USER_VACATIONS` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `register_dt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `frm_dt` DATETIME NULL DEFAULT NULL,
    `to_dt` DATETIME NULL DEFAULT NULL,
    `emp_id` INT(11) NOT NULL,
    `vacation_code` INT(11) NOT NULL,
    `status` VARCHAR(2) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_USER_VACATIONS_EMPLOYEES1_idx` (`emp_id` ASC) ,
    INDEX `fk_USER_VACATIONS_VACATION_TYPES1_idx` (`vacation_code` ASC) ,
    CONSTRAINT `fk_USER_VACATIONS_EMPLOYEES1`
        FOREIGN KEY (`emp_id`)
        REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_USER_VACATIONS_VACATION_TYPES1`
        FOREIGN KEY (`vacation_code`)
        REFERENCES `Elecon`.`VACATION_TYPES` (`vacation_code`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE `Elecon`.`USER_VACATIONS`
ADD COLUMN `doc_path` VARCHAR(100) NULL DEFAULT NULL AFTER `status`

ALTER TABLE `Elecon`.`VACATION_TYPES`
ADD COLUMN `vacation_name_ar` VARCHAR(100) NULL DEFAULT NULL AFTER `vacation_name`

INSERT INTO VACATION_TYPES (vacation_name, vacation_name_ar, vacation_desc, deduct_from_salary)
VALUES
  ('Normal Leave', 'إجازة عادية', 'Annual leave for personal reasons', 'N'),
  ('Medical Leave', 'إجازة مرضية', 'Sick leave approved by medical report', 'N'),
  ('Unpaid Leave', 'إجازة بدون راتب', 'Leave without pay', 'Y'),
  ('Late Permission', 'تصريح تأخير', 'Permission for late punch-in', 'N'),
  ('Early Permission', 'تصريح انصراف مبكر', 'Permission for early punch-out', 'N');

