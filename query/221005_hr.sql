--1. �̸��� ���� 'King' ����� ����� �μ����� ��� ( employees, departments )
SELECT e.employee_id employee_id, d.department_name dprtmnt_name
FROM employees e LEFT OUTER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.last_name = 'King';

--2. �̸��� ���� 'King' ����� ����� �μ��� �׸��� �������� ��� 
--( employees, departments, jobs )
SELECT e.employee_id employee_id, d.department_name dprtmnt_name, j.job_title job_title
FROM jobs j, employees e, departments d
WHERE e.department_id = d.department_id(+)
    and e.job_id = j.job_id(+)
    and e.last_name = 'King';

--ǥ��
SELECT e.employee_id employee_id, d.department_name dprtmnt_name, j.job_title job_title
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
    INNER JOIN jobs j
    ON e.job_id = j.job_id
WHERE e.last_name = 'King';


--3. 2007�� ��ݱ⿡ �Ի��� ������� ����� �̸�, �Ի��� �׸��� �μ����� ���
-- (*) Grant�� ���� �μ��� �������� ���� ���������� Grant�� ��µǷ���
SELECT e.employee_id employee_id,(e.first_name)||' '||(e.last_name) name, d.department_name dprtmnt_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

--4. 'Executive' �μ����� ����� �ش� ����� �Ŵ���(���) �̸��� ��� - �̿ϼ�
-- (*) �Ŵ���(���)�� ���� ����� 'King'�� ��µǷ���
SELECT e1.first_name||' '||e1.last_name name, e2.first_name||' '||e2.last_name boss_name
FROM employees e1 LEFT OUTER JOIN departments d
ON e1.department_id = d.department_id
FULL OUTER JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE d.department_name like 'Executive';
commit;