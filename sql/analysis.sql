use formula1;

/*==========          PHASE - 1    Basic SQL analysis          ==========*/


/*=================================================================================================

question -1 -> Top 10 drivers with most race wins.

===================================================================================================*/
with wins_cte as 
(select driverId, wins, rank() over (order by wins desc) as rank_win from 
(select driverId, count(driverId) as wins from results where positionOrder=1 GROUP by driverId) as totalWins) 
select driverRef, forename, surname, code, number, nationality, wins from drivers as d join
(select driverId, wins from wins_cte where rank_win<=10) w on d.driverId=w.driverId order by wins desc;

/*=================================================================================================

question -2 -> Top 10 constructors with the most race wins.

===================================================================================================*/
with wins_cte as
(select constructorId, wins, rank() over (order BY wins desc) as rank_win from
(select constructorId, count(*) wins from results where positionOrder=1 group by constructorId) as totalWins)
select constructorRef, name, nationality, wins from constructors as c join
(select constructorId, wins from wins_cte where rank_win<=10)w on c.constructorId=w.constructorId order by wins desc;

/*=================================================================================================

question -3 -> Top 10 drivers with the most podium finishes.

===================================================================================================*/
with podiums_cte as
(select driverId, podiums, rank() over (order by podiums desc) as rank_win from 
(select driverId, count(driverId) as podiums from results where positionOrder in (1,2,3) GROUP by driverId) as totalpodiums) 
select driverRef, forename, surname, code, number, nationality, podiums from drivers as d join
(select driverId, podiums from podiums_cte where rank_win<=10) w on d.driverId=w.driverId order by podiums desc;


/*=================================================================================================

question -4 -> Top 10 drivers with the most race starts.

===================================================================================================*/
with race_starts as
(select driverId, starts, rank() over (order by starts desc) s_rank FROM (select driverId, count(*) as starts from results 
where statusId not in (SELECT statusId FROM status WHERE status IN (
    'Did not qualify',
    'Did not prequalify',
    'Driver unwell',
    'Illness')
) group by driverId)t)
select driverRef, forename, surname, code, number, nationality, starts as race_starts from drivers as d join 
(select driverId, starts from race_starts where s_rank<=10) as s on d.driverId=s.driverId order by race_starts desc;


/*=================================================================================================

question -5 -> Top 10 constructors with the most podium finishes.

===================================================================================================*/
with podiums_cte as
(select constructorId, podiums, rank() over (order by podiums desc) as rank_win from 
(select constructorId, count(constructorId) as podiums from results where positionOrder in (1,2,3) GROUP by constructorId) as totalpodiums) 
select constructorRef, name, nationality, podiums from constructors as c join
(select constructorId, podiums from podiums_cte where rank_win<=10) w on c.constructorId=w.constructorId order by podiums desc;

/*=================================================================================================

question -6 -> Which circuits have hosted the most Formula 1 races.

===================================================================================================*/
with circuits_cte as 
(select circuitID, races, rank() over (order by races desc) as r_rank from
(select circuitID, count(*) races from races group by circuitId)t)
select circuitRef, name, location, country, races as races_hosted from circuits as c join 
(select circuitId, races, r_rank from circuits_cte where r_rank<=10) cc on c.circuitId=cc.circuitId order by races_hosted desc;

/*=================================================================================================

question -7 -> Which driver nationalities have won the most races.

===================================================================================================*/
with nationality_win AS 
(select nationality, count(*) as wins from drivers as d join 
(select driverId from results where positionOrder=1)r on d.driverId=r.driverID group by nationality)
select nationality, wins from (select nationality, wins, rank() over (order by wins desc) as r_win from nationality_win)rank_t
where r_win<=10 order by wins d

/*=================================================================================================

question -8 -> Which constructors have scored the most championship points.

===================================================================================================*/
with points_cte as 
(select constructorID, total_points, rank() over (order by total_points desc) as p_rank FROM 
(select constructorId, sum(points) as total_points from constructor_results group by constructorId)t)
select constructorRef, name, nationality, total_points from constructors as c join 
points_cte as pc on c.constructorId=pc.constructorId where p_rank<=10 order by p_rank;

/*=================================================================================================

question -9 -> Which drivers have improved the most from their grid position.

===================================================================================================*/
select driverRef, code, forename, surname, avg_gain from drivers as d join
(select driverId, AVG(grid-positionOrder) as avg_gain from results where grid>0 group by driverID order by avg_gain desc limit 50)g 
on d.driverId=g.driverID order by avg_gain desc;

/*=================================================================================================

question -10 -> Which drivers have the highest win percentage. (minimum 50 race starts)

===================================================================================================*/
with race_starts as 
(select driverID, count(*) as starts from results where statusId not in (SELECT statusId FROM status WHERE status IN (
    'Did not qualify',
    'Did not prequalify',
    'Driver unwell',
    'Illness')
) group by driverID having starts >=50),
win_per as
(select w.driverId, starts, wins, round((wins*100.00)/starts, 2) as win_percent from race_starts as r JOIN 
(select driverId, count(*) as wins from results where positionOrder=1 group by driverId) as w on r.driverId=w.driverID
order by win_percent desc)
select driverRef, forename, surname, starts, wins, win_percent from drivers as d join win_per as w on d.driverId=w.driverId
order by win_percent desc limit 10;



/*==========          PHASE - 2    Advanced SQL analysis          ==========*/

/*=================================================================================================

question -11 -> Running championship points.

===================================================================================================*/
select driverId, points, round, year, sum(points) over (partition by driverID, year order by round) as running_points from 
(select driverId, points, round, year from results as re join races as ra on re.raceId=ra.raceId) as t;

/*=================================================================================================

question -12 -> Previous race finishing position.

===================================================================================================*/
select driverId, year, round, positionOrder, lag(positionOrder) OVER  (partition by driverId, year order by round) as pre_finish_pos
from (select driverId, positionOrder, round, year from results as re join races as ra on re.raceId=ra.raceId)t;

/*=================================================================================================

question -13 -> Race to race position improvement.

===================================================================================================*/
with pos as
(select driverId, year, round, positionOrder, lag(positionOrder) OVER  (partition by driverId, year order by round) as pre_finish_pos
from (select driverId, positionOrder, round, year from results as re join races as ra on re.raceId=ra.raceId)t)
select driverId, year, round, positionOrder, pre_finish_pos, pre_finish_pos-positionOrder as pos_improvement from pos;

/*=================================================================================================

question -14 -> Driver's best/worst season.

===================================================================================================*/
with ranks as
(select driverId, year, points, rank() over (partition by driverId order by points desc) as best_seasons_rank, 
rank() over (partition by driverId order by points) as worst_seasons_rank from
(select driverId, year, sum(points) as points from races as ra join results as re on ra.raceId=re.raceID group by driverId, year)t)
select driverId, year, points, best_seasons_rank, worst_seasons_rank from ranks where best_seasons_rank=1 or worst_seasons_rank=1;

/*=================================================================================================

question -15 -> Constructor season dominance.

===================================================================================================*/
select year, constructorId, points, rank() over (partition by year order by points desc) cons_rank from 
(SELECT year, constructorId, round, points, rank() over (partition by year, constructorId order by round desc) as ran
from constructor_standings as c join races as r on c.raceId=r.raceId)t where ran=1;

/*=================================================================================================

question -16 -> Season-over-season improvement of drivers.

===================================================================================================*/
with pre_cte as
(SELECT driverId, year, points, lag(points) over (partition by driverID order by year) pre_season_points from 
(select driverId, year, sum(points) as points from races as ra join results as re on ra.raceId=re.raceID group by driverId, year)t)
select driverId, year, points, pre_season_points, points-pre_season_points as improvement from pre_cte;

/*=================================================================================================

question -17 -> Fastest lap times on circuits each season.

===================================================================================================*/
with laps as
(select raceId, driverId, time from 
(select raceId, driverId, time, milliseconds, min(milliseconds) over (partition by raceId) as fastest from lap_times)t
where t.milliseconds=t.fastest)
select year, c.name, time, driverRef from circuits as c join 
(select year, circuitId, driverId, laps.time from laps join races on laps.raceId=races.raceId)t on c.circuitId=t.circuitId join
drivers as d on t.driverId=d.driverId;

