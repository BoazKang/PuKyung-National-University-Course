select *
 from stops
where name in ('Craiglockhart','Lochend');

select num, stop
 from route
where num in (select distinct num
               from route
              where stop in (select stop
                              from route
                             where num in (SELECT num
									                FROM route
														WHERE STOP = 53
														)))
  and stop = 147;


SELECT a.num, a.company, stops.name, c.num, c.company

from route a join route b on a.company=b.company AND a.num=b.num

join stops on stops.id=a.stop

join route c on stops.id=c.stop

join route d on c.company=d.company AND c.num=d.num

where b.stop =(select id from stops where name= 'Craiglockhart')

and d.stop =(select id from stops where name= 'Lochend')



SELECT a.num, a.company, d.name, b.num, b.company
 FROM route a,
      route b,
      (SELECT a.num AS start_num,
		        b.num AS end_num,
		        a.company AS start_co,
		        b.company AS end_co
        FROM route a, route b
       WHERE a.stop = 53
         AND b.stop = 147
      ) c,
      stops d
WHERE a.num IN (c.start_num)
  AND b.num IN (c.end_num)
  AND a.stop = b.stop
  AND d.id = a.stop
  AND a.company = c.start_co
  AND b.company = c.end_co
order by a.num, d.name, b.num;

SELECT *
 FROM informataion_schema.tables
 WHERE table_schema = 'SampleDB';
 
SELECT *
 FROM columns
WHERE TABLE_NAME = '사원';