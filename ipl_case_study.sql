/*
Write queries for the following tasks:
1. Create a table named "matches" with appropriate data types for columns
2. Create a table named "deliveries" with appropriate data types for columns
3. Import data from csv file &#39;IPL_matches.csv&#39;attached in resources to
&#39;matches&#39;
4. Import data from csv file &#39;IPL_Ball.csv&#39; attached in resources to &#39;matches
5. Select the top 20 rows of the deliveries table.
6. Select the top 20 rows of the matches table.
7. Fetch data of all the matches played on 2nd May 2013.
8. Fetch data of all the matches where the margin of victory is more than
100 runs.
9. Fetch data of all the matches where the final scores of both teams tied
and order it in descending order of the date.

10. Get the count of cities that have hosted an IPL match.
11. Create table deliveries_v02 with all the columns of deliveries and an
additional column ball_result containing value boundary, dot or other
depending on the total_run (boundary for &gt;= 4, dot for 0 and other for any
other number)
12. Write a query to fetch the total number of boundaries and dot balls
13. Write a query to fetch the total number of boundaries scored by each
team
14. Write a query to fetch the total number of dot balls bowled by each
team
15. Write a query to fetch the total number of dismissals by dismissal kinds
16. Write a query to get the top 5 bowlers who conceded maximum extra
runs
17. Write a query to create a table named deliveries_v03 with all the
columns of deliveries_v02 table and two additional column (named venue
and match_date) of venue and date from table matches
18. Write a query to fetch the total runs scored for each venue and order it
in the descending order of total runs scored.
19. Write a query to fetch the year-wise total runs scored at Eden Gardens
and order it in the descending order of total runs scored.
20. Get unique team1 names from the matches table, you will notice that
there are two entries for Rising Pune Supergiant one with Rising Pune
Supergiant and another one with Rising Pune Supergiants. Your task is to
create a matches_corrected table with two additional columns team1_corr
and team2_corr containing team names with replacing Rising Pune
Supergiants with Rising Pune Supergiant. Now analyse these newly
created columns.
21. Create a new table deliveries_v04 with the first column as ball_id
containing information of match_id, inning, over and ball separated by&#39;(For
ex. 335982-1-0-1 match_idinning-over-ball) and rest of the columns same
as deliveries_v03)
22. Compare the total count of rows and total count of distinct ball_id in
deliveries_v04;
23. Create table deliveries_v05 with all columns of deliveries_v04 and an
additional column for row number partition over ball_id. (HINT :
row_number() over (partition by ball_id) as r_num)

24. Use the r_num created in deliveries_v05 to identify instances where
ball_id is repeating. (HINT : select * from deliveries_v05 WHERE
r_num=2;)
25. Use subqueries to fetch data of all the ball_id which are repeating.
(HINT: SELECT * FROM deliveries_v05 WHERE ball_id in (select BALL_ID
from deliveries_v05 WHERE r_num=2);
Note: Solve the project in your pgAdmin and keep it open for reference as
you will be finding several questions in the upcoming module test based on
this project.
*/


create database ipl;
use ipl;

-- To Fetch Big Data, We have to use command line
-- firstly create a table ipl_ball same as given in the csv file

create table ipl_ball
(id int,
inning int,
`over` int,
ball int,
batsman varchar(100),
non_striker varchar(100),
bowler varchar(100),
batsman_runs int,
extra_runs int,
total_runs int,
is_wicket int,
dismissal_kind varchar(100),
player_dismissed varchar(100),
fielder varchar(100),
extras_type varchar(100),
batting_team varchar(100),
bowling_team varchar(100),
venue varchar(300),
match_date varchar(50)
);
describe ipl_ball;
/*
Steps to import large data using command line interface (non - gui client): 

Note:- Before importing the data through command line, firstly make your csv file up to date like remove all the commas in fielder
	and venue column from excel.

Text instructions: 
*Load large CSV files into MySQL Database faster using Command line prompt
1. Open MySQL Workbench, Create a new database to store the tables you'll import (eg- FacilitySerivces).
Then, Create the table with matching data types of csv file, usually with INT and CHAR datatypes only (without the data) in the database you just created using Workbench.
2. Open the terminal or command line prompt (Go to windows, search for cmd.exe. Shortcut - Windows button + R, then type cmd)
3. We'll now connect with MySQL database in command line prompt. Follow the steps below:
Copy the path of your MySQL bin directory in your computer. (Normally it is under c drive program files).
The bin directory of MySQL Server is generally in this path - C:\Program Files\MySQL\MySQL Server 8.0\bin
Now, in the Command Line prompt, type 

cd C:\Program Files\MySQL\MySQL Server 8.0\bin 

and press enter.

4. Connect to the MySQL database using the following command in command line prompt

mysql -u root -p

(please replace "root" with your user name that you must have configured while installing MySQL server)
(press enter, it will ask for the password, give your password)

5. If you are successfully logged to mysql,
then set the global variables by using below command so that data can be imported from local computer folder.

mysql> SET GLOBAL local_infile=1;

Query OK, 0 rows affected (0.00 sec)
(you've just instructed MySQL server to allow local file upload from your computer)

6. Quit current server connection:
mysql> quit

7. Load the file from CSV file to the MySQL database. In order to do this, please follow the commands:
(We'll connect with the MySQL server again with the local-infile system variable. 
This basically means you want to upload data into a database table from your local machine)

mysql --local-infile=1 -u root -p
(give password)

- Show Databases;
(It'll show all the databases in MySQL server.)

- mysql> USE ipl;
(makes the database that you had created in step 1 as default schema to use for the next sql scripts)
(Use your Database and load the file into the table.

The next step is to load the data from local case study folder into the ipl_ball in ipl database)

mysql> LOAD DATA LOCAL INFILE 'F:\\SQL\\Large Data Import\\IPL_Ball.csv'
INTO TABLE ipl_ball
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

*VERY IMP - Please replace single backward (\) slash in the path with double back slashes (\\) instead of single slash*
Also note that "ipl_ball" is my table name, use the table name that you've given while creating the database in step 1.

8. Now check if data has been imported or not.

SELECT * FROM ipl_ball LIMIT 20;

9. If data has been imported successfully with 100% accuracy without error,
then alter the table to update the datatypes (if needed) of some columns, etc. You're all set now.

*/

SELECT 
    match_date
FROM
    ipl_ball
LIMIT 20;

SELECT 
    match_date,
    IF(match_date LIKE '%/%',
        STR_TO_DATE(match_date, '%d/%m/%Y'),
        STR_TO_DATE(match_date, '%d-%m-%Y'))
FROM
    ipl_ball;

alter table ipl_ball
add column match_date_new date;

set sql_safe_updates = 0;

UPDATE ipl_ball 
SET 
    match_date_new = IF(match_date LIKE '%/%',
        STR_TO_DATE(match_date, '%d/%m/%Y'),
        STR_TO_DATE(match_date, '%d-%m-%Y'));
-- or
UPDATE ipl_ball 
SET 
    match_date_new = CASE
        WHEN
            match_date IS NOT NULL
                AND match_date LIKE '%-%'
        THEN
            STR_TO_DATE(match_date, '%d-%m-%Y')
        WHEN
            match_date IS NOT NULL
                AND match_date LIKE '%/%'
        THEN
            STR_TO_DATE(match_date, '%d/%m/%Y')
        ELSE NULL
    END;

select * from ipl_ball;




-- Now Import the matches table through command line with the steps given above

CREATE TABLE matches (
    id INT,
    city VARCHAR(100),
    date VARCHAR(100),
    player_of_match VARCHAR(100),
    venue VARCHAR(200),
    neutral_venue BIT,
    team1 VARCHAR(100),
    team2 VARCHAR(100),
    toss_winner VARCHAR(100),
    toss_decision VARCHAR(100),
    winner VARCHAR(100),
    result VARCHAR(100),
    result_margin INT,
    eliminator CHAR(10),
    method VARCHAR(100),
    umpire1 VARCHAR(100),
    umpire2 VARCHAR(100)
);

select * from matches limit 20;


-- Next, we'll convert the date column values from text to date data type
SELECT 
    date,
    IF(date LIKE '%/%',
        STR_TO_DATE(date, '%d/%m/%Y'),
        STR_TO_DATE(date, '%d-%m-%Y'))
FROM
    matches;

-- add a new column match_date_new with date data type
alter table matches
add column date_new date;

set sql_safe_updates = 0;

UPDATE matches 
SET 
    date_new = IF(date LIKE '%/%',
        STR_TO_DATE(date, '%d/%m/%Y'),
        STR_TO_DATE(date, '%d-%m-%Y'));

-- verify the new date column's values.
SELECT 
    date_new
FROM
    matches
LIMIT 30; 

-- add a new column season with varchar data type
alter table matches
add column season varchar(10);

UPDATE matches 
SET 
    season = CASE
        WHEN YEAR(date_new) = 2008 THEN '1'
        WHEN YEAR(date_new) = 2009 THEN '2'
        WHEN YEAR(date_new) = 2010 THEN '3'
        WHEN YEAR(date_new) = 2011 THEN '4'
        WHEN YEAR(date_new) = 2012 THEN '5'
        WHEN YEAR(date_new) = 2013 THEN '6'
        WHEN YEAR(date_new) = 2014 THEN '7'
        WHEN YEAR(date_new) = 2015 THEN '8'
        WHEN YEAR(date_new) = 2016 THEN '9'
        WHEN YEAR(date_new) = 2017 THEN '10'
        WHEN YEAR(date_new) = 2018 THEN '11'
        WHEN YEAR(date_new) = 2019 THEN '12'
        WHEN YEAR(date_new) = 2020 THEN '13'
        ELSE NULL
    END;


-- 7. Fetch data of all the matches played on 2nd May 2013.
SELECT 
    *
FROM
    matches
WHERE
    date_new = '2013-05-02';

-- 8. Fetch data of all the matches where the margin of victory is more than 100 runs.
SELECT 
    *
FROM
    matches
WHERE
    result_margin > 100;

-- 9. Fetch data of all the matches where the final scores of both teams tied
--    and order it in descending order of the date.
SELECT 
    *
FROM
    matches
WHERE
    result_margin = 0
ORDER BY date_new DESC;

-- 10. Get the count of cities that have hosted an IPL match.
SELECT 
    COUNT(DISTINCT city) AS Cities
FROM
    matches;

/*11. Create table deliveries_v02 with all the columns of deliveries and an
additional column ball_result containing value boundary, dot or other
depending on the total_run (boundary for &gt;= 4, dot for 0 and other for any
other number*/

CREATE TABLE deliveries_v02 SELECT *,
    CASE
        WHEN total_runs >= 4 THEN 'boundary'
        WHEN total_runs = 0 THEN 'dot'
        ELSE 'other'
    END AS ball_result FROM
    ipl_ball;

select ball_result from deliveries_v02;


-- 12. Write a query to fetch the total number of boundaries and dot balls
SELECT 
    ball_result, COUNT(ball_result) AS ball_result_cnt
FROM
    deliveries_v02
GROUP BY ball_result;
 
/*13. Write a query to fetch the total number of boundaries scored by each team.*/
SELECT DISTINCT
    batting_team, COUNT(*) AS Total_Boundaries
FROM
    deliveries_v02
WHERE
    ball_result = 'boundary'
GROUP BY batting_team;

/*14. Write a query to fetch the total number of dot balls bowled by each team.*/
SELECT DISTINCT
    bowling_team, COUNT(*) AS Total_Dots
FROM
    deliveries_v02
WHERE
    ball_result = 'dot'
GROUP BY bowling_team;

/*15. Write a query to fetch the total number of dismissals by dismissal kinds.*/
SELECT 
    dismissal_kind, COUNT(*) AS Total_Dismissals
FROM
    deliveries_v02
WHERE
    dismissal_kind <> 'NA'
GROUP BY dismissal_kind;

SELECT DISTINCT
    extras_type
FROM
    deliveries_v02;

/*16. Write a query to get the top 5 bowlers who conceded maximum extra runs.*/
SELECT DISTINCT
    bowler, SUM(extra_runs) AS ExtrasConceded
FROM
    deliveries_v02
WHERE
    extras_type <> 'NA'
GROUP BY bowler
ORDER BY SUM(extra_runs) DESC
LIMIT 5;

/*17. Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table 
and two additional column (named venue and match_date) of venue and date from table matches.*/
CREATE TABLE deliveries_v03 SELECT dv2.id,
    inning,
    `over`,
    ball,
    batsman,
    non_striker,
    bowler,
    batsman_runs,
    extra_runs,
    total_runs,
    is_wicket,
    dismissal_kind,
    player_dismissed,
    fielder,
    extras_type,
    batting_team,
    bowling_team,
    ball_result,
    m.venue,
    date_new FROM
    deliveries_v02 dv2
        INNER JOIN
    matches m USING (id);   
    

/*18. Write a query to fetch the total runs scored for each venue and order it in the 
descending order of total runs scored.*/
SELECT DISTINCT
    venue, SUM(total_runs) AS TotalRuns
FROM
    deliveries_v03
GROUP BY venue
ORDER BY TotalRuns DESC;


/*19. Write a query to fetch the year-wise total runs scored at Eden Gardens and order 
it in the descending order of total runs scored.*/
SELECT 
    YEAR(date_new) AS Years, SUM(total_runs) AS TotalRunsScored
FROM
    deliveries_v03
WHERE
    venue = 'Eden Gardens'
GROUP BY Years
ORDER BY TotalRunsScored DESC;


/*20. Get unique team1 names from the matches table, you will notice that there are two 
entries for Rising Pune Supergiant one with Rising Pune Supergiant and another one with 
Rising Pune Supergiants. Your task is to create a matches_corrected table with two additional 
columns team1_corr and team2_corr containing team names with replacing Rising Pune Supergiants 
with Rising Pune Supergiant. Now analyse these newly created columns. */
SELECT DISTINCT
    team1
FROM
    matches;

CREATE TABLE matches_corrected SELECT * FROM
    matches;

alter table matches_corrected
add column team1_corr varchar(225),
add column team2_corr varchar(225);

set SQL_SAFE_UPDATES=0;

UPDATE matches_corrected 
SET 
    team1_corr = IF(team1 = 'Rising Pune Supergiants',
        'Rising Pune Supergiant',
        team1),
    team2_corr = IF(team2 = 'Rising Pune Supergiants',
        'Rising Pune Supergiant',
        team2);

SELECT DISTINCT
    team1_corr
FROM
    matches_corrected;

SELECT DISTINCT
    team2_corr
FROM
    matches_corrected;


/*21. Create a new table deliveries_v04 with the first column as ball_id containing information 
of match_id, inning, over and ball separated by - (For ex. 335982-1-0-1 match_id-inning-over-ball) 
and rest of the columns same as deliveries_v03) */

CREATE TABLE deliveries_v04 SELECT *,
    CONCAT(id, '-', inning, '-', `over`, '-', ball) AS ball_id FROM
    deliveries_v03;

SELECT 
    *
FROM
    deliveries_v04; 


/*22. Compare the total count of rows and total count of distinct ball_id in deliveries_v04; 
*/
SELECT 
    COUNT(DISTINCT id) AS DitinctMatches,
    COUNT(ball_id) AS TotalRows
FROM
    deliveries_v04;


/*23. Create table deliveries_v05 with all columns of deliveries_v04 and an additional column for 
row number partition over ball_id. (HINT : row_number() over (partition by ball_id) as r_num) */
create table deliveries_v05
select *, row_number() over (partition by ball_id) as r_num
from deliveries_v04;


/*24. Use the r_num created in deliveries_v05 to identify instances where ball_id is repeating. 
(HINT : select * from deliveries_v05 WHERE r_num=2;) */
SELECT 
    *
FROM
    deliveries_v05
WHERE
    r_num = 2;


/*25. Use subqueries to fetch data of all the ball_id which are repeating. 
(HINT: SELECT * FROM deliveries_v05 WHERE ball_id in (select BALL_ID from deliveries_v05 WHERE r_num=2); */
SELECT 
    *
FROM
    deliveries_v05
WHERE
    ball_id IN (SELECT 
            BALL_ID
        FROM
            deliveries_v05
        WHERE
            r_num = 2);

-- 26. WHAT ARE THE TOP 5 PLAYERS WITH THE MOST PLAYER OF THE MATCH AWARDS?
SELECT 
    player_of_match, COUNT(*) AS awards_count
FROM
    matches
GROUP BY player_of_match
ORDER BY awards_count DESC
LIMIT 5;

-- 26. HOW MANY MATCHES WERE WON BY EACH TEAM IN EACH SEASON?
SELECT 
    season, winner AS team, COUNT(*) AS matches_won
FROM
    matches
GROUP BY season , winner
ORDER BY season , matches_won DESC;


-- 27. WHAT IS THE AVERAGE STRIKE RATE OF BATSMEN IN THE IPL DATASET?
SELECT 
    AVG(strike_rate) AS average_strike_rate
FROM
    (SELECT 
        batsman,
            (SUM(total_runs) / COUNT(ball)) * 100 AS strike_rate
    FROM
        deliveries_v02
    GROUP BY batsman) AS batsman_stats;

-- 28. WHAT IS THE NUMBER OF MATCHES WON BY EACH TEAM BATTING FIRST VERSUS BATTINGSECOND?
SELECT 
    batting_first, COUNT(*) AS matches_won
FROM
    (SELECT 
        CASE
                WHEN result = 'runs' and result_margin > 0 THEN team1
                ELSE team2
            END AS batting_first
    FROM
        matches
    WHERE
        result != 'Tie') AS batting_first_teams
GROUP BY batting_first;


-- 29. WHICH BATSMAN HAS THE HIGHEST STRIKE RATE (MINIMUM 200 RUNS SCORED)?
SELECT 
    batsman, (SUM(batsman_runs) * 100 / COUNT(*)) AS strike_rate
FROM
    deliveries_v02
GROUP BY batsman
HAVING SUM(batsman_runs) >= 200
ORDER BY strike_rate DESC
LIMIT 1;


-- 30. HOW MANY TIMES HAS EACH BATSMAN BEEN DISMISSED BY THE BOWLER 'MALINGA'?
SELECT 
    batsman, COUNT(*) AS 'Dismissals'
FROM
    deliveries_v02
WHERE
    bowler = 'SL Malinga'
        AND is_wicket = '1'
GROUP BY batsman;


-- 31. WHAT IS THE AVERAGE PERCENTAGE OF BOUNDARIES (FOURS AND SIXESCOMBINED) HIT BY EACH BATSMAN?
SELECT 
    batsman,
    AVG(CASE
        WHEN batsman_runs = 4 OR batsman_runs = 6 THEN 1
        ELSE 0
    END) * 100 AS average_boundaries
FROM
    deliveries_v02
GROUP BY batsman;


-- 32. WHAT IS THE AVERAGE NUMBER OF BOUNDARIES HIT BY EACH TEAM IN EACH SEASON?
SELECT 
    season,
    batting_team,
    AVG(fours + sixes) AS average_boundaries
FROM
    (SELECT 
        season,
            batting_team,
            SUM(CASE
                WHEN batsman_runs = 4 THEN 1
                ELSE 0
            END) AS fours,
            SUM(CASE
                WHEN batsman_runs = 6 THEN 1
                ELSE 0
            END) AS sixes
    FROM
        deliveries_v02 join matches
    ON 
        deliveries_v02.id = matches.id
    GROUP BY season , batting_team) AS team_boundaries
GROUP BY season , batting_team;


-- 33. WHAT IS THE HIGHEST PARTNERSHIP (RUNS) FOR EACH TEAM IN EACH SEASON?
SELECT 
    season, batting_team, MAX(total_runs) AS highest_partnership
FROM
    (SELECT 
        season,
            batting_team,
            partnership,
            SUM(total_runs) AS total_runs
    FROM
        (SELECT 
        season,
            batting_team,
            `over`,
            SUM(batsman_runs) AS partnership,
            SUM(batsman_runs) + SUM(extra_runs) AS total_runs
    FROM
        deliveries_v02
    JOIN matches ON deliveries_v02.id = matches.id
    GROUP BY season , batting_team , `over`) AS team_scores
    GROUP BY season , batting_team , partnership) AS highest_partnership
GROUP BY season , batting_team; 


-- 34. HOW MANY EXTRAS (WIDES & NO-BALLS) WERE BOWLED BY EACH TEAM IN EACH MATCH?
SELECT 
    m.id AS match_no,
    d.bowling_team,
    SUM(d.extra_runs) AS extras
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
WHERE
    extra_runs > 0
GROUP BY m.id , d.bowling_team;


-- 35. WHICH BOWLER HAS THE BEST BOWLING FIGURES (MOST WICKETS TAKEN) IN A SINGLEMATCH?
SELECT 
    m.id AS match_no, d.bowler, COUNT(*) AS wickets_taken
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
WHERE
    d.player_dismissed IS NOT NULL and is_wicket = '1'
GROUP BY m.id , d.bowler
ORDER BY wickets_taken DESC
LIMIT 1;


-- 36. HOW MANY MATCHES RESULTED IN A WIN FOR EACH TEAM IN EACH CITY?
SELECT 
    m.city,
    CASE
        WHEN m.team1 = m.winner THEN m.team1
        WHEN m.team2 = m.winner THEN m.team2
        ELSE 'draw'
    END AS winning_team,
    COUNT(*) AS wins
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
WHERE
    m.result != 'Tie'
GROUP BY m.city , winning_team;


-- 37. HOW MANY TIMES DID EACH TEAM WIN THE TOSS IN EACH SEASON?
SELECT 
    season, toss_winner, COUNT(*) AS toss_wins
FROM
    matches
GROUP BY season , toss_winner;


-- 38. HOW MANY MATCHES DID EACH PLAYER WIN THE "PLAYER OF THE MATCH" AWARD?
SELECT 
    player_of_match, COUNT(*) AS total_wins
FROM
    matches
WHERE
    player_of_match IS NOT NULL
GROUP BY player_of_match
ORDER BY total_wins DESC;


-- 39. WHAT IS THE AVERAGE NUMBER OF RUNS SCORED IN EACH OVER OF THE INNINGS INEACH MATCH?
SELECT 
    m.id,
    d.inning,
    d.`over`,
    AVG(d.total_runs) AS average_runs_per_over
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
GROUP BY m.id , d.inning , d.`over`;


-- 40. WHICH TEAM HAS THE HIGHEST TOTAL SCORE IN A SINGLE MATCH?
SELECT 
    m.season,
    m.id AS match_no,
    d.batting_team,
    SUM(d.total_runs) AS total_score
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
GROUP BY m.season , m.id , d.batting_team
ORDER BY total_score DESC
LIMIT 1;


-- 41. WHICH BATSMAN HAS SCORED THE MOST RUNS IN A SINGLE MATCH?
SELECT 
    m.season,
    m.id AS match_no,
    d.batsman,
    SUM(d.batsman_runs) AS total_runs
FROM
    matches AS m
        JOIN
    deliveries_v02 AS d ON d.id = m.id
GROUP BY m.season , m.id , d.batsman
ORDER BY total_runs DESC
LIMIT 1;