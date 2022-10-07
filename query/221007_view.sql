CREATE OR REPLACE VIEW v_emp  AS
    select empno, ename, deptno from emp;

DESC v_emp;

INSERT INTO v_emp VALUES (1000, 'ȫ�浿', 20); -- �������̺� �Է��ص� �������̺� �Է� ��
SELECT * FROM v_emp;
SELECT * FROM emp;

INSERT INTO v_emp VALUES (1000, 'ȫȫ��', 20); -- ������ ��������(pk)�� ����. (����)
INSERT INTO v_emp VALUES (2000, 'ȫȫ��', 90); -- ������ ��������(fk)�� ����. (����)

CREATE OR REPLACE VIEW v_emp  AS
select empno, ename, deptno from emp
WITH READ ONLY; -- �б� ���� : ���� ���̺��� �Ѽ��� ����

INSERT INTO v_emp VALUES (2000, 'ȫȫ��', 30); -- �б� ���� ���̱� ������ �Է� �Ұ��� (����)


--  [ ���� ] EMP ���̺��� 30�� �μ��� 
-- EMPNO�� EMP_NO�� ENAME�� NAME�� SAL�� SALARY�� �ٲ㼭 
-- EMP_30 �並 �����Ͻÿ�
CREATE OR REPLACE VIEW v_emp_30 AS
SELECT empno EMP_NO, ename name, sal salary from emp where deptno=30
with read only;

SELECT * FROM v_emp_30;


-- ���պ�
Create or replace view v_emp_info as
select e.empno empno, e.ename ename, d.dname dname 
from emp e, dept d
where e.deptno=d.deptno;

SELECT * FROM v_emp_info;

-- ���� : �������� �Էµ��� ����
INSERT INTO v_emp_info (EMPNO, ENAME, DNAME) VALUES (3333,'�Ͳ���',30);
-- �� ���̺��� �Է��ϴ� �� ����
INSERT INTO v_emp_info (EMPNO, ENAME) VALUES (3333,'�Ͳ���');
DELETE FROM v_emp_info WHERE empno =7788; -- �б� �Ѽ� ���� : READ ONLY�� �����

-- [ ���� ] �μ����� �μ���, �ּұ޿�, �ִ� �޿�, 
--  �μ��� ��� �޿��� �����ϴ� V_DEPT_SUM �並 �����Ͽ���.
Create or replace view v_dept_sum as
select d.dname dname , min(e.sal) min, max(e.sal) max, round(avg(e.sal),2) avg
from emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
GROUP BY e.deptno, d.dname
WITH READ ONLY;

SELECT * FROM v_dept_sum;

INSERT INTO emp (empno, ename, sal, deptno) VALUES (4444, 'ȣ��', 9900, 20 );

