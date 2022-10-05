--1
SELECT empno, job, sal, sal*1.15 New_Salary, sal*0.15 Increase
FROM emp;
--2
SELECT ename, hiredate, NEXT_DAY(hiredate,2) Next_Monday
FROM emp;
--3
SELECT ename, hiredate, to_char(sysdate,'YYYY')-to_char(hiredate,'YYYY') year, sal,
    sal*floor(MONTHS_BETWEEN(sysdate,hiredate)) sum_sal
FROM emp;
--4
SELECT ename, job, hiredate, to_char(hiredate, 'Day') day
FROM emp;
--5
SELECT job, SUM(sal) sum_sal, count(*) count
FROM emp
HAVING deptno <> 10 and (job = 'SALESMAN' or job = 'MANAGER')
GROUP BY job, deptno;
--6
SELECT avg(sal) avg, max(sal) max
FROM emp
GROUP BY job
HAVING avg(sal)>=2000
ORDER BY avg(sal) desc;
--7
SELECT to_char(hiredate,'YYYY') year, count(*) count
FROM emp
GROUP BY to_char(hiredate, 'YYYY');
--8
SELECT ceil(rownum/5) row5, sum(sal) sum, count(*) count
FROM emp
GROUP BY ceil(rownum/5);
--9
SELECT count('CLERK') CLERK, count('SALESMAN') SALESMAN, count('MANAGER') MANAGER
FROM emp;
-- 10 ����
SELECT emp.job ������
FROM (
    SELECT deptno, sum(sal) sum
    FROM emp
    GROUP BY deptno )
GROUP BY emp.job;

-- ������̺�(emp)�� ������ �μ����̺�(dept)�� �� ����� �μ����� ���

-- ���� ���� : ���ʿ� ����Ǵ°� �� �������� ���ڵ� ���
SELECT e.ename ename, d.dname dname, d.deptno deptno -- ��Ī�ο� �߿�
FROM emp e, dept d
WHERE e.deptno=d.deptno;

-- ǥ�ؾ� : ����
SELECT e.ename ename, d.dname dname, d.deptno deptno -- ��Ī�ο� �߿�
FROM emp e INNER JOIN dept d
ON e.deptno=d.deptno;

-- �ܺ� ���� : ���ʿ� ��� �Ǵ� 
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e, dept d
WHERE e.deptno=d.deptno(+);

SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e, dept d
WHERE e.deptno(+)=d.deptno;

-- ���� : ���ʸ� + ���̱�
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e, dept d
WHERE e.deptno(+)=d.deptno(+);

-- ǥ�ؾ� : ����
SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno(+)=d.deptno;

SELECT e.ename ename, d.dname dname, d.deptno depto
FROM emp e RIGHT OUTER JOIN dept d
ON e.deptno = d.deptno;

SELECT e.ename ename, d.dname dname, d.deptno deptno
FROM emp e FULL OUTER JOIN dept d
ON e.deptno = d.deptno;

-- ������̺�(emp)�� �� ����� �Ŵ����� ��ȸ
SELECT  e1.empno , e1.ename, e1.mgr, e2.empno, e2.ename
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno;

-- �ܺ����� ǥ�ؾ�
SELECT  e1.empno empno , e1.ename ename, e1.mgr mgr, e2.empno mgrno, e2.ename mgrname
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.mgr=e2.empno;

SELECT  e1.empno empno , e1.ename ename, e1.mgr mgr, e2.empno mgrno, e2.ename mgrname
FROM emp e1, emp e2
WHERE e1.mgr=e2.empno(+);


-- [����]
SELECT empno, ename, job, deptno FROM emp WHERE job='CLERK'
    -- SMITH / ADAMS / JAMES / MILLER
    UNION ALL
SELECT empno, ename, job, deptno FROM emp WHERE deptno=10;
    -- CLARK / KING / MILLER
    
--1
SELECT e.empno empno, e.ename ename, e.job job, e.deptno deptno, d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno;
--2
SELECT e.empno empno, e.ename ename, e.sal sal, d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
WHERE e.job = 'SALESMAN';
--3
SELECT e.ename ename, d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
WHERE nvl(comm,0) <> 0;

--4
SELECT d.dname dname, SUM(e.sal) sumsal
FROM emp e RIGHT OUTER JOIN dept d
ON e.deptno = d.deptno
GROUP BY d.dname;


--5
SELECT e.empno empno, e.job job, d.dname dname, d.loc loc
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
WHERE e.job = 'MANAGER';

commit;



--1
SELECT �̸�
FROM student s LEFT OUTER JOIN enroll e
    ON s.�й� = e.�й�
    LEFT OUTER class c
    ON e.���¹�ȣ = c.���¹�ȣ
WHERE avg(e.����) >= 3.0;


--2





