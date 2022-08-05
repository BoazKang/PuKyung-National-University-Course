SELECT * FROM 학생;

SELECT 이름,
       CASE WHEN 점수 >= 90
		 THEN 'A'
		 when 점수 >= 80
		 then 'B'
		 ELSE 'C' 
		 END 등급,
		 점수
 FROM 학생;