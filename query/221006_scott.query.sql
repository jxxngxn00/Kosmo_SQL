-- ������ ���� ���� ����� ���� ��ȸ
SELECT ename, sal from emp
WHERE sal = (SELECT MAX(sal) FROM emp) ;

-- ��� �޿����� ���� �ִ� �޿����� ���� ������ �޴� ����� ������ ��ȸ
SELECT * FROM emp
WHERE sal >= (SELECT AVG(sal) FROM emp) 
      and sal < (SELECT MAX(sal) FROM emp) ;

SELECT e.*
FROM emp e,
    ( SELECT round(avg(sal)) avg, max(sal) max from emp ) ext -- �ϳ��� ���̺�� ����, �Ŀ� ����
WHERE e.sal > ext.avg AND e.sal < ext.max;

-- ���޼����� ���� 10���� ����� ���
SELECT e.*
FROM ( SELECT ename, sal FROM emp ORDER BY nvl(sal,0) desc ) e
WHERE ROWNUM <= 10;

-- ��������
-- 1. SCOTT�� �޿����� ���� ����� ������ �����ȣ, �̸�, ������, �޿��� ���
SELECT e.empno empno, e.ename ename, e.job job, e.sal sal
FROM emp e, ( SELECT * FROM emp WHERE ename = 'SCOTT') s
WHERE e.sal > s.sal;

-- 2. 30�� �μ��� �ּ� �޿����� ���μ��� �ּ� �޿��� ���� �μ��� ���
SELECT deptno, min(sal)
FROM emp  
GROUP BY deptno
HAVING min(sal) > (SELECT min(sal) min FROM emp WHERE deptno = 30);

-- 3. �������� ��� �޿� �߿��� ���� ���� �޿��� ���� ������ ���
SELECT s.job, round(min(s.avg),2) min_avg
FROM ( SELECT job, avg(sal) avg FROM emp GROUP BY job ORDER BY avg ) s 
WHERE ROWNUM = 1
GROUP BY s.job;

-- ������
SELECT job, avg(sal) min_avg
FROM emp
GROUP BY job
HAVING avg(sal) = ( SELECT min(avg(sal)) FROM emp GROUP BY job ) ;

-- 4. �����ȣ�� 7521�� ������ ���� ��� 7934�� �������� �޿��� ���� �޴� ����� ������ ���
SELECT e.*
FROM emp e, 
    ( SELECT job FROM emp WHERE empno = 7521 ) s1, 
    ( SELECT sal FROM emp WHERE empno = 7934 ) s2
WHERE e.job = s1.job AND e.sal > s2.sal;

-- 5. 'WARD'�� �μ��� ������ ���� ��� ��� ���
SELECT e.*
FROM emp e,
    ( SELECT * FROM emp WHERE ename = 'WARD' ) s
WHERE e.deptno = s.deptno AND e.job = s.job;

-- �������� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ������, �޿��� ���
SELECT empno, ename, job, sal
FROM emp
WHERE ( job, sal ) in ( SELECT job, min(sal) FROM emp GROUP BY job );

INSERT INTO emp(empno, ename, job, sal) VALUES (9999,'test','CLERK',1250);

-- 10�� �μ� ������� ������ ������ ������ �˻�
SELECT *
FROM emp
WHERE job in ( SELECT job FROM emp WHERE deptno = 10);

SELECT *
FROM emp
WHERE job = ANY ( SELECT job FROM emp WHERE deptno = 10);

-- ��� �Ѹ��� ������κ��� ���� ���� �� �ִ� ����� ������ �����ȣ, �̸�, ������ ���
-- ���(mgr)�� �ִ� ��� ���
SELECT empno, ename, job
FROM emp e1
WHERE EXISTS ( SELECT * FROM emp e2 WHERE e1.empno = e2.mgr );


-- ����� ���
-- ���(mgr)�� ���� ��� ���
SELECT empno, ename, job
FROM emp e1
WHERE NOT EXISTS ( SELECT * FROM emp e2 WHERE e1.empno = e2.mgr );










