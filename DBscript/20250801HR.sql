CREATE TABLE ATTENDANCE (
    attendance_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'Unique attendance record ID',

    user_id INT NOT NULL COMMENT 'FK to users.user_id; who performed the attendance action',

    attendance_date DATE NOT NULL COMMENT 'Date of attendance (one record per day)',

    check_in_time DATETIME DEFAULT NULL COMMENT 'Timestamp when user checked in',

    check_out_time DATETIME DEFAULT NULL COMMENT 'Timestamp when user checked out',

    status ENUM('Present', 'Absent', 'Leave') DEFAULT NULL COMMENT 'Explicit status if marked manually or by system',

    remarks VARCHAR(255) DEFAULT NULL COMMENT 'Optional note (e.g., sick leave, late, etc.)',

    work_hours DECIMAL(5,2) DEFAULT NULL COMMENT 'Optional: calculated hours worked in the day',

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Record creation timestamp',

    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record last update timestamp',

    CONSTRAINT fk_attendance_user
        FOREIGN KEY (user_id) REFERENCES ORG_USERS(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE KEY uq_user_date (user_id, attendance_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  COMMENT='Daily attendance records linked to users';

  CREATE TABLE ATTENDANCE_RULES (
  org_code            INT(11) PRIMARY KEY,
  work_start_hour     TIME NOT NULL DEFAULT '09:00:00',
  work_end_hour       TIME NOT NULL DEFAULT '17:00:00',
  late_after_minutes  INT NOT NULL DEFAULT 0,
  early_leave_minutes INT NOT NULL DEFAULT 0,
  overtime_after_hour TIME DEFAULT '19:00:00',
  weekend_day1        TINYINT NOT NULL, -- 1=Sunday … 7=Saturday
  weekend_day2        TINYINT DEFAULT NULL,
  CONSTRAINT fk_rules_org FOREIGN KEY (org_code)
    REFERENCES ORGANIZATIONS (org_code)
);
  -- MySQL Workbench Synchronization
-- Generated: 2025-08-01 22:47
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Mohamed Fayed

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='PIPES_AS_CONCAT';

ALTER TABLE `Elecon`.`ORG_USERS`
ADD COLUMN `emp_id` INT(11) NULL DEFAULT NULL AFTER `to_dt`,
ADD INDEX `fk_ORG_USERS_EMPLOYEES1_idx` (`emp_id` ASC) ,
ADD UNIQUE INDEX `user_id_emp_id_unique_indx` (`user_id` ASC, `emp_id` ASC) ;
;

ALTER TABLE `Elecon`.`ORG_USERS`
ADD CONSTRAINT `fk_ORG_USERS_EMPLOYEES1`
  FOREIGN KEY (`emp_id`)
  REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE PROCEDURE `create_today_attendance` (vUserId int)
CREATE PROCEDURE update_attendance (IN vUserId INT)
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

  -- Apply rules for status calculation
  UPDATE ATTENDANCE a
  JOIN ATTENDANCE_RULES r ON r.org_code = v_rule_org_code
  SET a.STATUS = CASE
      WHEN DAYOFWEEK(a.attendance_date) IN (r.weekend_day1, r.weekend_day2) THEN 'Weekend'
      WHEN a.check_in_time IS NULL AND a.check_out_time IS NULL THEN 'Absent'
      WHEN (a.check_in_time IS NOT NULL AND a.check_out_time IS NULL)
        OR (a.check_in_time IS NULL AND a.check_out_time IS NOT NULL) THEN 'Half Day'
      WHEN a.check_out_time >= CONCAT(a.attendance_date, ' ', r.overtime_after_hour) THEN 'Overtime'
      WHEN a.check_out_time <  DATE_ADD(CONCAT(a.attendance_date, ' ', r.work_end_hour), INTERVAL -r.early_leave_minutes MINUTE) THEN 'Left Early'
      WHEN a.check_in_time  >  DATE_ADD(CONCAT(a.attendance_date, ' ', r.work_start_hour), INTERVAL r.late_after_minutes MINUTE) THEN 'Late'
      ELSE 'Present'
    END,
    a.WORK_HOURS = CASE
      WHEN a.check_in_time IS NOT NULL AND a.check_out_time IS NOT NULL
        THEN ROUND(TIMESTAMPDIFF(MINUTE, a.check_in_time, a.check_out_time) / 60, 2)
      ELSE a.WORK_HOURS
    END
  WHERE a.user_id = vUserId
    AND a.attendance_date IS NOT NULL;
END


ALTER TABLE `Elecon`.`ATTENDANCE`
CHANGE COLUMN `status` `status` ENUM('Present', 'Absent', 'Half day', 'Weekend', 'Late', 'Left Early', 'Overtime') NULL DEFAULT NULL COMMENT 'Explicit status if marked manually or by system' ;

UPDATE `Elecon`.`SYSTEM_FNCTNS` SET `en_fncn_name` = 'Employee Profile', `ar_fncn_name` = 'ملف تعريف الموظف', `tf_link` = '/WEB-INF/empProfile/empProfile-TF.xml#empProfile-TF' WHERE (`fncn_id` = 'HCM05');
