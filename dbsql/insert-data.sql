.mode csv

.import ./dbsql/test-data/sport.csv sport_temp
.import ./dbsql/test-data/stat_type.csv stat_type_temp
.import ./dbsql/test-data/seasons.csv seasons_temp
.import ./dbsql/test-data/location.csv location_temp
.import ./dbsql/test-data/teams.csv teams_temp
.import ./dbsql/test-data/games.csv games_temp
.import ./dbsql/test-data/players.csv players_temp
.import ./dbsql/test-data/teams_players.csv teams_players_temp
.import ./dbsql/test-data/statistics.csv statistics_temp

INSERT INTO `users` VALUES (1,'admin','$2b$12$Kyru2BV3Tevk15XGzIupD.3NjhSDrZj5WvDm7zhlsuIj8e5ewiot6',1);
INSERT INTO sport (id,name)
SELECT id,name
FROM sport_temp;

INSERT INTO seasons (id,sport_id,name,year)
SELECT id,sport_id,name,year
FROM seasons_temp;

INSERT INTO stat_type (id,stat)
SELECT id,stat
FROM stat_type_temp;

INSERT INTO teams (id,season_id,name,captain_id,stats_obj)
SELECT id,season_id,name,captain_id,stats_obj
FROM teams_temp;

INSERT INTO players (id,active,f_name,l_name,name,number,pos)
SELECT id,active,f_name,l_name,name,number,pos
FROM players_temp;

INSERT INTO teams_players (team_id,player_id)
SELECT team_id,player_id
FROM teams_players_temp;

INSERT INTO location (id,court,address,city,state)
SELECT id,court,address,city,state
FROM location_temp;

INSERT INTO games (id, season_id, team1_id, team2_id, location_id, date, start_time, playoff, played)
SELECT id, season_id, team1_id, team2_id, location_id, date, start_time, playoff, played
FROM games_temp;

INSERT INTO statistics (id,sport_id,game_id,player_id,stat1_type,stat1,stat2_type,stat2,stat3_type,stat3)
SELECT id,sport_id,game_id,player_id,stat1_type,stat1,stat2_type,stat2,stat3_type,stat3
FROM statistics_temp;

DROP TABLE seasons_temp;
DROP TABLE sport_temp;
DROP TABLE stat_type_temp;
DROP TABLE location_temp;
DROP TABLE teams_temp;
DROP TABLE games_temp;
DROP TABLE players_temp;
DROP TABLE teams_players_temp;
DROP TABLE statistics_temp;