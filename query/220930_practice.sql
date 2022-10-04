--1
CREATE TABLE sawon
(
    sabun number(6),
    sawon_name VARCHAR2(15),
    ubmu varchar2(30),
    weolgub number(10,2),
    buseo number(3)
);
--2
ALTER  TABLE   sawon
 ADD  CONSTRAINT  pk_sawon_sabun  PRIMARY  KEY ( sabun );
--3
ALTER  TABLE   sawon
 ADD  jiyeok varchar2(30) Not Null ;
--4
ALTER TABLE sawon MODIFY (weolgub number(7));
--5
ALTER TABLE sawon
 ADD CONSTRAINT ck_sawon_ubmu CHECK ( ubmu in ('����','��������', '����'));
--6
ALTER TABLE sawon MODIFY (ubmu varchar2(30) DEFAULT '����');
--7
CREATE TABLE buseo
(
    buseo_no number(3),
    buseo_name varchar2(30),
    CONSTRAINT pk_buseo_no PRIMARY KEY ( buseo_no )
);
--8
ALTER TABLE sawon
 ADD CONSTRAINT fk_sawon_buseo FOREIGN KEY (buseo) REFERENCES buseo (buseo_no);
--9 
INSERT INTO buseo(buseo_no, buseo_name) VALUES (101,'����Ʈ��������������');
INSERT INTO buseo(buseo_no, buseo_name) VALUES (202,'������');
INSERT INTO buseo(buseo_no, buseo_name) VALUES (303,'�����ڿ���');
--10
INSERT INTO sawon(sabun, sawon_name, weolgub, buseo, jiyeok)
 VALUES(8001,'ȫ�浿�̱�',100000,101,'�λ�');

INSERT INTO sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok)
 VALUES(8002,'ȫ����','�繫',200000,202,'��õ'); -- ubmu �������� (check)

INSERT INTO sawon(sabun, sawon_name, ubmu, buseo, jiyeok)
 VALUES(8003,'ȫ���','����',111,'����'); -- buseo ���̺� ���� ����

INSERT INTO sawon(sabun, sawon_name, weolgub, jiyeok)
 VALUES(8004,'ȫ�漮',12345678,'����'); -- ������ weolgub�� ũ�⺸�� ū ��

INSERT INTO sawon(sabun, sawon_name, ubmu, buseo, jiyeok)
 VALUES(8005,'ȫ��ö','��������',303,'�Ǳ�');
--11
ALTER TABLE sawon DROP (jiyeok);
--12 : ORA-02292: integrity constraint (SCOTT.FK_SAWON_BUSEO) violated - child record found
-- �ڽķ��ڵ尡 ������ - ����Ű�� ����Ǿ��ֱ� ������
DELETE FROM buseo WHERE buseo_name = '�����ڿ���';
--13
DELETE FROM sawon;
--14
CREATE TABLE sawon
(
    sabun number(6),
    sawon_name VARCHAR2(15),
    ubmu varchar2(30) DEFAULT '����',
    weolgub number(7),
    buseo number(3),
    jiyeok varchar2(30) NOT NULL,
    CONSTRAINT pk_sawon_sabun PRIMARY KEY (sabun),
    CONSTRAINT ck_sawon_ubmu CHECK (ubmu IN ('����','��������','����')),
    CONSTRAINT fk_buseo_no FOREIGN KEY (buseo) REFERENCES buseo (buseo_no)
);

CREATE TABLE buseo
(
    buseo_no number(3),
    buseo_name varchar2(30),
    CONSTRAINT pk_buseo_no PRIMARY KEY (buseo_no)
);

SELECT * FROM buseo;
SELECT * FROM sawon;
DROP TABLE sawon;
DROP TABLE buseo;

commit;



