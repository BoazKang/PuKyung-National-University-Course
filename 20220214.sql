SHOW TABLES;

SELECT * 
 FROM 성적;

DESC 성적;

SELECT 학번, 이름, 점수
 FROM 성적;

SELECT 점수, 이름, 학번
 FROM 성적
ORDER BY 점수 ASC;

SELECT 점수, 이름, 학번
 FROM 성적
WHERE SUBSTR(이름,1,1) = '이'
ORDER BY 점수 desc;


SELECT SUBSTR(이름,1,1), 이름
 FROM 성적;
 
SELECT 이름, 점수
 FROM 성적
WHERE 점수 >= 90
ORDER BY 점수 DESC, 이름 desc; 

SELECT *
 FROM 성적
ORDER BY 점수 desc, 이름 DESC;

SELECT 이름, 점수 
 FROM 성적
WHERE SUBSTR(이름,1,1) != '김'; 

SELECT 이름, 점수 
 FROM 성적
WHERE SUBSTR(이름,1,1) <> '김'; 

SELECT 이름, 점수
 FROM 성적
WHERE 이름 not LIKE '김%';

SELECT 이름, 점수
 FROM 성적
WHERE 이름 LIKE '%석%' AND 점수 < 90;
 
SELECT 이름, 점수
 FROM 성적
WHERE 점수 <= 90 or 점수 > 80;

SELECT 이름, 점수, 성별
 FROM 성적
WHERE 이름 LIKE '이%' 
      AND (이름 LIKE '%석' OR 이름 LIKE '%기'); 

SELECT 이름, 점수, 성별
 FROM 성적
WHERE SUBSTR(이름,1,1) = '이' 
      AND (SUBSTR(이름,3,3) = '기' OR SUBSTR(이름,3,3) = '석'); 

SELECT 이름, 성별
 FROM 성적;

SELECT CONCAT(이름,'잘했어요') AS tt
 FROM 성적;

SELECT CONCAT('(',성별,')') 
 FROM 성적;
 
SELECT CONCAT(이름,'(',성별,')') AS 이름_성별
 FROM 성적;

SELECT *
 FROM 제품;

SELECT * 
 FROM 제품 
WHERE 가격 IS not NULL;

SELECT 제품번호,
       제품명,
		 종류,
		 색상,
		 IFNULL(가격,35000) 
 FROM 제품;

SELECT *
 FROM 책;

SELECT 책명
 FROM 책
WHERE 분야 = '컴퓨터';


SELECT DISTINCT 종류
 FROM 제품;
 
SELECT * 
 FROM 제품;

-- mssql 
SELECT top 5 * 
FROM 성적; 

-- oracle
SELECT *
 FROM 성적 
WHERE rownum <= 5;

-- mysql
SELECT *
 FROM 성적 LIMIT 5;
 
SELECT 이름, 점수, 성별
 FROM 성적
ORDER BY 점수 DESC
LIMIT 10; 

-- 여자의 상위 성적 3명만 
SELECT *
FROM 
(SELECT 이름, 점수, 성별
 FROM 성적
WHERE 성별 = '여'
ORDER BY 점수 DESC
LIMIT 3) a
ORDER BY 이름 desc;


SELECT *
 FROM 책;
 
SELECT 책명, 가격
 FROM 책
ORDER BY 가격 DESC
LIMIT 2;


SELECT *
 FROM 책
WHERE 책명 LIKE '자%' OR 책명 LIKE '세%';

SELECT *
 FROM 책;

-- 11,000 ~ 12,000
SELECT *
 FROM 책
WHERE 가격 >= 11000 AND 가격 <= 12000;

SELECT *
 FROM 책
WHERE 가격 not BETWEEN 11000 AND 12000;


-- '이종석' '송중기' '이연희'
SELECT *
 FROM 성적
WHERE 이름 = '이종석' OR 이름 = '송중기' OR 이름 = '이연희'; 

SELECT *
 FROM 성적
WHERE 이름 IN ('이종석', '송중기', '이연희');

SELECT 이름, 점수
 FROM 성적;

SELECT 이름, 점수+3
 FROM 성적;

UPDATE 성적 SET 점수 = 점수+3;

UPDATE 성적 SET 점수 = 점수- 3;

SELECT *
 FROM 성적
WHERE 이름 = '이종석';

SELECT *
 FROM 성적
WHERE 이름 LIKE '%이종석';


SELECT * 
 FROM 성적
WHERE 이름 LIKE '이%';

SELECT * 
 FROM 성적
WHERE SUBSTR(이름,1,1) = '이';


SELECT *
 FROM 성적
WHERE 이름 LIKE '이%' OR 이름 LIKE '김%' OR 이름 LIKE '박%';

SELECT *
 FROM 성적
WHERE SUBSTR(이름,1,1) IN ('이','김','박'); 

SELECT *
 FROM 제품;

SELECT SUM(가격), COUNT(가격), COUNT(제품명), COUNT(*)
 FROM 제품;

SELECT SUM(가격)/COUNT(가격), SUM(가격)/COUNT(*) 
 FROM 제품;

SELECT SUM(가격)/COUNT(*)
 FROM 제품
WHERE 가격 IS NOT NULL; 


SELECT COUNT(제품번호)
 FROM 제품;

SELECT *
 FROM 제품;

SELECT SUM(가격)/COUNT(가격), AVG(가격)
 FROM 제품;
 
 
SELECT MAX(가격) AS 가장비싼책, 
       MIN(가격) AS 가장저렴한책, 
		 AVG(가격) AS 평균책가격
 FROM 책;

SELECT count(DISTINCT 종류)
 FROM 제품; 

SELECT DISTINCT 종류
 FROM 제품; 

SELECT AVG(가격)
 FROM 제품
WHERE 종류 = '코트';

SELECT count(DISTINCT 종류)
 FROM 제품;

SELECT 종류, AVG(가격)
 FROM 제품
GROUP BY 종류;

SELECT * 
 FROM 제품;

SELECT COUNT(DISTINCT 색상)
 FROM 제품;
 
SELECT 색상, AVG(가격)
 FROM 제품
GROUP BY 색상;

SELECT 제품번호, AVG(가격), 색상
 FROM 제품
GROUP BY 제품번호;

SELECT 종류, AVG(가격), 색상
 FROM 제품
GROUP BY 종류;

SELECT 종류, 색상, AVG(가격)
 FROM 제품
GROUP BY 종류, 색상;

SELECT count(distinct CONCAT(종류,색상))
 FROM 제품;

SELECT 종류, 색상
 FROM 제품;

UPDATE 제품 SET 색상 = 'PINK' WHERE 종류 = '셔츠';

SELECT 종류, std(가격)
 FROM 제품
GROUP BY 종류;

SELECT SUM(개수)
FROM  
(SELECT 색상, COUNT(*) AS 개수  
 FROM 제품
GROUP BY 색상) a;

SELECT 색상, COUNT(*) AS 개수  
 FROM 제품
GROUP BY 색상;

SELECT *
 FROM 책;

SELECT 분야, AVG(가격)
 FROM 책
GROUP BY 분야
HAVING AVG(가격) > 11000;

SELECT *
FROM 
(SELECT 분야, AVG(가격) AS 평균가격
 FROM 책
GROUP BY 분야) a
WHERE 평균가격 > 11000;

SELECT *
 FROM 책;
 
SELECT 분야, AVG(가격)
 FROM 책
WHERE 가격 >= 10000
GROUP BY 분야;

-- 8750.0000
-- 10000.0000


SHOW TABLES;

SELECT *
 FROM 줄넘기결과;

SELECT SUM(스코어)
 FROM 줄넘기결과;


SELECT MIN(스코어), MAX(스코어)
 FROM 줄넘기결과;

SELECT *
 FROM 줄넘기결과;

SELECT AVG(스코어)
 FROM 줄넘기결과;

SELECT 학년
 FROM 줄넘기결과
GROUP BY 학년
HAVING SUM(스코어) >= 95;

SELECT 반,성별, avg(점수)
 FROM 성적
GROUP BY 반, 성별
         WITH rollup;

SELECT 성별, 반, AVG(점수)
 FROM 성적
GROUP BY 성별, 반
         WITH ROLLUP;
         
SELECT IFNULL(학년,'총계') AS 학년, 
       IFNULL(반,'소계') AS 반, 
		 개수
FROM (SELECT 학년, 
             반, 
				SUM(스코어) AS 개수
       FROM 줄넘기결과
      GROUP BY 학년, 반
            WITH ROLLUP) tmp;
            
SELECT *
 FROM 지도교수;

SELECT *
 FROM 전공;
 
SELECT COUNT(*)
FROM  
(SELECT a.지도교수, 
       a.교수명, 
		 b.전공명
 FROM 지도교수 a, 전공 b) a;
-- WHERE a.전공코드 = b.전공코드;
 
 
 
SELECT  a.지도교수,
        a.교수명,
		  a.전공코드, 
		  b.전공코드, 
		  b.전공명
 FROM 지도교수 a, 전공 b
WHERE a.전공코드 = b.전공코드;

-- 전공명이 DB인 교수만 출력 지도교수, 교수명, 전공명

SELECT  a.지도교수,
        a.교수명,
        b.전공명
 FROM 지도교수 a, 전공 b
WHERE a.전공코드 = b.전공코드 
    AND b.전공명 = 'DB'; 
 
SELECT  지도교수.지도교수,
        지도교수.교수명,
		  지도교수.전공코드, 
		  전공.전공명
 FROM 지도교수  INNER JOIN 전공 
      ON  지도교수.전공코드 = 전공.전공코드;

SELECT  a.지도교수,
        a.교수명,
		  a.전공코드, 
		  b.전공코드, 
		  b.전공명
 FROM 지도교수 a, 전공 b
WHERE a.전공코드 = b.전공코드;


SELECT *
 FROM 팀프로젝트 LIMIT 1;

SELECT *
 FROM 지도교수;
 
SELECT a.학번, 
       a.이름, 
		 b.교수명,
		 c.전공명
 FROM 팀프로젝트 a, 지도교수 b, 전공 c
WHERE a.조장 = b.조장 AND b.전공코드 = c.전공코드;


SELECT a.학번,
       a.이름,
       b.교수명,
       c.전공명
 FROM 팀프로젝트 a INNER JOIN 지도교수 b
      ON a.조장 = b.조장
		JOIN 전공 c
		ON c.전공코드 = b.전공코드;

SELECT a.이름, b.조명, a.점수 
 FROM 학생 a INNER join 졸작팀 b
   ON a.학번 =  b.학번;
 
 SELECT *
  FROM 학생;
 
 SELECT *
  FROM 졸작팀; 
  

SELECT a.이름, b.조명, a.점수
 FROM 학생 a, 졸작팀 b
 WHERE a.학번 = b.학번;

SELECT a.이름, b.조명, a.점수, c.동아리명 
 FROM  학생 a, 졸작팀 b, 동아리 c
WHERE a.학번 = b.학번 AND b.동아리코드 = c.동아리코드;

SELECT a.이름, b.조명, a.점수, c.동아리명
 FROM 학생 a INNER JOIN 졸작팀 b ON a.학번 = b.학번
      JOIN 동아리 c ON b.동아리코드 = c.동아리코드; 
      
SELECT a.전공코드, 
       a.전공명, 
		 b.교수명
FROM 전공 a INNER JOIN  지도교수 b
     ON  a.전공코드 = b.전공코드;
     
SELECT a.전공코드, 
       a.전공명, 
		 b.교수명
FROM 전공 a LEFT OUTER JOIN  지도교수 b
     ON  a.전공코드 = b.전공코드;

/*     
SELECT a.전공코드,
       a.전공명,
       b.교수명
FROM 전공 a, 지도교수 ㅠ
WHERE a.전공코드 = b.전공코드(+);
*/
SELECT a.학번,
       a.이름,
       b.점수,
       a.조장
 FROM 팀프로젝트 a RIGHT OUTER JOIN 성적 b
  ON a.학번 = b.학번;
  
SELECT a.학번,
       a.이름,
       b.점수,
       a.조장
 FROM 성적 b LEFT OUTER JOIN 팀프로젝트 a
  ON a.학번 = b.학번;  
  
SELECT 'x' AS 테스트 
 FROM 성적
UNION all
SELECT 'x' AS 테스트
 FROM 지도교수;


a.학번,;

SELECT a.이름,
       b.이름 AS 프로젝트참여자,
       a.점수,
       b.조장
FROM 성적 a LEFT OUTER JOIN 팀프로젝트 b
 ON a.학번 = b.학번
UNION 
SELECT a.이름,
       b.이름 AS 프로젝트참여자,
       a.점수,
       b.조장
FROM 성적 a RIGHT OUTER JOIN 팀프로젝트 b
 ON a.학번 = b.학번 
 ;

SELECT *
FROM 성적;

SELECT *
 FROM 팀프로젝트;

조원학번,
조원명,
조장학번,
조장명

;

SELECT a.학번 AS 조원학번,
       a.이름 AS 조원명,
       b.조장 AS 조장학번,
       b.이름 AS 조장명
 FROM 팀프로젝트 a, 팀프로젝트 b
WHERE a.조장 = b.학번;

SELECT * 
 FROM 팀프로젝트;
 
-- 판매한 제품의 품명과 판매수량 판매금액
SELECT *
 FROM 제품;


SELECT *
 FROM 판매; 

SELECT MAX(판매금액)
 FROM (SELECT a.제품명,
              a.판매수량,
              b.가격,
              a.판매수량 * b.가격 AS 판매금액
        FROM (SELECT a.제품번호,
                     a.제품명,
                     SUM(b.판매수량) AS 판매수량
               FROM 제품 a, 판매 b
              WHERE a.제품번호 = b.제품번호
              GROUP BY a.제품번호, a.제품명) a, 제품 b
       WHERE a.제품번호 = b.제품번호) a;

INSERT INTO 판매(제품번호,판매수량,판매날짜) 
       VALUES(1,30,'2015/03/01');


