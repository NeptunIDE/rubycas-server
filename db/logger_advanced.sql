CREATE SCHEMA IF NOT EXISTS `logins` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;

CREATE  TABLE IF NOT EXISTS `logins`.`logins` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `user_id` CHAR(36) NOT NULL ,
  `domain` VARCHAR(255) NOT NULL ,
  `timestamp` DATETIME NOT NULL ,
  `ip` VARCHAR(15) NOT NULL ,
  `real_ip` VARCHAR(15) NOT NULL ,
  `user_agent` TEXT NOT NULL ,
  `referer` TEXT NOT NULL ,
  `accepted_languages` TEXT NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB

CREATE  TABLE IF NOT EXISTS `logins`.`logouts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `timestamp` DATETIME NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;