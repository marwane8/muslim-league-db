-- -----------------------------------------------------
-- Table Season
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seasons` (
  `season_id` INTEGER NOT NULL,
  `season_name` VARCHAR(20) NULL DEFAULT NULL,
  `year` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`season_id`));

-- -----------------------------------------------------
-- Table Players
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players` (
  `player_id` INT NOT NULL,
  `player_name` VARCHAR(255) NOT NULL,
  `player_last_name` VARCHAR(255) NOT NULL,
  `player_number` INT NULL DEFAULT NULL,
  `player_pos` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`));

-- -----------------------------------------------------
-- Table Teams
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teams` (
  `team_id` INTEGER NOT NULL,
  `season_id` INT NOT NULL,
  `team_name` VARCHAR(255) NOT NULL,
  `team_captain` INT NULL DEFAULT NULL,
  `wins` INT NULL DEFAULT NULL,
  `losses` INT NULL DEFAULT NULL,
  `draws` INT NULL DEFAULT NULL,
  `goals_for` INT NULL DEFAULT NULL,
  `goals_against` INT NULL DEFAULT NULL,
  `points` INT NULL DEFAULT NULL,
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
-- Table Location
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` INT NOT NULL,
  `court` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`));


-- -----------------------------------------------------
-- Table Games
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `games` (
  `game_id` INT NOT NULL,
  `team1_id` INT NOT NULL,
  `team2_id` INT NOT NULL,
  `location_id` INT NULL DEFAULT NULL,
  `date` INT NULL DEFAULT NULL,
  `start_time` VARCHAR(50) NULL DEFAULT NULL,
  `playoff` INT NULL DEFAULT NULL,
  PRIMARY KEY (`game_id`),
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
-- Table Statistics
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `statistics` (
  `stat_id` INT NOT NULL,
  `game_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `goals` INT NULL DEFAULT NULL,
  `assists` INT NULL DEFAULT NULL,
  PRIMARY KEY (`stat_id`),
  FOREIGN KEY (`game_id` ) 
    REFERENCES games (`game_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`player_id` ) 
    REFERENCES players (`player_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);
 

-- -----------------------------------------------------
-- Table teams_players
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
    REFERENCES players (`player_id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);
