-- CREATE DATABASE projectdetails;
-- \c projectdetails;
-- \i /home/saloni/dbmslab/lab1/lab1_1.sql

CREATE TABLE employee(
    empid INT PRIMARY KEY NOT NULL,
    empname VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    doj DATE NOT NULL,
    salary INT NOT NULL
);

CREATE TABLE project(
    projectno INT PRIMARY KEY NOT NULL,
    duration INT NOT NULL,
    projectname VARCHAR(100)
);

CREATE TABLE workson(
    empid BIGINT NOT NULL,
    projno BIGINT NOT NULL,
    FOREIGN KEY (empid) REFERENCES employee(empid),
    FOREIGN KEY (projno) REFERENCES project(projectno)
);

INSERT INTO employee(empid, empname, address, doj, salary) VALUES (1,'Saloni R','Pearl plaza', DATE'2001-09-1', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (2,'Megh S','gwalior', DATE'2002-06-12', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (3,'Sneha R','chennai 12', DATE'2005-05-23', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (4,'Viswonathan M','musaffah 5', DATE'2011-12-21', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (5,'Udit','trichy 9', DATE'1998-01-04', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (6,'Pradeep S','chennai 8', DATE'2011-01-27', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (7,'Bhanan Abdul','burj', DATE'2020-07-14', 1500);
INSERT INTO employee(empid, empname, address, doj, salary) VALUES (8,'Boha mehta','gujarat', DATE'2004-11-11', 1500);

INSERT INTO project(projectno,duration,projectname) VALUES (1,2,'Build a recommendar system');
INSERT INTO project(projectno,duration,projectname) VALUES (2,3,'State machine project');
INSERT INTO project(projectno,duration,projectname) VALUES (3,4,'Randomised algorithms');
INSERT INTO project(projectno,duration,projectname) VALUES (4,1,'Automata');
INSERT INTO project(projectno,duration,projectname) VALUES (5,3,'Build a NN');
INSERT INTO project(projectno,duration,projectname) VALUES (6,7,'LSTM');
INSERT INTO project(projectno,duration,projectname) VALUES (7,1,'Develop a todo app');
INSERT INTO project(projectno,duration,projectname) VALUES (8,12,'Develop a social media');
INSERT INTO project(projectno,duration,projectname) VALUES (9,3,'Develop a exercise app');

INSERT INTO workson(empid, projno) VALUES (1,9);
INSERT INTO workson(empid, projno) VALUES (2,9);
INSERT INTO workson(empid, projno) VALUES (3,3);
INSERT INTO workson(empid, projno) VALUES (4,3);
INSERT INTO workson(empid, projno) VALUES (5,2);
INSERT INTO workson(empid, projno) VALUES (6,4);
INSERT INTO workson(empid, projno) VALUES (7,2);
INSERT INTO workson(empid, projno) VALUES (8,8);

--  question 1
SELECT * FROM employee ORDER BY empname DESC;
--  question 2
SELECT * FROM project WHERE projectno=2;
--  question 3
SELECT empname FROM employee WHERE empname LIKE 'B%';
--  question 4
SELECT empid FROM workson WHERE projno=9;