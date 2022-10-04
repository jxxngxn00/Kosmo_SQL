-- 8000�� ������� <�����̸�>�� �޿� 10000�� �����ϼ���
INSERT INTO emp ( empno, ename, sal ) VALUES ( 8000, 'ȫ����', 10000);

SELECT * FROM emp;

-- ������� ( key�� ��ħ, �浹 )
INSERT INTO emp ( empno, ename, sal ) VALUES ( 7788, 'ȫ����', 10000);

INSERT INTO emp ( empno, ename, sal, deptno ) VALUES ( 8001, 'ȫ�汹', 10000, 20);

-- ������� ( ���� key�� ���� ���� )
INSERT INTO emp ( empno, ename, sal, deptno ) VALUES ( 8002, 'ȫ�浿', 10000, 50);


------------------

INSERT INTO info_tab(tel, name, jumin, gender, age, home)
VALUES ('032','ȫ��','801212','����',33,'����');

SELECT * FROM info_tab;

INSERT INTO info_tab(tel, name) VALUES ('1001','ȫ�浿');
INSERT INTO info_tab(tel, name) VALUES ('1002','��浿');
INSERT INTO info_tab(tel, name) VALUES ('1002','�Ѹ�');
INSERT INTO info_tab(name, jumin) VALUES ('��浿','901212-1234567');
INSERT INTO info_tab(gender, age) VALUES ('����',22);

DELETE FROM info_tab;
commit;

ALTER TABLE info_tab
ADD CONSTRAINT pk_info_tel PRIMARY KEY ( tel );

DROP TABLE info_tab;
CREATE TABLE info_tab
(
    name varchar2(10),
    jumin char(15),
    tel      varchar2(20),
    gender   varchar2(10),
    age      number(3),
    home    varchar2(20),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel)
);

INSERT INTO info_tab(tel, name) VALUES ('1001','ȫ�浿');
INSERT INTO info_tab(tel, name) VALUES ('1002','��浿');
INSERT INTO info_tab(tel, name) VALUES ('1002','�Ѹ�'); -- primary key ���� ��ħ
INSERT INTO info_tab(name, jumin) VALUES ('��浿','901212-1234567'); -- primary key ���� ���� (tel �Է�X)
INSERT INTO info_tab(gender, age) VALUES ('����',22); -- primary key ����, �̸� �� null
INSERT INTO info_tab(tel,gender, age) VALUES ('9999','����',22);

 

ALTER TABLE info_tab ADD CONSTRAINT uq_info_jumin UNIQUE (jumin);


INSERT INTO info_tab(tel, name, jumin) VALUES ('20001','ȫ����','990101');
INSERT INTO info_tab(tel, name, jumin) VALUES ('20002','ȫ����','990101'); -- unique �ߺ����X
INSERT INTO info_tab(tel, name) VALUES ('20002','ȫȫ��'); -- unique null�� ���

ALTER TABLE info_tab
 ADD CONSTRAINT ck_info_gender CHECK ( gender in ('����','����')); -- CREATE �ȿ� �־ ��

INSERT INTO info_tab(tel,name,gender) VALUES ('10001','ȫ����','����');
INSERT INTO info_tab(tel,name,gender) VALUES ('30001','ȫ����','����'); -- CHECK�� ������ ���
INSERT INTO info_tab(tel,name,gender) VALUES ('30001','ȫ����','����');


ALTER TABLE info_tab
 MODIFY (gender varchar2(6) default '����');
 
INSERT INTO info_tab(tel, name) VALUES ('7777','ȫ��');
commit;

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('������', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('������','03-555-5555', '880808-1234567', '����', 27,'���');   -- gender ���� '����'�� �;���

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('ȫ�浿','03-031-0310', '900909-1234567', '����', 27,'���');

INSERT INTO info_tab( name, jumin) VALUES('ȫ����', '550505-1234567'); -- tel ���� (PRIMARY KEY)

INSERT INTO info_tab( tel, jumin ) VALUES('031-777-7777', '700707-1234567'); -- name ���� (NOT NULL)

INSERT INTO info_tab( name, tel, jumin ) VALUES('������', '031-000-0000', '700707-1234567');

commit;

CREATE TABLE info_tab
(
    name varchar2(10),
    jumin char(15),
    tel      varchar2(20),
    gender   varchar2(10),
    age      number(3),
    home    varchar2(20),
    deptno  number(2),
    CONSTRAINT pk_info_tel PRIMARY KEY (tel),
    CONSTRAINT uq_info_jumin UNIQUE (jumin),
    CONSTRAINT ck_info_jumin CHECK(gender IN ('����','����')),
    CONSTRAINT fk_info_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

INSERT INTO info_tab (tel, name, deptno) VALUES ('7777','����',20);
INSERT INTO info_tab (tel, name, deptno) VALUES ('8888','����',22); -- 22�� �μ��� DEPT�� deptno�� �������� ����
INSERT INTO info_tab (tel, name) VALUES ('9999','¯��');

commit;



------------------





























