SELECT * FROM EMP_CP;
-- [����1] �Ʒ��� employee ���̺��� ��� ����Դϴ�.
-- �޿��� 2000 �̻� 3000 ������ ����� �̸��� �����ȣ, �Ի���, �޿��� ����ϵ� �̸���  �������� �����ϼ���.
SELECT ename, eno, hiredate, salary
FROM employee
WHERE sal between 2000 and 3000
ORDER BY ename;

-- [����2] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
-- Ŀ�̼��� NULL �� ����̸���, �Ի��� �μ���ȣ�� ����ϵ� �μ���ȣ�� �������� �����ϵ� 
-- �μ���ȣ�� ���� �׸��� ���� ��� �̸��� ������������ �����ϼ���.
SELECT ename, hiredate, dno
FROM employee
WHERE commission is null
ORDER BY dno, ename;


--[����3] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    Ŀ�̼��� 300 �̰ų� 500 �̰ų� 1400�� ����� �����ȣ�� �̸�, ����, Ŀ�̼��� ��� �ϵ� Ŀ�̼��� �������� �����ϼ���.
--    IN �����ڸ� ����ؼ� ��� �ϼ���.
SELECT eno, ename, salary, commission
FROM employee
WHERE commission IN (300, 500, 1400)
ORDER BY commission desc;

--[����4] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    �̸��� ù ���ڰ� ��S���� �����ϴ� ����� �̸��� ����ϼ���.
SELECT ename
FROM employee
WHERE ename like 'S%';

--[����5] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--LIKE �����ڿ� ���ϵ� ī�带 ����ؼ� '81'�⵵�� �Ի����� ���� ����� �̸��� �Ի����� ����ϼ���.
SELECT ename, hiredate
FROM employee
WHERE hiredate LIKE '81%';

--[����6] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    �μ� ��ȣ�� �ߺ� ������ ������������ �����ؼ� ����ϼ���.
SELECT DISTINCT dno
FROM employee
ORDER BY dno;


--[����7] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--   �̸��� ��A��  �� ��E�� �� ��� �����ϴ� ����� �̸��� ����ϼ���.
SELECT ename
FROM employee
WHERE ename like '%A%' and ename like '%E%';


--[����8] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    substr �Լ��� ����ؼ� 12�� �޿� �Ի��� ����� �����ȣ, �̸�, �Ի����� ����ϼ���.
SELECT eno, ename, hiredate
FROM employee
WHERE substr(hiredate, 4 ,2) = '12';

--[����9] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    NVL �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.
SELECT ename, salary, commission, nvl(salary,0) * 12 year_salary
FROM employee
ORDER BY year_salary desc;

--[����10] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    NVL2 �Լ��� ����ؼ� ����� ������ ����ؼ� ����̸�, ����, Ŀ�̼� , ������ ����ϵ� ������ ���� ������� ����ϼ���.
SELECT ename, salary, commission, nvl2(salary ,salary, 0) * 12 year_salary
FROM employee
ORDER BY year_salary desc;


--[����11] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--������� �޿� �Ѿ� , ��վ�, �ְ��, �ּҾ��� ��� �ϼ���. 
-- �� �÷��� ���޿��Ѿס�, ����վ�, ���ְ�ס�, ���ּҾס����� ��Ī�̸����� ����ϼ���.
SELECT sum(salary) �޿��Ѿ�, avg(salary) ��վ�, max(salary) �ְ��, min(salary) �ּҾ�
FROM employee
GROUP BY ename;

--[����12] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    ���� ������ ������ ��� �ϼ���.  ����÷��� ������ ������ �������� ��Ī�̸����� ��� �ϼ���.
SELECT count( distinct job ) ����_������_����
FROM emp;


--[����13] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--   �� �μ��� ��� ������ ���ؼ� �μ���ȣ�� ��� ������ ��� �ϵ�  
--  ���� ���μ���ȣ��, ����տ��ޡ� ���� ��Ī�̸����� ����ϼ���.
SELECT dno �μ���ȣ, avg(salary) ��տ���
FROM employee
GROUP BY dno;


--[����14] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    ��� ������ ������ ����� ���� ���Ͻÿ�. (���� , count �Լ� ���)
SELECT count(*) �����_��
FROM employee
GROUP BY job;


--[����15] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--   ���޺� ����� ���� �޿��� ����Ͻÿ�, �����ڸ� �˼� ���� ��� �� ���� �޿��� 2000 �̸��� �׷��� ���� ��Ű��
--    ����� �޿��� ���� ������������ �����Ͽ� ��� �ϼ���.
SELECT min(salary) �����޿�
FROM employee
WHERE manager is not null
GROUP BY job
HAVING min(salary) >= 2000 
ORDER BY min(salary) desc;

--[����16] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    ���� ������ ����ؼ� �����ȣ�� 7788�� ����� �������� ���� ����� ��� �Ͻÿ�  <����̸�, ������> ��� �Ͻÿ�
SELECT ename, job
FROM employee
WHERE (manager, job) IN (SELECT eno, job FROM employee WHERE eno=7788);

SELECT ename, job
FROM emp
WHERE (mgr, job) IN (SELECT empno, job FROM emp WHERE empno=7788);


--[����17] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    ���� ������ ����ؼ� �������� 7499 �� ������� �޿��� ���� ����� ��� �Ͻÿ�. <����̸�, ������> ��� �Ͻÿ�.
SELECT ename, job
FROM employee
WHERE salary >= ALL (SELECT salary FROM employee WHERE eno=7499);

--[����18] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--    ���� ������ ����ؼ� �� �μ��� �ּ� �޿��� �޴� ����� �̸� , �޿�, �μ���ȣ�� ����Ͻÿ�.
SELECT e.ename ename, e.salary salary, e.dno dno
FROM employee e, ( SELECT min(salary) min FROM employee GROUP BY dno )s
WHERE salary = s.min;

--[����19] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
 --   ���� ������ ����ؼ� �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ������������ �����Ͻÿ�.
SELECT e.eno eno, e.ename ename, e.salary
FROM employee e
WHERE e.salary >= ( SELECT avg(salary) avg FROM employee )
ORDER BY salary ;


--[����20] �� 1�� ������ employee ���̺��� ��� ����� �����Ͽ� �Ʒ� ������ �������� �ۼ��ϼ���.
--   ���� ������ ����ؼ� DEPT ���̺� �ִ� �μ��� DNAME �÷�����  
-- ��RESEARCH�� �μ��� �μ���ȣ, ����̸� �� ��� ������ ǥ���Ͻÿ�.
SELECT e.dno dno, e.ename ename, e.job job
FROM employee e, (SELECT dname FROM dept ) d
WHERE d.dname = 'RESEARCH';