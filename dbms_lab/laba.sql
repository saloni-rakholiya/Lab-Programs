-- CREATE DATABASE en;
-- \c en;
-- \i /home/savitri/Desktop/Lab-Programs/dbms_lab/lab_endsem/laba.sql


-- Employee (employee-id, employee-name, street, city) 
-- Works (employee-name, company-name, salary) 
-- Company (company-name, city) 
-- Manages (employee-name, manager-name)

drop table if exists employee cascade;
CREATE TABLE employee(
    empid INT PRIMARY KEY NOT NULL,
    empname VARCHAR(50) NOT NULL,
    street VARCHAR(150) NOT NULL,
    city VARCHAR(150) NOT NULL
);

drop table if exists works cascade;
CREATE TABLE works(
    empname VARCHAR(50) NOT NULL,
    companyname VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

drop table if exists company cascade;
CREATE TABLE company(
    companyname VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

drop table if exists manages cascade;
CREATE TABLE manages(
    empname VARCHAR(50) NOT NULL,
    managername VARCHAR(50) NOT NULL
);

INSERT INTO employee(empid, empname, street, city) VALUES (1,'savitri','Pearl plaza', 'abudhabi');
INSERT INTO employee(empid, empname, street, city) VALUES (2,'apurva','somstreet plaza', 'ruwais');
INSERT INTO employee(empid, empname, street, city) VALUES (3,'jyothi','street2', 'dubai');
INSERT INTO employee(empid, empname, street, city) VALUES (4,'zeba','street3', 'alain');
INSERT INTO employee(empid, empname, street, city) VALUES (5,'ishi','ringroad', 'sharjah');
INSERT INTO employee(empid, empname, street, city) VALUES (6,'hetvi','ringroad', 'sharjah');

INSERT INTO works(empname, companyname, salary) VALUES('savitri','state bank of india',95000);
INSERT INTO works(empname, companyname, salary) VALUES('hetvi','state bank of india',100000);
INSERT INTO works(empname, companyname, salary) VALUES('apurva','uco bank',50500);
INSERT INTO works(empname, companyname, salary) VALUES('jyothi','hdfc bank',5220);
INSERT INTO works(empname, companyname, salary) VALUES('zeba','hdfc bank',5000);
INSERT INTO works(empname, companyname, salary) VALUES('ishi','uco bank',5400);

INSERT INTO company(companyname, city) VALUES('hdfc bank','chennai');
INSERT INTO company(companyname, city) VALUES('uco bank','bangalore');
INSERT INTO company(companyname, city) VALUES('state bank of india','hyderabad');


INSERT INTO manages(empname, managername) VALUES('savitri','ishita');
INSERT INTO manages(empname, managername) VALUES('apurva','joseph');
INSERT INTO manages(empname, managername) VALUES('jyothi','kina');
INSERT INTO manages(empname, managername) VALUES('ishi','piyal');
INSERT INTO manages(empname, managername) VALUES('zeba','rita');
INSERT INTO manages(empname, managername) VALUES('hetvi','kaavya');


-- (i) Find the name of all employees who work for State Bank of India. 
select employee.empname from employee,works where employee.empname=works.empname and works.companyname='state bank of india';

-- (ii) Find the names and cities of residence of all employees who work for State Bank of India. 
select employee.empname,employee.city from employee,works where employee.empname=works.empname and works.companyname='state bank of india';

-- (iii) Create a view for employee based on salary in ascending order. 
create view myview as
select employee.empname,works.salary,works.companyname,employee.street, employee.city 
from employee,works 
where employee.empname=works.empname
order by salary asc;

select * from myview;
-- (iv) Find all employees in the database who earn more than every employee of UCO Bank. 
select empname
from works
where salary> (select max(salary) 
from works
where companyname='uco bank') ;

-- (v) Find the employee in the database who earn minimum in state bank of India 
select empname 
from works 
where salary=(select min(salary) from works where companyname='state bank of india');

-- (vi) Create a Functionthat displaysthe employee who earn maximum in SBI.

create type g as (empname varchar, companyname varchar, salary int);
CREATE OR REPLACE FUNCTION  getmaxxx()

returns setof g
as $$
DECLARE 
    r g%rowtype;
BEGIN
    for r in 
        SELECT * 
        from works 
        where companyname='state bank of india' 
        and salary=(select max(salary) from works where companyname='state bank of india')
    loop   
        return next r; 
    end loop;

end;
$$
language plpgsql;

SELECT * FROM getmaxxx();


-- (vii) Write a procedure which takes the city as input parameter and lists the names 
-- of all employees belonging to that city. 

drop procedure if exists gette();

CREATE procedure gette(ci VARCHAR) language plpgsql
AS $$
DECLARE 
e varchar;
BEGIN
    for e in
        select employee.empname from employee where employee.city = ci
    loop
        RAISE NOTICE 'Employee: %', e;
    end loop;
end;
$$;

call gette('sharjah');

-- (viii)Write a function that will display the number of employees with salary morethan 50k.


drop function if exists morethan50k;
CREATE OR REPLACE FUNCTION morethan50k(out employee_count int) 
LANGUAGE plpgsql 
AS
$$ 
begin
SELECT count(*) into employee_count
FROM works
WHERE works.salary > 50000;
end;
$$;

select *
from morethan50k();

-- (ix)Write a procedure raise_sal which increases the salary of an employee. 
-- It accepts an employee number and salary increase amount.

drop procedure if exists salary_increase;
CREATE PROCEDURE salary_increase(emp_no int, amount int) LANGUAGE plpgsql AS $$ begin
UPDATE works
SET salary = salary + amount
WHERE empname = (
        SELECT empname
        FROM employee
        WHERE empid = emp_no
    );
end;
$$;
CALL salary_increase(1,5123);
select * from works;

-- (x)Create a Procedure thatdisplays the details of managers working in a bank

DROP FUNCTION IF EXISTS display_manager;
CREATE or REPLACE FUNCTION display_manager(_companyname varchar(50))
    RETURNS Table(empid int,
    empname varchar(50),
    street varchar(150),
    city varchar(150),
    managername varchar(150))
    language plpgsql
as
$$
begin
return query 
select employee.*, manages.managername 
from employee,works, manages 
where employee.empname=works.empname 
and works.companyname=_companyname
and employee.empname=manages.empname;
end;
$$;
select * from display_manager('state bank of india');


-- 10th
drop procedure if exists getmanager_details;
CREATE PROCEDURE getmanager_details(
    bank_name varchar(200),
    INOUT managers varchar(200) default null
) LANGUAGE plpgsql AS $$ begin
SELECT DISTINCT array_agg(managername) into managers
FROM employee,
    works,
    company,
    Manages
WHERE employee.empname = works.empname
    AND works.companyname = company.companyname
    AND employee.empname = Manages.empname
    AND company.companyname = bank_name;
end;
$$;
Call getmanager_details('uco bank');
Call getmanager_details('state bank of india')