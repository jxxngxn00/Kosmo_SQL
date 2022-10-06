-- 월급이 가장 많은 사원의 정보 조회
SELECT ename, sal from emp
WHERE sal = (SELECT MAX(sal) FROM emp) ;

-- 평균 급여보다 높고 최대 급여보다 낮은 월급을 받는 사원의 정보를 조회
SELECT * FROM emp
WHERE sal >= (SELECT AVG(sal) FROM emp) 
      and sal < (SELECT MAX(sal) FROM emp) ;

SELECT e.*
FROM emp e,
    ( SELECT round(avg(sal)) avg, max(sal) max from emp ) ext -- 하나의 테이블로 간주, 후에 조인
WHERE e.sal > ext.avg AND e.sal < ext.max;

-- 월급순으로 상위 10명의 명단을 출력
SELECT e.*
FROM ( SELECT ename, sal FROM emp ORDER BY nvl(sal,0) desc ) e
WHERE ROWNUM <= 10;

-- 연습문제
-- 1. SCOTT의 급여보다 많은 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
SELECT e.empno empno, e.ename ename, e.job job, e.sal sal
FROM emp e, ( SELECT * FROM emp WHERE ename = 'SCOTT') s
WHERE e.sal > s.sal;

-- 2. 30번 부서의 최소 급여보다 각부서의 최소 급여가 높은 부서를 출력
SELECT deptno, min(sal)
FROM emp  
GROUP BY deptno
HAVING min(sal) > (SELECT min(sal) min FROM emp WHERE deptno = 30);

-- 3. 업무별로 평균 급여 중에서 가장 적은 급여를 가진 직업을 출력
SELECT s.job, round(min(s.avg),2) min_avg
FROM ( SELECT job, avg(sal) avg FROM emp GROUP BY job ORDER BY avg ) s 
WHERE ROWNUM = 1
GROUP BY s.job;

-- 선생님
SELECT job, avg(sal) min_avg
FROM emp
GROUP BY job
HAVING avg(sal) = ( SELECT min(avg(sal)) FROM emp GROUP BY job ) ;

-- 4. 사원번호가 7521의 업무와 같고 사번 7934인 직원보다 급여를 많이 받는 사원의 정보를 출력
SELECT e.*
FROM emp e, 
    ( SELECT job FROM emp WHERE empno = 7521 ) s1, 
    ( SELECT sal FROM emp WHERE empno = 7934 ) s2
WHERE e.job = s1.job AND e.sal > s2.sal;

-- 5. 'WARD'와 부서와 업무가 같은 사원 명단 출력
SELECT e.*
FROM emp e,
    ( SELECT * FROM emp WHERE ename = 'WARD' ) s
WHERE e.deptno = s.deptno AND e.job = s.job;

-- 업무별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 담당업무, 급여를 출력
SELECT empno, ename, job, sal
FROM emp
WHERE ( job, sal ) in ( SELECT job, min(sal) FROM emp GROUP BY job );

INSERT INTO emp(empno, ename, job, sal) VALUES (9999,'test','CLERK',1250);

-- 10번 부서 사원들의 업무와 동일한 직원들 검색
SELECT *
FROM emp
WHERE job in ( SELECT job FROM emp WHERE deptno = 10);

SELECT *
FROM emp
WHERE job = ANY ( SELECT job FROM emp WHERE deptno = 10);

-- 적어도 한명의 사원으로부터 보고를 받을 수 있는 사원의 정보를 사원번호, 이름, 업무를 출력
-- 상사(mgr)가 있는 사원 출력
SELECT empno, ename, job
FROM emp e1
WHERE EXISTS ( SELECT * FROM emp e2 WHERE e1.empno = e2.mgr );


-- 사원을 출력
-- 상사(mgr)가 없는 사원 출력
SELECT empno, ename, job
FROM emp e1
WHERE NOT EXISTS ( SELECT * FROM emp e2 WHERE e1.empno = e2.mgr );










