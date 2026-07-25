CREATE TABLE PUNCH_AREA (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    area_name   VARCHAR(100) NOT NULL,
    center_lat  DECIMAL(10,6) NOT NULL,
    center_lon  DECIMAL(10,6) NOT NULL,
    radius_m    DOUBLE NOT NULL,
    is_active   CHAR(1) DEFAULT 'Y',
    org_code    INT(11) DEFAULT NULL,
    proj_id     INT(11) DEFAULT NULL,
    version_no  INT(11) DEFAULT NULL,
    created_by  VARCHAR(50),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_punch_area_org
        FOREIGN KEY (org_code)
        REFERENCES ORGANIZATIONS (org_code)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_punch_area_proj
        FOREIGN KEY (proj_id, version_no)
        REFERENCES PROJECTS_MAST (proj_id, version_no)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  COMMENT='Registered work areas for punch-in validation';
-------------------------------------------------------------
-- Punch-in location
ALTER TABLE ATTENDANCE
    ADD COLUMN check_in_lat      DECIMAL(10,6) DEFAULT NULL
        COMMENT 'Latitude at check-in',
    ADD COLUMN check_in_lon      DECIMAL(10,6) DEFAULT NULL
        COMMENT 'Longitude at check-in',
    ADD COLUMN check_in_accuracy DOUBLE DEFAULT NULL
        COMMENT 'GPS accuracy in meters at check-in',

-- Punch-out location
    ADD COLUMN check_out_lat      DECIMAL(10,6) DEFAULT NULL
        COMMENT 'Latitude at check-out',
    ADD COLUMN check_out_lon      DECIMAL(10,6) DEFAULT NULL
        COMMENT 'Longitude at check-out',
    ADD COLUMN check_out_accuracy DOUBLE DEFAULT NULL
        COMMENT 'GPS accuracy in meters at check-out',

-- Area reference
    ADD COLUMN area_id           INT DEFAULT NULL
        COMMENT 'FK to punch_area.id',
    ADD COLUMN area_name         VARCHAR(100) DEFAULT NULL
        COMMENT 'Snapshot of area name at punch-in time',
    ADD COLUMN distance_m        DOUBLE DEFAULT NULL
        COMMENT 'Distance in meters from area center at check-in',

-- Device info
    ADD COLUMN device_type       VARCHAR(20) DEFAULT NULL
        COMMENT 'mobile, tablet or desktop',

-- FK to punch_area
    ADD CONSTRAINT fk_attendance_area
        FOREIGN KEY (area_id)
        REFERENCES punch_area (id)
        ON DELETE SET NULL
        ON UPDATE CASCADE;
------------------------------------------------------------
ALTER TABLE `Elecon`.`EMPLOYEES`
ADD COLUMN `insuranse_no` VARCHAR(45) NULL DEFAULT NULL AFTER `org_code`,
ADD UNIQUE INDEX `insuranse_no_UNIQUE` (`insuranse_no` ASC) ;
------------------------------------------------------------
ALTER TABLE `Elecon`.`PUNCH_AREA`
ADD COLUMN `type` VARCHAR(2) NULL DEFAULT 'C' AFTER `is_active`;
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elecon`.`PROJECT_ASSIGNMENTS` (
  `ASSIGNMENT_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` INT(11) NOT NULL,
  `EMP_ID` INT(11) NOT NULL,
  `JOB_ID` INT(11) NOT NULL,
  `ASSIGN_DATE` DATETIME NOT NULL,
  `END_DATE` DATETIME NULL DEFAULT NULL,
  `IS_ACTIVE` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`ASSIGNMENT_ID`),
  INDEX `fk_PROJECT_ASSIGNMENTS_PROJCTS_idx` (`PROJECT_ID` ASC) ,
  INDEX `fk_PROJECT_ASSIGNMENTS_EMPS_idx` (`EMP_ID` ASC) ,
  INDEX `fk_PROJECT_ASSIGNMENTS_JOBS_idx` (`JOB_ID` ASC) ,
  CONSTRAINT `fk_PROJECT_ASSIGNMENTS_EMPS`
    FOREIGN KEY (`EMP_ID`)
    REFERENCES `Elecon`.`EMPLOYEES` (`emp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_ASSIGNMENTS_JOBS`
    FOREIGN KEY (`JOB_ID`)
    REFERENCES `Elecon`.`JOBS` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECT_ASSIGNMENTS_PROJCTS`
    FOREIGN KEY (`PROJECT_ID`)
    REFERENCES `Elecon`.`PROJECTS_MAST` (`proj_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
