-- �����, �޿�, ���� (�޿�/12)�� ����ϵ� ������ �ʴ������� �ݿø��Ͽ� ���
SELECT ename, sal, round(sal/12, -2) as wolgeub
FROM emp;

SELECT ename, sal, trunc(sal * 0.033,-1) as tax -- ����/�Լ��� ����� ��� �ݵ�� ��Ī �ο�
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
ORDER BY ename ASC; -- ����


--4
SELECT * FROM emp
WHERE LENGTH(ename)>=5;
--5
SELECT RPAD(ename,15,'*') FROM emp;
--6
SELECT LPAD(sal,10,'-') FROM emp;
--7
SELECT '-' || trim(' �̼��� ') || '-' as col1, 
       '-' || ltrim(' �̼��� ') || '-' as col2, 
       '-' || rtrim(' �̼��� ') || '-' as col3 from dual;

SELECT sysdate FROM dual;
--8
SELECT sal, TRANSLATE(sal,'0123456789','�����̻�����ĥ�ȱ�') as kor_sal
FROM emp;
--9
SELECT sal, REPLACE(sal,0,'$') as char_sal
FROM emp;

-- ***** ���ʿ� �ִ� ������� ��� ����
SELECT REPLACE('     ��        ��       ��            ',' ','') as ename
FROM dual;


-- [ ��¥ ]
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
SELECT sysdate, NEXT_DAY(sysdate,'��') as next_monday FROM dual;

--6
SELECT sysdate, LAST_DAY(sysdate) last_day FROM dual;




-- �Ի����ڿ��� �Ի�⵵�� ���
SELECT ename, hiredate, to_char(hiredate, 'YYYY') hire_year
FROM emp;

-- �Ի����ڸ� ��1999�� 1�� 1�ϡ� �������� ���
SELECT hiredate, to_char(hiredate,'YYYY"��" MM"��" DD"��"') date_hiredate
FROM emp;

-- 1981�⵵�� �Ի��� ��� �˻�
SELECT * FROM emp
WHERE to_char(hiredate,'YYYY') = '1981';

-- 5���� �Ի��� ��� �˻�
SELECT * FROM emp
WHERE to_char(hiredate,'MM') = '05';

-- �޿� �տ� $�� �����ϰ� 3�ڸ� ���� ,�� ���
SELECT ename, sal, to_char(sal,'$999,999,999,999') dollar
FROM emp;


-- 81�� 2���� �Ի��� ��� �˻�
SELECT * from emp
WHERE to_char(hiredate,'YYYYMM') = 198102;

-- 81�⿡ �Ի����� ���� ��� �˻�
SELECT * from emp
WHERE to_char(hiredate,'YYYY') <> 1981;

-- 81�� �Ϲݱ⿡ �Ի��� ��� �˻�
SELECT * from emp
WHERE to_char(hiredate,'YYYY') = 1981 and to_char(hiredate,'MM')>6;

commit;

SELECT jumin, decode ( substr(jumin, 8, 1), '1', '����', '3', '����', '����') as gender
FROM info_tab;

-------------------
SELECT jumin, 
    CASE substr( jumin, 8, 1) 
        WHEN '1' THEN '����'
        WHEN '3' THEN '����'
        ELSE '����'
        END as gender
FROM info_tab;

SELECT deptno, 
    decode ( deptno, 10, '������', 20, '������', 30, 'IT��', '�����') as dept
FROM emp;

SELECT deptno, 
    CASE deptno
        WHEN 10 THEN '������'
        WHEN 20 THEN '������'
        WHEN 30 THEN 'IT��'
        ELSE '�����'
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
SELECT empno, ename, job, rownum FROM emp where rownum<=5; -- rownum : ���� �÷�, ��ȣ�� �ٿ���



SELECT AVG(sal) avg, SUM(sal) sum, min(sal) min, max(sal) max
FROM emp
WHERE job = 'SALESMAN';

INSERT INTO emp(empno, ename, job)
VALUES (9001, 'ȫ�汹', 'SALESMAN');


-- Ŀ�̼��� �޴� ����� ��
SELECT count(comm) count_comm
FROM emp
WHERE nvl(comm,0)!=0;


-----------------------
-- �μ����� �ο���, ��ձ޿�, �����޿�, �ְ�޿�, �޿��� ���� ���ϱ�
SELECT deptno, count(*) count, avg(sal) avg, min(sal) min, max(sal) max, sum(sal) sum
FROM emp
GROUP BY deptno;
--HAVING;

-- �μ����� �ο���, ��ձ޿�, �����޿�, �ְ�޿�, �޿��� ���� ���ϱ� ( �μ��� �޿��� ���� ���� ������
SELECT deptno, count(*) count, avg(sal) avg, min(sal) min, max(sal) max, sum(sal) sum
FROM emp
GROUP BY deptno
ORDER BY sum desc;

-- �μ��� ������ �׷��Ͽ� �μ���ȣ, ����, �ο���, �޿��� ���, �޿��� ���� ���ϱ�
SELECT deptno, job, count(*) count, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY deptno, job;

-- �ִ� �޿��� 2900 �̻��� �μ��� ���� �μ���ȣ, ��� �޿�, �޿��� ���� ���
SELECT deptno, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY deptno
HAVING max(sal) >= 2900;

-- ������ �޿��� ����� 3000�̻��� ������ ���� ������, ��� �޿�, �޿��� ���� ���
SELECT job, avg(sal) avg, sum(sal) sum
FROM emp
GROUP BY job
HAVING avg(sal) >= 3000;

-- ��ü �հ� �޿��� 5000�� �ʰ��ϴ� �� ������ ���ؼ� ������ �޿� �հ踦 ���
-- ��, SALESMAN�� �����ϰ� �޿� �հ谡 ���� ������ ����
SELECT job, sum(sal) sum
FROM emp
WHERE job <> 'SALESMAN'
GROUP BY job
HAVING sum(sal) > 5000
ORDER BY sum(sal) desc;

-- ������ �ְ� �޿��� �ּ� �޿��� ���̸� ���϶�
SELECT job, max(sal)-min(sal) sub_sal
FROM emp
GROUP BY job;

-- �μ� �ο��� 4�� ���� ���� �μ��� �μ���ȣ, �ο���, �޿��� ���� ���
SELECT deptno,count(*) count, sum(sal) sum
FROM emp
GROUP BY deptno
HAVING count(*)>=4;


