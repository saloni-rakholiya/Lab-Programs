-- CREATE DATABASE studentdetails;
-- \c studentdetails;
-- \i /home/saloni/dbmslab/lab1/lab1_2.sql

CREATE TABLE student(
    rollno INT NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mark_sub1 INT NOT NULL, 
    mark_sub2 INT NOT NULL, 
    mark_sub3 INT NOT NULL, 
    mark_sub4 INT NOT NULL, 
    mark_sub5 INT NOT NULL, 
    mark_sub6 INT NOT NULL,
    total INT
);

CREATE TABLE department(
    deptid INT NOT NULL PRIMARY KEY,
    deptname VARCHAR(100) NOT NULL,
    hodname VARCHAR(100) NOT NULL
);

CREATE TABLE studdep(
    rollno INT NOT NULL ,
    deptid INT NOT NULL,
    FOREIGN KEY (rollno) REFERENCES student(rollno), 
    FOREIGN KEY (deptid) REFERENCES department(deptid) 
);

INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(1,'Saloni',20, 10,50,15,40,10);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(2,'Sneha',30,20,51,11,55,60);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(3,'Meghdeepa',100, 100,52,14,44,14);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(4,'Pradeep',100, 100,100,100,100,100);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(5,'Viswonathan',90, 80,90,100,100,100);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(6,'Subbu',10, 90,90,91,91,93);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(7,'Udit',90, 90,70,55,90,90);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(8,'Hanan',99, 100,75,92,64,76);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(9,'Deepesh',30, 30,80,65,32,43);
INSERT INTO student (rollno, name, mark_sub1, mark_sub2, mark_sub3, mark_sub4, mark_sub5, mark_sub6) VALUES(10,'Marmik',30, 30,70,25,47,12);

INSERT INTO department (deptid, deptname, hodname) VALUES (1,'CSE', 'Dr Priya');
INSERT INTO department (deptid, deptname, hodname) VALUES (2,'EEE', 'Dr Raja');
INSERT INTO department (deptid, deptname, hodname) VALUES (3,'ECE', 'Dr Sohan');

INSERT INTO studdep (rollno, deptid) VALUES (1,1);
INSERT INTO studdep (rollno, deptid) VALUES (2,2);
INSERT INTO studdep (rollno, deptid) VALUES (3,3);
INSERT INTO studdep (rollno, deptid) VALUES (4,1);
INSERT INTO studdep (rollno, deptid) VALUES (5,2);
INSERT INTO studdep (rollno, deptid) VALUES (6,3);
INSERT INTO studdep (rollno, deptid) VALUES (7,1);
INSERT INTO studdep (rollno, deptid) VALUES (8,2);
INSERT INTO studdep (rollno, deptid) VALUES (9,3);
INSERT INTO studdep (rollno, deptid) VALUES (10,1);


UPDATE student SET total=mark_sub6+mark_sub5+mark_sub4+mark_sub3+mark_sub2+mark_sub1; 
-- 2
SELECT student.rollno, student.name, student.mark_sub1,student.mark_sub2,student.mark_sub3,student.mark_sub4,student.mark_sub5,student.mark_sub6, student.total from student, studdep WHERE student.rollno=studdep.rollno AND studdep.deptid=1;
-- 3
SELECT department.id, department.name, department.hodname from department,studdep where department.deptid=studdep.deptid and studdep.rollno=1;
-- 4
SELECT * FROM student WHERE total>500;
-- 5
SELECT hodname FROM department WHERE deptname='CSE';
-- 6
SELECT studdep.rollno FROM studdep, department where department.deptid=studdep.deptid and department.deptname='CSE';