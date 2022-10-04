-- 구조잡기

/*
이름      name     varchar2(10)
주민번호   jumin    char(15)
전화번호   tel      varchar2(20)
성별      gender   varchar2(10)
나이      age      number(3)
출신지     home    varchar2(20)
*/

-- CREATE TABLE table_name ([column_name data_type);

CREATE TABLE info_tab
(
    name varchar2(10),
    jumin char(15),
    tel      varchar2(20),
    gender   varchar2(10),
    age      number(3),
    home    varchar2(20)
);

-- 테이블 구조확인
DESC info_tab;

-- 데이터 확인
SELECT * From info_tab;

/* 테이블명 : student_score
학번   id     char(4)
학생명 name    varchar2(20)
국어  kor     number(3)
영어  eng     number(3)     
총점  total   number
평균  avg     number(5,2)     -- 앞자리는 전체 자리수
*/

CREATE TABLE student_score
(
   id     char(4),
name    varchar2(20),
 kor     number(3),
eng     number(3),     
 total   number,
 avg     number(5,2)
);

DROP TABLE student_score;
DESC student_score;

-- 수학 컬럼을 추가
-- ALTER TABLE table_name ADD ( [ column_name data_type ] );

ALTER TABLE student_score 
    ADD ( math number(3) );

-- 총점 컬럼 삭제하기
ALTER TABLE student_score DROP ( total );

-- 평균 컬럼에서 소수점 1자리로 변경
ALTER TABLE student_score MODIFY ( avg number(4,1) );

-- 데이타 입력
-- 문자 : ''
INSERT INTO student_score( id, name, kor, eng )
    VALUES ( '0001','홍길동',50,80 );

SELECT * From student_score;

-- 2000번 학번인 홍길자의 국어와 영어 점수를 각각 60, 90점으로 저장
INSERT INTO student_score( id, name, kor, eng )
    VALUES ( '2000','홍길자',60,90 );

SELECT * FROM student_score;

-- 1000번 학생 홍길숙 정보를 저장
INSERT INTO student_score (id,name) VALUES (1000,'홍길숙');

-- 이름ㅇ ㅣ홍길숙인 학생의 레코드르 삭제
DELETE FROM student_score WHERE name = '홍길숙';

-- 0001번 학생의 국어 점수를 100점으로 수정

UPDATE student_score SET kor=100 WHERE id='0001';

-- 홍길자의 수학점수를 90점으로 입력 ( -> 수정 )
UPDATE student_score SET math=90 WHERE name='홍길자';

-- 학생들의 평균 구하기
UPDATE student_score 
SET avg= (kor+eng+ nvl(math, 0))/3;
-- WHERE 이 빠질 경우 : 모든 레코드를 대상으로 함


CREATE TABLE emp_copy AS SELECT * FROM emp;
DESC emp_copy;

SELECT * FROM emp_copy;

/*
    [ 연습문제 ] emp 전체 emp_copy 복사본 테이블 생성 후
    1. 사원번호가 7788인 사원의 부서를 10번으로 변경
    2. 사원번호가 7782인 사원의 이름을 홍길숙으로 변경하고 급여를 3500으로 변경
    3. 모든 부서원의 보너스를 300씩 인상 변경
    4. 사원번호가 7499인 사원의 정보를 삭제
    5. 입사일자가 81년 6월 1일 이전인 사원의 정보를 삭제
*/
UPDATE emp_copy SET deptno=10 WHERE empno = 7788;
UPDATE emp_copy SET ename='홍길숙', sal=3500 WHERE empno = 7782;

UPDATE emp_copy SET comm= nvl(comm,0)+300;

DELETE FROM emp_copy WHERE empno=7499;
DELETE FROM emp_copy WHERE hiredate<'1981-06-01';

commit;
rollback;

truncate table emp_copy;
