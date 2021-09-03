-- CREATE DATABASE coviddb;
-- \c coviddb
-- \i /home/saloni/dbmslab/lab2/lab2.sql

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
VALUES (9,9,2,'2009-01-01','negative','2009-01-10');
INSERT INTO Test_Report (T_ID,P_ID,H_ID,Reporting_date,Test_result, Discharge_date) 
VALUES (10,10,4,'2020-12-19','positive','2021-01-01');



-- Question 1
-- Find the name of all patients who is lesser than 15 years old.
SELECT Patient_Name FROM Patient WHERE Age<15;

-- Question 2
-- Find the nameof patients who has admitted in Apollo hospital.
SELECT g.Patient_Name FROM 
(SELECT Patient_Name,Hospital_Name FROM
Patient JOIN Hospital ON 
Patient.H_ID=Hospital.H_ID) g WHERE
g.Hospital_Name='apollo'; 

-- Question 3
-- Find the name of hospital that has a fastest recovery ratio.
CREATE VIEW forrecovery AS
SELECT Hospital.H_ID,Hospital.Hospital_Name, (Test_Report.Discharge_date::timestamp-Test_Report.Reporting_date::timestamp) AS recoverydays
FROM Hospital JOIN Test_Report 
ON Hospital.H_ID = Test_Report.H_ID;

SELECT Hospital_Name FROM 
Hospital JOIN (SELECT H_ID, AVG(recoverydays) 
FROM forrecovery
GROUP BY H_ID
ORDER BY avg
LIMIT 1) g ON
g.H_ID=Hospital.H_ID;

-- -- Question 4
-- Create a view on test results based on reporting date of last three months.
CREATE VIEW test_result AS
SELECT * FROM Test_Report WHERE 
EXTRACT(MONTH FROM Reporting_date::timestamp)+3>=EXTRACT(MONTH FROM current_date::timestamp);


-- -- Question 5
-- Find name and age of all patients whose test result is negative.
SELECT g.Patient_Name, g.Age FROM 
(
SELECT * FROM Patient JOIN 
Test_Report ON
Patient.P_ID=Test_Report.P_ID AND 
Test_Report.Test_result='negative'
) g;

-- -- Question 6
-- Find the hotspot area in a city based on the test results.
SELECT Area FROM
(SELECT Area, COUNT(*) FROM 
(SELECT Patient.P_ID, Patient.Area FROM Patient JOIN Test_Report ON 
Patient.P_ID=Test_Report.P_ID
WHERE Patient.City='mumbai' AND Test_Report.Test_result='positive') g GROUP BY
Area ORDER BY 
count DESC 
LIMIT 1) p;

-- -- Question 7
-- List out the states, which has reported with maximum child COVID cases.
SELECT State, COUNT(*) AS positive_kids
FROM Hospital, Patient, Test_Report 
WHERE Hospital.H_ID = Test_Report.H_ID AND Patient.P_ID = Test_Report.P_ID AND
Test_result = 'positive' AND 
Age < 18
GROUP BY State
ORDER BY positive_kids DESC
LIMIT 1;

-- -- Question 8
-- Find the name of the patients who belongs to same are in a particular city.
SELECT Area, array_agg(Patient_Name) AS patients FROM
(SELECT *
FROM Patient 
WHERE City = 'mumbai')g 
GROUP BY Area;



-- -- Question 9
-- Find the number of female patient(s) who has admitted in her city itself.
SELECT COUNT(*) FROM (
    SELECT * FROM Patient JOIN
    Hospital ON
    Patient.H_ID=Hospital.H_ID AND
    Patient.Sex='female' AND
    Patient.City=Hospital.Location
) g;

-- -- Question 10
-- Find the name of hospital that has admitted with maximum COVID positive cases in a particular state.

SELECT Hospital_Name FROM (
    SELECT Hospital_Name,COUNT(*) AS count_patients FROM Test_Report JOIN
    Hospital ON
    Test_Report.H_ID=Hospital.H_ID AND Hospital.State='maharashtra' AND Test_Report.Test_result='positive'
    GROUP BY Hospital_Name
    ORDER BY count_patients DESC
    LIMIT 1
) g;
