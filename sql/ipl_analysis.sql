-- IPL Match & Player Data Analytics
-- SQL Analysis Queries
-- Database: MySQL

-- 1. Check total number of deliveries
SELECT COUNT(*) AS total_deliveries
FROM ball_by_ball_data;


-- 2. Number of seasons available
SELECT COUNT(DISTINCT season_id) AS total_seasons
FROM ball_by_ball_data;


-- 3. Total runs scored
SELECT SUM(batter_runs) AS total_batter_runs
FROM ball_by_ball_data;


-- 4. Total runs by team
SELECT
    team_batting,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY team_batting
ORDER BY total_runs DESC;


-- 5. Top 10 run scorers
SELECT
    batter,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;


-- 6. Top 10 players by number of wickets
SELECT
    player_out,
    COUNT(*) AS total_wickets
FROM ball_by_ball_data
WHERE is_wicket = 1
  AND player_out IS NOT NULL
GROUP BY player_out
ORDER BY total_wickets DESC
LIMIT 10;


-- 7. Total wickets by season
SELECT
    season_id,
    COUNT(*) AS total_wickets
FROM ball_by_ball_data
WHERE is_wicket = 1
GROUP BY season_id
ORDER BY season_id;


-- 8. Team-wise wickets
SELECT
    team_bowling,
    COUNT(*) AS total_wickets
FROM ball_by_ball_data
WHERE is_wicket = 1
GROUP BY team_bowling
ORDER BY total_wickets DESC;


-- 9. Most common dismissal types
SELECT
    wicket_kind,
    COUNT(*) AS dismissals
FROM ball_by_ball_data
WHERE is_wicket = 1
  AND wicket_kind IS NOT NULL
GROUP BY wicket_kind
ORDER BY dismissals DESC;


-- 10. Runs scored by season
SELECT
    season_id,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY season_id
ORDER BY season_id;


-- 11. Top batting teams by season
SELECT
    season_id,
    team_batting,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY season_id, team_batting
ORDER BY season_id, total_runs DESC;


-- 12. Wide balls by bowling team
SELECT
    team_bowling,
    SUM(wide_ball_runs) AS wide_runs
FROM ball_by_ball_data
GROUP BY team_bowling
ORDER BY wide_runs DESC;


-- 13. No-ball runs by bowling team
SELECT
    team_bowling,
    SUM(no_ball_runs) AS no_ball_runs
FROM ball_by_ball_data
GROUP BY team_bowling
ORDER BY no_ball_runs DESC;


-- 14. Total extras by team
SELECT
    team_bowling,
    SUM(extras) AS total_extras
FROM ball_by_ball_data
GROUP BY team_bowling
ORDER BY total_extras DESC;


-- 15. Batter performance by season
SELECT
    season_id,
    batter,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY season_id, batter
ORDER BY season_id, total_runs DESC;


-- 16. Number of matches involving each batting team
SELECT
    team_batting,
    COUNT(DISTINCT match_id) AS matches_played
FROM ball_by_ball_data
GROUP BY team_batting
ORDER BY matches_played DESC;


-- 17. Runs scored in each innings
SELECT
    innings,
    SUM(batter_runs) AS total_runs
FROM ball_by_ball_data
GROUP BY innings
ORDER BY innings;


-- 18. Wickets by dismissal type and season
SELECT
    season_id,
    wicket_kind,
    COUNT(*) AS dismissals
FROM ball_by_ball_data
WHERE is_wicket = 1
  AND wicket_kind IS NOT NULL
GROUP BY season_id, wicket_kind
ORDER BY season_id, dismissals DESC;


-- 19. Player with the most runs in each season
WITH player_season_runs AS (
    SELECT
        season_id,
        batter,
        SUM(batter_runs) AS total_runs,
        RANK() OVER (
            PARTITION BY season_id
            ORDER BY SUM(batter_runs) DESC
        ) AS ranking
    FROM ball_by_ball_data
    GROUP BY season_id, batter
)
SELECT
    season_id,
    batter,
    total_runs
FROM player_season_runs
WHERE ranking = 1
ORDER BY season_id;


-- 20. Team-wise batting and bowling overview
SELECT
    team_batting AS team,
    SUM(batter_runs) AS runs_scored,
    COUNT(DISTINCT match_id) AS matches_played
FROM ball_by_ball_data
GROUP BY team_batting
ORDER BY runs_scored DESC;
