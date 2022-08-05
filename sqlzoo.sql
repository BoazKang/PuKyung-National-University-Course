SELECT basics

1.
SELECT population
 FROM world
WHERE name = 'Germany';

2. 
SELECT name, population
 FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

3. 
SELECT name, area
 FROM world
WHERE area BETWEEN 200000 AND 250000;


SELECT from world

1. 
SELECT name, continent, population FROM world;

2. 
SELECT name FROM world
WHERE population >= 200000000;

3. 
select name, gdp/population
 from world
where population >= 200000000;

4. 
select name, population/1000000
 from world
where continent = 'South America';

5. 
select name, population
 from world
where name in ('France', 'Germany', 'Italy');

6. 
select name
 from world
where name like '%United%';

7. 
select name, population, area
 from world
where area >= 3000000 or population >= 250000000;

8.
select name, population, area
 from world
where (area >= 3000000 and not population >= 250000000)
or (not area >= 3000000 and population >= 250000000);

select name, population, area
 from world
where (area >= 3000000 or population >= 250000000)
and not (area >= 3000000 and population >= 250000000);


9.
select name, round(population/1000000,2), round(gdp/1000000000,2)
 from world
where continent = 'south america';

10.
select name, round(gdp/population, -3)
 from world
where gdp >= 1000000000000;

11.
SELECT name, capital
 FROM world
WHERE LENGTH(name) = LENGTH(capital);

12.
SELECT name, capital
 FROM world
where LEFT(name,1) = LEFT(capital,1)
and name <> capital;

13.
SELECT name
   FROM world
WHERE name LIKE '%a%' 
  and name LIKE '%e%'
  and name LIKE '%i%'
  and name LIKE '%o%'
  and name LIKE '%u%'
  AND name NOT LIKE '% %';



SELECT from nobel

1.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

2.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

3.
select yr, subject
 from nobel
where winner = 'Albert Einstein';

4.
select winner
 from nobel
where yr >= 2000 and subject = 'Peace';

5.
select *
 from nobel
where subject = 'Literature'
and yr between 1980 and 1989;

6.
SELECT *
 FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                 'Woodrow Wilson',
                 'Jimmy Carter',
                 'Barack Obama');

7.
select winner
 from nobel
where winner like 'John %';

select winner
 from nobel
where substr(winner,1,instr(winner, ' ')-1) = 'John';

8.
select yr, subject, winner
 from nobel
where (yr = 1980 and subject = 'Physics')
or (yr = 1984 and subject = 'Chemistry');

SELECT yr, subject, winner
 FROM nobel
where yr = 1984 and subject = 'Chemistry'
union
SELECT yr, subject, winner
 FROM nobel
where yr = 1980 and subject = 'Physics'

9.
select yr, subject, winner
 from nobel
where subject not in ('Chemistry', 'Medicine')
  and yr = 1980;

10.
select yr, subject, winner
 from nobel
where (subject = 'Medicine' and yr < 1910)
   or (subject = 'Literature' and yr >= 2004);

11.
select *
 from nobel
where winner = 'PETER GRÜNBERG';

12.
select *
 from nobel
where winner = 'EUGENE O''NEILL';

13.
select winner, yr, subject
 from nobel
where winner like '%Sir %'
order by yr desc, winner asc;

14.
SELECT winner, subject
 FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject,winner


SELECT in SELECT

01.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

02.
SELECT name
 FROM world
WHERE gdp/population >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom')
and continent = 'Europe';

03.
select name, continent
 from world
where continent = (select continent
                    from world
                   where name = 'Argentina')
or continent =  (select continent
                    from world
                   where name = 'Australia')
order by name;

select name, continent
from world
where continent in (select continent
                    from world
                   where name in ('Argentina', 'Australia'))
order by name;

04.
select name, population
 from world
where population > (select population
                     from world
                    where name = 'Canada')
and population < (select population
                     from world
                    where name = 'Poland');

05.
select name,
       concat(round(population/(select population
                                 from world
                                where name = 'Germany')*100), '%')
 from world
where continent = 'Europe';

06.
select name
 from world
where gdp > (select max(gdp)
              from world
             where continent = 'Europe');

07.
SELECT continent, name, area
 FROM world x
WHERE area >= ALL
  (SELECT area FROM world y
      WHERE y.continent=x.continent
        AND area>0);

select a.continent,
       b.name as name,
       a.area
 from (select continent,
              max(area) as area
        from world
       group by continent) a, world b
where b.area = a.area;

08.
select continent, min(name)
 from world
group by continent;

09.
-- 서브쿼리
select name, continent, population
 from world
where continent in (select continent
                     from world
                    group by continent
                    having max(population) <= 25000000);

-- 인라인
select a.name, a.continent, a.population
 from world a, (select continent
                 from world
                group by continent
                having max(population) <= 25000000) b
where a.continent = b.continent;

10.
-- 같은 대륙안에 있는 각 나라들보다 3배 큰 나라의 이름과 속한 대륙 출력

-- 대륙별로 제일 큰 나라 선택

select continent, max(population)
 from world
group by continent
first_nation

-- 대륙별로 두번째 큰 나라를 선택

select continent, max(population)
 from world
where
group by continent
second_nation

-- 대륙별로 제일 큰 나라와 두번째 큰 나라를 비교 (f >= s*3)

select a.continent,
       a.population
 friom first_nation a, second_nation b
where a.population >= b.population * 3
ref

select name,
       continent
 from world a, ref b
where a.continent = b.continent and a.population = b.population


select a.name, 
       a.continent
from world a, (select b.continent, b.population
                from (select 
                           continent, 
                           max(population) as population
                       from (select a.continent,
                                    a.population
                              from world a, (select continent, max(population) as population
                                              from world
                                             group by continent) b 
                             where a.continent = b.continent 
                               and a.population <> b.population) a
                       group by continent) a, (select continent, max(population) as population
                                                from world
                                               group by continent) b
               where b.population >= a.population*3 
                 and b.continent = a.continent) b
where a.continent = b.continent
  and a.population = b.population;






SUM and COUNT

01.
SELECT SUM(population)
FROM world

02.
select distinct continent
 from world;

03.
select sum(gdp)
 from world
where continent = 'Africa';

04.
select count(name)
 from world
where area >= 1000000;

05.
select sum(population)
 from world
where name in ('Estonia', 'Latvia', 'Lithuania');

06.
select continent, count(name)
 from world
group by continent;

07.
select continent, count(name)
 from world
where population >=  10000000
group by continent;

08.
select continent
 from world
group by continent
having sum(population) >= 100000000;


JOIN

01.
SELECT matchid, player
 FROM goal 
WHERE teamid = 'GER';

02.
SELECT id,stadium,team1,team2
  FROM game
where id = 1012;

03.
select a.player,
       a.teamid,
       b.stadium,
       b.mdate
 from goal a, game b
where a.matchid = b.id
and teamid = 'GER';

04.
select team1, team2 , player
 from goal a, game b
where a.matchid = b.id
and player LIKE 'Mario%';

05.
SELECT a.player, a.teamid, b.coach, a.gtime
  FROM goal a, eteam b
 WHERE a.teamid = b.id
and a.gtime <= 10;

06.
select mdate, teamname
 from game a, eteam b
where a.team1 = b.id
and coach = 'Fernando Santos';

07.
select b.player
 from game a, goal b
where a.id = b.matchid
and a.stadium = 'National Stadium, Warsaw';

08.
SELECT distinct player
 FROM game JOIN goal ON goal.matchid = game.id 
WHERE (team1 = 'GER' and team2 = teamid)
   or (team1 = teamid and team2 = 'GER');

select distinct player
from goal
where matchid in (select id
                   from game
                  where team1 = 'GER' or team2 = 'GER')
  and teamid <> 'GER'

select distinct b.player
 from game a, goal b
where a.id = b.matchid
  and (a.team1 = 'GER' or a.team2 = 'GER')
  and (b.teamid <> 'GER')

09.
SELECT teamname, count(player)
  FROM eteam JOIN goal ON id=teamid
 group BY teamname;

select b.teamname, a.cnt
 from (select teamid, count(teamid) as cnt
        from goal
       group by teamid) a, eteam b
where a.teamid = b.id
order by teamname

10.
select stadium, count(player)
 from game a, goal b
where a.id = b.matchid
GROUP BY stadium;

select a.stadium, sum(a.cnt)
from (select b.stadium, a.cnt
       from (select matchid, count(*) as cnt
              from goal
             group by matchid) a, game b
      where a.matchid = b.id) a
group by a.stadium

11.
SELECT matchid,
       mdate,
       count(player)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

12.
select matchid,
       mdate,
       count(player)
 from game a, goal b
where a.id = b.matchid
and (team1 = 'GER' OR team2 = 'GER')
and teamid = 'GER'
GROUP BY matchid, mdate;

select a.matchid, b.mdate, a.cnt
from (select matchid, count(*) as cnt
       from goal
      where matchid in (select id
                         from game
                        where team1 = 'GER' OR team2 = 'GER')
                          and teamid = 'GER'
                        group by matchid) a, game b
where a.matchid = b.id

13.
select mdate, team1
 from game a, goal b
where a.id = b.matchid
  and a.team1 = b.teamid

select mdate, team1, count(*) as score1
 from (select mdate, team1
        from game a, goal b
       where a.id = b.matchid
         and a.team1 = b.teamid) a
group by mdate, team1;

select mdate, team2, count(*) as score2
from (select mdate, team2
       from game a, goal b
      where a.id = b.matchid
        and a.team2 = b.teamid) a
group by mdate, team2;



select a.mdate, a.team1, a.score1, b.team2, b.score2
from (select mdate, team1, count(*) as score1, teamid as t1
       from (select mdate, team1, teamid
              from game a, goal b
             where a.id = b.matchid
               and a.team1 = b.teamid) a
      group by mdate, team1) a left outer join

     (select mdate, team2, count(*) as score2, teamid as t2
       from (select mdate, team2, teamid
              from game a, goal b
             where a.id = b.matchid
               and a.team2 = b.teamid) a
      group by mdate, team2) b
     on a.mdate = b.mdate
where a.mdate = b.mdate
order by a.mdate, a.t1, b.t2


select a.mdate,
       a.team1,
       a.score,
       b.team2,
       b.score
 from (select mdate, team1, sum(score) as score, a.matchid
        from (select a.mdate, b.matchid,
                     ifnull(b.teamid, a.team1) as team1,
                     case when
                     b.teamid is not null
                     then 1 else 0
                     end score
               from game a left outer join goal b
                 on a.id = b.matchid and b.teamid = a.team1) a
       group by a.mdate, a.team1) a,
      (select mdate, team2, sum(score) as score, a.matchid
        from (select a.mdate, b.matchid,
                     ifnull(b.teamid, a.team2) as team2,
                     case when
                     b.teamid is not null
                     then 1 else 0
                     end score
               from game a left outer join goal b
                 on a.id = b.matchid and b.teamid = a.team2) a
       group by a.mdate, a.team2) b
where a.mdate = b.mdate
order by a.mdate, a.matchid, a.team1;