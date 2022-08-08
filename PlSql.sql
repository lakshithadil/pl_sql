1.select first_name ||' '|| last_name as employee_name, salary 
  from employees;
  
2.select department_name 
  from departments
  where manager_id IS NULL;
  
3.select first_name||' '||last_name as employee_name
  from employees
  where department_id = 50 and
  salary between 2500 and 5000;
  
4.select job_title,min_salary,max_salary
  from jobs
  where job_title in('Programmer','Accountant'); 
  
5.select first_name
  from employees
  where first_name like 'A%';
  
6.select department_name
  from departments
  where department_name not like '%IT%';
  
7.select first_name||' '||last_name as employee_name,salary
  from employees
  where department_id = 50
  order by salary desc;
 
8.select max(salary) maximum_salary,min(salary) minimum_salary
  from employees
  where department_id = 50;
  
9.select department_id,count(*) as num_of_stock_clerk
  from employees
  where job_id ='ST_CLERK' and salary>3000
  group by department_id;
  
10.select department_id,avg(salary)
   from employees
   where department_id in(50,80)
   group by department_id;
   
11.select department_id,count(*) num_of_assigned_emp,sum(salary)
   from employees
   group by department_id
   having count(*)>10;
   
12.select first_name||' '||last_name employee_name
   from employees
   where department_id =  (select department_id
                           from departments
                           where department_name = 'Finance');
						   
13.select e.first_name||' '||e.last_name as employee,m.first_name||' '||m.last_name as manager
   from employees e,employees m
   where m.employee_id = e.manager_id;   
   
14.select first_name 
   from employees
   where salary < (select avg(salary)
                   from employees);
  
15.select first_name
   from employees
   where salary > (select max(salary)
                   from employees
				   where department_id = 80);

16.select *
   from employees
   where salary = (select max(salary)
                   from employees);	

17.select department_name
   from departments
   where manager_id is null; 

18.select first_name
   from employees
   where employee_id not in(select manager_id
                           from departments
			 where manager_id is not null); 

1.create table EMP as 
  (select employee_id,first_name,last_name
  from employees);
  
2.create table empty_emp as
  (select * 
  from employees
  where 1=2); 
  
3.drop table emp;

4.alter table employees add gender varchar2(20);

5.alter table employees drop column gender;

6.update employees
  set salary = salary +200
  where department_id = 80;
  
7.update employees
  set salary = salary +1000
  where department_id = (select department_id
                         from departments
						 where department_name = 'Sales') and
 salary < 8000; 

8.select lower(first_name),upper(last_name),initcap(email)
  from employees;
  
9.select concat('the',' place') as disc
  from dual;
  
10.select substr('hello sql',1,6) as sub_string
   from dual;
   
11.select length('hello sql') as str_len
   from dual;
   
12.select substr('hello sql',-3,3) as sub_string
   from dual;
   
13.select instr('hello sql','s')
   from dual;
   
14.select lpad('hello sql',13,'a')
   from dual;
   
15.select rpad('hello sql',13,'pls')
   from dual;
   
16.select trim('l' from 'hello sql')
   from dual;
   
17.select replace('hello sql','sql','pl/sql')
   from dual;

18.select round(23.45,1)
   from dual;
   
19.select trunc(23.45876,2)
   from dual;
   
20.select round(to_date('23-jun-2022'),'year')
   from dual;
   
21.select round(to_date('2022-08-03','yyyy-mm-dd'),'year')
   from dual;
   
22.select first_name,round((sysdate-hire_date)/365) as service_years
   from employees;
   
23.select first_name,round((sysdate-hire_date)/365) as service_years
   from employees
   where sysdate-hire_date = (select max(sysdate-hire_date)
                                     from employees);
									 
24.select nvl(null,'abc')
   from dual;
   
25.create table emptycp as 
               (select * from employees);
			 
26.select first_name,nvl(commis_pct,0)
   from emptycp
   where commis_pct is null;
   
27.select first_name,salary*nvl2(commis_pct,0.9,0.1) as allowance
   from emptycp
   where commis_pct is null;

28.	savepoint bd;

    update employees 
	set salary = 10000 
	where employee_id =100;
	
	rollback to bd;
    		   
29.select first_name,job_id,salary,
   case job_id
		when 'IT_PROG' then 1.1*salary
		when 'ST_CLERK' then 1.5*salary
		when  'SA_REP' then 1.2*salary
		else salary
   end as revised_salary
   from employees;
   
30.select first_name,job_id,salary,
   decode( job_id,
		'IT_PROG',1.1*salary,
		'ST_CLERK', 1.5*salary,
		'SA_REP',1.2*salary,
		salary)
   as revised_salary
   from employees;
   
31.create view v_emp as
   select first_name,last_name,employee_id
   from employees;
			   
32.select * from v_emp;

33.drop view v_emp;

34.create or replace view v_emp as 
   select first_name,last_name,employee_id,salary
   from employees;
   
35.create sequence seq_1
   increment by 1
   start with 1;
      
36.select seq_1.nextval from dual;	

37. select seq_1.nextval from employees;

38.create table emptt as 
        (select seq_1.nextval,employee_id,first_name,last_name
		from employees);
		
39.update emptt 
   set last_name = seq_1.nextval;
   
40.drop table emptt;

41.select seq_1.currval from dual;

42.Create table Dept01 AS 
	(select * from departments where 
	department_name='Construction’);
	
43.Create table Dept02 AS 
	(select * from departments where 
	manager_id IS NULL);

44. merge into dept01
	using dept02
	on (dept01.department_id=dept02.department_id)
	when matched then update set dept01.department_name=dept02.department_name,dept01.location_id=dept01.location_id
	when not matched then insert (department_id,department_name,location_id,manager_id) values (dept02.department_id,dept02.department_name,dept02.location_id,dept02.manager_id);
--------------------------------

--pl/sql

1.begin
	dbms_output.put_line('hello pl/sql');
end;

2.declare
	name varchar2(20);
  begin
    dbms_output.put_line('['|| 'hello' || ' &name' ||']');
  end;

3.  
    variable bind_variable varchar2(20);
	begin
	: bind_variable:='laki';
	dbms_output.put_line('['||:bind_variable||']');
	end;
	
4.declare 
  v_fname varchar2(20);
  v_emp_id number;
  
  begin
  v_emp_id := &employee_id;
  select first_name
  into v_fname
  from employees
  where employee_id = v_emp_id;
  dbms_output.put_line('employee id ' || v_emp_id || ' is ' || v_fname);
  end;
  
5.declare 
  v_fname employees.first_name%type;
  v_emp_id number;
  
  begin
  v_emp_id := &employee_id;
  select first_name
  into v_fname
  from employees
  where employee_id = v_emp_id;
  dbms_output.put_line('employee id ' || v_emp_id || ' is ' || v_fname);
  end;
  
6.declare 
  vrec_emp employees%rowtype;
  v_emp_id number;
  
  begin
  v_emp_id := &employee_id;
  select *
  into vrec_emp
  from employees
  where employee_id = v_emp_id;
  dbms_output.put_line('employee id ' || v_emp_id || ' is ' || vrec_emp.first_name);
  dbms_output.put_line(vrec_emp.last_name);
  end;

7.declare
  v_fname employees.first_name%type;
  v_service number;
  begin
  select first_name,round((sysdate-hire_date)/365) into v_fname,v_service
  from employees
  where sysdate-hire_date = (select max(sysdate-hire_date)
                             from employees) and
  department_id = 90;
  dbms_output.put_line(v_fname || ' ' || v_service);
  end;
  
8.declare
  v_fname employees%rowtype;
  begin
  dbms_output.put_line(sql%rowcount);
  select * 
  into v_fname
  from employees
  where employee_id =100;
  dbms_output.put_line(sql%rowcount);
  end;

9.declare
  v_fname employees%rowtype;
  begin
  
  select * 
  into v_fname
  from employees
  where employee_id =&employee_id;
  if sql%found then
  dbms_output.put_line('inside the if');
  else 
  dbms_output.put_line('in the else');
  end if;
  end;  
  
10.declare
   dis_number number;
   begin
   dis_number :=1;
   
   loop
   dbms_output.put_line(dis_number);
   dis_number := dis_number +1;
   exit when dis_number >10;
   end loop;
   
   end;
   
11./* declare
   x number;
   y number;
   begin
   
   y :=1;
   
   loop
   loop
   x :=1;
   dbms_output.put('*');
   x := x + 1;
   exit when x <= y;
   end loop;
   
   dbms_output.put_line('');
   y := y + 1;
   exit when y >=11;
   end loop;
   
   end;
  */
  
  
12. 
  declare
  n number :=10;
  i number;
  j number;
  begin
  for i in 1..n
  loop
  for j in 1..i
  loop
  dbms_output.put('*');
  end loop;
  dbms_output.put_line('');
  end loop;
  end;
 
  declare
  n number :=0;
  i number;
  j number;
  begin
  i :=10;
  while i>=n
  loop
  j := 1;
  while j<=i
  loop
  dbms_output.put('*');
  j := j +1;
  end loop;
  dbms_output.put_line('');
  i := i - 1;
  end loop;
  end; 


13.declare
   type emprec is record
   (r_fname employees.first_name%type,
    r_salary employees.salary%type,
    new_salary number
   );
   empnewrec emprec;
   begin
   select first_name,salary,salary*1.10
   into empnewrec.r_fname,empnewrec.r_salary,empnewrec.new_salary
   from employees
   where employee_id = 105;
   dbms_output.put_line(empnewrec.r_fname ||'  '||empnewrec.r_salary||'  '||empnewrec.new_salary);
   end;

14.declare
   type salary is table of number
   index by varchar(20);

   s_list salary;
   name varchar(20);
   
   begin
   s_list('a') := 10000;
   s_list('b') := 12411;
   s_list('c') := 23626;
   
   name := s_list.first;
   while name is not null
   loop
   dbms_output.put_line(name ||' '|| to_char(s_list(name)));
   name := s_list.next(name);
   end loop;
   end;
   
   
15.declare
   type emp_id is table of employees.employee_id%type
   index by binary_integer;

   id emp_id;
   inx number;
   
   begin
   id(2) := 1000;
   id(6) := 1241;
   id(9) := 2362;
   
   inx := id.first;
   while inx is not null
   loop
   dbms_output.put_line(inx ||' '|| to_char(id(inx)));
   inx := id.next(inx);
   end loop;
   dbms_output.put_line(id.first ||' '|| id.last ||' '|| id.count);
   end;
   
16.declare
   cursor emp is
   select employee_id,first_name
   from employees;
   
   eid employees.employee_id%type;
   ename employees.first_name%type;
   
   begin
   open emp;
   fetch emp 
   into eid,ename;
   dbms_output.put_line(eid ||' '||ename);
   close emp;
   end;

 17.    declare
     cursor emp is
     select employee_id,first_name
     from employees;

     eid employees.employee_id%type;
     ename employees.first_name%type;
     begin
     open emp;
     for x in 100..105
     loop
     fetch emp
     into eid,ename;
      dbms_output.put_line(eid ||' '||ename);
     end loop;
     close emp;
     end;
 
18.  declare
     cursor emp is
     select employee_id,first_name
     from employees;

     begin
     
     for x in emp
     loop
     
     dbms_output.put_line(x.employee_id ||' '||x.first_name);
     end loop;
     
     end;	
	 
	 
19.  declare
     cursor emp(dpt_id employees.department_id%type) is
     select employee_id,first_name
     from employees
	 where department_id = dpt_id;

     begin
     
     for x in emp(&department_id)
     loop
     
     dbms_output.put_line(x.employee_id ||' '||x.first_name);
     end loop;
     
     end;	
	 
	 
20. declare 
    v_n number;
	begin
	v_n :=10;
	v_n := v_n/0;
	
	exception
	when zero_divide then
		dbms_output.put_line('divide by zero');
	when others then
		dbms_output.put_line('other');
	
	end;
	
	
21.declare
   v_n number;
   too_high exception;
   pragma exception_init(too_high,-2345);
   
   begin
   v_n :=&number;
   if v_n>100 then
   raise too_high;
   else
   v_n:= v_n +10;
   end if;
   
   exception
   when too_high then
   dbms_output.put_line('value too high');
   end;
   
22.declare
   v_n number;
   
   
   begin
   v_n :=&number;
   if v_n>100 then
   raise_application_error(-20056,'value too high app error');
   else
   v_n:= v_n +10;
   end if;
   
   
   end;
   
23.  create or replace procedure find_emp(dpt_id employees.employee_id%type) is
     cursor emp is
     select employee_id,first_name
     from employees
	 where department_id = dpt_id;

     begin
     
     for x in emp
     loop
     
     dbms_output.put_line(x.employee_id ||' '||x.first_name);
     end loop;
     
     end;	

24.	CREATE OR REPLACE PROCEDURE proc_getservice (p_hiredate DATE) 
    IS

    vn_service NUMBER;
    BEGIN

    vn_service:=TRUNC((sysdate-p_hiredate)/365);
    DBMS_OUTPUT.PUT_LINE(vn_service);
    END;
	
25.	create or replace function calt(x in number,y in number) return number is
        sum1 number:=0;
	begin
	sum1 := x+y;
	dbms_output.put_line('total is ' ||sum1);
	return sum1;
	end;

	 