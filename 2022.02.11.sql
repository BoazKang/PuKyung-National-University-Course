# 개체를 관리 CREATE, DROP, ALTER
# DATABASE, View, Table, user,constraints

# CREATE DATABASE pknu;
#DROP DATABASE pknu;

# CREATE TABLE custom(custom_id VARCHAR(10),
# 							custom_name VARCHAR(20), 
# 							tel_no VARCHAR(20),
# 							address VARCHAR(50));pknucustom

#  SELECT * FROM custom;

-- SELECT ABS(-10);

-- SELECT sqrt(LOG(10));

-- SELECT SUBSTR("abcdefg",1,4);

-- SELECT substr(NOW(),12);

/*
1. 데이터베이스 만들기 pknu (ddl)
2. 테이블 만들기 address, age (ddl)
	address 이름, 고향
	age 이름, 나이
	address (dml transaction)
	이민주,부산
	강보민,부산
	최어진,경남
	유지현,경남
	정지연,경남
	age (dml transaction)
	이민주,25
	강보민,26
	최어진,27
	유지현,28
	정지연,29
3. 데이터 인서트 (dml transaction)
4. 전체 address를 출력 (sql)
5. 전체 age를 출력 (sql)
6. 가장 나이가 적은 사람의 고향 출력 (sql)
7. 가장 나이가 많은 사람의 성만 출력 (sql)
	
*/

-- 데이터 베이스 생성
-- create database pknu;

-- address 테이블 생성
-- DROP TABLE address;
/* CREATE TABLE address(student_name VARCHAR(10),
							address VARCHAR(5));
*/


-- age 테이블 생성
-- DROP TABLE age;
-- CREATE TABLE age(student_name VARCHAR(10), age INT(10));

-- ALTER TABLE address CONVERT TO CHARSET UTF8;
-- ALTER TABLE age CONVERT TO CHARSET UTF8;


-- address에 데이터 넣기
/*
INSERT INTO address(student_name, address)
VALUES('이민주','부산');
INSERT INTO address(student_name, address)
VALUES('강보민','부산');
INSERT INTO address(student_name, address)
VALUES('최어진','경남');
INSERT INTO address(student_name, address)
VALUES('유지현','경남');
INSERT INTO address(student_name, address)
VALUES('정지연','경남');

INSERT INTO age(student_name, age)
VALUES('이민주',25);
INSERT INTO age(student_name, age)
VALUES('강보민',26);
INSERT INTO age(student_name, age)
VALUES('최어진',27);
INSERT INTO age(student_name, age)
VALUES('유지현',28);
INSERT INTO age(student_name, age)
VALUES('정지연',29);
*/

-- address 테이블 컬럼이 있는가?

DESC address;

SELECT *
FROM address;

UPDATE address SET address = '경남';

SELECT *
from address;

UPDATE address SET address = '부산'
WHERE student_name = '이민주';

UPDATE address SET address = '부산'
WHERE student_name = '강보민';

SELECT student_name
		,address
 FROM address;
 
SELECT *
 FROM age;
 
SELECT address
 FROM address
 WHERE student_name = (SELECT student_name
 FROM age
 WHERE age = (SELECT min(age)
 					FROM age));
 					
SELECT substr(student_name,1,1)
 FROM age
 WHERE age = (SELECT MAX(age) FROM age);
 
 
SELECT
 FROM
 where
 GROUP by
 ORDER BY;
 
 SELECT * FROM TABLES;
 
 SELECT table_name
  FROM tables
  WHERE table_schema = 'sakila';
  
SHOW TABLES;
  
SELECT *
FROM actor;

DESC actor;

DESC film;

DESC actor_info;

SELECT *
FROM actor_info;

SELECT *
FROM film_actor;

SELECT COUNT(*)
 FROM film_actor;
 
SELECT actor_id, COUNT(*)
 FROM film_actor
 GROUP BY actor_id;
 
DESC film_actor;
DESC actor;

SELECT *
 FROM actor
 WHERE actor_id = 198;

CREATE TABLE actor_tmp as
SELECT actor_id,
		 COUNT(*) AS cnt
 FROM film_actor
 GROUP BY actor_id;
 
 SELECT MAX(cnt)
  FROM actor_tmp;
  
SELECT *
 FROM actor_tmp
 WHERE cnt = (SELECT MAX(cnt)
  				 FROM actor_tmp);
  				 
SELECT first_name,
		 last_name
 FROM actor
 WHERE actor_id = (SELECT actor_id
 						FROM actor_tmp
 						WHERE cnt = (SELECT MAX(cnt)
  				 						FROM actor_tmp));

SELECT first_name,
		 last_name,
		 actor_id
 FROM actor
 WHERE actor_id = (SELECT actor_id
					  	 FROM (SELECT actor_id, COUNT(*) AS cnt
      					 	 FROM film_actor
								 GROUP BY actor_id) a
						 WHERE cnt = (SELECT MAX(cnt) AS cnt
										  FROM (SELECT COUNT(*) AS cnt
 							 					  FROM film_actor
 												  GROUP BY actor_id) a));
 												  
SELECT *
 FROM film_actor;
 
SELECT *
 FROM film_actor
 WHERE film_id = 841;
 
SELECT *
 FROM film
 WHERE film_id = 841;


SELECT title
 FROM film
 WHERE film_id = (SELECT film_id
						FROM (SELECT film_id, COUNT(*) AS cnt
 								FROM film_actor
								GROUP BY film_id) a
						WHERE cnt = (SELECT max(cnt) AS cnt
									  	 FROM (SELECT film_id, COUNT(*) AS cnt
 												 FROM film_actor
												 GROUP BY film_id) a));


-- 영화별로 중요배우의 캐스팅 수를 구하고
SELECT film_id, COUNT(*) AS cnt
FROM film_actor
GROUP BY film_id;

-- 구한 캐스팅수의 최고값을 구하고
SELECT film_id, COUNT(*) AS cnt
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(*) DESC LIMIT 1;

-- 최고값의 영화 아이디를 구하고
SELECT film_id
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(*) DESC LIMIT 1;

-- 영화 아이디로 영화 제목을 구하기
SELECT title
FROM film
WHERE film_id = (SELECT film_id
						FROM film_actor
						GROUP BY film_id
						ORDER BY COUNT(*) DESC LIMIT 1);


-- film_actor 테이블에서 주요 배우들을 많이 쓴 영화 100개 구하기
-- 영화 100개에서 배우들의 합계 구하기

SELECT SUM(cnt)
FROM (SELECT film_id,
	 	 COUNT(*) AS cnt
		FROM film_actor
		GROUP BY film_id
		ORDER BY COUNT(*) DESC LIMIT 100) a;



-- 영화별로 주요배우 캐스팅의 평균을 구하기

SELECT AVG(cnt)
FROM (SELECT film_id,
		 COUNT(*) AS cnt
		FROM film_actor
		GROUP BY film_id) a;

-- 영화별로 주요배우 캐스팅이 평균보다 큰 영화들의 제목 구하기

SELECT title
FROM film
WHERE film_id IN (SELECT film_id
						FROM (SELECT film_id,
								 COUNT(*) AS cnt
								FROM film_actor
								GROUP BY film_id) a
						WHERE cnt >= (SELECT AVG(cnt)
											FROM (SELECT film_id,
													 COUNT(*) AS cnt
													FROM film_actor
													GROUP BY film_id) a));

SELECT *
FROM actor
WHERE actor_id IN (1,2,4);




SELECT title
FROM film
WHERE film_id IN (SELECT film_id
                   FROM (SELECT film_id,
                                COUNT(*) AS cnt
                          FROM film_actor
                         GROUP BY film_id) a
                  WHERE cnt >= (SELECT AVG(cnt) 
                                 FROM (SELECT film_id,
                                              COUNT(*) AS cnt
                                        FROM film_actor
                                       GROUP BY film_id) a));

SELECT rating, COUNT(*)
FROM film
WHERE film_id IN (SELECT film_id
                   FROM (SELECT film_id,
                                COUNT(*) AS cnt
                          FROM film_actor
                         GROUP BY film_id) a
                  WHERE cnt >= (SELECT AVG(cnt) 
                                 FROM (SELECT film_id,
                                              COUNT(*) AS cnt
                                        FROM film_actor
                                       GROUP BY film_id) a))
GROUP BY rating
ORDER BY COUNT(*) DESC;

SELECT rating
FROM (SELECT title, rating
		FROM film LIMIT 10) a;