-- -----------------------------------------------------
-- Schedule View 
-- -----------------------------------------------------
CREATE VIEW `schedule` AS
    SELECT
        `seasons`.`sport_id` AS `sport_id`,
		`games`.`season_id` AS `season_id`,
        `games`.`id` AS `game_id`,
        `games`.`team1_id` AS `team1_id`,
        `tm1`.`name` AS `team1`,
        `games`.`team2_id` AS `team2_id`,
        `tm2`.`name` AS `team2`,
        `games`.`date` AS `date`,
        `games`.`start_time` AS `start_time`,
        `l`.`court` AS `court`,
        `games`.`playoff` AS `playoff`,
        `games`.`played` AS `played` 
    from 
        ((((`games` 
        left join `seasons` on((`games`.`season_id` = `seasons`.`id`)))
        left join `teams` `tm1` on((`games`.`team1_id` = `tm1`.`id`))) 
        left join `location` `l` on((`games`.`location_id` = `l`.`id`))) 
        left join `teams` `tm2` on((`games`.`team2_id` = `tm2`.`id`)));
-- -----------------------------------------------------
-- Game Statistics 
-- -----------------------------------------------------
CREATE VIEW `game_statistics` AS
    SELECT 
        `s`.`game_id` AS `game_id`,
        `t`.`id` AS `team_id`,
        `t`.`name` AS `team_name`,
        `s`.`player_id` AS `player_id`,
        `s`.`id` AS `stat_id`,
        `p`.`name` AS `player_name`,
        `s`.`dnp` AS `dnp`,
        `s`.`stat1_type` AS `type1`,
        `s`.`stat1` AS `stat1`,
        `s`.`stat2_type` AS `type2`,
        `s`.`stat2` AS `stat2`,
        `s`.`stat3_type` AS `type3`,
        `s`.`stat3` AS `stat3`		
    FROM
	    (((`teams_players` `tp`
        LEFT JOIN `teams` `t` ON ((`tp`.`team_id` = `t`.`id`)))
        LEFT JOIN `players` `p` ON ((`tp`.`player_id` = `p`.`id`)))
        LEFT JOIN `statistics` `s` ON (`tp`.`player_id` = `s`.`player_id`));


-- -----------------------------------------------------
-- Game Totals 
-- -----------------------------------------------------
CREATE VIEW `game_totals` AS
SELECT
        `teams`.`id` AS `t_id`,
        `teams`.`name` AS `team_name`,
        `statistics`.`game_id` AS `g_id`,
	    `statistics`.`stat1_type` AS `type1`,
		sum(`statistics`.`stat1`) AS `stat1_total`,
        `statistics`.`stat2_type` AS `type2`,
		sum(`statistics`.`stat2`) AS `stat2_total`,
        `statistics`.`stat3_type` AS `type3`,
        sum(`statistics`.`stat3`) AS `stat3_total`
FROM
	teams_players
	LEFT JOIN teams ON teams_players.team_id = teams.id
	LEFT JOIN players ON teams_players.player_id = players.id
	LEFT JOIN statistics ON teams_players.player_id=statistics.player_id
    GROUP BY `t_id`,`g_id`,`type1`,`type2`,`type3`;

-- -----------------------------------------------------
-- Basketball Team Totals 
-- -----------------------------------------------------
CREATE VIEW `team_totals` AS
    SELECT 
		`statistics`.`sport_id` AS `sport_id`,
        `teams`.`id` AS `t_id`,
        `teams`.`name` AS `team_name`,
        `statistics`.`game_id` AS `g_id`,
        `statistics`.`stat1_type` AS `type1`,
        sum(`statistics`.`stat1`) AS `stat1_total`,
        `statistics`.`stat2_type` AS `type2`,
        sum(`statistics`.`stat2`) AS `stat2_total`,
        `statistics`.`stat3_type` AS `type3`,
        sum(`statistics`.`stat3`) AS `stat3_total`
    FROM
        (((`teams_players` `tp`
        LEFT JOIN `teams` ON ((`tp`.`team_id` = `teams`.`id`)))
        LEFT JOIN `players` ON ((`tp`.`player_id` = `players`.`id`)))
        LEFT JOIN `statistics` ON (`tp`.`player_id` = `statistics`.`player_id`))
        GROUP BY `t_id`,`type1`,`type2`,`type3`;

-- -----------------------------------------------------
-- Player Totals 
-- -----------------------------------------------------
CREATE  VIEW `player_totals` AS 
    SELECT
        `games`.`season_id` AS `season_id`,
        `st`.`player_id` AS `p_id`,
        `players`.`name` AS `name`,
        COUNT(*) AS `stat_records`,
	    `st`.`dnp` AS `dnp`,
        `st`.`stat1_type` AS `type1`,
        sum(`st`.`stat1`) AS `stat1`,
        `st`.`stat2_type` AS `type2`,
        sum(`st`.`stat2`) AS `stat2`,
        `st`.`stat3_type` AS `type3`,
        sum(`st`.`stat3`) AS `stat3`
   FROM
        ((`statistics` `st` 
        LEFT JOIN `games` ON ((`st`.`game_id` = `games`.`id`)))
        LEFT JOIN `players` on((`st`.`player_id` = `players`.`id`))) 
        GROUP BY `p_id`,`type1`,`type2`,`type3`;


-- -----------------------------------------------------
-- Roster View 
-- -----------------------------------------------------
CREATE VIEW `roster` AS
    SELECT 
        `players`.`id` AS `id`,
        `teams`.`id` AS `team_id`,
        `teams`.`name` AS `team_name`,
        `players`.`active` AS `active`,
        `players`.`f_name` AS `f_name`,
        `players`.`l_name` AS `l_name`,
        `players`.`name` AS `player_name`,
        `players`.`number` AS `player_number`,
        `players`.`pos` AS `player_pos`
    FROM
        ((`teams_players` `tp`
        LEFT JOIN `teams` ON ((`tp`.`team_id` = `teams`.`id`)))
        LEFT JOIN `players` ON ((`tp`.`player_id` = `players`.`id`)))