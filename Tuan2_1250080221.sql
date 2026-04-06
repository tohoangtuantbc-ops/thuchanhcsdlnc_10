--1
SELECT last_name, salary
FROM employees
WHERE salary > 12000;
--2
Select last_name, salary
from employees
where salary < 5000 or salary > 12000;
--3
SELECT last_name, job_id, hire_date
from employees
where hire_date BETWEEN TO_DATE ('20/02/2005', 'DD/MM/YYYY') and TO_DATE ('01/05/2005', 'DD/MM/YYYY')
order by hire_date ASC;
--4
SELECT last_name, department_id
from employees
WHERE department_id in (20, 50)
ORDER by last_name ASC;
--5
SELECT last_name, hire_date
from employees
where hire_date BETWEEN TO_DATE ('01/01/2005', 'DD/MM/YYYY') and TO_DATE ('31/12/2005', 'DD/MM/YYYY')
--6
SELECT last_name, job_id
from employees
where manager_id is NULL;
--7
SELECT last_name, salary, commission_pct
from employees
where commission_pct is NOT NULL
order by salary DESC, commission_pct DESC;
--8
select last_name
from employees
where last_name like '__a%';
--9
select last_name
from employees
where last_name like '%a%'
and last_name like '%e%';
--10
select last_name, job_id, salary
from employees
where job_id in ('SA_REP','ST_CLERK') and salary not in (2500,3500,7000);
--11
select employee_id, last_name, round (salary * 1.15,0) as "New Salary"
from employees;
--12
select initcap(last_name) as "Ten Nhan Vien",
       length(last_name) as "Chieu Dai"
from employees
where substr(last_name, 1,1) in ('J','A','L','M')
order by last_name asc;
--13
select last_name,
       trunc(months_between(sysdate, hire_date)) as "so thang lam viec"
from   employees
order by months_between(sysdate, hire_date) asc;
--14
select last_name || ' earns '
    || TO_CHAR(salary, '$99,999') || ' monthly but wants '
    || TO_CHAR(salary*3, '$99,999') AS "Dream Salaries"
FROM   employees;
--15
select last_name,
       CASE WHEN commission_pct IS NULL THEN 'No commission'
            ELSE TO_CHAR(commission_pct)
       END AS "Commission"
FROM   employees;
--16
select job_id,
    case job_id
        when 'ad_pres'  then 'A'
        when 'st_man'   then 'B'
        when 'it_prog'  then 'C'
        when 'sa_rep'   then 'D'
        when 'st_clerk' then 'E'
        else '0'
    end as "grade"
from employees;
--17
select e.last_name, e.department_id, d.department_name
from   employees e, departments d, locations l
where  e.department_id = d.department_id
  and  d.location_id   = l.location_id
  and  upper(l.city)   = 'TORONTO';
--18
select e.employee_id  as "Ma NV",
       e.last_name     as "Ten NV",
       m.employee_id  as "Ma Quan Ly",
       m.last_name     as "Ten Quan Ly"
from   employees e, employees m
where  e.manager_id = m.employee_id;
--19
select e1.last_name as "Nhan Vien 1",
       e2.last_name as "Nhan Vien 2",
       e1.department_id as "Phong Ban"
from   employees e1, employees e2
where  e1.department_id = e2.department_id
  and  e1.employee_id   < e2.employee_id
order by e1.department_id, e1.last_name;
--20
select last_name, hire_date
from   employees
where  hire_date > (select hire_date
                    from   employees
                    where  last_name = 'Davies');
--21
select e.last_name   as "Nhan Vien",
       e.hire_date   as "Ngay Vao",
       m.last_name   as "Quan Ly",
       m.hire_date   as "Quan Ly Vao"
from  employees e, employees m
where  e.manager_id = m.employee_id
  and  e.hire_date  < m.hire_date;
--22
select job_id,
       min(salary)  as "Luong Thap Nhat",
       max(salary)  as "Luong Cao Nhat",
       round(avg(salary),2) as "Luong Trung Binh",
       sum(salary)  as "Tong Luong"
from  employees
group by job_id
order by job_id;
--23
select d.department_id,
       d.department_name,
       count(e.employee_id) as "So Nhan Vien"
from   departments d left join employees e
       on d.department_id = e.department_id
group by d.department_id, d.department_name
order by d.department_id;
--b
SELECT COUNT(*) AS "Tong NV",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1995' THEN 1 ELSE 0 END) AS "Nam 1995",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1996' THEN 1 ELSE 0 END) AS "Nam 1996",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1997' THEN 1 ELSE 0 END) AS "Nam 1997",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1998' THEN 1 ELSE 0 END) AS "Nam 1998"
FROM   employees;
-- 25
select last_name, hire_date
from   employees
where  department_id = (select department_id
                        from   employees
                        where  last_name = 'Zlotkey')
  and  last_name <> 'Zlotkey';
-- 26
select last_name, department_id, job_id
from   employees
where  department_id in (select department_id
from   departments
where  location_id = 1700);
-- 27
select last_name, manager_id
from   employees
where  manager_id in (select employee_id
                      from   employees
                      where  last_name = 'King');
--28
select last_name, salary, department_id
from   employees
where  salary > (select avg(salary) from employees)
  and  department_id in (select department_id
                         from   employees
                         where  last_name like '%n');
--29
select department_id, department_name
from   departments d
where  (select count(*) from employees e
        where e.department_id = d.department_id) < 3
order by department_id;
--30
select department_id, count(*) as "So Nhan Vien", 'Dong nhat' as "Loai"
from employees
group by department_id
having count(*) = (select max(count(*)) from employees group by department_id)
union all
select department_id, count(*), 'It nhat'
from employees
group by department_id
having count(*) = (select min(count(*)) from employees group by department_id);
--31
select last_name, hire_date,
       to_char(hire_date,'Day') as "Thu trong tuan"
from employees
where to_char(hire_date,'Day') in (
    select to_char(hire_date,'Day')
    from employees
    group by to_char(hire_date,'Day')
    having count(*) = (
        select max(count(*))
        from   employees
        group by to_char(hire_date,'Day')
    )
);
--32
select last_name, salary
from (
    select last_name, salary
    from   employees
    order by salary desc
)
where rownum <= 3;
--33 
select e.last_name, e.department_id
from   employees    e,
       departments  d,
       locations    l
where  e.department_id = d.department_id
  and  d.location_id   = l.location_id
  and  upper(l.state_province) = 'CALIFORNIA';
--34
select employee_id, last_name from employees where employee_id = 103;
update employees
set    last_name = 'Drexler'
where  employee_id = 103;
commit;
select employee_id, last_name from employees where employee_id = 103;
--35
select e1.last_name, e1.salary, e1.department_id
from   employees e1
where  e1.salary < (select avg(e2.salary)
	from   employees e2
	where  e2.department_id = e1.department_id)
order by e1.department_id;
--36
select employee_id, last_name, salary
from   employees
where  salary < 900;
update employees
set    salary = salary + 100
where  salary < 900;
commit;
select employee_id, last_name, salary from employees
--37
-- dữ liệu thêm vào
INSERT INTO departments (department_id, department_name, manager_id, location_id)
VALUES (500, 'New Testing Dept', NULL, 1700);
INSERT INTO employees (employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (1023, 'Nguyen', 'NGUYEN99', SYSDATE, 'IT_PROG', 500);

select count(*) from employees where department_id = 500;
delete from departments where department_id = 500;
commit;
update employees set department_id = null where department_id = 500;
delete from departments where department_id = 500;
commit;
select * from employees where department_id = 500
-- 38
select department_id, department_name from departments
where  department_id not in (
    select distinct department_id from employees
    where  department_id is not null
);
delete from departments
where  department_id not in (
    select distinct department_id from employees
    where  department_id is not null
);
commit;
select * from departments