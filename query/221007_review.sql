-- 11. scott �Ǵ� ward�� ������ ���� ����� ������ �̸�, ����, �޿��� ���
SELECT sal FROM emp WHERE lower(ename) = 'scott' or lower(ename) = 'ward';

SELECT ename, job, sal
FROM emp
WHERE sal IN ( 
    SELECT sal 
    FROM emp 
    WHERE lower(ename) = 'scott' or lower(ename) = 'ward');

-- ? 12. chicago���� �ٹ��ϴ� ����� ���� ������ �ϴ� ����� �̸�, ������ ���
SELECT job FROM emp e LEFT OUTER JOIN dept d ON e.deptno = d.deptno WHERE d.loc = 'CHICAGO';

SELECT ename, job
FROM emp
WHERE job IN (
    SELECT job
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno
    WHERE d.loc = 'CHICAGO' );
    
-- 13. �μ����� ������ ��� ���޺��� ���� ����� �μ���ȣ, �̸�, �޿��� ���
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