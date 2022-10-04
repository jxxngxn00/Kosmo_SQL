-- �������

/*
�̸�      name     varchar2(10)
�ֹι�ȣ   jumin    char(15)
��ȭ��ȣ   tel      varchar2(20)
����      gender   varchar2(10)
����      age      number(3)
�����     home    varchar2(20)
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

-- ���̺� ����Ȯ��
DESC info_tab;

-- ������ Ȯ��
SELECT * From info_tab;

/* ���̺�� : student_score
�й�   id     char(4)
�л��� name    varchar2(20)
����  kor     number(3)
����  eng     number(3)     
����  total   number
���  avg     number(5,2)     -- ���ڸ��� ��ü �ڸ���
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

-- ���� �÷��� �߰�
-- ALTER TABLE table_name ADD ( [ column_name data_type ] );

ALTER TABLE student_score 
    ADD ( math number(3) );

-- ���� �÷� �����ϱ�
ALTER TABLE student_score DROP ( total );

-- ��� �÷����� �Ҽ��� 1�ڸ��� ����
ALTER TABLE student_score MODIFY ( avg number(4,1) );

-- ����Ÿ �Է�
-- ���� : ''
INSERT INTO student_score( id, name, kor, eng )
    VALUES ( '0001','ȫ�浿',50,80 );

SELECT * From student_score;

-- 2000�� �й��� ȫ������ ����� ���� ������ ���� 60, 90������ ����
INSERT INTO student_score( id, name, kor, eng )
    VALUES ( '2000','ȫ����',60,90 );

SELECT * FROM student_score;

-- 1000�� �л� ȫ��� ������ ����
INSERT INTO student_score (id,name) VALUES (1000,'ȫ���');

-- �̸��� ��ȫ����� �л��� ���ڵ帣 ����
DELETE FROM student_score WHERE name = 'ȫ���';

-- 0001�� �л��� ���� ������ 100������ ����

UPDATE student_score SET kor=100 WHERE id='0001';

-- ȫ������ ���������� 90������ �Է� ( -> ���� )
UPDATE student_score SET math=90 WHERE name='ȫ����';

-- �л����� ��� ���ϱ�
UPDATE student_score 
SET avg= (kor+eng+ nvl(math, 0))/3;
-- WHERE �� ���� ��� : ��� ���ڵ带 ������� ��


CREATE TABLE emp_copy AS SELECT * FROM emp;
DESC emp_copy;

SELECT * FROM emp_copy;

/*
    [ �������� ] emp ��ü emp_copy ���纻 ���̺� ���� ��
    1. �����ȣ�� 7788�� ����� �μ��� 10������ ����
    2. �����ȣ�� 7782�� ����� �̸��� ȫ������� �����ϰ� �޿��� 3500���� ����
    3. ��� �μ����� ���ʽ��� 300�� �λ� ����
    4. �����ȣ�� 7499�� ����� ������ ����
    5. �Ի����ڰ� 81�� 6�� 1�� ������ ����� ������ ����
*/
UPDATE emp_copy SET deptno=10 WHERE empno = 7788;
UPDATE emp_copy SET ename='ȫ���', sal=3500 WHERE empno = 7782;

UPDATE emp_copy SET comm= nvl(comm,0)+300;

DELETE FROM emp_copy WHERE empno=7499;
DELETE FROM emp_copy WHERE hiredate<'1981-06-01';

commit;
rollback;

truncate table emp_copy;
