-- CREATE DATABASE coviddb2;
-- \c coviddb2
-- \i /home/saloni/Desktop/Lab-Programs/dbms_lab/lab3/q1.sql

CREATE TABLE Hospital (
    H_ID INT PRIMARY KEY NOT NULL,
    Hospital_Name VARCHAR(150) NOT NULL, 
    Location VARCHAR(500) NOT NULL, 
    State VARCHAR(100) NOT NULL
);

CREATE TABLE Patient(
    P_ID INT PRIMARY KEY NOT NULL,
    Patient_Name VARCHAR(50) NOT NULL,
    Sex VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Area VARCHAR(150) NOT NULL,
    City VARCHAR(150) NOT NULL,
    H_ID INT NOT NULL,
    FOREIGN KEY (H_ID) REFERENCES Hospital (H_ID)
);

CREATE TABLE Test_Report(
    T_ID INT PRIMARY KEY NOT NULL,
    P_ID INT NOT NULL,
    H_ID INT NOT NULL,
    Reporting_date DATE NOT NULL,
    Test_result VARCHAR(150) NOT NULL, 
    Discharge_date DATE NOT NULL,
    FOREIGN KEY (H_ID) REFERENCES Hospital (H_ID),
    FOREIGN KEY (P_ID) REFERENCES Patient (P_ID)
);



--  INSERT VALUES

INSERT INTO Hospital (H_ID, Hospital_Name, Location, State) 
VALUES (1,'lifecare','123, oval park','gujarat');
INSERT INTO Hospital (H_ID, Hospital_Name, Location, State) 
VALUES (2,'lifeline','mumbai','maharashtra');
INSERT INTO Hospital (H_ID, Hospital_Name, Location, State) 
VALUES (3,'heartbeat','near oryx hotel','karnataka');
INSERT INTO Hospital (H_ID, Hospital_Name, Location, State) 
VALUES (4,'wockhart','street 99','maharashtra');
INSERT INTO Hospital (H_ID, Hospital_Name, Location, State) 
VALUES (5,'apollo','opposite big mart','kerala');


INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (1,'saloni','female',25,'nalasopara','mumbai',2);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (2,'vish','male',5,'building x','delhi',1);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (3,'meghdeepa','female',15,'nalasopara','mumbai',2);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (4,'rads','male',16,'4 square','chennai',3);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (5,'pradeep','male',9,'paperbuild','chennai',5);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (6,'udit','male',34,'nalasopara','mumbai',3);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (7,'anurag','male',80,'bigbasket','bangalore',4);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (8,'sneha','female',95,'supermarket','chennai',3);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (9,'hanan','female',16,'hills green','jamnagar',2);
INSERT INTO Patient (P_ID, Patient_Name, Sex, Age, Area, City, H_ID) 
VALUES (10,'deepesh','male',12,'hello world street','chennai',5);


INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (1,1,1,'1998-10-19','positive','1998-10-25');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (2,2,2,'2009-08-9','negative','2009-08-12');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (11,2,2,'2009-08-10','positive','2009-10-12');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (3,3,2,'2008-07-10','positive','2008-07-10');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (4,4,3,'2020-06-11','negative','2020-06-12');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (5,5,4,'2021-05-21','negative','2021-05-23');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (6,6,5,'2005-04-23','positive','2006-05-25');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (7,7,1,'2001-03-17','negative','2001-03-19');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (8,8,3,'2012-02-05','positive','2012-02-08');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (9,9,2,'2009-01-01','positive','2009-01-10');
-- INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
-- VALUES (10,10,4,'2020-12-19','positive','2021-01-01');


-- Q1
-- Create a procedure to display the details of a patient record for a given Patient ID.
CREATE PROCEDURE display_patient(id INT)
LANGUAGE plpgsql
AS 
$$
DECLARE result patient%ROWTYPE;
BEGIN
SELECT * INTO result FROM Patient WHERE P_ID=id;
RAISE NOTICE 'Patient details %',result;
END
$$;

CALL display_patient(3);
-- Q2
-- .Create a procedure to add details of a new patient record into patient table.
CREATE OR REPLACE PROCEDURE add_dets(
    id INT,
    patientname VARCHAR(50),
    gender VARCHAR(50),
    patient_age INT ,
    patient_area VARCHAR(150) ,
    patient_city VARCHAR(150),
    hospital_id INT
)
LANGUAGE plpgsql AS 
$$
BEGIN
INSERT INTO Patient VALUES(id,patientname,gender,patient_age,patient_area,patient_city,hospital_id);
END
$$
;

CALL add_dets(11,'newname','female',66,'somearea','somecity',3);
-- Q3
-- Write a procedure that lists the highest cases reported in a district of any particular state.
-- Use the procedure named Find_highest which finds the highest cases for the given State.

CREATE TABLE dummy (  District VARCHAR(100),Casecount INT);

CREATE OR REPLACE PROCEDURE list_highest_cases(
    given_state VARCHAR(100)
)
LANGUAGE plpgsql AS 
$$
DECLARE result dummy%ROWTYPE;
BEGIN
SELECT * INTO result FROM (SELECT Area,COUNT(*) FROM (SELECT * FROM Hospital, Patient, Test_Report
WHERE Hospital.State=given_state 
AND Hospital.H_ID=Test_Report.H_ID 
AND Patient.P_ID=Test_Report.P_ID)p GROUP BY Area
ORDER BY COUNT DESC 
LIMIT 1)l;

RAISE NOTICE 'Highest cases %',result;

END
$$
;

CALL list_highest_cases('maharashtra');

-- Q4
-- Write a procedure to list the hospital, which has fastest recovery.


create procedure bestHospital()
language plpgsql
AS $$
DECLARE 
best_hosp VARCHAR;
rate float;
BEGIN

CREATE VIEW Recovery_Days AS
SELECT Hospital.Hospital_Name AS Hospital_Name, (Test_Report.Discharge_date - Test_Report.Reporting_date) AS R_Days
FROM Hospital INNER JOIN Test_Report 
ON Hospital.H_ID = Test_Report.H_ID;

SELECT Hospital_Name, AVG(R_Days) AS R_Rate INTO best_hosp, rate 
FROM Recovery_Days
GROUP BY Hospital_Name
ORDER BY R_Rate
LIMIT 1;

DROP VIEW IF EXISTS Recovery_Days;

RAISE NOTICE 'Best Hospital is % with a minimum Average Recovery Rate of % Days', best_hosp, rate;

END;
$$;

call bestHospital();

-- Q5
-- Create a procedure to delete a record from patient table

CREATE OR REPLACE PROCEDURE delete_record(
    id INT
)
LANGUAGE plpgsql AS 
$$
BEGIN
DELETE FROM Patient WHERE P_ID=id;
END
$$
;
CALL delete_record(10);

-- Q6
-- Write a function to display the patient details from the Patient table.
CREATE OR REPLACE FUNCTION  display_all_patiens()
RETURNS TABLE(
    id INT,
    patientname VARCHAR(50),
    gender VARCHAR(50),
    patient_age INT ,
    patient_area VARCHAR(150) ,
    patient_city VARCHAR(150),
    hospital_id INT
)
LANGUAGE plpgsql 
AS 
$$
BEGIN 
RETURN QUERY SELECT * FROM Patient;
END
$$;

SELECT * FROM display_all_patiens();
-- Q7
-- Writea function to list the state, which has reported with maximum child COVID cases

CREATE OR REPLACE FUNCTION  max_state()
RETURNS TABLE(maxstate VARCHAR(100))
LANGUAGE plpgsql 
AS 
$$
BEGIN 
RETURN QUERY SELECT State FROM (SELECT State,COUNT(*) AS positive_kids
FROM Hospital, Patient, Test_Report 
WHERE Hospital.H_ID = Test_Report.H_ID AND Patient.P_ID = Test_Report.P_ID AND
Test_result = 'positive' AND 
Age < 18
GROUP BY State
ORDER BY positive_kids DESC
LIMIT 1) pp;

END
$$;

SELECT * FROM max_state();

-- Q8
-- Write a function to find the hotpot area in a district based on the Test results.
CREATE OR REPLACE FUNCTION  hotspot_area(givencity VARCHAR(150))
RETURNS TABLE(hotspot VARCHAR(100))
LANGUAGE plpgsql 
AS 
$$
BEGIN 
RETURN QUERY 

SELECT Area FROM
(SELECT Area, COUNT(*) FROM 
(SELECT Patient.P_ID, Patient.Area FROM Patient JOIN Test_Report ON 
Patient.P_ID=Test_Report.P_ID
WHERE Patient.City=givencity AND Test_Report.Test_result='positive') g GROUP BY
Area ORDER BY 
count DESC 
LIMIT 1) p;

END
$$;

SELECT * FROM hotspot_area('mumbai');

-- Q9
-- Write a function to display total number of male and female patients tested for COVID of
-- which how many are reported with positive in a particular state.

create type gender_cases as (gender varchar, cases int);

create function genderPositve(inp_state varchar)
returns setof gender_cases
as $$
DECLARE 
    r gender_cases%rowtype;
BEGIN
    for r in 
        select Patient.Sex, count(Test_result)
        from Hospital, Test_Report, Patient
        where Hospital.H_ID = Test_Report.H_ID and Patient.P_ID = Test_Report.P_ID and
        Test_Report.Test_result = 'positive' and Hospital.State = inp_state
        group by Patient.Sex
    loop   
        return next r;
    end loop;

end;
$$
language plpgsql;

select * from genderPositve('maharashtra');

-- Q10
-- Write a function to display the average days for the recovery of child, adults and senior
-- citizen of a particular hospital.

CREATE or REPLACE FUNCTION RecoveryDays(h_name varchar(20),out child bigint, out adult bigint, out senior bigint)
language plpgsql
as
$$
BEGIN
    SELECT avg(discharge_date - reporting_date) into child 
    FROM Patient, Hospital, Test_Report
    WHERE Hospital.H_id = Patient.H_id and Test_Report.P_id = Patient.P_id AND test_result = 'negative' AND age < 18 
    GROUP BY Hospital_Name
    HAVING Hospital_Name = h_name;

    SELECT avg(discharge_date - reporting_date) into adult
    FROM Patient, Hospital, Test_Report
    WHERE Hospital.H_id = Patient.H_id and Test_Report.P_id = Patient.P_id AND test_result = 'negative' AND age >= 18 AND age < 61 
    GROUP BY Hospital_Name
    HAVING Hospital_Name = h_name;

    SELECT avg(discharge_date - reporting_date) into senior 
    FROM Patient, Hospital, Test_Report
    WHERE Hospital.H_id = Patient.H_id and Test_Report.P_id = Patient.P_id AND test_result = 'negative' AND age > 60
    GROUP BY Hospital_Name
    HAVING Hospital_Name = h_name;
END;
$$;

SELECT * FROM RecoveryDays('wockhart');


-- pt 2 

create function recovery_hospitalCategory(inp_hosp varchar)
returns setof float
as $$
declare 
begin 
    
    return query
    select cast(avg(Test_Report.Discharge_date - Test_Report.Reporting_date) as float)
    from Test_Report, Hospital, Patient
    where Test_Report.P_ID = Patient.P_ID and Hospital.H_ID = Test_Report.H_ID and
    Hospital.Hospital_Name = inp_hosp and Patient.Age < 18;

    return query
    select cast(avg(Test_Report.Discharge_date - Test_Report.Reporting_date) as float)
    from Test_Report, Hospital, Patient
    where Test_Report.P_ID = Patient.P_ID and Hospital.H_ID = Test_Report.H_ID and
    Hospital.Hospital_Name = inp_hosp and Patient.Age >= 18 and Patient.Age < 60;

    return query
    select cast(avg(Test_Report.Discharge_date - Test_Report.Reporting_date) as float)
    from Test_Report, Hospital, Patient
    where Test_Report.P_ID = Patient.P_ID and Hospital.H_ID = Test_Report.H_ID and
    Hospital.Hospital_Name = inp_hosp and Patient.Age >= 60;
    return;

end;
$$
language plpgsql;

select * from recovery_hospitalCategory('wockhart');