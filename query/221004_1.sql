CREATE TABLE dept;
SELECT * FROM scott.dept;
DESC dept;

ALTER  TABLE   dept
ADD  CONSTRAINT  pk_dept_deptno  PRIMARY  KEY ( deptno );
--1
CREATE TABLE student(
    no char(4),
    name varchar2(30) not null,
    gender varchar2(10),
    addr long,
    jumin char(45) not null,
    deptno number(2),
    CONSTRAINT fk_student_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
    --CONSTRAINT ck_student_no CHECK ( length( trim(no) ) == 4 )
);
--2
ALTER TABLE student
ADD CONSTRAINT pk_student_no PRIMARY KEY (no);
--3
ALTER TABLE student
MODIFY (jumin varchar2(45) null);
DESC student;
--4
ALTER TABLE student
MODIFY (addr long DEFAULT '서울');
--5
ALTER TABLE student
ADD CONSTRAINT ck_student_gender CHECK ( gender in ('남성','여성'));
--6
INSERT INTO student(no, name, gender, addr, jumin ) 
VALUES('1111', '김태희', '여성', '서울시 강남구', '801212-1234567' );

INSERT INTO student(no, name, jumin ) 
VALUES('2222', '송혜교', '881212-1234567');


INSERT INTO student(no, name, jumin ) 
VALUES('1111', '강동원', '881212-1234567');    -- unipe constraint (학번 컬럼)


INSERT INTO student(no, name, gender, jumin ) 
VALUES('3333', '하정우', '남자', '830303-1234567'); -- 성별 컬럼 : check 에 없는 조건


INSERT INTO student(no, name, addr, jumin ) 
VALUES('4444', '김새론', '서울시 서초구', '990909-1234567');


INSERT INTO student(no, name, addr, deptno ) 
VALUES('8888', '이병헌', '서울시 한강', 50); -- 주민번호 null값

SELECT * from student;

--6
CREATE TABLE library (
 rent_id number(1),
 book_id varchar2 (5) NOT NULL,
 hakbun varchar2(4),
 CONSTRAINT pk_library_rentid PRIMARY KEY (rent_id),
 CONSTRAINT fk_library_hakbun FOREIGN KEY (hakbun) REFERENCES student (no)
);

--[확인]
INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 1, 'bk001', '1111' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 2, 'bk002', '2222' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 3, 'bk003', '3333' ); -- parent에 없는 레코드

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 4, 'bk004', '4444' );

INSERT INTO library ( rent_id, book_id, hakbun ) VALUES( 5, 'bk005', '5555' ); -- parent에 없는 레코드

SELECT * from library;


-- 테이블 생성 (CONSTAINT - X)
DROP TABLE DEPT;
DROP TABLE student;
DROP TABLE library;
DROP TABLE EMP;

CREATE TABLE DEPT(

DEPTID NUMBER(5)

, DEPTNAME VARCHAR(50)

, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);


CREATE TABLE EMP(

EMPID NUMBER(5) 

, NAME VARCHAR2(20) 

, RESID CHAR(14) 

, GENDER VARCHAR2(10) 

, AGE NUMBER(5) 

, DEPTID NUMBER(5) NOT NULL

, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)

, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)

, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))

, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) REFERENCES DEPT(DEPTID)

);


-- INSERT (TABLE: DEPT)

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10001, 'IT팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10002, '생산운영팀');

INSERT INTO DEPT(DEPTID, DEPTNAME)

VALUES (10003, '생산기술팀');

-- INSERT (TABLE: EMP)

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30001, '최가은', '881012-1187527', '여성', 32, 10001);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30002, '김효준', '850712-1000007', '남성', 35, 10002);

INSERT INTO EMP(EMPID, NAME, RESID, GENDER, AGE, DEPTID)

VALUES (30003, '서종균', '881112-1187527', '남성', 32, 10003);

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- TEST DML (DELETE)

DELETE FROM DEPT WHERE DEPTID = 10003;

-- DROP (BOTH)

DROP TABLE EMP;

DROP TABLE DEPT;

-- 테이블 생성 (CONSTAINT - O / FK - ON DELETE CASCADE / 테이블 레벨)

---------------------------------------------------------------------------------

CREATE TABLE DEPT(

DEPTID NUMBER(5)

, DEPTNAME VARCHAR(50)

, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);

CREATE TABLE EMP(

EMPID NUMBER(5) 

, NAME VARCHAR2(20) 

, RESID CHAR(14) 

, GENDER VARCHAR2(10) 

, AGE NUMBER(5) 

, DEPTID NUMBER(5) NOT NULL

, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)

, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)

, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))

, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 

REFERENCES DEPT(DEPTID) ON DELETE CASCADE
 -- ON DELETE CASCADE : foreign key와 연관된 레코드 모두 삭제 (실무에서는 잘 사용 X)
);
---------------------------------------------------------------------------------

-- 테이블 생성 (CONSTAINT - O / FK - ON DELETE SET NULL / 테이블 레벨)

---------------------------------------------------------------------------------

CREATE TABLE DEPT(

DEPTID NUMBER(5)

, DEPTNAME VARCHAR(50)

, CONSTRAINT PK_DEPT_DEPTID PRIMARY KEY(DEPTID)

);


CREATE TABLE EMP(

EMPID NUMBER(5) 

, NAME VARCHAR2(20) 

, RESID CHAR(14) 

, GENDER VARCHAR2(10) 

, AGE NUMBER(5) 

, DEPTID NUMBER(5) 

, CONSTRAINT PK_EMP_EMPID PRIMARY KEY (EMPID)

, CONSTRAINT UK_EMP_RESID UNIQUE (RESID)

, CONSTRAINT EMP_CK_GENDER CHECK (GENDER IN ('남성', '여성'))

, CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTID) 

REFERENCES DEPT(DEPTID) ON DELETE SET NULL

);

---------------------------------------------------------------------------------
commit;
?