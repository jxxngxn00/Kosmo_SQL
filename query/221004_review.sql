-- 1. 2003년에 입사한 사원들의 사번, 이름, 입사일을 출력
SELECT employee_id, (first_name||' '||last_name) name, hire_date
FROM employees
WHERE to_char(hire_date,'YYYY') = 2003;

-- 2. 업무가 FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP 인 사원들의 정보를 출력
SELECT *
FROM employees
WHERE lower(job_id) = 'fi_account' or lower(job_id) = 'ft_mgr' 
    or lower(job_id) = 'sa_man' or lower(job_id) = 'sa_rep';

-- IN 연산자 사용
SELECT *
FROM employees
WHERE lower(job_id) IN ('fi_account', 'ft_mgr', 'sa_man', 'sa_rep');

-- 3. 커미션을 받는 사원들의 명단을 출력
SELECT *
FROM employees
WHERE commission_pct is not null;

-- 4.업무가 SA_MAN 또는 SA_REP이면 "판매부서"를 그 외는 "그 외 부서"라고 출력
SELECT job_id,
CASE job_id
    WHEN 'SA_MAN' THEN '판매부서'
    WHEN 'SA_REP' THEN '판매부서'
    ELSE '그 외 부서'
    END as job
FROM employees;

--decode 사용
SELECT job_id,
decode(job_id,'SA_MAN','판매부서','SA_REP','판매부서','그외부서') dept_name
FROM employees;

-- 5. 연도별로 입사자들의 최소급여, 최대 급여, 급여의 총합 그리고 평균 급여를 구하시오
SELECT to_char(hire_date, 'YYYY') year, max(salary) min, max(salary) max, 
sum(salary) sum, avg(salary) avg
FROM employees
GROUP BY to_char(hire_date, 'YYYY');

-- 6. 부서별 평균 급여가 $10,000 이상인 부서만 구하시오. ( 평균급여가 높은 순으로 )
SELECT department_id, round(avg(salary),0) avg -- 평균 : 소수점 아래에서 반올림
FROM employees
GROUP BY department_id
HAVING avg(salary)>= 10000
ORDER BY avg(salary) desc;

-- 7. 부서별 최대 급여를 구하시오.
SELECT department_id, max(salary) max_salary
FROM employees
GROUP BY department_id;