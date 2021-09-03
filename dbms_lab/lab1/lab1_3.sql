-- CREATE DATABASE salesdetails;
-- \c salesdetails;
-- \i /home/saloni/dbmslab/lab1/lab1_3.sql


CREATE TABLE salesperson(
    ssn INT PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    start_year INT NOT NULL,
    dept_no INT NOT NULL
);

CREATE TABLE trip(
    ssn INT NOT NULL, 
    from_city VARCHAR(100), 
    to_city VARCHAR(100), 
    departure_date DATE, 
    return_date DATE, 
    trip_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (ssn) REFERENCES salesperson(ssn)
);

CREATE TABLE salerep_expense(
    trip_id INT NOT NULL, 
    expense_type VARCHAR(50),
    amount INT NOT NULL,
    FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
);


INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (100,'Saloni',2001,1);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (200,'Megh S',2011,2);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (300,'Sneha S',2005,1);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (400,'Viswonathan M',2006,3);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (500,'Pradeep S',2006,1);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (600,'Hanan Ab',2011,3);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (700,'Raj gohil',2020,1);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (800,'Jyothi Rajesh',2021,5);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (900,'Shreyash',2015,4);
INSERT INTO salesperson (ssn,name,start_year,dept_no) VALUES (1000,'Ahmed',2019,1);

INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (100,'mumbai','chennai',DATE'2001-09-1',DATE'2001-09-10',1);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (200,'delhi','mumbai',DATE'2011-10-1',DATE'2011-11-10',2);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (300,'mumbai','chennai',DATE'2001-02-22',DATE'2001-05-11',3);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (400,'jaipur','mumbai',DATE'2021-09-1',DATE'2021-09-10',4);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (500,'goa','jaipur',DATE'2015-09-1',DATE'2016-09-10',5);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (600,'raipur','gondal',DATE'2019-10-1',DATE'2020-10-22',6);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (700,'rajkot','dubai',DATE'2020-06-2',DATE'2020-09-23',7);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (800,'chennai','rajkot',DATE'2016-04-1',DATE'2017-05-30',8);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (900,'hyderabad','abu dhabi',DATE'2015-05-12',DATE'2015-07-15',9);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (1000,'vaapi','trichy',DATE'2016-06-1',DATE'2016-06-21',10);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (100,'ahmedabad','chennai',DATE'2005-07-1',DATE'2005-11-11',11);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (200,'kashi','kolkata',DATE'2002-08-1',DATE'2003-12-18',12);
INSERT INTO trip (ssn,from_city,to_city,departure_date,return_date,trip_id) VALUES (100,'haridwar','udaipur',DATE'2007-11-1',DATE'2007-12-19',13);

INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (1,'TRAVEL',2000);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (2,'TRAVEL',1500);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (3,'TRAVEL',3000);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (4,'TRAVEL',2000);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (5,'TRAVEL',4500);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (6,'TRAVEL',9800);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (7,'TRAVEL',1000);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (8,'TRAVEL',920);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (9,'TRAVEL',100);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (10,'TRAVEL',1230);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (11,'TRAVEL',8530);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (12,'TRAVEL',2134);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (13,'TRAVEL',3564);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (1,'FOOD',100);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (2,'FOOD',2456);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (3,'FOOD',2311);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (4,'FOOD',1243);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (5,'FOOD',100);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (6,'FOOD',500);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (7,'FOOD',600);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (8,'FOOD',354);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (9,'FOOD',200);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (10,'FOOD',980);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (11,'FOOD',209);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (12,'FOOD',999);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (13,'FOOD',399);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (1,'STAY',1000);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (2,'STAY',1200);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (3,'STAY',4200);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (4,'STAY',6500);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (5,'STAY',1200);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (6,'STAY',900);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (7,'STAY',800);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (8,'STAY',100);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (9,'STAY',190);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (10,'STAY',720);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (11,'STAY',980);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (12,'STAY',870);
INSERT INTO salerep_expense (trip_id,expense_type, amount) VALUES (13,'STAY',2100);

--  question 1
SELECT ssn,from_city,to_city,departure_date,return_date,trip_id
FROM
(SELECT trip.trip_id, trip.ssn, trip.from_city, trip.to_city, trip.departure_date, trip.return_date,sum(salerep_expense.amount) total
FROM trip left join salerep_expense
ON trip.trip_id = salerep_expense.trip_id
GROUP BY trip.trip_id) data
WHERE data.total>2000;

--  question 2
SELECT ssn 
FROM (SELECT ssn, count(*) FROM trip WHERE to_city='chennai'GROUP BY ssn) g 
WHERE count>1; 

--  question 3
SELECT total FROM (SELECT trip.ssn,sum(salerep_expense.amount) total
FROM trip join salerep_expense
ON trip.trip_id = salerep_expense.trip_id
GROUP BY trip.ssn)g WHERE ssn=1000;

--  question 4
SELECT * FROM salesperson ORDER BY name ASC;