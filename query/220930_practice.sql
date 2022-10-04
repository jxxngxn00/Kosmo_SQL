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
 ADD CONSTRAINT ck_sawon_ubmu CHECK ( ubmu in ('개발','유지보수', '관리'));
--6
ALTER TABLE sawon MODIFY (ubmu varchar2(30) DEFAULT '개발');
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
INSERT INTO buseo(buseo_no, buseo_name) VALUES (101,'소프트웨어유지보수부');
INSERT INTO buseo(buseo_no, buseo_name) VALUES (202,'관리부');
INSERT INTO buseo(buseo_no, buseo_name) VALUES (303,'인적자원부');
--10
INSERT INTO sawon(sabun, sawon_name, weolgub, buseo, jiyeok)
 VALUES(8001,'홍길동이군',100000,101,'부산');

INSERT INTO sawon(sabun, sawon_name, ubmu, weolgub, buseo, jiyeok)
 VALUES(8002,'홍길자','사무',200000,202,'인천'); -- ubmu 조건제약 (check)

INSERT INTO sawon(sabun, sawon_name, ubmu, buseo, jiyeok)
 VALUES(8003,'홍길순','개발',111,'대전'); -- buseo 테이블에 없는 내용

INSERT INTO sawon(sabun, sawon_name, weolgub, jiyeok)
 VALUES(8004,'홍길석',12345678,'서울'); -- 지정된 weolgub의 크기보다 큰 값

INSERT INTO sawon(sabun, sawon_name, ubmu, buseo, jiyeok)
 VALUES(8005,'홍길철','유지보수',303,'판교');
--11
ALTER TABLE sawon DROP (jiyeok);
--12 : ORA-02292: integrity constraint (SCOTT.FK_SAWON_BUSEO) violated - child record found
-- 자식레코드가 생성됨 - 참조키로 연결되어있기 때문에
DELETE FROM buseo WHERE buseo_name = '인적자원부';
--13
DELETE FROM sawon;
--14
CREATE TABLE sawon
(
    sabun number(6),
    sawon_name VARCHAR2(15),
    ubmu varchar2(30) DEFAULT '개발',
    weolgub number(7),
    buseo number(3),
    jiyeok varchar2(30) NOT NULL,
    CONSTRAINT pk_sawon_sabun PRIMARY KEY (sabun),
    CONSTRAINT ck_sawon_ubmu CHECK (ubmu IN ('개발','유지보수','관리')),
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



