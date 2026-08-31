-- MySQL Workbench Synchronization
-- Generated: 2026-06-13 15:43
-- Model: New Model
-- Version: 1.0
-- Project: FERB
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

ALTER TABLE `Elecon`.`EMPLOYEE_JOB_HISTORY`
ADD COLUMN `proj_id` INT(11) NULL DEFAULT NULL AFTER `to_dt`,
ADD COLUMN `version_no` INT(11) NULL DEFAULT NULL AFTER `proj_id`,
ADD INDEX `fk_EMPLOYEE_JOB_HISTORY_PROJECTS_MAST1_idx` (`proj_id` ASC, `version_no` ASC);
;

DROP TABLE IF EXISTS `Elecon`.`PROJECT_ASSIGNMENTS` ;

ALTER TABLE `Elecon`.`EMPLOYEE_JOB_HISTORY`
ADD CONSTRAINT `fk_EMPLOYEE_JOB_HISTORY_PROJECTS_MAST1`
  FOREIGN KEY (`proj_id` , `version_no`)
  REFERENCES `Elecon`.`PROJECTS_MAST` (`proj_id` , `version_no`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE EMPLOYEE_JOB_HISTORY
MODIFY frm_dt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `Elecon`.`EMPLOYEE_JOB_HISTORY`
CHANGE COLUMN `seq` `seq` INT(11) NOT NULL AUTO_INCREMENT ;

CREATE DEFINER=`root`@`localhost` TRIGGER `Elecon`.`ORG_USERS_AFTER_INSERT` AFTER INSERT ON `ORG_USERS` FOR EACH ROW
BEGIN
if new.emp_id is not null then
insert into USER_CONTROL_ORGS (user_id,org_code)
values (new.user_id, (select org_code from EMPLOYEES where emp_id = new.emp_id));
end if;
END

DROP PROCEDURE IF EXISTS `create_today_attendance`;

DELIMITER $$

CREATE DEFINER=`elecon`@`localhost` PROCEDURE `create_today_attendance`(vUserId int)
BEGIN
  DECLARE v_start DATE;
  DECLARE v_today DATE;
  DECLARE v_org_code INT(11);
  DECLARE v_rule_org_code INT(11);

  -- Get today
  SET v_today = CURDATE();

  -- Find user org_code
  SELECT E.org_code INTO v_org_code
  FROM ORG_USERS OU,EMPLOYEES E
  WHERE OU.emp_id = E.emp_id
  and user_id = vUserId;

  -- Walk up parent chain until we find matching rules
  SET v_rule_org_code = v_org_code;
  WHILE v_rule_org_code IS NOT NULL
        AND NOT EXISTS (SELECT 1 FROM ATTENDANCE_RULES r WHERE r.org_code = v_rule_org_code) DO
    SELECT prnt_org_code INTO v_rule_org_code
    FROM ORGANIZATIONS
    WHERE org_code = v_rule_org_code;
  END WHILE;

  -- If still null → fallback to global company rules (root org)
  IF v_rule_org_code IS NULL THEN
    SELECT org_code INTO v_rule_org_code
    FROM ORGANIZATIONS
    WHERE prnt_org_code IS NULL
    LIMIT 1;
  END IF;

  -- Insert missing attendance rows
  SELECT IFNULL(DATE_ADD(MAX(attendance_date), INTERVAL 1 DAY),
                DATE_FORMAT(v_today, '%Y-%m-01'))
    INTO v_start
  FROM ATTENDANCE
  WHERE user_id = vUserId;

  INSERT INTO ATTENDANCE (user_id, attendance_date, created_at, updated_at)
  SELECT vUserId, DATE_ADD(v_start, INTERVAL seq.n DAY), NOW(), NOW()
  FROM (
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7
    UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11
    UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15
    UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19
    UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23
    UNION ALL SELECT 24 UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27
    UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30 UNION ALL SELECT 31
  ) seq
  WHERE DATE_ADD(v_start, INTERVAL seq.n DAY) <= v_today
    AND NOT EXISTS (
      SELECT 1 FROM ATTENDANCE a
      WHERE a.user_id = vUserId
        AND a.attendance_date = DATE_ADD(v_start, INTERVAL seq.n DAY)
    );

 -- Apply attendance status, remarks and work hours
UPDATE ATTENDANCE a
JOIN ATTENDANCE_RULES r
    ON r.org_code = v_rule_org_code

SET
    /*
     * STATUS
     *
     * STATUS represents the overall attendance state.
     */
    a.STATUS = CASE

        -- Weekend
        WHEN DAYOFWEEK(a.attendance_date)
             IN (r.weekend_day1, r.weekend_day2)
        THEN 'Weekend'

        -- No punch-in and no punch-out
        WHEN a.check_in_time IS NULL
         AND a.check_out_time IS NULL
        THEN 'Absent'

        -- Punched in but did not punch out
        WHEN a.check_in_time IS NOT NULL
         AND a.check_out_time IS NULL
        THEN 'Missing Punch-out'

        -- Both punch-in and punch-out exist
        WHEN a.check_in_time IS NOT NULL
         AND a.check_out_time IS NOT NULL
        THEN 'Attend'

        ELSE 'Absent'

    END,

    /*
     * REMARKS
     *
     * REMARKS contains additional attendance observations.
     *
     * Possible values:
     *   Arrive Late
     *   Left Early
     *   Arrive Late; Left Early
     *   NULL
     */
    a.REMARKS = CASE

        /*
         * Both late arrival and early leaving
         */
        WHEN a.check_in_time IS NOT NULL
         AND a.check_out_time IS NOT NULL

         AND a.check_in_time >
             DATE_ADD(
                 CONCAT(
                     a.attendance_date,
                     ' ',
                     r.work_start_hour
                 ),
                 INTERVAL r.late_after_minutes MINUTE
             )

         AND a.check_out_time <
             DATE_ADD(
                 CONCAT(
                     a.attendance_date,
                     ' ',
                     r.work_end_hour
                 ),
                 INTERVAL -r.early_leave_minutes MINUTE
             )

        THEN 'Arrive Late; Left Early'

        /*
         * Late arrival only
         */
        WHEN a.check_in_time IS NOT NULL

         AND a.check_in_time >
             DATE_ADD(
                 CONCAT(
                     a.attendance_date,
                     ' ',
                     r.work_start_hour
                 ),
                 INTERVAL r.late_after_minutes MINUTE
             )

        THEN 'Arrive Late'

        /*
         * Early leaving only
         */
        WHEN a.check_out_time IS NOT NULL

         AND a.check_out_time <
             DATE_ADD(
                 CONCAT(
                     a.attendance_date,
                     ' ',
                     r.work_end_hour
                 ),
                 INTERVAL -r.early_leave_minutes MINUTE
             )

        THEN 'Left Early'

        ELSE NULL

    END,

    /*
     * WORK_HOURS
     *
     * Calculate only when both punches exist.
     */
    a.WORK_HOURS = CASE

        WHEN a.check_in_time IS NOT NULL
         AND a.check_out_time IS NOT NULL

        THEN ROUND(
            TIMESTAMPDIFF(
                MINUTE,
                a.check_in_time,
                a.check_out_time
            ) / 60,
            2
        )

        ELSE a.WORK_HOURS

    END

WHERE a.user_id = vUserId
  AND a.attendance_date IS NOT NULL;

END$$

DELIMITER ;

ALTER TABLE `Elecon`.`EMPLOYEE_JOB_HISTORY`
CHANGE COLUMN `frm_dt` `frm_dt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ;

ALTER TABLE `Elecon`.`ATTENDANCE`
CHANGE COLUMN `status` `status` ENUM('Absent', 'Weekend', 'Missing Punch-out', 'Attend', 'Medical Leave', 'Emergency Leave', 'Personal Leave') NULL DEFAULT NULL COMMENT 'Explicit status if marked manually or by system' ,
ADD INDEX `idx_attendance_user_date` (`user_id` ASC, `attendance_date` ASC) ,
ADD INDEX `idx_attendance_date` (`attendance_date` ASC) ,
ADD UNIQUE INDEX `uk_attendance_user_date` (`user_id` ASC, `attendance_date` ASC) ;
;
