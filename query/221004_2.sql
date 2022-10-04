-- 사원명, 급여, 월급 (급여/12)를 출력하되 월급은 십단위에서 반올림하여 출력
SELECT ename, sal, round(sal/12, -2) as wolgeub
FROM emp;

SELECT ename, sal, trunc(sal * 0.033,-1) as tax -- 연산/함수를 사용할 경우 반드시 별칭 부여
FROM emp;

-- 1-1
SELECT empno, ename, lower(job) lower_job
FROM emp WHERE ename = UPPER('smith');
-- 1-2
SELECT empno, ename, lower(job) lower_job
FROM emp WHERE lower(ename) = 'smith';
-- 1-3
SELECT empno, ename, lower(job) lower_job
FROM emp WHERE lower(ename) = lower('smith');
--2
SELECT empno, INITCAP(ename) as INITCAP_ename, INITCAP(job) as INITCAP_job
FROM emp;

--extra
SELECT name, substr(jumin,8,1) as jumin_gender
           , substr(jumin,1,2) as jumin_year
FROM info_tab;


--3
SELECT empno, ename, job, sal, deptno
FROM emp WHERE SUBSTR(ename,1,1)>'K' and SUBSTR(ename,1,1)<'Y'
ORDER BY ename ASC; -- 정렬


--4
SELECT * FROM emp
WHERE LENGTH(ename)>=5;
--5
SELECT RPAD(ename,15,'*') FROM emp;
--6
SELECT LPAD(sal,10,'-') FROM emp;
--7
SELECT '-' || trim(' 이순신 ') || '-' as col1, 
       '-' || ltrim(' 이순신 ') || '-' as col2, 
       '-' || rtrim(' 이순신 ') || '-' as col3 from dual;

SELECT sysdate FROM dual;
--8
SELECT sal, TRANSLATE(sal,'0123456789','영일이삼사오육칠팔구') as kor_sal
FROM emp;
--9
SELECT sal, REPLACE(sal,0,'$') as char_sal
FROM emp;

-- ***** 안쪽에 있는 공백까지 모두 제거
SELECT REPLACE('     이        순       신            ',' ','') as ename
FROM dual;


-- [ 날짜 ]
-- 1
SELECT ename, hiredate, ceil(sysdate-nvl(hiredate,sysdate))
FROM emp
ORDER BY hiredate desc;

SELECT ename, hiredate
FROM emp
ORDER BY hiredate desc NULLs LAST;

--2
SELECT ename, sysdate-hiredate as origin, 
trunc((sysdate-hiredate)/7,0) as weeks, 
floor(mod(sysdate-hiredate,7)) as days
FROM emp;

--3
SELECT ename,deptno, floor(MONTHS_BETWEEN(sysdate,hiredate)) as hire_month
FROM emp
WHERE deptno = 10;

--4
select add_months( sysdate, 3 ) as mydate from dual;

--5
SELECT sysdate, NEXT_DAY(sysdate,'월') as next_monday FROM dual;

--6
SELECT sysdate, LAST_DAY(sysdate) last_day FROM dual;




-- 입사일자에서 입사년도를 출력
SELECT ename, hiredate, to_char(hiredate, 'YYYY') hire_year
FROM emp;

-- 입사일자를 ‘1999년 1월 1일’ 형식으로 출력
SELECT hiredate, to_char(hiredate,'YYYY"년" MM"월" DD"일"') date_hiredate
FROM emp;

-- 1981년도에 입사한 사원 검색
SELECT * FROM emp
WHERE to_char(hiredate,'YYYY') = '1981';

-- 5월에 입사한 사원 검색
SELECT * FROM emp
WHERE to_char(hiredate,'MM') = '05';

-- 급여 앞에 $를 삽입하고 3자리 마다 ,를 출력
SELECT ename, sal, to_char(sal,'$999,999,999,999') dollar
FROM emp;


-- 81년 2월에 입사한 사원 검색
SELECT * from emp
WHERE to_char(hiredate,'YYYYMM') = 198102;

-- 81년에 입사하지 않은 사원 검색
SELECT * from emp
WHERE to_char(hiredate,'YYYY') <> 1981;

-- 81년 하반기에 입사한 사원 검색
SELECT * from emp
WHERE to_char(hiredate,'YYYY') = 1981 and to_char(hiredate,'MM')>6;

commit;

SELECT jumin, decode ( substr(jumin, 8, 1), '1', '남자', '3', '남자', '여자') as gender
FROM info_tab;

-------------------
SELECT jumin, 
    CASE substr( jumin, 8, 1) 
        WHEN '1' THEN '남자'
        WHEN '3' THEN '남자'
        ELSE '여자'
        END as gender
FROM info_tab;

SELECT deptno, 
    decode ( deptno, 10, '영업부', 20, '관리부', 30, 'IT부', '기술부') as dept
FROM emp;

SELECT deptno, 
    CASE deptno
        WHEN 10 THEN '영업부'
        WHEN 20 THEN '관리부'
        WHEN 30 THEN 'IT부'
        ELSE '기술부'
        END as dept
FROM emp;

SELECT empno, ename, job, sal,
    decode ( job, 'ANALYST', sal * 1.1, 'CLERK', sal*1.15, 'MANAGER', sal*1.2 ) change
FROM emp;


SELECT empno, ename, job, sal,
 CASE job
        WHEN 'ANALYST' THEN sal * 1.1
        WHEN 'CLERK' THEN sal *1.15
        WHEN 'MANAGER' THEN sal * 1.2
        END as change
FROM emp;


--------------

SELECT all job FROM emp;
SELECT distinct job FROM emp;
SELECT empno, ename, job, rownum FROM emp where rownum<=5; -- rownum : 가상 컬럼, 번호를 붙여줌



SELECT AVG(sal) avg, SUM(sal) sum, min(sal) min, max(sal) max
FROM emp
WHERE job = 'SALESMAN';

INSERT INTO emp(empno, ename, job)
VALUES (9001, '홍길국', 'SALESMAN');


-- 커미션을 받는 사람의 수
SELECT count(comm) count_comm
FROM emp
WHERE nvl(comm,0)!=0;


-----------------------
-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기
SELECT deptno, count(*) count, avg(sal) avg, min(sal) min, max(sal) max, sum(sal) sum
FROM emp
GROUP BY deptno;
--HAVING;

-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기 ( 부서별 급여의 합이 높은 순으로
SELECT deptno, count(*) count, avg(sal) avg, min(sal) min, max(sal) max, sum(sal) sum
FROM emp
GROUP BY deptno
ORDER BY sum desc;

-- 부서별 업무별 그룹하여 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하기
SELECT deptno, job, count(*) count, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY deptno, job;

-- 최대 급여가 2900 이상인 부서에 대해 부서번호, 평균 급여, 급여의 합을 출력
SELECT deptno, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY deptno
HAVING max(sal) >= 2900;

-- 업무별 급여의 평균이 3000이상인 업무에 대해 업무명, 평균 급여, 급여의 합을 출력
SELECT job, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY job
HAVING avg(sal) >= 3000;

-- 전체 합계 급여가 5000를 초과하는 각 업무에 대해서 업무와 급여 합계를 출력
-- 단, SALESMAN은 제외하고 급여 합계가 높은 순으로 정렬
SELECT job, sum(sal) sum
FROM emp
WHERE job <> 'SALESMAN'
GROUP BY job
HAVING sum(sal) > 5000
ORDER BY sum(sal) desc;

-- 업무별 최고 급여와 최소 급여의 차이를 구하라
SELECT job, max(sal)-min(sal) sub_sal
FROM emp
GROUP BY job;

-- 부서 인원이 4명 보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력
SELECT deptno,count(*) count, sum(sal) sum
FROM emp
GROUP BY deptno
HAVING count(*)>=4;


