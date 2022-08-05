CREATE DATABASE SampleDB DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE SampleDB;

-- 성적테이블 생성
CREATE TABLE 성적
(학번 CHAR(9) PRIMARY KEY,
 이름 VARCHAR(20),
 성별 CHAR(2),
 반   CHAR(10),
 점수 INT);
 
 
select * from SampleDB.성적;

DELETE FROM 성적;

DELETE FROM 성적 WHERE 학번 = '201501001';

-- INSERT INTO TABLE_NAME(COLUMN1, COLUMN2) VALUES('val1', 'val2');

INSERT INTO 성적 VALUES('201501001','김수현','남','A',90);
INSERT INTO 성적 VALUES('201501002','송혜교','여','A',75);
INSERT INTO 성적 VALUES('201501003','하지원','여','A',77);
INSERT INTO 성적 VALUES('201501004','장근석','남','A',85);
INSERT INTO 성적 VALUES('201501005','이종석','남','A',95);
INSERT INTO 성적 VALUES('201501006','주원','남','A',80);
INSERT INTO 성적 VALUES('201501007','박보영','여','A',95);
INSERT INTO 성적 VALUES('201501008','한효주','여','A',90);
INSERT INTO 성적 VALUES('201501009','송중기','남','A',83);
INSERT INTO 성적 VALUES('201501010','김우빈','남','A',88);
INSERT INTO 성적 VALUES('201501011','이연희','여','B',75);
INSERT INTO 성적 VALUES('201501012','유승호','남','B',84);
INSERT INTO 성적 VALUES('201501013','박신혜','여','B',80);
INSERT INTO 성적 VALUES('201501014','한지민','여','B',94);
INSERT INTO 성적 VALUES('201501015','이승기','남','B',78);
INSERT INTO 성적 VALUES('201501016','박민영','여','B',71);
INSERT INTO 성적 VALUES('201501017','유아인','남','B',87);
INSERT INTO 성적 VALUES('201501018','강소라','여','B',90);
INSERT INTO 성적 VALUES('201501019','이민호','남','B',94);
INSERT INTO 성적 VALUES('201501020','김태희','여','B',78);

-- 제품 테이블 생성

 CREATE TABLE 제품(
 제품번호 int PRIMARY KEY,
 제품명 CHAR(20),
 종류 CHAR(20),
 색상 CHAR(10),
 가격 INT);


 INSERT INTO 제품 VALUES(1,'롱코트','코트','BLACK',150000);
 INSERT INTO 제품 VALUES(2,'하프코트','코트','RED',130000);
 INSERT INTO 제품 VALUES(3,'짚업점퍼','점퍼','BROWN',55000);
 INSERT INTO 제품 VALUES(4,'후드점퍼','점퍼','YELLOW',63000);
 INSERT INTO 제품 VALUES(5,'가죽자켓','자켓','BLACK',82000);
 INSERT INTO 제품 VALUES(6,'주름스커트','스커트','WHITE',65000);
 INSERT INTO 제품 VALUES(7,'옥스포드셔츠','셔츠','WHITE',15000);
 INSERT INTO 제품 VALUES(8,'블라우스','셔츠','PINK',35000);
 INSERT INTO 제품 VALUES(9,'원피스','원피스','BLUE',95000);
 INSERT INTO 제품 VALUES(10,'반바지','바지','WHITE',35000);
 INSERT INTO 제품 VALUES(11,'장갑','패션잡화','RED',NULL);
 INSERT INTO 제품 VALUES(12,'목도리','패션잡화','BEIGE',NULL);
  
 -- 판매이블 생성
 CREATE TABLE 판매
 (
 판매번호 INT AUTO_INCREMENT primary key,
 제품번호 INT,
 판매수량 INT,
 판매날짜 CHAR(10),
 foreign key(제품번호) references 제품(제품번호)
 );

 INSERT INTO 판매 VALUES(1, 1,10,'2015/02/11');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(2,12,'2015/02/11');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(2,15,'2015/02/12');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(4,21,'2015/02/13');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(7,17,'2015/02/16');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(4,11,'2015/02/16');
 INSERT INTO 판매 (제품번호, 판매수량, 판매날짜) VALUES(10,3,'2015/02/17');

 -- 전공이블 생성
CREATE TABLE 전공
(
 전공코드 CHAR(3) PRIMARY KEY,
 전공명 VARCHAR(20)
);

INSERT INTO 전공 VALUES('D01','통신');
INSERT INTO 전공 VALUES('D02','DB');
INSERT INTO 전공 VALUES('D03','그래픽');
INSERT INTO 전공 VALUES('D04','알고리즘');
INSERT INTO 전공 VALUES('D05','정보보안');
INSERT INTO 전공 VALUES('D06','분산시스템');


-- 지도교수 테이블 생성
CREATE TABLE 지도교수
(
 지도교수 CHAR(3) PRIMARY KEY,
 교수명  VARCHAR(20),
 전공코드 CHAR(3),
 조장 CHAR(9),
 foreign key (전공코드) references 전공(전공코드)
);

INSERT INTO 지도교수 VALUES('P01','김철수','D02','201501013');
INSERT INTO 지도교수 VALUES('P02','박영희','D01','201501001');
INSERT INTO 지도교수 VALUES('P03','최석민','D04','201501009');
INSERT INTO 지도교수 VALUES('P04','이영민','D02','201501005');
INSERT INTO 지도교수 VALUES('P05','한시원','D03','201501003');

-- 팀프로젝트 테이블 생성
CREATE TABLE 팀프로젝트
(학번 CHAR(9) PRIMARY KEY,
이름 VARCHAR(20),
조장 CHAR(9)
);

INSERT 팀프로젝트 VALUES('201501001','김수현','201501001');
INSERT 팀프로젝트 VALUES('201501002','송혜교','201501005');
INSERT 팀프로젝트 VALUES('201501003','하지원','201501003');
INSERT 팀프로젝트 VALUES('201501004','장근석','201501013');
INSERT 팀프로젝트 VALUES('201501005','이종석','201501005');
INSERT 팀프로젝트 VALUES('201501006','주원','201501013');
INSERT 팀프로젝트 VALUES('201501007','박보영','201501001');
INSERT 팀프로젝트 VALUES('201501009','송중기','201501009');
INSERT 팀프로젝트 VALUES('201501010','김우빈','201501003');
INSERT 팀프로젝트 VALUES('201501012','유승호','201501001');
INSERT 팀프로젝트 VALUES('201501013','박신혜','201501013');
INSERT 팀프로젝트 VALUES('201501014','한지민','201501009');
INSERT 팀프로젝트 VALUES('201501016','박민영','201501009');
INSERT 팀프로젝트 VALUES('201501019','이민호','201501005');
INSERT 팀프로젝트 VALUES('201501020','김태희','201501003');
INSERT 팀프로젝트 VALUES('G01','원빈','201501005'); -- FULL OUTER JOIN 예제를 위한 레코드 삽입

-- 학생평가 테이블 생성 
CREATE TABLE 학생평가
(학번 CHAR(9) PRIMARY KEY,
이름 VARCHAR(20),
점수 INT,
조이름 VARCHAR(20));

INSERT INTO 학생평가 VALUES('201501001','김수현',90,'T2015');
INSERT INTO 학생평가 VALUES('201501002','송혜교',75,'무한도전');
INSERT INTO 학생평가 VALUES('201501003','하지원',77,'학교짱');
INSERT INTO 학생평가 VALUES('201501004','장근석',85,'T2015');
INSERT INTO 학생평가 VALUES('201501005','이종석',96,'BIG');
INSERT INTO 학생평가 VALUES('201501006','주원',80,'베스트');
INSERT INTO 학생평가 VALUES('201501007','박보영',95,'BIG');
INSERT INTO 학생평가 VALUES('201501008','한효주',90,'학교짱');
INSERT INTO 학생평가 VALUES('201501009','송중기',83,'T2015');
INSERT INTO 학생평가 VALUES('201501010','김우빈',88,'베스트');
INSERT INTO 학생평가 VALUES('201501011','이연희',75,'학교짱');
INSERT INTO 학생평가 VALUES('201501012','유승호',84,'BIG');
INSERT INTO 학생평가 VALUES('201501013','박신혜',89,'무한도전');
INSERT INTO 학생평가 VALUES('201501014','한지민',94,'베스트');
INSERT INTO 학생평가 VALUES('201501015','이승기',78,'무한도전');

-- merge 예제로 대상 테이블, 소스 테이블 생성
 CREATE TABLE 대상
 (사번 INT PRIMARY KEY,
 이름 VARCHAR(10) NOT NULL,
 직급 VARCHAR(10) NOT NULL,
 부서 CHAR(20) NOT NULL);
 
 INSERT INTO 대상 VALUES(1,'홍길동','부장','홍보부');
 INSERT INTO 대상 VALUES(2,'김선달','부장','인사부');
 INSERT INTO 대상 VALUES(3,'이도령','과장','홍보부');

 CREATE TABLE 소스
 (사번 INT PRIMARY KEY,
 이름 VARCHAR(10) NOT NULL,
 직급 VARCHAR(10) NOT NULL,
 부서 CHAR(20) NOT NULL);
 
 INSERT INTO 소스 VALUES(1,'홍길동','부장','국제마케팅부');
 INSERT INTO 소스 VALUES(3,'이도령','부장','홍보부');
 INSERT INTO 소스 VALUES(4,'성춘향','과장','영업부');

 -- 사원테이블 생성
 CREATE TABLE 사원
 (사번 CHAR(5),
  직책 VARCHAR(20),
  부서 CHAR(3),
  팀장사번 CHAR(5));

INSERT INTO 사원 VALUES('1','일반디자이너','D02','6');
INSERT INTO 사원 VALUES('2','프로그래머','D02','9');
INSERT INTO 사원 VALUES('3','마케팅매니저','D02','10');
INSERT INTO 사원 VALUES('4','일반디자이너','D02','6');
INSERT INTO 사원 VALUES('5','영업','D02','3');
INSERT INTO 사원 VALUES('6','수석디자이너','D02','10');
INSERT INTO 사원 VALUES('7','영업','D02','3');
INSERT INTO 사원 VALUES('8','프로그래머','D02','9');
INSERT INTO 사원 VALUES('9','프로그램관리','D02','10');
INSERT INTO 사원 VALUES('10','대표이사','D02',null);

 -- 사원업무 테이블 생성
CREATE TABLE 사원업무(
 사번 int auto_increment NOT NULL primary key,
 이름 VARCHAR(10),
 시급 int,
 연봉 int,
 판매수량 int,
 커미션 int,
 업무 VARCHAR(50)
);

INSERT INTO 사원업무(이름,시급,업무) VALUES('홍길동',7000,'문서수발');
INSERT INTO 사원업무(이름,시급,업무) VALUES('김선달',7500,'문서정리');
INSERT INTO 사원업무(이름,시급,업무) VALUES('성춘향',7000,'고객상담');
INSERT INTO 사원업무(이름,연봉,업무) VALUES('변학도',35000000,'홍보팀장');
INSERT INTO 사원업무(이름,연봉,업무) VALUES('김철수',34000000,'전산팀장');
INSERT INTO 사원업무(이름,판매수량,커미션,업무) VALUES('이방자',1200,500,'서비스');

-- 수업자료 테이블 추가 -----
-- 줄넘기 결과 테이블
create table 줄넘기결과
(학년 int,
반 char(1),
이름 varchar(10),
스코어 int);
insert 줄넘기결과 values(1,'A','고현정',10);
insert 줄넘기결과 values(2,'B','김남주',23);
insert 줄넘기결과 values(3,'A','김수미',5);
insert 줄넘기결과 values(3,'B','김하늘',22);
insert 줄넘기결과 values(2,'A','김희애',15);
insert 줄넘기결과 values(1,'B','서우',5);
insert 줄넘기결과 values(1,'A','손예진',25);
insert 줄넘기결과 values(2,'A','수지',17);
insert 줄넘기결과 values(3,'B','신세경',18);
insert 줄넘기결과 values(3,'A','염정아',11);
insert 줄넘기결과 values(2,'B','최정안',21);
insert 줄넘기결과 values(3,'B','최지우',6);
insert 줄넘기결과 values(1,'B','한가인',30);
insert 줄넘기결과 values(1,'A','한지민',12);
insert 줄넘기결과 values(2,'A','황신혜',18);
insert 줄넘기결과 values(1,'B','전혜빈',11);
insert 줄넘기결과 values(2,'B','김태희',6);
insert 줄넘기결과 values(3,'A','신민아',28);

-- 졸작팀 테이블 생성
create table 졸작팀
(학번 varchar(9),
이름 varchar(20),
조명 varchar(20),
조장 varchar(9),
동아리코드 char(3)
);

insert 졸작팀 values('201326001','고현정','예쁜걸','201326001','D02');
insert 졸작팀 values('201326002','김남주','내가제일잘나가','201326005','D03');
insert 졸작팀 values('201326003','김수미','섹시걸','201326003','D01');
insert 졸작팀 values('201326004','김하늘','배화짱','201326013','D02');
insert 졸작팀 values('201326005','김희애','내가제일잘나가','201326005','D03');
insert 졸작팀 values('201326006','서우','배화짱','201326013','D01');
insert 졸작팀 values('201326007','손예진','예쁜걸','201326001','D03');
insert 졸작팀 values('201326008','수지','B2011','201326009','D02');
insert 졸작팀 values('201326009','신세경','B2011','201326009','D01');
insert 졸작팀 values('201326010','염정아','섹시걸','201326003','D04');
insert 졸작팀 values('201326011','최정안','내가제일잘나가','201326005','D05');
insert 졸작팀 values('201326012','최지우','예쁜걸','201326001','D05');
insert 졸작팀 values('201326013','한가인','배화짱','201326013','D04');
insert 졸작팀 values('201326014','한지민','B2011','201326009','D05');
insert 졸작팀 values('201326015','황신혜','섹시걸','201326003','D04');
 
-- 동아리 테이블 생성
create table 동아리
(
 동아리코드 char(3),
 동아리명  varchar(20)
);
insert 동아리 values('D01','배화댄스');
insert 동아리 values('D02','방송반');
insert 동아리 values('D03','봉사help');
insert 동아리 values('D04','배화연극반');
insert 동아리 values('D05','RCY');
 
-- 학생 테이블 생성
 create table 학생
(학번 varchar(9),
이름 varchar(20),
점수 int);
insert 학생 values('201326001','고현정',90);
insert 학생 values('201326002','김남주',70);
insert 학생 values('201326003','김수미',75);
insert 학생 values('201326004','김하늘',85);
insert 학생 values('201326005','김희애',95);
insert 학생 values('201326006','서우',80);
insert 학생 values('201326007','손예진',95);
insert 학생 values('201326008','수지',90);
insert 학생 values('201326009','신세경',80);
insert 학생 values('201326010','염정아',88);
insert 학생 values('201326011','최정안',75);
insert 학생 values('201326012','최지우',84);
insert 학생 values('201326013','한가인',77);
insert 학생 values('201326014','한지민',94);
insert 학생 values('201326015','황신혜',80);
 
-- 책 테이블 생성

CREATE TABLE 책
(책코드 CHAR(5) PRIMARY KEY,
 책명 VARCHAR(100) NOT NULL,
 분야 CHAR(10),
 가격 INT,
 출간날짜 CHAR(7) NOT NULL);

INSERT INTO 책 VALUES('B1034','파스타요리','요리',7500,'2011/05');
INSERT INTO 책 VALUES('B1051','지중해요리','요리',10000,'2012/05');
INSERT INTO 책 VALUES('B2021','운영체제','컴퓨터',12000,'2014/12');
INSERT INTO 책 VALUES('B2157','자바프로그래밍','컴퓨터',12000,'2014/03');
INSERT INTO 책 VALUES('B2205','자료구조','컴퓨터',11500,'2013/02');
INSERT INTO 책 VALUES('B3089','사회적 경제의 이해','경제',12000,'2010/08');
INSERT INTO 책 VALUES('B3111','세계의 경제지표','경제',13000,'2012/11');
INSERT INTO 책 VALUES('B3324','경제학원론','경제',15000,'2015/01');
INSERT INTO 책 VALUES('B4077','행동의심리학','심리',11500,'2014/09');
INSERT INTO 책 VALUES('B4101','심리학의 이해','심리',12000,'2015/01');

-- 모의고사 테이블 생성
 CREATE TABLE 모의고사
 (이름 VARCHAR(10),
  과목 CHAR(4),
  점수 INT);

-- 모의고사 데이터 입력

 INSERT 모의고사 VALUES('홍길동','국어',80);
 INSERT 모의고사 VALUES('홍길동','영어',90);
 INSERT 모의고사 VALUES('홍길동','수학',85);
 INSERT 모의고사 VALUES('김선달','국어',100);
 INSERT 모의고사 VALUES('김선달','영어',95);
 INSERT 모의고사 VALUES('김선달','수학',80);
 INSERT 모의고사 VALUES('홍길동','국어',80);
 INSERT 모의고사 VALUES('홍길동','영어',100);
 INSERT 모의고사 VALUES('홍길동','수학',97);
 INSERT 모의고사 VALUES('김선달','국어',100);
 INSERT 모의고사 VALUES('김선달','영어',90);
 INSERT 모의고사 VALUES('김선달','수학',85);
 SELECT * FROM 모의고사;

CREATE TABLE 분기실적
(년도 CHAR(4),
 분기 CHAR(10),
 금액 INT);

INSERT INTO 분기실적 VALUES('2013','1분기',100);
INSERT INTO 분기실적 VALUES('2013','2분기',150);
INSERT INTO 분기실적 VALUES('2013','3분기',200);
INSERT INTO 분기실적 VALUES('2013','4분기',300);
INSERT INTO 분기실적 VALUES('2014','1분기',150);
INSERT INTO 분기실적 VALUES('2014','2분기',250);
INSERT INTO 분기실적 VALUES('2014','3분기',200);
INSERT INTO 분기실적 VALUES('2014','4분기',400);

  -- 상품 테이블 생성
 CREATE TABLE 상품
 (상품코드 CHAR(3) PRIMARY KEY,
  상품명   VARCHAR(15) NOT NULL,
  가격     INT NOT NULL,
  재고수량 INT DEFAULT 0);

-- 입고 테이블 생성
 CREATE TABLE 입고
 (입고번호 INT auto_increment primary key,
  상품코드 CHAR(3),
  입고날짜 CHAR(10),
  입고수량 INT NOT NULL,
  foreign key (상품코드) references 상품(상품코드));

-- 상품 테이블에 상품 데이터 추가
 INSERT INTO 상품 VALUES('P01','노트북',980000,0);
 INSERT INTO 상품 VALUES('P02','프린터',180000,0);
 
create table 기증내역
(번호 int auto_increment primary key,
 물품코드 char(3),
 기증자 char(10),
 기증수량 int);

create table 물품
(물품코드 char(3),
 물품명 char(20),
 수량 int);

insert 기증내역 (물품코드, 기증자, 기증수량) values('p01','홍길동',10);
insert 기증내역 (물품코드, 기증자, 기증수량) values('p02','성춘향',5);
insert 기증내역 (물품코드, 기증자, 기증수량) values('p01','김선달',10);

insert 물품 values('p01','장갑',20);
insert 물품 values('p02','모자',5);

create table 고객
(고객id int,
 고객명 char(20),
 연령 int,
 마일리지 int,
 뉴스레터 char(1));

create table 뉴스레터
(고객id int,
 고객명 char(20));