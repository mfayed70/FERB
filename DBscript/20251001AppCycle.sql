-- MySQL Workbench Synchronization
-- Generated: 2025-10-06 21:35
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

ALTER TABLE `Elecon`.`JOBS`
ADD COLUMN `parent_job_id` INT(11) NULL DEFAULT NULL AFTER `org_code`,
ADD INDEX `fk_JOBS_JOBS1_idx` (`parent_job_id` ASC) ;
;
ALTER TABLE `Elecon`.`JOBS`
ADD CONSTRAINT `fk_JOBS_JOBS1`
  FOREIGN KEY (`parent_job_id`)
  REFERENCES `Elecon`.`JOBS` (`job_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


CREATE TABLE IF NOT EXISTS `Elecon`.`ERP_MODULES` (
  `erp_module` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`erp_module`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



  INSERT INTO `SYSTEM_FNCTNS` (`fncn_id`,`en_fncn_name`,`ar_fncn_name`,`system_id`,`en_fncn_desc`,`ar_fncn_desc`,`tf_link`) VALUES ('ADM03','Approval Cycles','---------','ADM',NULL,NULL,'/WEB-INF/ApprovalCycles/approval_cycles-TF.xml#approval_cycles-TF');

  INSERT INTO `SYSTEM_FNCTNS` (`fncn_id`,`en_fncn_name`,`ar_fncn_name`,`system_id`,`en_fncn_desc`,`ar_fncn_desc`,`tf_link`) VALUES ('ADM04','Approval Cyles Transactions','*******','ADM',NULL,NULL,NULL);

INSERT INTO `ERP_MODULES` (`erp_module`) VALUES ('HR');

-- MySQL Workbench Synchronization
-- Generated: 2025-10-11 17:56
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';


CREATE TABLE IF NOT EXISTS `Elecon`.`APPROVAL_CYCLE_TYPES` (
  `CYCLE_TYPE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `MODULE_NAME` VARCHAR(100) NOT NULL,
  `TRANSACTION_TYPE_CODE` INT(11) NOT NULL,
  `TRANSACTION_TYPE_NAME` VARCHAR(150) NOT NULL,
  `DESCRIPTION` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`CYCLE_TYPE_ID`),
  UNIQUE INDEX `UK_CYCLE_TYPE` (`MODULE_NAME` ASC, `TRANSACTION_TYPE_CODE` ASC) ,
  CONSTRAINT `fk_APPROVAL_CYCLE_TYPES_ERP_MODULES1`
    FOREIGN KEY (`MODULE_NAME`)
    REFERENCES `Elecon`.`ERP_MODULES` (`erp_module`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`APPROVAL_ROLES` (
  `ROLE_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` VARCHAR(200) NOT NULL,
  `JOB_ID` INT(11) NULL DEFAULT NULL,
  `RESOLVE_ENTITY` ENUM('JOB', 'ORG') NOT NULL DEFAULT 'JOB' COMMENT 'Specifies whether approver is resolved via Job or Organization hierarchy',
  `RESOLVE_LEVEL` INT(11) NOT NULL DEFAULT '0' COMMENT 'Number of hierarchy levels to move upward (0 = same level)',
  `RESOLVE_SCOPE` ENUM('SAME_ORG', 'ANCESTOR_ORG', 'GLOBAL') NOT NULL DEFAULT 'SAME_ORG' COMMENT 'Scope of resolution when searching for employees with target job/organization',
  `MULTI_POLICY` ENUM('SINGLE', 'ALL', 'ANY', 'N_OF_M') NOT NULL DEFAULT 'SINGLE' COMMENT 'Policy for handling multiple employees assigned to the resolved job/role',
  `MULTI_N` INT(11) NULL DEFAULT NULL COMMENT 'Used only if MULTI_POLICY = N_OF_M, specifies the number of approvals required',
  `ALLOW_DELEGATION` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '1 = apply delegation rules if available, 0 = skip delegation',
  `FALLBACK_ROLE_ID` INT(11) NULL DEFAULT NULL COMMENT 'Optional fallback role if resolution finds no approver',
  PRIMARY KEY (`ROLE_ID`),
  INDEX `FK_JOB` (`JOB_ID` ASC) ,
  INDEX `FK_APPROVAL_ROLE_FALLBACK` (`FALLBACK_ROLE_ID` ASC) ,
  CONSTRAINT `FK_APPROVAL_ROLE_FALLBACK`
    FOREIGN KEY (`FALLBACK_ROLE_ID`)
    REFERENCES `Elecon`.`APPROVAL_ROLES` (`ROLE_ID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_JOB`
    FOREIGN KEY (`JOB_ID`)
    REFERENCES `Elecon`.`JOBS` (`job_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`APPROVAL_CYCLE_STEPS` (
  `STEP_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CYCLE_TYPE_ID` INT(11) NOT NULL,
  `STEP_NO` INT(11) NOT NULL,
  `ORG_CODE` INT(11) NULL DEFAULT NULL,
  `APPROVAL_ORDER` INT(11) NOT NULL,
  `IS_FINAL_STEP` TINYINT(1) NULL DEFAULT '0',
  `ROLE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`STEP_ID`),
  INDEX `FK_CYCLE_TYPE` (`CYCLE_TYPE_ID` ASC) ,
  INDEX `FK_ORG` (`ORG_CODE` ASC) ,
  INDEX `fk_APPROVAL_CYCLE_STEPS_APPROVAL_ROLES1_idx` (`ROLE_ID` ASC) ,
  CONSTRAINT `FK_CYCLE_TYPE`
    FOREIGN KEY (`CYCLE_TYPE_ID`)
    REFERENCES `Elecon`.`APPROVAL_CYCLE_TYPES` (`CYCLE_TYPE_ID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_ORG`
    FOREIGN KEY (`ORG_CODE`)
    REFERENCES `Elecon`.`ORGANIZATIONS` (`org_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_ROLE`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `Elecon`.`APPROVAL_ROLES` (`ROLE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `Elecon`.`APPROVAL_TRANSACTIONS` (
  `APPROVAL_TRANS_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CYCLE_TYPE_ID` INT(11) NOT NULL,
  `TRANSACTION_REF_ID` INT(11) NOT NULL,
  `REQUEST_DATE` DATETIME NOT NULL,
  `REQUESTED_BY` INT(11) NOT NULL,
  `CURRENT_ORDER` INT(11) NULL DEFAULT '1',
  `STATUS` VARCHAR(20) NULL DEFAULT 'PENDING',
  `ORG_CODE` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`APPROVAL_TRANS_ID`),
  INDEX `CYCLE_TYPE_ID` (`CYCLE_TYPE_ID` ASC) ,
  INDEX `REQUESTED_BY` (`REQUESTED_BY` ASC) ,
  INDEX `ORG_CODE` (`ORG_CODE` ASC) ,
  CONSTRAINT `APPROVAL_TRANSACTIONS_ibfk_1`
    FOREIGN KEY (`CYCLE_TYPE_ID`)
    REFERENCES `Elecon`.`APPROVAL_CYCLE_TYPES` (`CYCLE_TYPE_ID`),
  CONSTRAINT `APPROVAL_TRANSACTIONS_ibfk_2`
    FOREIGN KEY (`REQUESTED_BY`)
    REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`),
  CONSTRAINT `APPROVAL_TRANSACTIONS_ibfk_3`
    FOREIGN KEY (`ORG_CODE`)
    REFERENCES `Elecon`.`ORGANIZATIONS` (`org_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Elecon`.`APPROVAL_TRANSACTION_DETAILS` (
  `DETAIL_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `APPROVAL_TRANS_ID` INT(11) NOT NULL,
  `STEP_ID` INT(11) NOT NULL,
  `APPROVER_ID` INT(11) NOT NULL,
  `ACTION_STATUS` VARCHAR(20) NULL DEFAULT 'PENDING',
  `ACTION_DATE` DATETIME NULL DEFAULT NULL,
  `COMMENTS` VARCHAR(500) NULL DEFAULT NULL,
  `APPROVAL_ORDER` INT(11) NOT NULL,
  `IS_ACTIVE` TINYINT(1) NULL DEFAULT '0',
  `ROLE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`DETAIL_ID`),
  INDEX `FK_TRANS` (`APPROVAL_TRANS_ID` ASC) ,
  INDEX `FK_STEP` (`STEP_ID` ASC) ,
  INDEX `FK_APPROVER` (`APPROVER_ID` ASC) ,
  INDEX `fk_APPROVAL_TRANSACTION_DETAILS_APPROVAL_ROLES1_idx` (`ROLE_ID` ASC) ,
  CONSTRAINT `FK_APPROVER`
    FOREIGN KEY (`APPROVER_ID`)
    REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `FK_STEP`
    FOREIGN KEY (`STEP_ID`)
    REFERENCES `Elecon`.`APPROVAL_CYCLE_STEPS` (`STEP_ID`),
  CONSTRAINT `FK_TRANS`
    FOREIGN KEY (`APPROVAL_TRANS_ID`)
    REFERENCES `Elecon`.`APPROVAL_TRANSACTIONS` (`APPROVAL_TRANS_ID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `APPROVAL_TRANSACTION_DETAILS_ibfk_1`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `Elecon`.`APPROVAL_ROLES` (`ROLE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `Elecon`.`APPROVAL_TRANSACTIONS`
ADD COLUMN `MODULE_NAME` VARCHAR(100) NOT NULL AFTER `ORG_CODE`,
ADD INDEX `fk_APPROVAL_TRANSACTIONS_ERP_MODULES1_idx` (`MODULE_NAME` ASC);
;

ALTER TABLE `Elecon`.`APPROVAL_TRANSACTIONS`
ADD CONSTRAINT `fk_APPROVAL_TRANSACTIONS_ERP_MODULES1`
  FOREIGN KEY (`MODULE_NAME`)
  REFERENCES `Elecon`.`ERP_MODULES` (`erp_module`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

DELIMITER $$

CREATE PROCEDURE sp_create_approval_transaction(
    IN p_cycle_type_id INT,
    IN p_transaction_ref_id INT,
    IN p_requested_by INT,
    IN p_org_code INT,
    IN p_request_date DATETIME
)
BEGIN
    DECLARE v_trans_id INT;
    DECLARE v_step_id INT;
    DECLARE v_role_id INT;
    DECLARE v_approval_order INT;
    DECLARE v_resolve_entity VARCHAR(10);
    DECLARE v_resolve_level INT;
    DECLARE v_is_final_step TINYINT;
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_approver_id INT;
    DECLARE v_job_id INT;
    DECLARE v_target_job_id INT;
    DECLARE v_org_level INT;
    DECLARE v_target_org INT;
    DECLARE v_module_name VARCHAR(100);

    -- Cursor for cycle steps
    DECLARE cur_steps CURSOR FOR
        SELECT s.step_id, s.role_id, s.approval_order, r.resolve_entity, r.resolve_level, s.is_final_step
        FROM APPROVAL_CYCLE_STEPS s
        JOIN APPROVAL_ROLES r ON s.role_id = r.role_id
        WHERE s.cycle_type_id = p_cycle_type_id
        ORDER BY s.approval_order;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    -- Get module name
    SELECT c.module_name INTO v_module_name
    FROM APPROVAL_CYCLE_TYPES c
    WHERE c.cycle_type_id = p_cycle_type_id
    LIMIT 1;

    -- Insert transaction header
    INSERT INTO APPROVAL_TRANSACTIONS (
        cycle_type_id, module_name, transaction_ref_id, request_date,
        requested_by, org_code, current_order, status
    ) VALUES (
        p_cycle_type_id, v_module_name, p_transaction_ref_id, p_request_date,
        p_requested_by, p_org_code, 1, 'PENDING'
    );

    SET v_trans_id = LAST_INSERT_ID();

    -- Loop through steps
    OPEN cur_steps;

    step_loop: LOOP
        FETCH cur_steps INTO v_step_id, v_role_id, v_approval_order,
            v_resolve_entity, v_resolve_level, v_is_final_step;

        IF v_done = 1 THEN
            LEAVE step_loop;
        END IF;

        SET v_approver_id = NULL;

        -- Get requester's job
        SELECT job_id INTO v_job_id
        FROM EMPLOYEES
        WHERE emp_id = p_requested_by;

        IF v_resolve_entity = 'JOB' THEN

            SET v_target_job_id = v_job_id;
            SET v_org_level = v_resolve_level;

            WHILE v_org_level > 0 DO
                SELECT parent_job_id INTO v_target_job_id
                FROM JOBS
                WHERE job_id = v_target_job_id;

                SET v_org_level = v_org_level - 1;
            END WHILE;

            -- Prevent self-approval
            IF v_target_job_id = v_job_id THEN
                SET v_approver_id = NULL;
            ELSE
                SELECT emp_id INTO v_approver_id
                FROM EMPLOYEES
                WHERE job_id = v_target_job_id
                LIMIT 1;
            END IF;

        ELSEIF v_resolve_entity = 'ORG' THEN

            SET v_target_org = p_org_code;

            IF v_resolve_level > 0 THEN
                SET v_org_level = v_resolve_level;
                WHILE v_org_level > 0 DO
                    SELECT prnt_org_code INTO v_target_org
                    FROM ORGANIZATIONS
                    WHERE org_code = v_target_org;

                    SET v_org_level = v_org_level - 1;
                END WHILE;
            END IF;

            -- Find highest-level job in that org
            SELECT e.emp_id INTO v_approver_id
            FROM EMPLOYEES e
            JOIN JOBS j ON e.job_id = j.job_id
            WHERE e.org_code = v_target_org
              AND (j.parent_job_id IS NULL OR j.parent_job_id NOT IN (
                    SELECT job_id FROM JOBS WHERE org_code = v_target_org
                 ))
            LIMIT 1;

        END IF;

        -- Insert approval detail
        IF v_approver_id IS NOT NULL THEN
            INSERT INTO APPROVAL_TRANSACTION_DETAILS (
                approval_trans_id, step_id, approver_id, role_id,
                approval_order, action_status, is_active
            ) VALUES (
                v_trans_id, v_step_id, v_approver_id, v_role_id,
                v_approval_order, 'PENDING',
                CASE WHEN v_approval_order = 1 THEN 1 ELSE 0 END
            );
        END IF;

    END LOOP;

    CLOSE cur_steps;

    -- Return values
    SELECT v_trans_id AS new_transaction_id,
           v_module_name AS module_name;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_handle_approval_action(
    IN p_trans_id INT,
    IN p_detail_id INT,
    IN p_action VARCHAR(20),
    IN p_action_date DATETIME,
    IN p_comments VARCHAR(4000)
)
proc_block: BEGIN
    DECLARE v_current_order INT;
    DECLARE v_is_final_step TINYINT DEFAULT 0;
    DECLARE v_next_order INT;
    DECLARE v_valid_detail INT;
    DECLARE v_module_name VARCHAR(50);
    DECLARE v_ref_id INT;

    -- 1. Validate detail belongs to transaction
    SELECT COUNT(*)
    INTO v_valid_detail
    FROM APPROVAL_TRANSACTION_DETAILS
    WHERE detail_id = p_detail_id
      AND approval_trans_id = p_trans_id;

    IF v_valid_detail = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Detail ID does not belong to the specified transaction.';
    END IF;

    -- 2. Get current order
    SELECT approval_order
    INTO v_current_order
    FROM APPROVAL_TRANSACTION_DETAILS
    WHERE detail_id = p_detail_id
    LIMIT 1;

    IF v_current_order IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid detail ID: record not found.';
    END IF;

    -- 3. Update current step
    UPDATE APPROVAL_TRANSACTION_DETAILS
    SET action_status = p_action,
        is_active = 0,
        action_date = p_action_date,
        comments = p_comments
    WHERE detail_id = p_detail_id;

    -- 4. Get module + ref record id
    SELECT module_name, transaction_ref_id
    INTO v_module_name, v_ref_id
    FROM APPROVAL_TRANSACTIONS
    WHERE approval_trans_id = p_trans_id;

    -- 5. Check if final step
    SELECT CASE WHEN MAX(approval_order) = v_current_order THEN 1 ELSE 0 END
    INTO v_is_final_step
    FROM APPROVAL_TRANSACTION_DETAILS
    WHERE approval_trans_id = p_trans_id;

    -- 6. Handle rejection
    IF p_action = 'REJECTED' THEN

        UPDATE APPROVAL_TRANSACTIONS
        SET status = 'REJECTED'
        WHERE approval_trans_id = p_trans_id;

        UPDATE APPROVAL_TRANSACTION_DETAILS
        SET is_active = 0
        WHERE approval_trans_id = p_trans_id
          AND action_status = 'PENDING';

        -- HR module logic
        IF v_module_name = 'HR' THEN
            UPDATE USER_VACATIONS
            SET status = 'R'
            WHERE id = v_ref_id;
        END IF;

        LEAVE proc_block;
    END IF;

    -- 7. Approved but NOT final → activate next step
    IF p_action = 'APPROVED' AND v_is_final_step = 0 THEN

        SELECT approval_order
        INTO v_next_order
        FROM APPROVAL_TRANSACTION_DETAILS
        WHERE approval_trans_id = p_trans_id
          AND action_status = 'PENDING'
          AND approval_order > v_current_order
        ORDER BY approval_order
        LIMIT 1;

        IF v_next_order IS NOT NULL THEN
            UPDATE APPROVAL_TRANSACTION_DETAILS
            SET is_active = 1
            WHERE approval_trans_id = p_trans_id
              AND approval_order = v_next_order;

            UPDATE APPROVAL_TRANSACTIONS
            SET current_order = v_next_order
            WHERE approval_trans_id = p_trans_id;

        ELSE
            -- no more steps → approve transaction
            UPDATE APPROVAL_TRANSACTIONS
            SET status = 'APPROVED'
            WHERE approval_trans_id = p_trans_id;

            IF v_module_name = 'HR' THEN
                UPDATE USER_VACATIONS
                SET status = 'A'
                WHERE id = v_ref_id;
            END IF;
        END IF;

    END IF;

    -- 8. Final step approved → close transaction
    IF p_action = 'APPROVED' AND v_is_final_step = 1 THEN
        UPDATE APPROVAL_TRANSACTIONS
        SET status = 'APPROVED'
        WHERE approval_trans_id = p_trans_id;

        IF v_module_name = 'HR' THEN
            UPDATE USER_VACATIONS
            SET status = 'A'
            WHERE id = v_ref_id;
        END IF;
    END IF;

END proc_block$$

DELIMITER ;
