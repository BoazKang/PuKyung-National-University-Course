SELECT *
 FROM 제품;

SELECT *
 FROM 판매;
 
SELECT product.제품명,
		 sales.판매수량 AS 판매수량
 FROM 제품 product LEFT JOIN 판매 sales
	ON product.제품번호 = sales.제품번호
-- GROUP BY product.제품번호
ORDER BY sales.판매수량 desc;
	 
SELECT distinct a.지도교수,
		 a.교수명
 FROM 지도교수 a JOIN 팀프로젝트 b
	ON a.조장 =  b.조장
WHERE b.이름 IN ('김수현', '이종석', '박보영', '이민호');

SELECT distinct a.지도교수,
		 a.교수명
 FROM 지도교수 a, 팀프로젝트 b
WHERE a.조장 =  b.조장
	 AND b.이름 IN ('김수현', '이종석', '박보영', '이민호');

SELECT *
 FROM 지도교수;

SELECT *
 FROM 전공;

-- 참조를 위해 만든 view
CREATE VIEW 교수전공 AS
SELECT a.교수명,
		 b.전공명
 FROM 지도교수 a, 전공 b
WHERE a.전공코드 = b.전공코드;

SELECT *
 FROM 교수전공
WHERE 교수명 = '김철수';

SELECT *
 FROM 학생평가;
 
SELECT 이름,
		 조이름,
		 점수
 FROM 학생평가
WHERE 점수 = ;

SELECT a.조이름,
		 a.이름,
		 a.점수
 FROM 학생평가 a, (SELECT 조이름, MAX(점수) AS 점수
 		 				  FROM 학생평가
						 GROUP BY 조이름) b
WHERE a.조이름 = b.조이름
  AND a.점수 = b.점수;

SELECT 조이름,
		 이름,
		 점수
 FROM 학생평가
WHERE 점수 = (select MAX(점수)
				   FROM 학생평가);
				   
SELECT a.조이름,
		 a.이름,
		 b.점수
 FROM 학생평가 a, (select MAX(점수) AS 점수
				   	  FROM 학생평가) b
WHERE a.점수 = b.점수;

SELECT a.조이름,
		 a.이름, 
		 a.점수
 FROM 학생평가 a
WHERE a.점수 = (SELECT max(점수)
 					  FROM 학생평가 b
					 WHERE a.조이름 = b.조이름);

SELECT *
 FROM 학생평가;
 
SELECT *
 FROM 판매;
 
SELECT SUM(판매수량)
 FROM 판매;
 
SELECT 제품번호,
		 판매수량,
		 89 AS 총판매수량
 FROM 판매;
 
SELECT 제품번호,
		 판매수량,
		 (SELECT SUM(판매수량)
 		   FROM 판매) AS 총판매수량 -- 스칼라 서브쿼리
 FROM 판매;
 
 SELECT *
  FROM 지도교수;
  
SELECT *
  FROM 전공;
  
SELECT a.지도교수,
		 a.교수명,
		 a.전공코드,
		 b.전공명
 FROM 지도교수 a, 전공 b
WHERE a.전공코드 = b.전공코드;

SELECT a.지도교수,
		 a.교수명,
		 a.전공코드,
		 (SELECT b.전공명
		   FROM 전공 b 
		  WHERE a.전공코드 = b.전공코드) AS 전공명
 FROM 지도교수 a;
 
