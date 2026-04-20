-- MySQL Workbench Synchronization
-- Generated: 2025-12-19 16:18
-- Model: New Model
-- Version: 1.0
-- Project: FERB
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

ALTER TABLE `Elecon`.`PUR_RFQ_SUPPLIERS_DETS`
CHANGE COLUMN `price` `price` DECIMAL(7,2) NOT NULL DEFAULT 1 ;

CREATE TABLE IF NOT EXISTS `Elecon`.`EMPLOYEE_EXTRA_JOBS` (
  `extra_job_id` INT(11) NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NULL DEFAULT NULL,
  `end_date` DATETIME NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  `emp_id` INT(11) NOT NULL,
  `job_id` INT(11) NOT NULL,
  `org_code` INT(11) NOT NULL,
  PRIMARY KEY (`extra_job_id`),
  INDEX `fk_EMPLOYEE_EXTRA_JOBS_EMPLOYEES1_idx` (`emp_id` ASC) ,
  INDEX `fk_EMPLOYEE_EXTRA_JOBS_JOBS1_idx` (`job_id` ASC) ,
  INDEX `fk_EMPLOYEE_EXTRA_JOBS_ORGANIZATIONS1_idx` (`org_code` ASC) ,
  CONSTRAINT `fk_EMPLOYEE_EXTRA_JOBS_EMPLOYEES1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEE_EXTRA_JOBS_JOBS1`
    FOREIGN KEY (`job_id`)
    REFERENCES `Elecon`.`JOBS` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEE_EXTRA_JOBS_ORGANIZATIONS1`
    FOREIGN KEY (`org_code`)
    REFERENCES `Elecon`.`ORGANIZATIONS` (`org_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
-------------------------------------------------------------
CREATE DEFINER=`elecon`@`localhost`
PROCEDURE sp_create_approval_transaction(
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
    DECLARE v_module_name VARCHAR(100);

    -- Cursor for approval steps
    DECLARE cur_steps CURSOR FOR
        SELECT s.step_id,
               s.role_id,
               s.approval_order,
               r.resolve_entity,
               r.resolve_level,
               s.is_final_step
        FROM APPROVAL_CYCLE_STEPS s
        JOIN APPROVAL_ROLES r ON s.role_id = r.role_id
        WHERE s.cycle_type_id = p_cycle_type_id
        ORDER BY s.approval_order;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    -- Get module name
    SELECT module_name
    INTO v_module_name
    FROM APPROVAL_CYCLE_TYPES
    WHERE cycle_type_id = p_cycle_type_id;

    -- Insert transaction header
    INSERT INTO APPROVAL_TRANSACTIONS (
        cycle_type_id,
        module_name,
        transaction_ref_id,
        request_date,
        requested_by,
        org_code,
        current_order,
        status
    )
    VALUES (
        p_cycle_type_id,
        v_module_name,
        p_transaction_ref_id,
        p_request_date,
        p_requested_by,
        p_org_code,
        1,
        'PENDING'
    );

    SET v_trans_id = LAST_INSERT_ID();

    OPEN cur_steps;

    step_loop: LOOP
        FETCH cur_steps
        INTO v_step_id,
             v_role_id,
             v_approval_order,
             v_resolve_entity,
             v_resolve_level,
             v_is_final_step;

        IF v_done = 1 THEN
            LEAVE step_loop;
        END IF;

        /* =====================================================
           Resolve approvers for this step
           ===================================================== */

        IF v_resolve_entity = 'JOB' THEN

            INSERT INTO APPROVAL_TRANSACTION_DETAILS (
                approval_trans_id,
                step_id,
                approver_id,
                role_id,
                approval_order,
                action_status,
                is_active
            )
            SELECT DISTINCT
                v_trans_id,
                v_step_id,
                e2.emp_id,
                v_role_id,
                v_approval_order,
                'PENDING',
                CASE WHEN v_approval_order = 1 THEN 1 ELSE 0 END
            FROM
            (
                /* requester primary + extra jobs */
                SELECT job_id
                FROM EMPLOYEES
                WHERE emp_id = p_requested_by

                UNION

                SELECT job_id
                FROM EMPLOYEE_EXTRA_JOBS
                WHERE emp_id = p_requested_by
            ) req_jobs
            JOIN JOBS j ON j.job_id = req_jobs.job_id
            /* walk up job hierarchy */
            JOIN JOBS j_target
              ON j_target.job_id = (
                  SELECT jx.job_id
                  FROM JOBS jx
                  WHERE jx.job_id = j.job_id
                  LIMIT 1
              )
            JOIN EMPLOYEES e2
              ON e2.job_id = j_target.job_id
            WHERE e2.emp_id <> p_requested_by
            LIMIT 1; -- SINGLE policy for now

        ELSEIF v_resolve_entity = 'ORG' THEN

            INSERT INTO APPROVAL_TRANSACTION_DETAILS (
                approval_trans_id,
                step_id,
                approver_id,
                role_id,
                approval_order,
                action_status,
                is_active
            )
            SELECT
                v_trans_id,
                v_step_id,
                e.emp_id,
                v_role_id,
                v_approval_order,
                'PENDING',
                CASE WHEN v_approval_order = 1 THEN 1 ELSE 0 END
            FROM EMPLOYEES e
            WHERE e.org_code = p_org_code
              AND e.emp_id <> p_requested_by
            LIMIT 1;

        END IF;

    END LOOP;

    CLOSE cur_steps;

    SELECT v_trans_id AS new_transaction_id,
           v_module_name AS module_name;
END;

-------------------------------------------------------------

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

