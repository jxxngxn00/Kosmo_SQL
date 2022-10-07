CREATE  SEQUENCE   sequence_name
            minvalue 1                  -- 시퀀스 최소 숫자
            maxvalue 999999999999       -- 시퀀스 최대 숫자
            increment by 1              -- 증가치
            start with 1                -- 시작숫자
            nocache                     -- cache를 사용하면 미리 값을 할당하여 조금 빠르게 접근
            noorder                     -- 요청되는 순서대로 값 할당
            nocycle  ;                  -- 다시 시작할지 여부
            
CREATE SEQUENCE seq_temp;
SELECT seq_temp.NEXTVAL FROM dual; -- 다음 시퀀스 값
SELECT seq_temp.CURRVAL FROM dual; -- 현재 시퀀스 값 ( NEXTVAL을 하지 않으면 CURRVAL을 할 수 없음 )

-- [연습] 5000번부터 10씩 증가하는 자동 증가 수 (시퀀스)
CREATE SEQUENCE seq_temp2
    START WITH 5000
    INCREMENT BY 10;

INSERT INTO emp(empno, ename) VALUES (seq_temp2.NEXTVAL, '박씨');

SELECT * FROM emp;
