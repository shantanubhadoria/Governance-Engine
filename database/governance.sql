SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `governance` ;
CREATE SCHEMA IF NOT EXISTS `governance` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `governance` ;

-- -----------------------------------------------------
-- Table `governance`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`users` ;

CREATE  TABLE IF NOT EXISTS `governance`.`users` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `email` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `middle_name` VARCHAR(45) NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `mobile_number` VARCHAR(45) NOT NULL ,
  `authenticated` TINYINT(1) NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `username_UNIQUE` ON `governance`.`users` (`username` ASC) ;

CREATE UNIQUE INDEX `email_UNIQUE` ON `governance`.`users` (`email` ASC) ;


-- -----------------------------------------------------
-- Table `governance`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`roles` ;

CREATE  TABLE IF NOT EXISTS `governance`.`roles` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NOT NULL ,
  `parent_role_id` INT(11) UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_roles_1`
    FOREIGN KEY (`parent_role_id` )
    REFERENCES `governance`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_roles_1_idx` ON `governance`.`roles` (`parent_role_id` ASC) ;


-- -----------------------------------------------------
-- Table `governance`.`user_role_maps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`user_role_maps` ;

CREATE  TABLE IF NOT EXISTS `governance`.`user_role_maps` (
  `user_id` INT(11) UNSIGNED NOT NULL ,
  `role_id` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`user_id`, `role_id`) ,
  CONSTRAINT `fk_user_role_maps_1`
    FOREIGN KEY (`user_id` )
    REFERENCES `governance`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role_maps_2`
    FOREIGN KEY (`role_id` )
    REFERENCES `governance`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_role_maps_1_idx` ON `governance`.`user_role_maps` (`user_id` ASC) ;

CREATE INDEX `fk_user_role_maps_2_idx` ON `governance`.`user_role_maps` (`role_id` ASC) ;


-- -----------------------------------------------------
-- Table `governance`.`issue_statuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`issue_statuses` ;

CREATE  TABLE IF NOT EXISTS `governance`.`issue_statuses` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `is_closed` TINYINT(1) UNSIGNED NOT NULL ,
  `ordering` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE INDEX `index2` ON `governance`.`issue_statuses` (`ordering` ASC) ;


-- -----------------------------------------------------
-- Table `governance`.`issue_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`issue_types` ;

CREATE  TABLE IF NOT EXISTS `governance`.`issue_types` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `ordering` INT(11) UNSIGNED NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `governance`.`issues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `governance`.`issues` ;

CREATE  TABLE IF NOT EXISTS `governance`.`issues` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
  `issue_type_id` INT(11) UNSIGNED NOT NULL ,
  `project_id` INT(11) UNSIGNED NULL DEFAULT NULL ,
  `author_user_id` INT(11) UNSIGNED NOT NULL ,
  `subject` VARCHAR(255) NOT NULL ,
  `description` TEXT NOT NULL ,
  `issue_status_id` INT(11) UNSIGNED NOT NULL DEFAULT 1 ,
  `created_time` DATETIME NOT NULL ,
  `modified_time` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_issues_1`
    FOREIGN KEY (`issue_status_id` )
    REFERENCES `governance`.`issue_statuses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_issues_2`
    FOREIGN KEY (`author_user_id` )
    REFERENCES `governance`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_issues_3`
    FOREIGN KEY (`issue_type_id` )
    REFERENCES `governance`.`issue_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_issues_1_idx` ON `governance`.`issues` (`issue_status_id` ASC) ;

CREATE INDEX `fk_issues_2_idx` ON `governance`.`issues` (`author_user_id` ASC) ;

CREATE INDEX `fk_issues_3_idx` ON `governance`.`issues` (`issue_type_id` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `governance`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `governance`;
INSERT INTO `governance`.`users` (`id`, `username`, `email`, `password`, `first_name`, `middle_name`, `last_name`, `mobile_number`, `authenticated`) VALUES (1, 'shantanubhadoria', 'shantanu@cpan.org', '{SSHA}Yvtzed4XeZrRFrM4jKXvltnXnlkadqgVAV7Ppx6EA7Dor+OQ5AuyRg==', 'Shantanu', '', 'Bhadoria', '92296717', 1);

COMMIT;

-- -----------------------------------------------------
-- Data for table `governance`.`issue_statuses`
-- -----------------------------------------------------
START TRANSACTION;
USE `governance`;
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (1, 'New', 'Just Created - Needs to be accepted or assigned', 0, 1);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (2, 'Assigned', 'Assigned - waiting for initiation of work by assignee', 0, 2);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (3, 'In Progress', 'Accepted by assignee. In Progress', 0, 3);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (4, 'Feedback', 'Sent back to the issue author requesting for feedback', 0, 4);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (5, 'Testing', 'Task completed, quality check in progress', 0, 5);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (6, 'Resolved', 'Issue is resolved solution is in place. Waiting for task issuer to close or return the issue. Issue automatically closes after given time.', 1, 6);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (7, 'Returned', 'Issue is returned again after being resolved. Author not satisfied with resolution', 0, 7);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (8, 'Closed', 'Issue satisfactorily resolved', 1, 8);
INSERT INTO `governance`.`issue_statuses` (`id`, `name`, `description`, `is_closed`, `ordering`) VALUES (9, 'Reopened', 'Issue Reopened due to reoccurence after it was closed with satisfactory resolution by the author due to regression, reoccurence of the issue', 0, 9);

COMMIT;

-- -----------------------------------------------------
-- Data for table `governance`.`issue_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `governance`;
INSERT INTO `governance`.`issue_types` (`id`, `name`, `ordering`) VALUES (1, 'Grievance', 1);
INSERT INTO `governance`.`issue_types` (`id`, `name`, `ordering`) VALUES (2, 'Development Task', 2);
INSERT INTO `governance`.`issue_types` (`id`, `name`, `ordering`) VALUES (3, 'Support', 3);

COMMIT;

-- -----------------------------------------------------
-- Data for table `governance`.`issues`
-- -----------------------------------------------------
START TRANSACTION;
USE `governance`;
INSERT INTO `governance`.`issues` (`id`, `issue_type_id`, `project_id`, `author_user_id`, `subject`, `description`, `issue_status_id`, `created_time`, `modified_time`) VALUES (1, 1, 1, 1, 'Subject 1', 'description 1', 1, '2014-03-01 20:26:36', '2014-03-02 10:26:36');
INSERT INTO `governance`.`issues` (`id`, `issue_type_id`, `project_id`, `author_user_id`, `subject`, `description`, `issue_status_id`, `created_time`, `modified_time`) VALUES (2, 1, 1, 1, 'Subject 2', 'description 2', 2, '2014-03-01 20:26:36', '2014-03-02 20:26:36');

COMMIT;
