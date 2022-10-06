-- 1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하십시오. 
-- Zlotkey 제외
SELECT first_name||' '||last_name name, hire_date
FROM employees e
WHERE e.department_id =
( SELECT department_id FROM employees WHERE last_name = 'Zlotkey' )
AND e.last_name <> 'Zlotkey';

-- 2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 
-- 결과를 급여에 대해 오름차순으로 정렬하십시오.
SELECT employee_id, e.first_name||' '||e.last_name name, salary
FROM employees e,( SELECT avg(salary) avg FROM employees ) s
WHERE e.salary >= s.avg
ORDER BY salary ;

--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 
-- 사원 번호와 이름을 표시하는 질의를 작성하십시오.
SELECT e.employee_id, e.first_name||' '||e.last_name name
FROM employees e
WHERE (e.department_id, first_name||' '||last_name)
      in ( SELECT department_id, first_name||' '||last_name FROM employees 
           WHERE first_name||' '||last_name like '%u%');

--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하십시오.
SELECT e.first_name||' '||e.last_name name, e.department_id, e.job_id
FROM employees e
WHERE e.department_id in ( SELECT e.department_id
       FROM employees e full outer join departments d 
       ON e.department_id = d.department_id
       WHERE d.location_id = 1700);

--5. King에게 보고하는 모든 사원의 이름과 급여를 표시하십시오.
SELECT e.first_name||' '||e.last_name name, salary
FROM employees e
WHERE manager_id 
    IN ( select employee_id from employees WHERE last_name = 'King' );


--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름 및 업무 ID를 표시하십시오.
SELECT e.department_id, e.first_name||' '||e.last_name name, job_id
FROM employees e
WHERE e.department_id
    IN ( select e.department_id 
         from employees e left outer join departments d
         on e.department_id = d.department_id
         WHERE d.department_name = 'Executive' );

--7. 평균 급여보다 많은 급여를 받고 이름에 u가 포함된 사원과 같은 부서에서 근무하는 
--모든 사원의 사원 번호, 이름 및 급여를 표시하는 질의를 작성하십시오.
SELECT e.employee_id, e.first_name||' '||e.last_name name, e.salary
FROM employees e,( SELECT avg(salary) avg FROM employees ) s
WHERE e.salary >= s.avg 
      and(e.department_id)
      in ( SELECT department_id FROM employees 
           WHERE first_name||' '||last_name like '%u%');
