--1. 이름의 성이 'King' 사원의 사번과 부서명을 출력 ( employees, departments )
SELECT e.employee_id employee_id, d.department_name dprtmnt_name
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.last_name = 'King';

--2. 이름의 성이 'King' 사원의 사번과 부서명 그리고 업무명을 출력 
--( employees, departments, jobs )
SELECT e.employee_id employee_id, d.department_name dprtmnt_name, j.job_title job_title
FROM jobs j, employees e, departments d
WHERE e.department_id = d.department_id(+)
    and e.job_id = j.job_id(+)
    and e.last_name = 'King';

--표준
SELECT e.employee_id employee_id, d.department_name dprtmnt_name, j.job_title job_title
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
    INNER JOIN jobs j
    ON e.job_id = j.job_id
WHERE e.last_name = 'King';


--3. 2007년 상반기에 입사한 사원들의 사번과 이름, 입사일 그리고 부서명을 출력
-- (*) Grant는 아직 부서가 배정받지 못한 상태이지만 Grant도 출력되려면
SELECT e.employee_id employee_id,(e.first_name)||' '||(e.last_name) name, d.department_name dprtmnt_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--4. 'Executive' 부서에서 사원과 해당 사원의 매니저(상사) 이름을 출력 - 미완성
-- (*) 매니저(상사)가 없는 사원인 'King'이 출력되려면
SELECT e1.first_name||' '||e1.last_name name, e2.first_name||' '||e2.last_name boss_name
FROM employees e1 LEFT OUTER JOIN departments d
ON e1.department_id = d.department_id
FULL OUTER JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE d.department_name like 'Executive';
commit;