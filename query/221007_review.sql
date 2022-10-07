-- 11. scott 또는 ward와 월급이 같은 사원의 정보를 이름, 업무, 급여를 출력
SELECT sal FROM emp WHERE lower(ename) = 'scott' or lower(ename) = 'ward';

SELECT ename, job, sal
FROM emp
WHERE sal IN ( 
    SELECT sal 
    FROM emp 
    WHERE lower(ename) = 'scott' or lower(ename) = 'ward');

-- ? 12. chicago에서 근무하는 사원과 같은 업무를 하는 사원의 이름, 업무를 출력
SELECT job FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'CHICAGO';

SELECT ename, job
FROM emp
WHERE job IN (
    SELECT job
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno
    WHERE d.loc = 'CHICAGO' );
    
-- 13. 부서별로 월급이 평균 월급보다 높은 사원을 부서번호, 이름, 급여를 출력
SELECT deptno, avg(sal) avg FROM emp GROUP BY deptno;

SELECT deptno, ename, sal
FROM emp e1
WHERE sal >= ANY ( SELECT avg(sal) FROM emp e2 WHERE e1.deptno = e2.deptno GROUP BY deptno );


SELECT deptno, ename, sal
FROM emp e1
WHERE sal > (SELECT AVG(sal) FROM emp e2 WHERE e1.deptno = e2.deptno)
ORDER BY deptno;


SELECT E1.DEPTNO, E1.ENAME, E1.SAL
FROM EMP E1,(SELECT DEPTNO, round(AVG(SAL),2) AVG FROM EMP GROUP BY DEPTNO) E
WHERE E1.DEPTNO=E.DEPTNO
      AND E1.SAL> E.AVG;