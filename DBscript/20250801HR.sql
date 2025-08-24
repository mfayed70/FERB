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
BEGIN
UPDATE ATTENDANCE
SET
  STATUS = CASE
    WHEN DAYOFWEEK(attendance_date) IN (6,7) THEN 'Weekend'
    WHEN check_in_time IS NULL AND check_out_time IS NULL THEN 'Absent'
    WHEN (check_in_time IS NOT NULL AND check_out_time IS NULL)
      OR (check_in_time IS NULL AND check_out_time IS NOT NULL) THEN 'Half Day'
    WHEN check_out_time >= DATE_ADD(attendance_date, INTERVAL 19 HOUR) THEN 'Overtime'
    WHEN check_out_time <  DATE_ADD(attendance_date, INTERVAL 17 HOUR) THEN 'Left Early'
    WHEN check_in_time  >  DATE_ADD(attendance_date, INTERVAL 9 HOUR)  THEN 'Late'
    ELSE 'Present'
  END,
  WORK_HOURS = CASE
    WHEN check_in_time IS NOT NULL AND check_out_time IS NOT NULL
      THEN ROUND(TIMESTAMPDIFF(MINUTE, check_in_time, check_out_time) / 60, 2)
    ELSE WORK_HOURS
  END
WHERE user_id = vUserId
  AND attendance_date IS NOT NULL;

INSERT INTO ATTENDANCE (user_id, attendance_date, created_at, updated_at)
SELECT vUserId, CURDATE(), NOW(), NOW() FROM dual
WHERE NOT EXISTS (SELECT 1 FROM ATTENDANCE WHERE user_id = vUserId AND attendance_date = CURDATE());
END

ALTER TABLE `Elecon`.`ATTENDANCE`
CHANGE COLUMN `status` `status` ENUM('Present', 'Absent', 'Half day', 'Weekend', 'Late', 'Left Early', 'Overtime') NULL DEFAULT NULL COMMENT 'Explicit status if marked manually or by system' ;

