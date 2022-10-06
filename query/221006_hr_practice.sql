-- 1. Zlotkey�� ������ �μ��� ���� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�. 
-- Zlotkey ����
SELECT first_name||' '||last_name name, hire_date
FROM employees e
WHERE e.department_id =
( SELECT department_id FROM employees WHERE last_name = 'Zlotkey' )
AND e.last_name <> 'Zlotkey';

-- 2. �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� 
-- ����� �޿��� ���� ������������ �����Ͻʽÿ�.
SELECT employee_id, e.first_name||' '||e.last_name name, salary
FROM employees e,( SELECT avg(salary) avg FROM employees ) s
WHERE e.salary >= s.avg
ORDER BY salary ;

--3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� ��� ����� 
-- ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�.
SELECT e.employee_id, e.first_name||' '||e.last_name name
FROM employees e
WHERE (e.department_id, first_name||' '||last_name)
      in ( SELECT department_id, first_name||' '||last_name FROM employees 
           WHERE first_name||' '||last_name like '%u%');

--4. �μ� ��ġ ID�� 1700�� ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻʽÿ�.
SELECT e.first_name||' '||e.last_name name, e.department_id, e.job_id
FROM employees e
WHERE e.department_id in ( SELECT e.department_id
       FROM employees e full outer join departments d 
       ON e.department_id = d.department_id
       WHERE d.location_id = 1700);

--5. King���� �����ϴ� ��� ����� �̸��� �޿��� ǥ���Ͻʽÿ�.
SELECT e.first_name||' '||e.last_name name, salary
FROM employees e
WHERE manager_id 
    IN ( select employee_id from employees WHERE last_name = 'King' );


--6. Executive �μ��� ��� ����� ���� �μ� ��ȣ, �̸� �� ���� ID�� ǥ���Ͻʽÿ�.
SELECT e.department_id, e.first_name||' '||e.last_name name, job_id
FROM employees e
WHERE e.department_id
    IN ( select e.department_id 
         from employees e left outer join departments d
         on e.department_id = d.department_id
         WHERE d.department_name = 'Executive' );

--7. ��� �޿����� ���� �޿��� �ް� �̸��� u�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� 
--��� ����� ��� ��ȣ, �̸� �� �޿��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻʽÿ�.
SELECT e.employee_id, e.first_name||' '||e.last_name name, e.salary
FROM employees e,( SELECT avg(salary) avg FROM employees ) s
WHERE e.salary >= s.avg 
      and(e.department_id)
      in ( SELECT department_id FROM employees 
           WHERE first_name||' '||last_name like '%u%');
