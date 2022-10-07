CREATE OR REPLACE VIEW v_emp  AS
    select empno, ename, deptno from emp;

DESC v_emp;

INSERT INTO v_emp VALUES (1000, '홍길동', 20); -- 가상테이블에 입력해도 원본테이블에 입력 됨
SELECT * FROM v_emp;
SELECT * FROM emp;

INSERT INTO v_emp VALUES (1000, '홍홍이', 20); -- 원본의 제약조건(pk)을 따름. (오류)
INSERT INTO v_emp VALUES (2000, '홍홍이', 90); -- 원본의 제약조건(fk)을 따름. (오류)

CREATE OR REPLACE VIEW v_emp  AS
select empno, ename, deptno from emp
WITH READ ONLY; -- 읽기 전용 : 원본 테이블의 훼손을 막음

INSERT INTO v_emp VALUES (2000, '홍홍이', 30); -- 읽기 전용 뷰이기 때문에 입력 불가능 (오류)


--  [ 연습 ] EMP 테이블에서 30번 부서만 
-- EMPNO를 EMP_NO로 ENAME을 NAME로 SAL를 SALARY로 바꿔서 
-- EMP_30 뷰를 생성하시오
CREATE OR REPLACE VIEW v_emp_30 AS
SELECT empno EMP_NO, ename name, sal salary from emp where deptno=30
with read only;

SELECT * FROM v_emp_30;


-- 복합뷰
Create or replace view v_emp_info as
select e.empno empno, e.ename ename, d.dname dname 
from emp e, dept d
where e.deptno=d.deptno;

SELECT * FROM v_emp_info;

-- 오류 : 나눠져서 입력되진 않음
INSERT INTO v_emp_info (EMPNO, ENAME, DNAME) VALUES (3333,'맹꽁이',30);
-- 한 테이블에만 입력하는 건 가능
INSERT INTO v_emp_info (EMPNO, ENAME) VALUES (3333,'맹꽁이');
DELETE FROM v_emp_info WHERE empno =7788; -- 읽기 훼손 가능 : READ ONLY로 만들기

-- [ 연습 ] 부서별로 부서명, 최소급여, 최대 급여, 
--  부서의 평균 급여를 포함하는 V_DEPT_SUM 뷰를 생성하여라.
Create or replace view v_dept_sum as
select d.dname dname , min(e.sal) min, max(e.sal) max, round(avg(e.sal),2) avg
from emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno
GROUP BY e.deptno, d.dname
WITH READ ONLY;

SELECT * FROM v_dept_sum;

INSERT INTO emp (empno, ename, sal, deptno) VALUES (4444, '호이', 9900, 20 );

