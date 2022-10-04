-- 1. 2003�⿡ �Ի��� ������� ���, �̸�, �Ի����� ���
SELECT employee_id, (first_name||' '||last_name) name, hire_date
FROM employees
WHERE to_char(hire_date,'YYYY') = 2003;

-- 2. ������ FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP �� ������� ������ ���
SELECT *
FROM employees
WHERE lower(job_id) = 'fi_account' or lower(job_id) = 'ft_mgr' 
    or lower(job_id) = 'sa_man' or lower(job_id) = 'sa_rep';

-- IN ������ ���
SELECT *
FROM employees
WHERE lower(job_id) IN ('fi_account', 'ft_mgr', 'sa_man', 'sa_rep');

-- 3. Ŀ�̼��� �޴� ������� ����� ���
SELECT *
FROM employees
WHERE commission_pct is not null;

-- 4.������ SA_MAN �Ǵ� SA_REP�̸� "�Ǹźμ�"�� �� �ܴ� "�� �� �μ�"��� ���
SELECT job_id,
CASE job_id
    WHEN 'SA_MAN' THEN '�Ǹźμ�'
    WHEN 'SA_REP' THEN '�Ǹźμ�'
    ELSE '�� �� �μ�'
    END as job
FROM employees;

--decode ���
SELECT job_id,
decode(job_id,'SA_MAN','�Ǹźμ�','SA_REP','�Ǹźμ�','�׿ܺμ�') dept_name
FROM employees;

-- 5. �������� �Ի��ڵ��� �ּұ޿�, �ִ� �޿�, �޿��� ���� �׸��� ��� �޿��� ���Ͻÿ�
SELECT to_char(hire_date, 'YYYY') year, max(salary) min, max(salary) max, 
sum(salary) sum, avg(salary) avg
FROM employees
GROUP BY to_char(hire_date, 'YYYY');

-- 6. �μ��� ��� �޿��� $10,000 �̻��� �μ��� ���Ͻÿ�. ( ��ձ޿��� ���� ������ )
SELECT department_id, round(avg(salary),0) avg -- ��� : �Ҽ��� �Ʒ����� �ݿø�
FROM employees
GROUP BY department_id
HAVING avg(salary)>= 10000
ORDER BY avg(salary) desc;

-- 7. �μ��� �ִ� �޿��� ���Ͻÿ�.
SELECT department_id, max(salary) max_salary
FROM employees
GROUP BY department_id;