-- ȸ�� ���̺�
create table ex_member(
id varchar2(10), -- ���̵� (pk)
pass varchar2(10), -- �н�����
name varchar2(20), -- �̸�
tel varchar2(20), -- ��ȭ��ȣ
addr varchar2(100) -- �ּ�
);

-- ��ǰ ���̺�
create table ex_good(
gno varchar2(10), -- ��ǰ��ȣ (pk)
gname varchar(30), -- ��ǰ��
gdetail varchar2(300), -- �󼼼���
price number); -- ����

-- �ֹ� ���̺�
create table ex_order (
ono number, -- ��ȣ (pk)
orderno varchar2(20), -- �ֹ���ȣ
gno varchar2(10), -- ��ǰ��ȣ (fk)
id varchar2(10), -- ȸ�� ���̵� (fk)
count number, -- ����
status varchar2(10) -- ��ۻ���
);

commit;

-- ######################################################

-- �ֹ����̺�� ȸ�����̺�, ��ǰ���̺��� ���踦 �δ´ٸ�?
-- pk ���� �� fk ����

ALTER TABLE ex_member
ADD CONSTRAINT pk_exmember_id PRIMARY KEY (id);

ALTER TABLE ex_good
ADD CONSTRAINT pk_exgood_gno PRIMARY KEY (gno);

ALTER TABLE ex_order
ADD CONSTRAINT pk_exorder_orderno PRIMARY KEY (ono);

SELECT * FROM ex_member;

ALTER TABLE ex_order
ADD CONSTRAINT fk_exorder_id FOREIGN KEY (id) REFERENCES ex_member (id);

ALTER TABLE ex_order
ADD CONSTRAINT fk_exorder_gno FOREIGN KEY (gno) REFERENCES ex_good (gno);

-- ȸ�� ���̺� ����Ÿ �Է�

insert into ex_member(id, pass, name, tel, addr )
values('kim', '1111', '��浿', '02-222-2222','���� ������ �̻۵�');

insert into ex_member(id, pass, name, tel, addr )
values('park', '1111', '�ڱ浿', '03-333-3333','��õ ������ �̻۵�');

insert into ex_member(id, pass, name, tel, addr )
values('meng', '1111', '�ͱ浿', '04-444-4444','��� ������ �̻۵�');

commit;

-- ���� ���̺� ����Ÿ �Է�

insert into ex_good( gno, gname, gdetail, price )
values('1001', '�Ӹ���', '���� ��� �Ӹ���', 200 );

insert into ex_good( gno, gname, gdetail, price )
values('2002', '������-A', '������� ������ �޸��� ������', 10000 );

insert into ex_good( gno, gname, gdetail, price )
values('2010', '������-B', '���� ������� ������ �����ϰ� �޸��ٴ� ������', 20000 );

insert into ex_good( gno, gname, gdetail, price )
values('3333', '�ڵ������̽�', '�ΰ� �����ϴ� �ڵ��� ���̽�', 1500 );

commit;

-- �ֹ� ���̺� ����Ÿ �˻�

insert into ex_order( ono, orderno, gno, id, count, status )
values( 1, '20161212', '1001', 'park', 1, '��ۿϷ�'); -- ���� �ʰ�

insert into ex_order( ono, orderno, gno, id, count, status )
values( 2, '20161212', '2010', 'park', 1, '�����');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 3, '20161111', '1001', 'kim', 2, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 4, '20161111', '3333', 'kim', 3, '�ֹ�'); 

insert into ex_order( ono, orderno, gno, id, count, status )
values( 5, '20163333', '1001', 'park', 3, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 6, '20163333', '2010', 'park', 1, '�����');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 7, '20163333', '2002', 'park', 2, '�ֹ�');

insert into ex_order( ono, orderno, gno, id, count, status )
values( 8, '20165050', '1001', 'meng', 1, '�����');

commit;

select * from ex_good;
select * from ex_member;
select * from ex_order;

drop TABLE ex_order;
-- ###############################################################

--[ ���� ]
--1. ������� ��ǰ�� ���� ������ ���
SELECT *
FROM ex_good g, ( SELECT gno, status FROM ex_order WHERE status = '�����' ) o
WHERE g.gno = o.gno;

--2. �ֹ� ���� ��ǰ ������ �� ���� ���
SELECT g.*, m.*
FROM ex_order o,ex_good g, ex_member m 
WHERE o.gno = g.gno 
    and o.id = m.id
    and status = '�ֹ�';

--3. �ֹ����� �� ����(���̵�)�� �ֹ��� ��ǰ�� �ѱݾ��� ���
SELECT o.id, sum(g.price * o.count) total
FROM ex_member m, ex_good g, ex_order o
WHERE o.id = m.id AND g.gno = o.gno
GROUP BY o.id, o.orderno;

-- [ �������� ]
--4. 3���� �ֹ� ������ ù���� ��ǰ�� �� �� ���� ���
-- [��] 20161212   �Ӹ��� �� 1�� 
SELECT ORDERNO, MIN(GNO) GNO, COUNT(ORDERNO) COUNT 
FROM EX_ORDER 
GROUP BY ORDERNO;

SELECT E.ORDERNO, G.GNAME ||' ��'||(E.COUNT-1)||'��' GOOD
FROM (SELECT ORDERNO, MIN(GNO) GNO, COUNT(ORDERNO) COUNT 
      FROM EX_ORDER GROUP BY ORDERNO) E, EX_GOOD G
WHERE E.GNO=G.GNO;