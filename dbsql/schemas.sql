-- -----------------------------------------------------
--  Users Table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS "users" (
	"id"	INTEGER NOT NULL,
	"username"	TEXT NOT NULL UNIQUE,
	"password"	TEXT NOT NULL,
	"admin"	INTEGER NOT NULL CHECK("admin" IN (0, 1)),
	PRIMARY KEY("id")
);


-- -----------------------------------------------------
-- Sport Lookup Table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sport` (
  `id` INTEGER PRIMARY KEY,
  `name` VARCHAR(20) NULL DEFAULT NULL
);


-- -----------------------------------------------------
-- Season Lookup Table
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `seasons` (
  `id` INTEGER PRIMARY KEY,
  `sport_id` INTEGER NOT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `year` INTEGER NULL DEFAULT NULL,
  FOREIGN KEY (`sport_id` ) 
    REFERENCES sport (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Players Table 
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
-- Teams Table 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teams` (
  `id` INTEGER PRIMARY KEY,
  `season_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `captain_id` INT NULL DEFAULT NULL,
  `stats_obj` TEXT,
  FOREIGN KEY (`season_id` ) 
    REFERENCES season (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`captain_id`) 
    REFERENCES players (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- teams_players join Table 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teams_players` (
  `team_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  PRIMARY KEY (`team_id`, `player_id`),
  FOREIGN KEY (`team_id` ) 
    REFERENCES teams (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`player_id` ) 
    REFERENCES players (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Locations 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `location` (
  `id` INTEGER PRIMARY KEY,
  `court` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL
);


-- -----------------------------------------------------
-- Games 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `games` (
  `id` INTEGER PRIMARY KEY,
  `season_id` INT NOT NULL,
  `team1_id` INT NOT NULL,
  `team2_id` INT NOT NULL,
  `location_id` INT NULL DEFAULT NULL,
  `date` INT NULL DEFAULT NULL,
  `start_time` VARCHAR(50) NULL DEFAULT NULL,
  `playoff` INT NULL DEFAULT NULL,
  `played` BOOLEAN NOT NULL CHECK (`played` IN (0, 1)) DEFAULT 0,
  FOREIGN KEY (`season_id` ) 
    REFERENCES season (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`team1_id` ) 
    REFERENCES teams (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`team2_id` ) 
    REFERENCES teams (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`location_id` ) 
    REFERENCES location (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `muslimball`.`stat_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stat_type` (
  `id` INTEGER PRIMARY KEY,
  `stat` VARCHAR(60)
  );


-- -----------------------------------------------------
-- Game Stats 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `statistics` (
  `id` INTEGER PRIMARY KEY,
  `sport_id` INTEGER NOT NULL,
  `game_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `dnp` BOOLEAN NOT NULL CHECK (`dnp` IN (0, 1)) DEFAULT 0,
  `stat1_type` INT DEFAULT NULL,
  `stat1` INT NULL DEFAULT NULL,
  `stat2_type` INT DEFAULT NULL,
  `stat2` INT NULL DEFAULT NULL,
  `stat3_type` INT DEFAULT NULL,
  `stat3` INT NULL DEFAULT NULL,
FOREIGN KEY (`sport_id` ) 
    REFERENCES sport (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`game_id` ) 
    REFERENCES games (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`player_id` ) 
    REFERENCES players (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`stat1_type` ) 
    REFERENCES stat_type (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`stat2_type` ) 
    REFERENCES stat_type (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION,
  FOREIGN KEY (`stat3_type` ) 
    REFERENCES stat_type (`id`)
        ON DELETE CASCADE 
        ON UPDATE NO ACTION
);
 

