--Write an SQL query to determine patients from the tblPATIENT table 
--who meet the following conditions:

--а) Visited the hospital with symptoms recorded in the 
--tblPATIENT_SYMPTOM table at least 2 times during 2024.
--b)Have had at least 3 appointments (tblAPPOINTMENT) with professionals 
--working in the Cardiology department (tblDEPARTMENT.DepartmentName = 
--'Cardiology') since January 2024.
--c)Have had at least 3 appointments and Were prescribed medication (tblPRESCRIPTION) classified as 
--"Antibiotic" (tblMEDICATION_TYPE.MedicationTypeName = 'Antibiotic') 
--before August 2023.


SELECT A.*, B.Appointments, C.Appointmentss
FROM
(select P.PatientID, P.PatientFName, P.PatientLname, count(*) as symptoms
from tblPATIENT P 
JOIN tblPATIENT_SYMPTOM PS on P.PatientID = PS.PatientID
JOIN tblAPPOINTMENT A on PS.PatientSymptomID = A.PatientSymptomID
where YEAR(A.DateOfApp) = 2024
group by P.PatientID, P.PatientFName, P.PatientLname
having count(*) >=2) A, 

(select P.PatientID, P.PatientFName, P.PatientLname, count(AP.AppointProID) as Appointments
from tblPATIENT P 
JOIN tblPATIENT_SYMPTOM PS on P.PatientID = PS.PatientID
JOIN tblAPPOINTMENT A on PS.PatientSymptomID = A.PatientSymptomID
JOIN tblAPPOINTMENT_PRO AP on A.AppointmentID = AP.AppointmentID 
JOIN tblDEPARTMENT D on AP.DepartmentID = D.DepartmentID 
where Departmentname = 'Cardiology'
and AP.BeginDateTime > '2024-01-01'
group by P.PatientID, P.PatientFName, P.PatientLname
having count(AP.AppointProID) >= 3) B,

(select P.PatientID, P.PatientFName, P.PatientLname, count(AP.AppointProID) as Appointmentss
from tblPATIENT P 
JOIN tblPATIENT_SYMPTOM PS on P.PatientID = PS.PatientID
JOIN tblAPPOINTMENT A on PS.PatientSymptomID = A.PatientSymptomID
JOIN tblAPPOINTMENT_PRO AP on A.AppointmentID = AP.AppointmentID 
JOIN tblDIAGNOSIS D on AP.AppointProID = D.AppointProID 
JOIN tblPRESCRIPTION PR on D.DiagnosisID = PR.DiagnosisID
JOIN tblMEDICATION M on PR.MedicationID = M.MedicationID
JOIN tblMEDICATION_TYPE MT on M.MedicationTypeID = MT.MedicationTypeID 
where MT.MedicationTypeName = 'Antibiotic'
and AP.BeginDateTime < '2024-08-01'
group by P.PatientID, P.PatientFName, P.PatientLname
having count(AP.AppointProID) >=5) C 

where A.PatientID = B.PatientID 
AND A.PatientID = C.PatientID 

/*Write an SQL query to determine the hospitals (tblHOSPITAL) that meet the following conditions:

Conducted at least 50 appointments (tblAPPOINTMENT) for patients with symptoms classified as 'Severe' (tblSYMPTOM_TYPE.SymptomTypeName = 'Fevere') after January 2024.

Generated more than 20 prescriptions (tblPRESCRIPTION) for medications of type 'Antibiotic' (tblMEDICATION_TYPE.MedicationTypeName = 'AImmunomodulators') before December 2024.

Had at least 100 appointments scheduled in rooms located in buildings with a 'Main Building' type (tblBUILDING_TYPE.BuildingTypeName = 'Main Hospital Building') on Mondays between March 2024 and October 2024.*/

select A.*, B.numprescrip, C. appnum
from
(select H.HospitalID, H.HospitalName, count(A.AppointmentID) as numapp
from tblSymptom S
join tblSymptom_Type ST on S.SymptomTypeID = ST.SymptomTypeID
join tblPatient_Symptom PS on S.SymptomID = PS.SymptomID
join tblAppointment A on PS.PatientSymptomID = A.PatientSymptomID
join tblAppointment_Pro AP on A.AppointmentID = AP.AppointmentID
join tblRoom R on AP.RoomID = R.RoomID
join tblBuilding B on R.BUildingID = B.BuildingID
join tblHospital H on B.HospitalID = H.HospitalID
where ST.SymptomTypeName = 'Fevere'
and AP.BeginDateTime > '2022-01-31'
group by H.HospitalID, H.HospitalName
having count(A.AppointmentID) >=50) A,
(select  H.HospitalID, H.HospitalName, count(P.PrescriptionID) as numprescrip
from tblAppointment_Pro AP
join tblRoom R on AP.RoomID = R.RoomID
join tblBuilding B on R.BUildingID = B.BuildingID
join tblHospital H on B.HospitalID = H.HospitalID
join tblDiagnosis D on AP.AppointProID = D.AppointProID
join tblPrescription P on D.DiagnosisID = P.DiagnosisID
join tblMedication M on P.MedicationID = M.MedicationID
join tblMedication_Type MT on M.MedicationTypeID = MT.MedicationTypeID
where MT.MedicationTypeName = 'Immunomodulators'
and  AP.BeginDateTime < '2024-01-01'
group by H.HospitalID, H.HospitalName
having count(P.PrescriptionID) > 20) B,
(select H.HospitalID, H.HospitalName, count(A.AppointmentID) as appnum
from tblAppointment_Pro AP
join tblAppointment A on AP.AppointmentID = A.AppointmentID
join tblRoom R on AP.RoomID = R.RoomID
join tblBuilding B on R.BUildingID = B.BuildingID
join tblHospital H on B.HospitalID = H.HospitalID
join tblBuilding_Type BT on B.BuildingTypeID = BT.BuildingTypeID
where BT.BuildingTypeName = 'Main Hospital Building'
and datepart(weekday, AP.BeginDateTime) = 2
and AP.BeginDateTime between '2024-03-01' and '2024-10-01'
group by H.HospitalID, H.HospitalName
having count(A.AppointmentID)>=100) C

where A.HospitalID = B.HospitalID
and A.HospitalID = C.HospitalID 


CTE

Write an SQL query using a Common Table Expression (CTE) to determine the patients who meet the following conditions:
They rank between #5 and #20 based on the number of symptoms recorded in 2023.
Use the RANK() function for ranking patients in descending order of the total symptoms they had in 2023.
They have had a total of 4 or more appointments before January 1, 2023.

WITH CTE_SymptomRank AS (
    SELECT 
        P.PatientID,
        P.PatientFName,
        P.PatientLName,
        COUNT(*) AS TotalSymptoms,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS SymptomRank
    FROM tblPATIENT P
    JOIN tblPATIENT_SYMPTOM PS ON P.PatientID = PS.PatientID
    WHERE YEAR(PS.DateOfApp) = 2023
    GROUP BY P.PatientID, P.PatientFName, P.PatientLName
),
CTE_AppointmentCount AS (
    SELECT 
        P.PatientID,
        P.PatientFName,
        P.PatientLName,
        COUNT(*) AS TotalAppointments
    FROM tblPATIENT P
    JOIN tblAPPOINTMENT A ON P.PatientID = A.PatientSymptomID
    WHERE A.DateOfApp < '2023-01-01'
    GROUP BY P.PatientID, P.PatientFName, P.PatientLName
    HAVING COUNT(*) >= 4
)
SELECT 
    SR.PatientID,
    SR.PatientFName,
    SR.PatientLName,
    SR.TotalSymptoms,
    SR.SymptomRank,
    AC.TotalAppointments
FROM CTE_SymptomRank SR
JOIN CTE_AppointmentCount AC ON SR.PatientID = AC.PatientID
WHERE SR.SymptomRank BETWEEN 5 AND 20;
