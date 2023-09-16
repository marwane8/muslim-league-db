.mode csv

.import ./soccer-db/test-data/seasons.csv seasons_temp
.import ./soccer-db/test-data/location.csv location_temp
.import ./soccer-db/test-data/teams.csv teams_temp
.import ./soccer-db/test-data/games.csv games_temp
.import ./soccer-db/test-data/players.csv players_temp
.import ./soccer-db/test-data/teams_players.csv teams_players_temp
.import ./soccer-db/test-data/statistics.csv statistics_temp

INSERT INTO seasons (season_id,season_name,year)
SELECT season_id,season_name,year
FROM seasons_temp;

INSERT INTO location (location_id,court,address,city,state)
SELECT location_id,court,address,city,state
FROM location_temp;

INSERT INTO teams (team_id,season_id,team_name,team_captain,wins,losses,draws,goals_for,goals_against,points)
SELECT team_id,season_id,team_name,team_captain,wins,losses,draws,goals_for,goals_against,points
FROM teams_temp;

INSERT INTO games (game_id, season_id, team1_id, team2_id, location_id, date, start_time, playoff)
SELECT game_id, season_id, team1_id, team2_id, location_id, date, start_time, playoff
FROM games_temp;

INSERT INTO players (id,active,f_name,l_name,name,number,pos)
SELECT id,active,f_name,l_name,name,number,pos
FROM players_temp;

INSERT INTO teams_players (team_id,player_id)
SELECT team_id,player_id
FROM teams_players_temp;

INSERT INTO statistics (stat_id,game_id,player_id,goals,assists)
SELECT stat_id,game_id,player_id,goals,assists
FROM statistics_temp;


DROP TABLE seasons_temp;
DROP TABLE location_temp;
DROP TABLE teams_temp;
DROP TABLE games_temp;
DROP TABLE players_temp;
DROP TABLE teams_players_temp;
DROP TABLE statistics_temp;