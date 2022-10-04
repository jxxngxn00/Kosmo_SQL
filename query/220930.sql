-- 8000번 사원으로 <본인이름>과 급여 10000을 저장하세요
INSERT INTO emp ( empno, ename, sal ) VALUES ( 8000, '홍길자', 10000);

SELECT * FROM emp;

-- 실행오류 ( key가 겹침, 충돌 )
INSERT INTO emp ( empno, ename, sal ) VALUES ( 7788, '홍길자', 10000);

INSERT INTO emp ( empno, ename, sal, deptno ) VALUES ( 8001, '홍길국', 10000, 20);

-- 실행오류 ( 참조 key와 맞지 않음 )
INSERT INTO emp ( empno, ename, sal, deptno ) VALUES ( 8002, '홍길동', 10000, 50);


------------------

INSERT INTO info_tab(tel, name, jumin, gender, age, home)
VALUES ('032','홍자','801212','남자',33,'제주');

SELECT * FROM info_tab;

INSERT INTO info_tab(tel, name) VALUES ('1001','홍길동');
INSERT INTO info_tab(tel, name) VALUES ('1002','김길동');
INSERT INTO info_tab(tel, name) VALUES ('1002','둘리');
INSERT INTO info_tab(name, jumin) VALUES ('김길동','901212-1234567');
INSERT INTO info_tab(gender, age) VALUES ('남자',22);

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

INSERT INTO info_tab(tel, name) VALUES ('1001','홍길동');
INSERT INTO info_tab(tel, name) VALUES ('1002','김길동');
INSERT INTO info_tab(tel, name) VALUES ('1002','둘리'); -- primary key 값이 겹침
INSERT INTO info_tab(name, jumin) VALUES ('김길동','901212-1234567'); -- primary key 값이 없음 (tel 입력X)
INSERT INTO info_tab(gender, age) VALUES ('남자',22); -- primary key 없음, 이름 값 null
INSERT INTO info_tab(tel,gender, age) VALUES ('9999','남자',22);

 

ALTER TABLE info_tab ADD CONSTRAINT uq_info_jumin UNIQUE (jumin);


INSERT INTO info_tab(tel, name, jumin) VALUES ('20001','홍실이','990101');
INSERT INTO info_tab(tel, name, jumin) VALUES ('20002','홍동이','990101'); -- unique 중복허용X
INSERT INTO info_tab(tel, name) VALUES ('20002','홍홍이'); -- unique null값 허용

ALTER TABLE info_tab
 ADD CONSTRAINT ck_info_gender CHECK ( gender in ('남성','여성')); -- CREATE 안에 넣어도 됨

INSERT INTO info_tab(tel,name,gender) VALUES ('10001','홍돌이','남성');
INSERT INTO info_tab(tel,name,gender) VALUES ('30001','홍숙이','남자'); -- CHECK의 조건을 벗어남
INSERT INTO info_tab(tel,name,gender) VALUES ('30001','홍숙이','여성');


ALTER TABLE info_tab
 MODIFY (gender varchar2(6) default '남성');
 
INSERT INTO info_tab(tel, name) VALUES ('7777','홍이');
commit;

INSERT INTO info_tab( name, tel, jumin ) 
VALUES('갑순이', '02-777-4444', '990909-1234567');

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('갑갑이','03-555-5555', '880808-1234567', '남자', 27,'경기');   -- gender 에는 '남성'이 와야함

INSERT INTO info_tab( name, tel, jumin, gender, age, home )
VALUES('홍길동','03-031-0310', '900909-1234567', '남성', 27,'경기');

INSERT INTO info_tab( name, jumin) VALUES('홍길자', '550505-1234567'); -- tel 없음 (PRIMARY KEY)

INSERT INTO info_tab( tel, jumin ) VALUES('031-777-7777', '700707-1234567'); -- name 없음 (NOT NULL)

INSERT INTO info_tab( name, tel, jumin ) VALUES('갑동이', '031-000-0000', '700707-1234567');

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
    CONSTRAINT ck_info_jumin CHECK(gender IN ('남성','여성')),
    CONSTRAINT fk_info_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

INSERT INTO info_tab (tel, name, deptno) VALUES ('7777','맹이',20);
INSERT INTO info_tab (tel, name, deptno) VALUES ('8888','꽁이',22); -- 22번 부서가 DEPT의 deptno에 존재하지 않음
INSERT INTO info_tab (tel, name) VALUES ('9999','짱이');

commit;



------------------





























