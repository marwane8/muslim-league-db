-- -----------------------------------------------------
-- Table Season
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seasons` (
  `season_id` INTEGER NOT NULL,
  `season_name` VARCHAR(20) NULL DEFAULT NULL,
  `year` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`season_id`));

-- -----------------------------------------------------
-- Table `muslimball`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players` (
  `id` INTEGER PRIMARY KEY,
  `active` BOOLEAN NOT NULL CHECK (`active` IN (0, 1)) DEFAULT 0,
  `f_name` VARCHAR(255) NOT NULL,
  `l_name` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `number` INT NULL DEFAULT NULL,
  `pos` VARCHAR(5) NULL DEFAULT NULL
);

-- -----------------------------------------------------
-- Table `muslimball`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teams` (
  `team_id` INTEGER NOT NULL,
  `season_id` INT NOT NULL,
  `team_name` VARCHAR(255) NOT NULL,
  `team_captain` INT NULL DEFAULT NULL,
  `wins` INT NULL DEFAULT NULL,
  `losses` INT NULL DEFAULT NULL,
  `PF` INT NULL DEFAULT NULL,
  `PA` INT NULL DEFAULT NULL,
  `rebounds_tot` INT NULL DEFAULT NULL,
  `fouls_tot` INT NULL DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  FOREIGN KEY (`season_id` ) 
    REFERENCES season (`season_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`team_captain`) 
    REFERENCES players (`player_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `muslimball`.`teams_players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teams_players` (
  `team_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  PRIMARY KEY (`team_id`, `player_id`),
  FOREIGN KEY (`team_id` ) 
    REFERENCES teams (`team_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`player_id` ) 
    REFERENCES players (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `muslimball`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` INT NOT NULL,
  `court` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`));


-- -----------------------------------------------------
-- Table `muslimball`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `games` (
  `game_id` INT NOT NULL,
  `season_id` INT NOT NULL,
  `team1_id` INT NOT NULL,
  `team2_id` INT NOT NULL,
  `location_id` INT NULL DEFAULT NULL,
  `date` INT NULL DEFAULT NULL,
  `start_time` VARCHAR(50) NULL DEFAULT NULL,
  `playoff` INT NULL DEFAULT NULL,
  `played` BOOLEAN NOT NULL CHECK (`played` IN (0, 1)) DEFAULT 0,
  PRIMARY KEY (`game_id`),
  FOREIGN KEY (`season_id` ) 
    REFERENCES season (`season_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`team1_id` ) 
    REFERENCES teams (`team_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`team2_id` ) 
    REFERENCES teams (`team_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`location_id` ) 
    REFERENCES location (`location_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `muslimball`.`statistics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `statistics` (
  `stat_id` INTEGER PRIMARY KEY,
  `game_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `dnp` BOOLEAN NOT NULL CHECK (`dnp` IN (0, 1)) DEFAULT 0,
  `points` INT NULL DEFAULT NULL,
  `rebounds` INT NULL DEFAULT NULL,
  `fouls` INT NULL DEFAULT NULL,
  FOREIGN KEY (`game_id` ) 
    REFERENCES games (`game_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`player_id` ) 
    REFERENCES players (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);
 

