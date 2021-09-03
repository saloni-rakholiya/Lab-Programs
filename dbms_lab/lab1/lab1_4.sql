-- CREATE DATABASE cardetails;
-- \c cardetails;
-- \i /home/saloni/dbmslab/lab1/lab1_4.sql

CREATE TABLE car(
    serial_no INT PRIMARY KEY NOT NULL,
    model VARCHAR(150) NOT NULL,
    manufacturer VARCHAR(150) NOT NULL,
    price BIGINT NOT NULL
);


CREATE TABLE options(
    serial_no INT NOT NULL,
    option_name VARCHAR(150) NOT NULL,
    price BIGINT NOT NULL,
    FOREIGN KEY (serial_no) REFERENCES car (serial_no)
);

CREATE TABLE salesperson(
    salesperson_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone CHAR(10)
);

CREATE TABLE sales(
    salesperson_id INT NOT NULL,
    serial_no INT NOT NULL,
    date DATE NOT NULL,
    sale_price BIGINT NOT NULL,
    FOREIGN KEY (serial_no) REFERENCES car(serial_no),
    FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id)
);


INSERT INTO car (serial_no,model,manufacturer,price) VALUES (1,'model1', 'manufacturer1', 258000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (2,'model2', 'manufacturer2', 126000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (3,'model3', 'manufacturer3', 896000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (4,'model4', 'manufacturer4', 124000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (5,'model5', 'manufacturer5', 98000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (6,'model6', 'manufacturer6', 986000);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (7,'model7', 'manufacturer7', 256280);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (8,'model8', 'manufacturer8', 76430);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (9,'model9', 'manufacturer9', 192840);
INSERT INTO car (serial_no,model,manufacturer,price) VALUES (10,'model10', 'manufacturer10', 816380);


INSERT INTO options(serial_no,option_name,price) VALUES (1,'option1',250000);
INSERT INTO options(serial_no,option_name,price) VALUES (2,'option2',120000);
INSERT INTO options(serial_no,option_name,price) VALUES (3,'option3',432000);
INSERT INTO options(serial_no,option_name,price) VALUES (9,'option4',194000);
INSERT INTO options(serial_no,option_name,price) VALUES (10,'option5',230000);
INSERT INTO options(serial_no,option_name,price) VALUES (6,'option6',987000);
INSERT INTO options(serial_no,option_name,price) VALUES (7,'option7',143700);
INSERT INTO options(serial_no,option_name,price) VALUES (8,'option8',817350);

INSERT INTO salesperson(salesperson_id,name,phone) VALUES(1,'John',2222222222);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(2,'Sia',2435289762);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(3,'Pop',1234567898);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(4,'Bob',8765656565);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(5,'Hela',9394959697);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(6,'Yuyu',0192847663);
INSERT INTO salesperson(salesperson_id,name,phone) VALUES(7,'Wener',6123905000);

INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (1,1,DATE'2001-09-1', 500000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (1,2,DATE'2002-02-12', 120000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (2,3,DATE'2004-06-15', 540000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (4,4,DATE'2012-08-15', 870000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (3,5,DATE'2008-03-2', 123000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (5,6,DATE'2006-09-4', 532000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (7,7,DATE'2003-12-15', 570000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (6,8,DATE'2021-01-9', 572000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (7,9,DATE'1999-12-22', 510000);
INSERT INTO sales(salesperson_id,serial_no,date,sale_price) VALUES (1,10,DATE'1998-10-19', 123000);

--  question 1
select serial_no, manufacturer, sale_price 
from (select car.serial_no,car.model,car.manufacturer,car.price,g.sale_price from car 
join (select sales.serial_no,sales.sale_price from sales 
join salesperson 
on sales.salesperson_id=salesperson.salesperson_id and salesperson.name='John' ) g 
on car.serial_no=g.serial_no) pp;

--  question 2
select serial_no, model 
from car 
where serial_no 
not in (select car.serial_no from car join options on car.serial_no=options.serial_no);

--  question 3
select sales.serial_no, model, sale_price 
from sales 
join (select car.serial_no,car.model,car.manufacturer,car.price,options.option_name,options.price from car join options on car.serial_no=options.serial_no) g 
on sales.serial_no=g.serial_no;

--  question 4
update salesperson 
set phone=7227962460 
where salesperson_id=2;
