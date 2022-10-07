CREATE  SEQUENCE   sequence_name
            minvalue 1                  -- ������ �ּ� ����
            maxvalue 999999999999       -- ������ �ִ� ����
            increment by 1              -- ����ġ
            start with 1                -- ���ۼ���
            nocache                     -- cache�� ����ϸ� �̸� ���� �Ҵ��Ͽ� ���� ������ ����
            noorder                     -- ��û�Ǵ� ������� �� �Ҵ�
            nocycle  ;                  -- �ٽ� �������� ����
            
CREATE SEQUENCE seq_temp;
SELECT seq_temp.NEXTVAL FROM dual; -- ���� ������ ��
SELECT seq_temp.CURRVAL FROM dual; -- ���� ������ �� ( NEXTVAL�� ���� ������ CURRVAL�� �� �� ���� )

-- [����] 5000������ 10�� �����ϴ� �ڵ� ���� �� (������)
CREATE SEQUENCE seq_temp2
    START WITH 5000
    INCREMENT BY 10;

INSERT INTO emp(empno, ename) VALUES (seq_temp2.NEXTVAL, '�ھ�');

SELECT * FROM emp;
