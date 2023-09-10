-- -----------------------------------------------------
-- Schedule View 
-- -----------------------------------------------------
CREATE VIEW `schedule` AS
    SELECT
        `games`.`season_id` AS `season_id`,
        `games`.`game_id` AS `game_id`,
        `games`.`team1_id` AS `team1_id`,
        `tm1`.`team_name` AS `team1`,
        `games`.`team2_id` AS `team2_id`,
        `tm2`.`team_name` AS `team2`,
        `games`.`date` AS `date`,
        `games`.`start_time` AS `start_time`,
        `l`.`court` AS `court`,
        `games`.`playoff` AS `playoff` 
    from 
        (((`games` 
        left join `teams` `tm1` on((`games`.`team1_id` = `tm1`.`team_id`))) 
        left join `location` `l` on((`games`.`location_id` = `l`.`location_id`))) 
        left join `teams` `tm2` on((`games`.`team2_id` = `tm2`.`team_id`)));


-- -----------------------------------------------------
-- Game Statistics 
-- -----------------------------------------------------
CREATE VIEW `game_statistics` AS
    SELECT 
        `s`.`game_id` AS `game_id`,
        `t`.`team_id` AS `team_id`,
        `t`.`team_name` AS `team_name`,
        `s`.`player_id` AS `player_id`,
        `s`.`stat_id` AS `stat_id`,
        `p`.`player_name` AS `player_name`,
        `s`.`dnp` AS `dnp`,
        `s`.`goals` AS `goals`,
        `s`.`assists` AS `assists`
    FROM
        (((`teams_players` `tp`
        LEFT JOIN `teams` `t` ON ((`tp`.`team_id` = `t`.`team_id`)))
        LEFT JOIN `players` `p` ON ((`tp`.`player_id` = `p`.`player_id`)))
        LEFT JOIN `statistics` `s` ON (`tp`.`player_id` = `s`.`player_id`));

-- -----------------------------------------------------
-- Game Totals 
-- -----------------------------------------------------
CREATE VIEW `game_totals` AS
    SELECT 
        `teams`.`team_id` AS `t_id`,
        `teams`.`team_name` AS `team_name`,
        `statistics`.`game_id` AS `g_id`,
        sum(`statistics`.`goals`) AS `goals`,
        sum(`statistics`.`assists`) AS `assists`
    FROM
        (((`teams_players` `tp`
        LEFT JOIN `teams` ON ((`tp`.`team_id` = `teams`.`team_id`)))
        LEFT JOIN `players` ON ((`tp`.`player_id` = `players`.`player_id`)))
        LEFT JOIN `statistics` ON (`tp`.`player_id` = `statistics`.`player_id`))
        GROUP BY `t_id`,`g_id`;

-- -----------------------------------------------------
-- Game Totals 
-- -----------------------------------------------------
CREATE VIEW `team_totals` AS
    SELECT 
        `teams`.`team_id` AS `t_id`,
        `teams`.`team_name` AS `team_name`,
        `statistics`.`game_id` AS `g_id`,
        sum(`statistics`.`goals`) AS `goals`,
        sum(`statistics`.`assists`) AS `assists`
    FROM
        (((`teams_players` `tp`
        LEFT JOIN `teams` ON ((`tp`.`team_id` = `teams`.`team_id`)))
        LEFT JOIN `players` ON ((`tp`.`player_id` = `players`.`player_id`)))
        LEFT JOIN `statistics` ON (`tp`.`player_id` = `statistics`.`player_id`))
        GROUP BY `t_id`;

-- -----------------------------------------------------
-- Player Totals 
-- -----------------------------------------------------
CREATE  VIEW `player_totals` AS 
    SELECT
        `games`.`season_id` AS `season_id`,
        `st`.`player_id` AS `p_id`,
        `players`.`player_name` AS `player_name`,
        Count(*) AS `games_played`,
        sum(`st`.`goals`) AS `goals`,
        sum(`st`.`assists`) AS `assists`
    FROM 
        ((`statistics` `st` 
        LEFT JOIN `games` ON ((`st`.`game_id` = `games`.`game_id`)))
        LEFT JOIN `players` on((`st`.`player_id` = `players`.`player_id`))) 
        GROUP BY `p_id`;

-- -----------------------------------------------------
-- Roster View 
-- -----------------------------------------------------
CREATE VIEW `roster` AS
    SELECT 
        `players`.`player_id` AS `id`,
        `teams`.`team_id` AS `team_id`,
        `teams`.`team_name` AS `team_name`,
        `players`.`player_name` AS `player_name`,
        `players`.`player_number` AS `player_number`,
        `players`.`player_pos` AS `player_pos`
    FROM
        ((`teams_players` `tp`
        LEFT JOIN `teams` ON ((`tp`.`team_id` = `teams`.`team_id`)))
        LEFT JOIN `players` ON ((`tp`.`player_id` = `players`.`player_id`)))